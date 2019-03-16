#!/usr/bin/env bash
# Jordan huang<good5dog5@gmail.com>

set -o errexit
set -o pipefail
set -o nounset


if lsmod | grep "qcuda" &> /dev/null ; then
    rmmod qcuda && echo "rmmod qcuda"
fi

cd  ~/prj_qCUDA/qCUDA/qcu-driver 
make insmod

cd ~/prj_qCUDA/qCUDA/test/exe
./cudaHostAlloc_internal

cd -

