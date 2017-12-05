# Standalone Toolchain for Android NDK in Docker

Or **stand** for short, is different versions of the Android NDK packaged in a
container as a standalone toolchain.

The Android NDK is a bit of a beast sizewise, since it comes *batteries
included*, bundling all architectures and a range of platforms for each release.

At the time of writing, the current release, r16, weighs in at 800M/2.9G zipped
and unzipped respectively.

Typically you might only need a single platform version for a single
architecture, so lugging all that extra stuff along is a bit excessive.

With a **stand** container, only a single specific toolchain for a platform and
architecture is bundled, saving some much valued space and bandwidth.

## Versioning

Each version is tagged according to the following naming convention:

`<ndk>-<platform>-<toolchain>`

E.g. to get the container for platform `android-21` from the `r10e` NDK:

`docker pull rhardih/stand:r10e-a21-arm-linux-androideabi-4.9`


## Info

Docker hub page:

[https://hub.docker.com/r/rhardih/stand](https://hub.docker.com/r/rhardih/stand)
