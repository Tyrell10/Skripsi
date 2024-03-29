#!/usr/bin/env python2

import roslib
import rospy
import smach
import smach_ros
import threading
import time
from std_msgs.msg import Empty
import paho.mqtt.client as mqtt
from conveyorbelt_models.msg import *
from geometry_msgs.msg import *
from gazebo_msgs.srv import DeleteModel, SpawnModel
from gazebo_msgs.msg import ModelState
from gazebo_msgs.srv import SetModelState

# Publisher node and msgs
convey1_cmd_pub = None
convey2_cmd_pub = None
object_cmd_pub = None
box_cmd_pub = None
convey1_cmd_msg = convey1_cmd_vel()
convey2_cmd_msg = convey2_cmd_vel()
object_cmd_msg = object_cmd_vel()
box_cmd_msg = box_cmd_vel()

# Service node
srv_spawn_model = None
srv_delete_model = None
srv_set_state = None
first_box = True
first_obj = True

# MQTT param
client1 = None
client2 = None
client3 = None
convey1_server_topic = "AppleConveyor/Conveyor1/Server/"
convey2_server_topic = "AppleConveyor/Conveyor2/Server/"
counter_server_topic = "AppleConveyor/Counter/Server/"
convey1_client_topic = "AppleConveyor/Conveyor1/Client/"
convey2_client_topic = "AppleConveyor/Conveyor2/Client/"

# Conveyor state
isStart = False
isStop = False
stop_req = False
isBox_detect = False
isCounter_finish = False
isConveyor1_on = False
isConveyor2_on = False
convey1_msgs_time = 0.0
convey2_msgs_time = 0.0
delete_box_time = 0.0
delete_obj_time = 0.0
apple_count = 0
bearing_i = 0
box_i = 0
last_box_detect = False
last_obj_detect = False

# spawn model param
model_name1 = "box_model"
model_name2 = "bearing_model"
model_type = "urdf"
bearing_list = []
object_position = (0.098, 0.29, 0.155)
box_position = (-0.11, -0.01, 0.056)
bearing_store = (-0.12, 0.327, 0.012)
object_pose = Pose()
box_pose = Pose()
object_pose.position.x = float(object_position[0])
object_pose.position.y = float(object_position[1])
object_pose.position.z = float(object_position[2])
box_pose.position.x = float(box_position[0])
box_pose.position.y = float(box_position[1])
box_pose.position.z = float(box_position[2])

box_file_location = roslib.packages.get_pkg_dir('conveyorbelt_models') + '/models/' + model_name1 + '.' + model_type
object_file_location = roslib.packages.get_pkg_dir('conveyorbelt_models') + '/models/' + model_name2 + '.' + model_type

object_file_xml = open(object_file_location)
box_file_xml = open(box_file_location)
object_xml_string = object_file_xml.read().replace('\n', '')
box_xml_string = box_file_xml.read().replace('\n', '')

start_flag = False
delete_flag = True
terminate = False
sim_timer = 0
sim_duration = 0
count_start = 0
packaging_sys_timer = 0  # in ms

class Setup(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['setup_done', 'waiting'])

    def execute(self, ud):
        global isStart, isStop

        rospy.loginfo("[WAITING FOR SETUP]")
        rospy.sleep(0.1)

        if(isConveyor1_on):
            isStop = False
            return 'setup_done'
        else:
            return 'waiting'


class Stop(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['stop', 'start', 'terminate'])

    def execute(self, ud):
        global isStart, isStop, client1, client2

        rospy.loginfo("[SYSTEM STOP]")
        rospy.sleep(0.1)

        if(isStart):
            isStop = False
            return 'start'

        elif(terminate):
            return 'terminate'

        if not isConveyor1_on :
            convey1_cmd_msg.linear.x = 0.0
            convey1_cmd_msg.linear.y = 0.0
            convey1_cmd_msg.linear.z = 0.0
            convey1_cmd_msg.angular.x = 0.0
            convey1_cmd_msg.angular.y = 0.0
            convey1_cmd_msg.angular.z = 0.0
            convey1_cmd_pub.publish(convey1_cmd_msg)

        if not isConveyor2_on :
            convey2_cmd_msg.linear.x = 0.0
            convey2_cmd_msg.linear.y = 0.0
            convey2_cmd_msg.linear.z = 0.0
            convey2_cmd_msg.angular.x = 0.0
            convey2_cmd_msg.angular.y = 0.0
            convey2_cmd_msg.angular.z = 0.0
            convey2_cmd_pub.publish(convey2_cmd_msg)

