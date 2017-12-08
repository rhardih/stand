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


## By

In case a certain combination of NDK version, platform version and toolchain is not
currently available on Docker Hub, you can use this small companion site, to trigger a new build:

[stand.rhardih.io](https://stand.rhardih.io)

It's a small [Sinatra](http://sinatrarb.com) application deployed to Heroku.
Source available at [by](https://github.com/rhardih/by).

Once you've triggered a build, go grab a cup of coffee and wait till [Travis](https://travis-ci.org/rhardih/stand) is done building and subsequently pushing
the new image to Docker Hub.

Check the tags on [https://hub.docker.com/r/rhardih/stand/tags](https://hub.docker.com/r/rhardih/stand/tags) after the build is done.

If all went well, the new image should be tagged and listed amongst the others.

Profit!

## Disclaimer

Please note that the use the Android NDK is subject to the Terms and Conditions
laid forth by Google. For the full text, please see:

[https://developer.android.com/ndk/downloads/](https://developer.android.com/ndk/downloads/index.html)
