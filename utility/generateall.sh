#!/usr/bin/env bash

set -e

if [ -z ${PYTHON+x} ]; then
    PYTHON="/usr/bin/env python"
fi

echo "Using python \"$PYTHON\""

if [ "$1" != "no-download" ]; then
    ./utility/download.sh
fi


rm -rf build
echo "Generating C"
$PYTHON -m glad c --api egl=1.5 --out-path build
$PYTHON -m glad c --api gl:core=4.6 --out-path build
$PYTHON -m glad c --api glx=1.4 --out-path build
$PYTHON -m glad c --api wgl=1.0 --out-path build
echo "Generating D"
$PYTHON -m glad d --out-path build --api egl=1.5
$PYTHON -m glad d --out-path build --api gl:core=4.6 --api gles1=1.1 --api gles2=3.2
$PYTHON -m glad d --out-path build --api glx=1.4
$PYTHON -m glad d --out-path build --api wgl=1.0
echo "Generating Volt"
$PYTHON -m glad volt --out-path build --api egl=1.5
$PYTHON -m glad volt --out-path build --api gl:core=4.6 --api gles1=1.1 --api gles2=3.2
$PYTHON -m glad volt --out-path build --api glx=1.4
$PYTHON -m glad volt --out-path build --api wgl=1.0



# echo "Generating C"
# $PYTHON -m glad --out-path=build --spec=egl --generator=c
# $PYTHON -m glad --out-path=build --spec=gl --api="gl=,gles1=,gles2=" --generator=c
# $PYTHON -m glad --out-path=build --spec=glx --generator=c
# $PYTHON -m glad --out-path=build --spec=wgl --generator=c
# echo "Generating D"
# $PYTHON -m glad --out-path=build --spec=egl --generator=d
# $PYTHON -m glad --out-path=build --spec=gl --api="gl=,gles1=,gles2=" --generator=d
# $PYTHON -m glad --out-path=build --spec=glx --generator=d
# $PYTHON -m glad --out-path=build --spec=wgl --generator=d
# echo "Generating Volt"
# $PYTHON -m glad --out-path=build --spec=egl --generator=volt
# $PYTHON -m glad --out-path=build --spec=gl --api="gl=,gles1=,gles2=" --generator=volt
# $PYTHON -m glad --out-path=build --spec=glx --generator=volt
# $PYTHON -m glad --out-path=build --spec=wgl --generator=volt