#            if(stop_req) :
#                ret1 = client1.publish(convey1_topic, "stop", qos=1)

#                if ret1 != 0 :
#                    rospy.loginfo("[MQTT PUBLISHED STOP: SUCCESS]")
#                else :
#                    rospy.loginfo("[MQTT PUBLISHED STOP: FAILED]")

#                ret2 = client2.publish(convey2_topic, "stop", qos=1)

#                if ret2 != 0 :
#                    rospy.loginfo("[MQTT PUBLISHED STOP: SUCCESS]")
#                else :
#                    rospy.loginfo("[MQTT PUBLISHED STOP: FAILED]")

#                stop_req = False

        return 'stop'


class Apple_counter(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['counter_finish', 'waiting_counting', 'stop'], input_keys=['obj_counter_in'], output_keys=['obj_counter_out'])

    def execute(self, ud):
        global isCounter_finish, isConveyor2_on, stop_req, convey2_msgs_time, isStart

        rospy.loginfo("[START COUNTING]")
        rospy.sleep(0.05)

        if (isStop):
            isStart = False
            return 'stop'

        elif(isCounter_finish):
            isConveyor2_on = False
            return 'counter_finish'

        else:
            ud.obj_counter_out = apple_count
            return 'waiting_counting'


class Conveyor1(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['box_detect', 'running', 'stop', 'system_finish'], input_keys=['duration_in'], output_keys=['duration_out'])

    def execute(self, ud):
        global isBox_detect, isConveyor1_on, stop_req, convey1_msgs_time, isStart, isStop
        global last_box_detect, last_obj_detect, delete_box_time, delete_obj_time, delete_flag
        global convey1_cmd_msg, convey1_cmd_pub, box_cmd_msg, box_cmd_pub, box_i, bearing_i

        rospy.loginfo("[EXECUTING CONYEVOR 1]")
        duration = rospy.get_rostime() - convey1_msgs_time
#        rospy.loginfo(duration)
        rospy.sleep(0.02)

        ud.duration_out = duration.secs

        if isStop :
            isStart = False
            isConveyor1_on = False
            return 'stop'

        elif(isBox_detect):
            convey1_cmd_msg.linear.x = 0.0
            convey1_cmd_msg.linear.y = 0.0
            convey1_cmd_msg.linear.z = 0.0
            convey1_cmd_msg.angular.x = 0.0
            convey1_cmd_msg.angular.y = 0.0
            convey1_cmd_msg.angular.z = 0.0
            convey1_cmd_pub.publish(convey1_cmd_msg)
            return 'box_detect'

        elif(duration.secs >= 30.0 or not isConveyor1_on):

            if duration.secs >= 60.0 :
                isStop = True

            convey1_cmd_msg.linear.x = 0.0
            convey1_cmd_msg.linear.y = 0.0
            convey1_cmd_msg.linear.z = 0.0
            convey1_cmd_msg.angular.x = 0.0
            convey1_cmd_msg.angular.y = 0.0
            convey1_cmd_msg.angular.z = 0.0
            convey1_cmd_pub.publish(convey1_cmd_msg)

            if not isConveyor1_on :
                return 'system_finish'
            else :
                return 'running'

        else:
            # publish /convey1_cmd_vel -> x
            # publish /plannar_node/box_cmd_vel -> x

#            if isCounter_finish :
#                valid_delete_box = rospy.get_rostime() - delete_box_time
#                rospy.loginfo("delete_time %f", valid_delete_box.secs)

#                if valid_delete_box.secs >= 4.0 and delete_flag :
#                    # delete bearing_model
#                    try :
#                        for i in range(len(model_list)-1, 0, -1) :
#                            rospy.loginfo(model_list)
#                            res_delete = srv_delete_model(model_list[i])

