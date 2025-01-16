FROM --platform=$TARGETPLATFORM ubuntu:22.04

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive

# Create non-root user
RUN useradd -m -u 1000 selenium

# Add Debian repository and keys
RUN apt-get update && apt-get install -y gnupg2 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F8D2585B8783D481 && \
    echo "deb http://deb.debian.org/debian stable main" >> /etc/apt/sources.list

# Install dependencies and Chromium
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    xvfb \
    openjdk-8-jdk \
    supervisor \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Set up Selenium
ENV SELENIUM_VERSION=3.141.59
RUN wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-${SELENIUM_VERSION}.jar -O /opt/selenium-server.jar

# Create and set permissions
RUN mkdir -p /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix && \
    chown selenium:selenium /opt/selenium-server.jar && \
    mkdir -p /var/log/supervisor && \
    chown -R selenium:selenium /var/log/supervisor

# Environment variables
ENV DISPLAY=:99
ENV SCREEN_WIDTH=1920
ENV SCREEN_HEIGHT=1080
ENV SCREEN_DEPTH=24
ENV SELENIUM_PORT=4444
ENV HOME=/home/selenium
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Switch to non-root user
USER selenium
WORKDIR /home/selenium

# Copy configs
COPY --chown=selenium:selenium supervisord.conf /home/selenium/supervisord.conf
COPY --chown=selenium:selenium start-selenium.sh /home/selenium/start-selenium.sh
RUN chmod +x /home/selenium/start-selenium.sh

EXPOSE $SELENIUM_PORT

CMD ["supervisord", "-c", "/home/selenium/supervisord.conf"]