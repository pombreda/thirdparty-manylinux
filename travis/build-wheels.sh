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
    ${PYBIN}/pip wheel intbitset --wheel-dir=wheels
    ${PYBIN}/pip wheel bitarray --wheel-dir=wheels
    ${PYBIN}/pip wheel lxml==3.6.4 --wheel-dir=wheels
    ${PYBIN}/pip wheel tinyarray --wheel-dir=wheels
    ${PYBIN}/pip wheel pyahocorasick --wheel-dir=wheels
    ${PYBIN}/pip wheel https://github.com/WojciechMula/pyahocorasick/archive/19282329183f465130cb9cb3538c9ac44c9cf796.zip --wheel-dir=wheels
done

ls -al wheels
rm -rf wheels/six*whl

# Bundle external shared libraries into the wheels
#for whl in wheels/*.whl; do
#    auditwheel repair $whl -w /io/wheels
#done

# Install packages and test
# for PYBIN in /opt/python/*/bin/; do
#     ${PYBIN}/pip install python-manylinux-demo --no-index -f /io/wheels
#     (cd $HOME; ${PYBIN}/nosetests pymanylinuxdemo)
# done