#                            if res_delete.success == True:
#                                rospy.loginfo(res_delete.status_message + " " + model_list[i])
#                                model_list.pop(i)
#                                rospy.sleep(2)
#                            else:
#                                print("Error: model %s not spawn. error message = "% model_list[i] + res_spawn.status_message)

#                    except rospy.ServiceException as e :
#                        print("Delete Model service call failed: {0}".format(e))

#                    if last_obj_detect and bearing_i > 1:
#                        res_delete = srv_delete_model(model_name2+str(bearing_i-1))
#                        last_obj_detect = False

#                        if res_delete.success == True:
#                            rospy.loginfo(res_delete.status_message + " " + model_name2+str(bearing_i-1))
#                        else:
#                            print "Error: model %s not spawn. error message = "% model_name2 + res_spawn.status_message
#                    else :
#                        res_delete = srv_delete_model(model_name2+str(bearing_i))
#                        if res_delete.success == True:
#                            rospy.loginfo(res_delete.status_message + " " + model_name2+str(bearing_i))
#                        else:
#                            print "Error: model %s not spawn. error message = "% model_name2 + res_spawn.status_message

#                    # delete box_model
#                    if last_box_detect and box_i > 1 :
#                        res_delete = srv_delete_model(model_name1+str(box_i-1))
#                        last_box_detect = False

#                        if res_delete.success == True:
#                            rospy.loginfo(res_delete.status_message + " " + model_name1+str(box_i-1))
#                        else:
#                            print "Error: model %s not spawn. error message = "% model_name1 + res_spawn.status_message
#                    else :
#                        res_delete = srv_delete_model(model_name1+str(box_i))
#                        if res_delete.success == True:
#                            rospy.loginfo(res_delete.status_message + " " + model_name1+str(box_i))
#                        else:
#                            print "Error: model %s not spawn. error message = "% model_name1 + res_spawn.status_message

#                    delete_flag = False

            convey1_cmd_msg.linear.x = 0.070
            convey1_cmd_msg.linear.y = 0.0
            convey1_cmd_msg.linear.z = 0.0
            convey1_cmd_msg.angular.x = 0.0
            convey1_cmd_msg.angular.y = 0.0
            convey1_cmd_msg.angular.z = 0.0
            convey1_cmd_pub.publish(convey1_cmd_msg)

            box_cmd_msg.linear.x = 0.18
            box_cmd_msg.linear.y = 0.0
            box_cmd_msg.linear.z = 0.0
            box_cmd_msg.angular.x = 0.0
            box_cmd_msg.angular.y = 0.0
            box_cmd_msg.angular.z = 0.0
            box_cmd_pub.publish(box_cmd_msg)

            return 'running'



class Conveyor2(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['counter_finish', 'running', 'stop'], input_keys=['duration_in'], output_keys=['duration_out'])

    def execute(self, ud):
        global isConveyor2_on, isCounter_finish, stop_req, convey2_msgs_time, isStart, isStop
        global convey2_cmd_msg, convey2_cmd_pub, object_cmd_msg, object_cmd_pub

        rospy.loginfo("[EXECUTING CONVEYOR 2]")
        duration = rospy.get_rostime() - convey2_msgs_time
