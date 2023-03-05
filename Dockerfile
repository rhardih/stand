FROM ubuntu:latest AS ndk

ARG NDK=r10e
ARG PLATFORM=android-21
ARG TOOLCHAIN=arm-linux-androideabi-4.9

RUN apt update && apt -y install \
  file \
  wget \
  unzip \
  python2

COPY get-ndk.sh make-stc.sh .

# Download and unzip NDK
RUN /bin/bash ./get-ndk.sh

# Make standalone toolchain
RUN /bin/bash ./make-stc.sh

# Final stage

FROM ubuntu:latest

ARG PLATFORM=android-21

RUN apt update && apt -y install \
  build-essential

COPY --from=ndk /$PLATFORM-toolchain /$PLATFORM-toolchain
