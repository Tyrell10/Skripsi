#!/bin/bash
mosquitto_pub -d -h broker.emqx.io -p 1883 -t AppleConveyor/Conveyor1/Client/ -m "stop" -q 1
