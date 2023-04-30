#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -u  Treat unset variables as an error when substituting.
# -x  Print commands and their arguments as they are executed.
# -o option-name
#   pipefail     the return value of a pipeline is the status of
#                the last command to exit with a non-zero status,
set -euxo pipefail

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

declare -A sha_sums

sha_sums["r10e"]="f692681b007071103277f6edc6f91cb5c5494a32"
sha_sums["r11c"]="de5ce9bddeee16fb6af2b9117e9566352aa7e279"
sha_sums["r12b"]="170a119bfa0f0ce5dc932405eaa3a7cc61b27694"
sha_sums["r13b"]="0600157c4ddf50ec15b8a037cfc474143f718fd0"
sha_sums["r14b"]="becd161da6ed9a823e25be5c02955d9cbca1dbeb"
sha_sums["r15c"]="0bf02d4e8b85fd770fd7b9b2cdec57f9441f27a2"
sha_sums["r16b"]="42aa43aae89a50d1c66c3f9fdecd676936da6128"
sha_sums["r17c"]="12cacc70c3fd2f40574015631c00f41fb8a39048"
sha_sums["r18b"]="500679655da3a86aecf67007e8ab230ea9b4dd7b"

ndk_url="https://dl.google.com/android/repository/android-ndk-$NDK-linux-x86_64.zip"
ndk_sha=${sha_sums[$NDK]}
ndk_folder=$(basename "${ndk_url%-linux-x86_64.zip}")

# Download and unzip NDK
wget -O ndk.zip --progress=dot:giga "$ndk_url"

echo "$ndk_sha ndk.zip" | sha1sum -c

unzip -q ndk.zip

# Make standalone toolchain
declare -a args

args+=("--platform=$PLATFORM")
args+=("--toolchain=$TOOLCHAIN")
args+=("--install-dir=/$PLATFORM-toolchain")
args+=("--verbose")

case "$NDK" in
  r10e )
   args+=("--system=linux-x86_64")
   ;;
esac

# make-standalone-toolchain.sh relies on Python 2 being the default
# `python`, but in later versions of Ubuntu, you're meant to target either
# `python2` or `python3` directly.  Additionally the meta package for
# `python` now points to `python3` by default, so this workaround is
# necessary.
#
# Reference:
# - https://github.com/rhardih/stand/issues/3
ln -s /usr/bin/python2 /usr/bin/python

/"$ndk_folder"/build/tools/make-standalone-toolchain.sh "${args[@]}"
