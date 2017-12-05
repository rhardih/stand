# Standalone Toolchain for Android NDK in Docker

Or **stand** for short, is different versions of the Android NDK packaged in a
container as a standalone toolchain.

## Versioning

To minimise the size of the image, each container only has a single toolchain,
for a certain platform version and toolchain, from a select NDK version. 

Each version is tagged according to a combination of the above, in the
following manner:

`<ndk>-<platform>-<toolchain>`

E.g. to get the container for platform `android-21` from the `r10e` platform:

`docker pull rhardih/stand:r10e-a21-arm-linux-androideabi-4.9`


## Info

Docker hub page:

[https://hub.docker.com/r/rhardih/stand](https://hub.docker.com/r/rhardih/stand)