#        rospy.loginfo(duration)
        rospy.sleep(0.02)

        ud.duration_out = duration.secs

        if isStop :
            isStart = False
            isConveyor2_on = False
            return 'stop'

        elif(isCounter_finish):
            convey2_cmd_msg.linear.x = 0.0
            convey2_cmd_msg.linear.y = 0.0
            convey2_cmd_msg.linear.z = 0.0
            convey2_cmd_msg.angular.x = 0.0
            convey2_cmd_msg.angular.y = 0.0
            convey2_cmd_msg.angular.z = 0.0
            convey2_cmd_pub.publish(convey2_cmd_msg)

            return 'counter_finish'

        elif(duration.secs >= 30.0 or not isConveyor2_on):

            if duration.secs >= 60.0 :
                isStop = True

            convey2_cmd_msg.linear.x = 0.0
            convey2_cmd_msg.linear.y = 0.0
            convey2_cmd_msg.linear.z = 0.0
            convey2_cmd_msg.angular.x = 0.0
            convey2_cmd_msg.angular.y = 0.0
            convey2_cmd_msg.angular.z = 0.0
            convey2_cmd_pub.publish(convey2_cmd_msg)
            return 'running'

        else:
            # publish /convey2_cmd_vel -> x
            # publish /plannar_node/object_cmd_vel -> x

            convey2_cmd_msg.linear.x = 0.073
            convey2_cmd_msg.linear.y = 0.0
            convey2_cmd_msg.linear.z = 0.0
            convey2_cmd_msg.angular.x = 0.0
            convey2_cmd_msg.angular.y = 0.0
            convey2_cmd_msg.angular.z = 0.0
            convey2_cmd_pub.publish(convey2_cmd_msg)

            object_cmd_msg.linear.x = 0.0
            object_cmd_msg.linear.y = -0.19
            object_cmd_msg.linear.z = 0.0
            object_cmd_msg.angular.x = 0.0
            object_cmd_msg.angular.y = 0.0
            object_cmd_msg.angular.z = 0.0
            object_cmd_pub.publish(object_cmd_msg)

            return 'running'


class Ready(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['conveyor1_start', 'conveyor2_start', 'stop', 'waiting_next_input', 'terminate'], input_keys=['sim_in', 'packaging_sys_in'], output_keys=['sim_out', 'packaging_sys_out'])

    def execute(self, ud):
        global isConveyor1_on, isConveyor2_on, isCounter_finish, isBox_detect
        global sim_duration, packaging_sys_timer

        rospy.loginfo("[WAITING FOR TRANSITION]")
        rospy.sleep(0.1)

        ud.sim_out = sim_duration
        ud.packaging_sys_out = packaging_sys_timer/1000.0

        if(isStop):
            isStart = False
            return 'stop'

        elif(isConveyor1_on):
            isBox_detect = False
            return 'conveyor1_start'

        elif(isConveyor2_on):
            isCounter_finish = False
            return 'conveyor2_start'

        elif(terminate):
            return 'terminate'

        else:
            return 'waiting_next_input'


def on_message(client, ud, msg) :
    global isBox_detect, isStart, isStop, isConveyor1_on, isConveyor2_on, isCounter_finish, box_i, delete_box_time
    global convey1_msgs_time, convey2_msgs_time, apple_count, srv_spawn_model, srv_delete_model, bearing_list, first_box
    global srv_set_state, start_flag, sim_timer, sim_duration, count_start, packaging_sys_timer

    """
    1 : Conveyor On
    2 : Conveyor Off
    3 : Box/obj Detected Start
    4 : Box/obj Detected Stop
    """

    msgs = str(msg.payload.decode("utf-8"))

    print("message received " ,msgs)
    print("message topic=",msg.topic)
    print("message qos=",msg.qos)
    print("message retain flag=",msg.retain)

    if(msg.topic==convey1_server_topic) :
        convey1_msgs_time = rospy.get_rostime()

        if(msgs == "start") :
            isStart = True

        elif(msgs == "stop") :
            isStop = True
#            stop_req = True

        elif(msgs == "1") :
            isConveyor1_on = True

            if(not start_flag) :
                start_flag = True
                count_start += 1
                if(count_start%2==1) :
                    sim_timer = rospy.get_rostime()

        elif(msgs == "2") :
            isConveyor1_on = False

            if(start_flag) :
                start_flag = False
                if(count_start%2==0) :
                    sim_duration = rospy.get_rostime().secs - sim_timer.secs

        elif(msgs == "3") :
#            pass
            # Spawn model
#            box_i += 1
#            last_box_detect = True

            if first_box :
                res_spawn = srv_spawn_model(model_name1, box_xml_string, "/", box_pose, "world")

                if res_spawn.success == True:
                    rospy.loginfo(res_spawn.status_message + " " + model_name1)#+str(box_i))
                    first_box = False
