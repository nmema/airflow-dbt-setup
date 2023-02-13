#!/bin/bash

airflow db init

airflow users create \
    -e nmema@waisdata.com \
    -f Nicolas \
    -l Mema \
    -p admin \
    -r Admin \
    -u admin

airflow scheduler & airflow webserver