# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "conveyorbelt_models: 4 messages, 0 services")

set(MSG_I_FLAGS "-Iconveyorbelt_models:/home/tyrell/Skripsi/src/conveyorbelt_models/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(conveyorbelt_models_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_custom_target(_conveyorbelt_models_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "conveyorbelt_models" "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" "geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_custom_target(_conveyorbelt_models_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "conveyorbelt_models" "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" "geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_custom_target(_conveyorbelt_models_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "conveyorbelt_models" "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" "geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_custom_target(_conveyorbelt_models_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "conveyorbelt_models" "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" "geometry_msgs/Vector3"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_cpp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_cpp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_cpp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
)

### Generating Services

### Generating Module File
_generate_module_cpp(conveyorbelt_models
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(conveyorbelt_models_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(conveyorbelt_models_generate_messages conveyorbelt_models_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_cpp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_cpp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_cpp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_cpp _conveyorbelt_models_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(conveyorbelt_models_gencpp)
add_dependencies(conveyorbelt_models_gencpp conveyorbelt_models_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS conveyorbelt_models_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_eus(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_eus(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_eus(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
)

### Generating Services

### Generating Module File
_generate_module_eus(conveyorbelt_models
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(conveyorbelt_models_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(conveyorbelt_models_generate_messages conveyorbelt_models_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_eus _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_eus _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_eus _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_eus _conveyorbelt_models_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(conveyorbelt_models_geneus)
add_dependencies(conveyorbelt_models_geneus conveyorbelt_models_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS conveyorbelt_models_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_lisp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_lisp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_lisp(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
)

### Generating Services

### Generating Module File
_generate_module_lisp(conveyorbelt_models
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(conveyorbelt_models_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(conveyorbelt_models_generate_messages conveyorbelt_models_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_lisp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_lisp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_lisp _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_lisp _conveyorbelt_models_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(conveyorbelt_models_genlisp)
add_dependencies(conveyorbelt_models_genlisp conveyorbelt_models_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS conveyorbelt_models_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_nodejs(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_nodejs(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_nodejs(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
)

### Generating Services

### Generating Module File
_generate_module_nodejs(conveyorbelt_models
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(conveyorbelt_models_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(conveyorbelt_models_generate_messages conveyorbelt_models_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_nodejs _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_nodejs _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_nodejs _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_nodejs _conveyorbelt_models_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(conveyorbelt_models_gennodejs)
add_dependencies(conveyorbelt_models_gennodejs conveyorbelt_models_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS conveyorbelt_models_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_py(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_py(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
)
_generate_msg_py(conveyorbelt_models
  "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
)

### Generating Services

### Generating Module File
_generate_module_py(conveyorbelt_models
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(conveyorbelt_models_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(conveyorbelt_models_generate_messages conveyorbelt_models_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey1_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_py _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/object_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_py _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/box_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_py _conveyorbelt_models_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tyrell/Skripsi/src/conveyorbelt_models/msg/convey2_cmd_vel.msg" NAME_WE)
add_dependencies(conveyorbelt_models_generate_messages_py _conveyorbelt_models_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(conveyorbelt_models_genpy)
add_dependencies(conveyorbelt_models_genpy conveyorbelt_models_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS conveyorbelt_models_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/conveyorbelt_models
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(conveyorbelt_models_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(conveyorbelt_models_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/conveyorbelt_models
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(conveyorbelt_models_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(conveyorbelt_models_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/conveyorbelt_models
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(conveyorbelt_models_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(conveyorbelt_models_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/conveyorbelt_models
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(conveyorbelt_models_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(conveyorbelt_models_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/conveyorbelt_models
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(conveyorbelt_models_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(conveyorbelt_models_generate_messages_py geometry_msgs_generate_messages_py)
endif()