#                    if box_i == 2 :
#                        first_box = False
#                        box_i = 0
                else:
                    print "Error: model %s not spawn. error message = "% model_name1 + res_spawn.status_message
            else :
                state_msg = ModelState()

                for i in range(0, 3) :
                    bearing_list.append(bearing_list[i])

                for i in range(2,-1,-1) :
                    rospy.loginfo(bearing_list)
                    state_msg.model_name = bearing_list[i]
                    state_msg.pose.position.x = float(bearing_store[0])
                    state_msg.pose.position.y = float(bearing_store[1])
                    state_msg.pose.position.z = float(bearing_store[2]+i*0.007)
                    state_msg.pose.orientation.x = 0
                    state_msg.pose.orientation.y = 0
                    state_msg.pose.orientation.z = 0
                    state_msg.pose.orientation.w = 0

                    try:
                        resp = srv_set_state(state_msg)
                        bearing_list.pop(i)

                    except rospy.ServiceException, e:
                        print "Service call failed: %s" % e

                state_msg.model_name = model_name1#+str(box_i)
                state_msg.pose.position.x = float(box_position[0])
                state_msg.pose.position.y = float(box_position[1])
                state_msg.pose.position.z = float(box_position[2])
                state_msg.pose.orientation.x = 0
                state_msg.pose.orientation.y = 0
                state_msg.pose.orientation.z = 0
                state_msg.pose.orientation.w = 0

                try:
                    resp = srv_set_state(state_msg)
#                    if box_i == 2 :
#                        box_i = 0

                except rospy.ServiceException, e:
                    print "Service call failed: %s" % e

        elif(msgs == "4") :
            ## Publish Start to Conveyor2

            isBox_detect = True
            isConveyor1_on = False

#            ret = client2.publish(convey2_client_topic, "start", qos=1)

#            if ret != 0 :
#                rospy.loginfo("[MQTT PUBLISHED STOP: SUCCESS]")
#            else :
#                rospy.loginfo("[MQTT PUBLISHED STOP: FAILED]")
        else :
            packaging_sys_timer = int(msgs)


def on_message2(client, ud, msg) :
    global isStart, isStop, isConveyor2_on, isCounter_finish, bearing_i, delete_obj_time, srv_set_state
    global convey2_msgs_time, srv_spawn_model, srv_delete_model, delete_flag, bearing_list, first_obj

    """
    1 : Conveyor On
    2 : Conveyor Off
    3 : Box/obj Detected Start
    4 : Box/obj Detected Stop
    """

    msgs = str(msg.payload.decode("utf-8"))

    print("message received " ,msgs)
    print("message topic=",msg.topic)
    print("message qos=",msg.qos)
    print("message retain flag=",msg.retain)

    if(msg.topic==convey2_server_topic) :
        convey2_msgs_time = rospy.get_rostime()

        if(msgs == "start") :
            isStart = True

        elif(msgs == "stop") :
            isStop = True
#            stop_req = True

        if(msgs == "1") :
            isConveyor2_on = True

        elif(msgs == "2") :
            isConveyor2_on = False

        elif(msgs == "3") :
#            pass
            # Spawn model
            bearing_i += 1
#            last_obj_detect = True

            if bearing_i <= 5 and first_obj :
                res_spawn = srv_spawn_model(model_name2+str(bearing_i), object_xml_string, "/", object_pose, "world")

                if res_spawn.success :
                    rospy.loginfo(res_spawn.status_message + " " + model_name2+str(bearing_i))
                    bearing_list.append(model_name2+str(bearing_i))
                    if bearing_i == 5 :
                        first_obj = False
                        bearing_i = 0
                else:
                    print "Error: model %s not spawn. error message = "% model_name2 + res_spawn.status_message
            else :
                state_msg = ModelState()
                state_msg.model_name = model_name2 + str(bearing_i)
                state_msg.pose.position.x = float(object_position[0])
                state_msg.pose.position.y = float(object_position[1])
                state_msg.pose.position.z = float(object_position[2])
                state_msg.pose.orientation.x = 0
                state_msg.pose.orientation.y = 0
                state_msg.pose.orientation.z = 0
                state_msg.pose.orientation.w = 0

                try:
                    resp = srv_set_state(state_msg)
                    if bearing_i == 5 :
                        bearing_i = 0

                except rospy.ServiceException, e:
                    print "Service call failed: %s" % e

        elif(msgs == "4") :
            ## Publish Start to Conveyor1
