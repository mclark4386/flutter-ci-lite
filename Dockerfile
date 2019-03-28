FROM google/dart:latest
MAINTAINER  Matthew Clark <mclark4386@gmail.com>
LABEL Description="Dart SDK + Flutter"

# Install Flutter.
RUN cd / && git clone -b dev https://github.com/flutter/flutter.git
ENV PATH=/flutter/bin:$PATH
RUN flutter doctor
RUN apt-get  -y --force-yes install libstdc++6 fonts-droid
RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

# https://circleci.com/docs/2.0/high-uid-error/
RUN rm -rfv /flutter/bin/cache/artifacts/gradle_wrapper/
