#!/bin/bash
set -e -x

# Install a system package required by our libraries
yum install -y libxslt-devel python-devel libxml2 libxml2-devel libxslt

# list all pythons
ls -al /opt/python/

# ... then delete the python we do not care for such that no build is done for these:
# only keep 2.7 and 3.6
rm -rf /opt/python/cp26-*
rm -rf /opt/python/cp33-*
rm -rf /opt/python/cp34-*
rm -rf /opt/python/cp35-*
# no 3.7 yet for now
rm -rf /opt/python/cp37-*
rm -rf /opt/_internal/cpython-2.6.*
rm -rf /opt/_internal/cpython-3.3.*
rm -rf /opt/_internal/cpython-3.4.*
rm -rf /opt/_internal/cpython-3.5.*
# no 3.7 yet for now
rm -rf /opt/_internal/cpython-3.7.*

ls -al /opt/python/



# list of packages to build
############################
PACKAGES="intbitset \
bitarray \
simplejson \
tinyarray \
pyahocorasick \
billiard \
psutil \
requests \
pycryptodome \
lxml \
url==0.1.6 \
markupsafe \
scandir \
pyyaml==3.12 \
pyyaml 
"

# FIXME:
# Does not build on old 32 bits Linux: lxml==3.6.4 \
# Does not build: re2 requires a vendoring or package of re2: re2 \


# Compile (or fetch pre-built) wheels
############################
for PYBIN in /opt/python/*/bin; do
    for PACKAGE in $PACKAGES; do
        ${PYBIN}/pip wheel --wheel-dir=/io/wheels $PACKAGE
    done
done

# Fetch sources
############################
# we use 2.7 for downloads
export PIPBIN=/opt/python/cp27-cp27m/bin/pip
for PACKAGE in $PACKAGES; do
    echo ""
    $PIPBIN download -d /io/wheels --no-binary :all: $PACKAGE
done

ls -al /io/wheels


# Bundle external shared libraries into the wheels
#for whl in wheels/*.whl; do
#    auditwheel repair $whl -w /io/wheels
#done
