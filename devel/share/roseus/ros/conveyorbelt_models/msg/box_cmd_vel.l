;; Auto-generated. Do not edit!


(when (boundp 'conveyorbelt_models::box_cmd_vel)
  (if (not (find-package "CONVEYORBELT_MODELS"))
    (make-package "CONVEYORBELT_MODELS"))
  (shadow 'box_cmd_vel (find-package "CONVEYORBELT_MODELS")))
(unless (find-package "CONVEYORBELT_MODELS::BOX_CMD_VEL")
  (make-package "CONVEYORBELT_MODELS::BOX_CMD_VEL"))

(in-package "ROS")
;;//! \htmlinclude box_cmd_vel.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass conveyorbelt_models::box_cmd_vel
  :super ros::object
  :slots (_linear _angular ))

(defmethod conveyorbelt_models::box_cmd_vel
  (:init
   (&key
    ((:linear __linear) (instance geometry_msgs::Vector3 :init))
    ((:angular __angular) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _linear __linear)
   (setq _angular __angular)
   self)
  (:linear
   (&rest __linear)
   (if (keywordp (car __linear))
       (send* _linear __linear)
     (progn
       (if __linear (setq _linear (car __linear)))
       _linear)))
  (:angular
   (&rest __angular)
   (if (keywordp (car __angular))
       (send* _angular __angular)
     (progn
       (if __angular (setq _angular (car __angular)))
       _angular)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Vector3 _linear
    (send _linear :serialization-length)
    ;; geometry_msgs/Vector3 _angular
    (send _angular :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Vector3 _linear
       (send _linear :serialize s)
     ;; geometry_msgs/Vector3 _angular
       (send _angular :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Vector3 _linear
     (send _linear :deserialize buf ptr-) (incf ptr- (send _linear :serialization-length))
   ;; geometry_msgs/Vector3 _angular
     (send _angular :deserialize buf ptr-) (incf ptr- (send _angular :serialization-length))
   ;;
   self)
  )

(setf (get conveyorbelt_models::box_cmd_vel :md5sum-) "9f195f881246fdfa2798d1d3eebca84a")
(setf (get conveyorbelt_models::box_cmd_vel :datatype-) "conveyorbelt_models/box_cmd_vel")
(setf (get conveyorbelt_models::box_cmd_vel :definition-)
      "geometry_msgs/Vector3 linear
geometry_msgs/Vector3 angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :conveyorbelt_models/box_cmd_vel "9f195f881246fdfa2798d1d3eebca84a")


