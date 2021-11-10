
(cl:in-package :asdf)

(defsystem "conveyorbelt_models-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "box_cmd_vel" :depends-on ("_package_box_cmd_vel"))
    (:file "_package_box_cmd_vel" :depends-on ("_package"))
    (:file "convey1_cmd_vel" :depends-on ("_package_convey1_cmd_vel"))
    (:file "_package_convey1_cmd_vel" :depends-on ("_package"))
    (:file "convey2_cmd_vel" :depends-on ("_package_convey2_cmd_vel"))
    (:file "_package_convey2_cmd_vel" :depends-on ("_package"))
    (:file "object_cmd_vel" :depends-on ("_package_object_cmd_vel"))
    (:file "_package_object_cmd_vel" :depends-on ("_package"))
  ))