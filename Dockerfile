# List of Android NDK urls for linux-x86_64 along with their sha1 hashes, as
# listed on:
#
# https://developer.android.com/ndk/downloads/older_releases.html
#
# All files share the following common url prefix, so that has been omitted in
# the listing:
#
# https://dl.google.com/android/repository/
#
# Latest stable version:
#
# /android-ndk-r16-linux-x86_64.zip  - b7dcb08fa9fa403e3c0bc3f741a445d7f0399e93
#
# Older versions:
#
# /android-ndk-r15c-linux-x86_64.zip - 0bf02d4e8b85fd770fd7b9b2cdec57f9441f27a2
# /android-ndk-r14b-linux-x86_64.zip - becd161da6ed9a823e25be5c02955d9cbca1dbeb
# /android-ndk-r13b-linux-x86_64.zip - 0600157c4ddf50ec15b8a037cfc474143f718fd0
# /android-ndk-r12b-linux-x86_64.zip - 170a119bfa0f0ce5dc932405eaa3a7cc61b27694
# /android-ndk-r11c-linux-x86_64.zip - de5ce9bddeee16fb6af2b9117e9566352aa7e279
# /android-ndk-r10e-linux-x86_64.zip - f692681b007071103277f6edc6f91cb5c5494a32

FROM ubuntu:latest AS ndk

ARG NDK_URL=https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
ARG NDK_SHA=f692681b007071103277f6edc6f91cb5c5494a32
ARG PLATFORM=android-21
ARG TOOLCHAIN=arm-linux-androideabi-4.9

RUN apt-get update && apt-get -y install \
  file \
  wget

RUN wget -O ndk.zip --progress=dot:giga $NDK_URL

RUN echo "$NDK_SHA ndk.zip" | sha1sum -c

RUN apt-get -y install \
  unzip

RUN unzip -q ndk.zip

COPY make-stc.sh make-stc.sh

RUN /bin/bash ./make-stc.sh

# Final stage

FROM ubuntu:latest

ARG PLATFORM=android-21

RUN apt-get update && apt-get -y install \
  build-essential

COPY --from=ndk /$PLATFORM-toolchain /$PLATFORM-toolchain
