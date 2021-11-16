#!/usr/bin/env bash
set -x

# Use the name of the current directory by default
: "${ASSET_NAME:=$(basename $(pwd))}"
INSTALL_DIR=./.asset
LIB_DIR=$INSTALL_DIR/lib
PYTHON_VERSION=$(python3 -c 'import sys; major, minor, *_ = sys.version_info; print("{}.{}".format(major, minor));')

if [ -z "$PYTHON_VERSION" ]; then echo "No python3 found"; exit 1 ; fi

rm -rf $INSTALL_DIR
# Install all required python modules, overriding the prefix to a temporary directory
pip install --prefix $INSTALL_DIR --ignore-installed --system -r requirements.txt 
# Install all the check script module, overriding the prefix to a temporary directory
# The project must have a setup.py with the required script and/or endpoints declared
pip install --prefix $INSTALL_DIR --system .
# Move all the python libraries to the top level "lib" dir to simplify the process of 
# setting $PYTHONPATH later on
rsync -a --remove-source-files "${LIB_DIR}/python${PYTHON_VERSION}/site-packages/" "${LIB_DIR}/"
rm -rf "${LIB_DIR}/python${PYTHON_VERSION}"
# Wrap up the script and it's module depencies in a tarball
tar -czf "${ASSET_NAME}.tar.gz" -C $INSTALL_DIR .
rm -rf $INSTALL_DIR
# And dump the sha512 checksum to a file because that might be handy
sha512sum "${ASSET_NAME}.tar.gz" > "${ASSET_NAME}.sha512"
