declare -a args

args+=("--platform=$PLATFORM")
args+=("--toolchain=$TOOLCHAIN")
args+=("--install-dir=/$PLATFORM-toolchain")
args+=("--verbose")

case "$NDK_URL" in
  *r10e* )
    args+=("--system=linux-x86_64")
    ;;
  *r13b*)
    ;&
  *r14b*)
    ;&
  *r15c*)
    ;&
  *r16*)
    apt-get -y install python
    ;&
esac

ndk_folder=$(basename ${NDK_URL%-linux-x86_64.zip})

/$ndk_folder/build/tools/make-standalone-toolchain.sh ${args[@]}
