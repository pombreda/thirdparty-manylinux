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
PACKAGES="intbitset \
bitarray \
simplejson \
tinyarray \
lxml==3.6.4 \
pyahocorasick
"
# re2 requires a vendoring or package of re2


# Compile (or fetch pre-built) wheels
############################
for PYBIN in /opt/python/*/bin; do
    for PACKAGE in $PACKAGES; do
        ${PYBIN}/pip wheel --wheel-dir=wheels $PACKAGE
    done
done

# Fetch sources
############################
PY35_BIN=/opt/python/cp35-cp35m/bin
for PACKAGE in $PACKAGES; do
    echo ""
    $PY35_BIN/pip download -d wheels --no-binary :all: $PACKAGE
done

ls -al wheels

# Remove extra dep
rm -rf wheels/six*whl

# Bundle external shared libraries into the wheels
#for whl in wheels/*.whl; do
#    auditwheel repair $whl -w /io/wheels
#done
