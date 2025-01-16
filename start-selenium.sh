#!/bin/bash

echo "Starting Selenium..."
export DBUS_SESSION_BUS_ADDRESS=/dev/null
export CHROME_PATH=/usr/bin/chromium
export CHROMIUM_FLAGS="--no-sandbox --headless --disable-dev-shm-usage --disable-gpu"

java -jar /opt/selenium-server.jar \
    -role standalone \
    -port $SELENIUM_PORT \
    -debug