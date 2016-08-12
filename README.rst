# thirdparty-manylinux
 A multi-linux builder loop for packages using Travis and uploading binaries to Bintray. Supports many Linux distros with a single binary (32 and 64 bits on Intel arches) in the most compatible way.

This repo is a builder of thidrparty components.
The repo itself is in the public domain. 
Each built component is released under its own license.

The goal of this repo is to build native C code and Python libraries with native code
to create decently portable libraries for many Linux distros.

See also https://github.com/pombreda/thirdparty that provides similar services for Windows and MacOSX.

The travis config is used to build native code and Python wheels for Linux via Docker.

The final results of the builds is then uploaded to bintray: https://dl.bintray.com/pombreda/thirdparty/

Build status
============

- **Linux (Travis)**

.. image:: https://api.travis-ci.org/pombreda/thirdparty-manylinux.svg?branch=master
   :target: https://travis-ci.org/pombreda/thirdparty-manylinux
   :alt: Linux Master branch build status
