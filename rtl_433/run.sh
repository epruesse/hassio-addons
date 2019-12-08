#!/bin/sh

CONFIG_PATH=/data/options.json

PROTOCOL="$(jq --raw-output '.protocol' $CONFIG_PATH)"
FREQUENCY="$(jq --raw-output '.frequency' $CONFIG_PATH)"
GAIN="$(jq --raw-output '.gain // 0' $CONFIG_PATH)"
OFFSET="$(jq --raw-output '.frequency_offset // 0' $CONFIG_PATH)"

MQTT_HOST="$(jq --raw-output '.mqtt_host' $CONFIG_PATH)"
MQTT_PORT="$(jq --raw-output '.mqtt_port' $CONFIG_PATH)"
MQTT_USER="$(jq --raw-output '.mqtt_username' $CONFIG_PATH)"
MQTT_PASS="$(jq --raw-output '.mqtt_password' $CONFIG_PATH)"

MQTT_ARGS=""
if [ -n "$MQTT_USER" ]; then
	MQTT_ARGS="$MQTT_ARGS,user=$MQTT_USER"
fi
if [ -n "$MQTT_PASS" ]; then
	MQTT_ARGS="$MQTT_ARGS,pass=$MQTT_PASS"
fi

set -x
rtl_433 -f $FREQUENCY -p $OFFSET \
	-g $GAIN \
	-R $PROTOCOL \
	-F mqtt://$MQTT_HOST:$MQTT_PORT$MQTT_ARGS

