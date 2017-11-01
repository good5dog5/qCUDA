#!/usr/bin/env bash
# Jordan huang<good5dog5@gmail.com>

set -o errexit
set -o pipefail
set -o nounset

if lsmod | grep "qcuda" &> /dev/null ; then
    echo "qcuda module is loaded"
    exit 0
else
    cd qcu-driver && make && make i
    cd -
fi

cd qcu-library && make && make install
cd -
