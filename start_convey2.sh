#!/bin/bash
mosquitto_pub -d -h broker.emqx.io -p 1883 -t AppleConveyor/Conveyor2/Client/ -m "start" -q 1