#            delete_obj_time = rospy.get_rostime()

            isConveyor2_on = False
            isCounter_finish = True
#            delete_flag = True


def on_message3(client, ud, msg) :
    global apple_count, isCounter_finish, convey2_msgs_time

    msgs = str(msg.payload.decode("utf-8"))

    print("message received " ,msgs)
    print("message topic=",msg.topic)
    print("message qos=",msg.qos)
    print("message retain flag=",msg.retain)

    if(msg.topic==counter_server_topic) :
        convey2_msgs_time = rospy.get_rostime()

        apple_count = int(msgs)
        rospy.loginfo("counting object :%s", msgs)
#        if apple_count == 10 :
#            apple_count = 0
#            isCounter_finish = True


def subscribing_convey1() :
    global client1, convey1_msgs_time

    client1.on_message = on_message
    client1.loop_start()


def subscribing_convey2() :
    global client2, client3

    client2.on_message = on_message2
    client2.loop_start()

#    client3.on_message = on_message3
#    client3.loop_start()


#def subscribing_convey3() :
#    global client3

#    client3.on_message = on_message3
#    client3.loop_start()


def main():
    global client1, client2, client3, convey1_cmd_pub, convey2_cmd_pub, object_cmd_pub, box_cmd_pub
    global srv_spawn_model, srv_delete_model, srv_set_state

    rospy.init_node("Monitor_SM")

    broker_address = "broker.emqx.io"
#    broker_address = "36.92.136.155"
    client1 = mqtt.Client("Conveyor1_Monitor")
    client1.connect(broker_address, 1883)
    client1.subscribe(convey1_server_topic)

    client2 = mqtt.Client("Conveyor2_Monitor")
    client2.connect(broker_address, 1883)
    client2.subscribe(convey2_server_topic)

#    client3 = mqtt.Client("Counter_Monitor")
#    client3.connect(broker_address, 1883)
#    client3.subscribe(counter_server_topic)

    sub1 = threading.Thread(target=subscribing_convey1)
    sub2 = threading.Thread(target=subscribing_convey2)
#    sub3 = threading.Thread(target=subscribing_convey3)

    client1.publish(convey1_client_topic, "0", qos=1)
    client2.publish(convey2_client_topic, "0", qos=1)

    sub1.start()
    sub2.start()
#    sub3.start()

    # Publisher
    convey1_cmd_pub = rospy.Publisher("convey1_cmd_vel", convey1_cmd_vel, queue_size=3)
    convey2_cmd_pub = rospy.Publisher("convey2_cmd_vel", convey2_cmd_vel, queue_size=3)
    object_cmd_pub = rospy.Publisher("plannar_node/object_cmd_vel", object_cmd_vel, queue_size=3)
    box_cmd_pub = rospy.Publisher("plannar_node/box_cmd_vel", box_cmd_vel, queue_size=3)

    # Service
    rospy.sleep(5)
    rospy.wait_for_service("/gazebo/spawn_urdf_model")

    srv_spawn_model = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
#    srv_delete_model = rospy.ServiceProxy('gazebo/delete_model', DeleteModel)
    srv_set_state = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)

#    res_spawn = srv_spawn_model(model_name1, box_xml_string, "/", box_pose, "world")

#    if res_spawn.success == True:
#            rospy.loginfo(res_spawn.status_message + " " + model_name2)
#    else:
#            print "Error: model %s not spawn. error message = "% model_name2 + res_spawn.status_message

    # Delete model
