FROM google/dart:2.0
MAINTAINER  Matthew Clark <mclark4386@gmail.com>
LABEL Description="Dart SDK with content-shell"

# Configuration
ENV CHANNEL stable
ENV SDK_VERSION 2.0.0
ENV ARCHIVE_URL https://storage.googleapis.com/dart-archive/channels/$CHANNEL/release/$SDK_VERSION
ENV PATH $PATH:/usr/lib/dart/bin

# Install third-party dependencies.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu precise main multiverse" \ 
    >> /etc/apt/sources.list
RUN apt-get update; echo 'true'
RUN apt-get install -y --force-yes git wget unzip xvfb chromedriver libgconf-2-4 gdb

# https://github.com/dart-lang/sdk/issues/28549#issuecomment-277534958
RUN apt-get install -y --force-yes gdb

RUN apt-get clean

# Download the SDK.
RUN wget $ARCHIVE_URL/sdk/dartsdk-linux-x64-release.zip
RUN unzip dartsdk-linux-x64-release.zip
RUN cp -r dart-sdk/* /usr/local
RUN rm -rf dartsdk-linux-x64-release.zip

# Install Flutter.
RUN cd / && git clone -b dev https://github.com/flutter/flutter.git
ENV PATH=/flutter/bin:$PATH
RUN flutter doctor
RUN apt-get  -y --force-yes install libstdc++6 fonts-droid
RUN flutter doctor

# https://circleci.com/docs/2.0/high-uid-error/
RUN rm -rfv /flutter/bin/cache/artifacts/gradle_wrapper/
