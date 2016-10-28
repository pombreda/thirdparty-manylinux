#!/bin/bash
set -e -x

# Install a system package required by our libraries
yum install -y libxslt-devel python-devel libxml2 libxml2-devel libxslt

ls -al /opt/python/
rm -rf /opt/python/cp26-*
rm -rf /opt/python/cp33-*
rm -rf /opt/python/cp34-*
ls -al /opt/python/

# list of packages to build
############################
PACKAGES="intbitset bitarray lxml==3.6.4 \
pyahocorasick \
https://github.com/WojciechMula/pyahocorasick/archive/19282329183f465130cb9cb3538c9ac44c9cf796.zip \
re2"


# Compile (or fetch pre-built) wheels
############################
for PYBIN in /opt/python/*/bin; do
    for PACKAGE in $PACKAGES; do
        ${PYBIN}/pip -v wheel --wheel-dir=wheels $PACKAGE
    done
done

# Fetch sources
############################
PY35_BIN=/opt/python/cp35-cp35m/bin
for PACKAGE in $PACKAGES; do
    $PY35_BIN/pip -v download -d wheels --no-binary :all: $PACKAGE
done

ls -al wheels

# Remove extra dep
rm -rf wheels/six*whl

# Bundle external shared libraries into the wheels
#for whl in wheels/*.whl; do
#    auditwheel repair $whl -w /io/wheels
#done
