FROM google/dart:latest
MAINTAINER  Matthew Clark <mclark4386@gmail.com>
LABEL Description="Dart SDK + Flutter"


# Install third-party dependencies.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu precise main multiverse" \ 
    >> /etc/apt/sources.list
RUN apt-get update; echo 'true'
RUN apt-get install -y --force-yes git wget unzip xvfb chromedriver libgconf-2-4 gdb lib32stdc++6 libstdc++6
RUN apt-get clean

# Install Flutter.
RUN cd / && git clone -b dev https://github.com/flutter/flutter.git
ENV PATH=/flutter/bin:$PATH
RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

# https://circleci.com/docs/2.0/high-uid-error/
RUN rm -rfv /flutter/bin/cache/artifacts/gradle_wrapper/
