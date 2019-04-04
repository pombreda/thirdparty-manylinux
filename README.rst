# thirdparty-manylinux

A multi-linux builder loop for packages using Travis and uploading binaries to 
Bintray. Supports many Linux distros with a single binary (32 and 64 bits on
Intel architectures) in the most compatible way.

This repo is a builder of thidrparty components.
The repo itself is in the public domain. 
Each built component is released under its own license.

The goal of this repo is to build native C code and Python libraries with native code
to create decently portable libraries for many Linux distros.

See also https://github.com/pombreda/thirdparty that provides similar services for Windows and MacOSX.

The travis config is used to build native code and Python wheels for Linux via Docker.
Note: all the creadits goes to the Pypa team for setting up the https://github.com/pypa/python-manylinux-demo


From https://github.com/pypa/python-manylinux-demo :

Because these wheels need to be compiled on CentOS 5, this build loop uses Docker
running on Travis-CI to compile. The docker-based build environment images are:

- 64-bit image (x86-64): ``quay.io/pypa/manylinux1_x86_64`` [![Docker Repository on Quay](https://quay.io/repository/pypa/manylinux1_x86_64/status "Docker Repository on Quay")](https://quay.io/repository/pypa/manylinux1_x86_64)
- 32-bit image (i686): ``quay.io/pypa/manylinux1_i686`` [![Docker Repository on Quay](https://quay.io/repository/pypa/manylinux1_i686/status "Docker Repository on Quay")](https://quay.io/repository/pypa/manylinux1_i686)


The `.travis.yml` file instructs Travis to run the script
`travis/build-wheels.sh` inside of the 32-bit and 64-bit manylinux1 docker
build environments. This script builds the package using `pip`. But these
wheels link against an external library. So to create self-contained wheels,
the build script runs the wheels through
[`auditwheel`](https://pypi.python.org/pypi/auditwheel), which copies the external
library into the wheel itself, so that users won't need to install any extra non-PyPI
dependencies.


The final results of the builds is then uploaded to bintray: https://dl.bintray.com/pombreda/thirdparty/

Build status
============

- **Linux (Travis)**

.. image:: https://api.travis-ci.org/pombreda/thirdparty-manylinux.svg?branch=master
   :target: https://travis-ci.org/pombreda/thirdparty-manylinux
   :alt: Linux Master branch build status


Code of Conduct
---------------

Everyone interacting in the python-manylinux-demo project's codebases, issue trackers,
chat rooms, and mailing lists is expected to follow the
[PyPA Code of Conduct](https://www.pypa.io/en/latest/code-of-conduct/).