#    srv_delete_model(model_name1)
#    srv_delete_model(model_name2)

    sm = smach.StateMachine(outcomes=['SM_DONE'])
    with sm:
        #smach.StateMachine.add('READY', smach_ros.MonitorState("/sm_start", Empty, monitor_cb),
        #                        transitions={'invalid':'ESP32-1', 'valid':'SM_DONE', 'preempted':'SM_PREEMPTED'})

        smach.StateMachine.add('SETUP', Setup(),
                                transitions={'setup_done':'APPLE_CONVEYOR',
                                             'waiting':'SETUP'})

        sm_1 = smach.StateMachine(outcomes=['APPLE_CONVEYOR_DONE'])
        sm_1.userdata.delay_convey1 = 0
        sm_1.userdata.sim_timer = 0
        sm_1.userdata.packaging_sys_timer = 0.0

        with sm_1:
            smach.StateMachine.add('CONVEYOR1', Conveyor1(),
                                    transitions={'box_detect':'READY',
                                                 'running':'CONVEYOR1',
                                                 'stop':'STOP',
                                                 'system_finish':'READY'},
                                    remapping={'duration_in':'delay_convey1',
                                               'duration_out':'delay_convey1'})

            smach.StateMachine.add('CONVEYOR2', Conveyor2(),
                                    transitions={'counter_finish':'READY',
                                                 'running':'CONVEYOR2',
                                                 'stop':'STOP'},
                                    remapping={'duration_in':'delay_convey2',
                                               'duration_out':'delay_convey2'})

            smach.StateMachine.add('READY', Ready(),
                                    transitions={'conveyor1_start':'CONVEYOR1',
                                                 'conveyor2_start':'CONVEYOR2',
                                                 'stop':'STOP',
                                                 'terminate':'APPLE_CONVEYOR_DONE',
                                                 'waiting_next_input':'READY'},
                                    remapping={'sim_in':'sim_timer',
                                               'packaging_sys_in':'packaging_sys_timer',
                                               'sim_out':'sim_timer',
                                               'packaging_sys_out':'packaging_sys_timer'})

            smach.StateMachine.add('STOP', Stop(),
                                    transitions={'start':'READY',
                                                 'stop':'STOP',
                                                 'terminate':'APPLE_CONVEYOR_DONE'})

#            sm_concurrence = smach.Concurrence(outcomes=['CONCURRENCE_DONE', 'WAITING_CON', 'STOP_CON'],
#                                               default_outcome='WAITING_CON',
#                                               outcome_map={'CONCURRENCE_DONE':
#                                                            {'APPLE_COUNTER':'counter_finish',
#                                                             'CONVEYOR2':'counter_finish'},
#                                                            'WAITING_CON':
#                                                            {'APPLE_COUNTER':'waiting_counting',
#                                                             'CONVEYOR2':'running'},
#                                                            'STOP_CON':
#                                                            {'CONVEYOR2':'stop',
#                                                             'APPLE_COUNTER':'stop'}})

#            sm_concurrence.userdata.bearing_counter = 0
#            sm_concurrence.userdata.delay_convey2 = 0
#            with sm_concurrence:
#                smach.Concurrence.add('CONVEYOR2', Conveyor2(), remapping={'duration_in':'delay_convey2',
#                                                                           'duration_out':'delay_convey2'})
#                smach.Concurrence.add('APPLE_COUNTER', Apple_counter(), remapping={'obj_counter_in':'bearing_counter',
#                                                                                   'obj_counter_out':'bearing_counter'})

#            smach.StateMachine.add('SM_CON', sm_concurrence,
#                                    transitions={'CONCURRENCE_DONE':'READY',
#                                                 'WAITING_CON':'SM_CON',
#                                                 'STOP_CON':'STOP'})

        smach.StateMachine.add('APPLE_CONVEYOR', sm_1,
                                transitions={'APPLE_CONVEYOR_DONE':'SM_DONE'})

    viewer = smach_ros.IntrospectionServer('smach_viewer', sm, '/APPLE_CONVEYOR_MONITOR')
    viewer.start()

    outcome = sm.execute()

    rospy.spin()
    viewer.stop()
    client1.loop_stop()
    client2.loop_stop()
#    client3.loop_stop()
    sub1.stop()
    sub2.stop()
#    sub3.stop()


if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        terminate = True
