#!/bin/bash
mosquitto_pub -d -h broker.emqx.io -p 1883 -t AppleConveyor/Conveyor2/ -m "start" -q 1
