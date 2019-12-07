#!/bin/sh

CONFIG_PATH=/data/options.json

PROTOCOL="$(jq --raw-output '.protocol' $CONFIG_PATH)"
FREQUENCY="$(jq --raw-output '.frequency' $CONFIG_PATH)"
GAIN="$(jq --raw-output '.gain' $CONFIG_PATH)"
OFFSET="$(jq --raw-output '.frequency_offset' $CONFIG_PATH)"

MQTT_HOST="$(jq --raw-output '.mqtt_host' $CONFIG_PATH)"
MQTT_PORT="$(jq --raw-output '.mqtt_port' $CONFIG_PATH)"
MQTT_USER="$(jq --raw-output '.mqtt_user' $CONFIG_PATH)"
MQTT_PASS="$(jq --raw-output '.mqtt_password' $CONFIG_PATH)"

rtl_433 -f $FREQUENCY -p $OFFSET \
	-g $GAIN \
	-R $PROTOCOL \
	-F mqtt://$MQTT_HOST:$MQTT_PORT,user=$MQTT_USER,pass=$MQTT_PASS

