#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/tyrell/Skripsi/src/smach_viewer"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tyrell/Skripsi/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tyrell/Skripsi/install/lib/python2.7/dist-packages:/home/tyrell/Skripsi/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tyrell/Skripsi/build" \
    "/usr/bin/python2" \
    "/home/tyrell/Skripsi/src/smach_viewer/setup.py" \
     \
    build --build-base "/home/tyrell/Skripsi/build/smach_viewer" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/tyrell/Skripsi/install" --install-scripts="/home/tyrell/Skripsi/install/bin"
