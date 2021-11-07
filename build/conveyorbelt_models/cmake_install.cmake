# Install script for directory: /home/tyrell/conveyorBelt_ws/src/conveyorbelt_models

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/tyrell/conveyorBelt_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/conveyorbelt_models/msg" TYPE FILE FILES
    "/home/tyrell/conveyorBelt_ws/src/conveyorbelt_models/msg/convey1_cmd_vel.msg"
    "/home/tyrell/conveyorBelt_ws/src/conveyorbelt_models/msg/convey2_cmd_vel.msg"
    "/home/tyrell/conveyorBelt_ws/src/conveyorbelt_models/msg/object_cmd_vel.msg"
    "/home/tyrell/conveyorBelt_ws/src/conveyorbelt_models/msg/box_cmd_vel.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/conveyorbelt_models/cmake" TYPE FILE FILES "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/conveyorbelt_models-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/tyrell/conveyorBelt_ws/devel/include/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/tyrell/conveyorBelt_ws/devel/share/roseus/ros/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/tyrell/conveyorBelt_ws/devel/share/common-lisp/ros/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/tyrell/conveyorBelt_ws/devel/share/gennodejs/ros/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/tyrell/conveyorBelt_ws/devel/lib/python2.7/dist-packages/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/tyrell/conveyorBelt_ws/devel/lib/python2.7/dist-packages/conveyorbelt_models")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/conveyorbelt_models.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/conveyorbelt_models/cmake" TYPE FILE FILES "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/conveyorbelt_models-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/conveyorbelt_models/cmake" TYPE FILE FILES
    "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/conveyorbelt_modelsConfig.cmake"
    "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/conveyorbelt_modelsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/conveyorbelt_models" TYPE FILE FILES "/home/tyrell/conveyorBelt_ws/src/conveyorbelt_models/package.xml")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/conveyorbelt_models" TYPE PROGRAM FILES "/home/tyrell/conveyorBelt_ws/build/conveyorbelt_models/catkin_generated/installspace/sm_skripsi.py")
endif()

