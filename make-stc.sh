declare -a args

args+=("--platform=$PLATFORM")
args+=("--toolchain=$TOOLCHAIN")
args+=("--install-dir=/$PLATFORM-toolchain")

case "$NDK_URL" in
  *r10e* )
    args+=("--system=linux-x86_64")
    ;;
esac

ndk_folder=$(basename ${NDK_URL%-linux-x86_64.zip})

/$ndk_folder/build/tools/make-standalone-toolchain.sh ${args[@]}
