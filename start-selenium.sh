#!/bin/bash

echo "Starting Selenium..."
java -jar /opt/selenium-server.jar \
    -role standalone \
    -port $SELENIUM_PORT \
    -browserTimeout 60 \
    -timeout 60 \
    -debug