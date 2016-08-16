#!/bin/bash
set -e -x

# Install a system package required by our libraries
yum install -y libxslt-devel python-devel libxml2 libxml2-devel libxslt

ls -al /opt/python/
rm -rf /opt/python/cp26-*
rm -rf /opt/python/cp33-*
rm -rf /opt/python/cp34-*
ls -al /opt/python/

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/pip wheel pyahocorasick --wheel-dir=wheels
    ${PYBIN}/pip wheel intbitset --wheel-dir=wheels
    ${PYBIN}/pip wheel bitarray --wheel-dir=wheels
    ${PYBIN}/pip wheel lxml==3.6.0 --wheel-dir=wheels
    ${PYBIN}/pip wheel tinyarray --wheel-dir=wheels

done

# Bundle external shared libraries into the wheels
for whl in wheels/*.whl; do
    auditwheel repair $whl -w /io/wheels
done

# Install packages and test
# for PYBIN in /opt/python/*/bin/; do
#     ${PYBIN}/pip install python-manylinux-demo --no-index -f /io/wheels
#     (cd $HOME; ${PYBIN}/nosetests pymanylinuxdemo)
# done
