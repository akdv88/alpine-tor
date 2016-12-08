#!/bin/sh
while :; do
  exec /dnspacmaker.sh
  sleep $UPDATE_TIME
done
