#!/usr/bin/env bash
# Jordan huang<good5dog5@gmail.com>

set -o errexit
set -o pipefail
set -o nounset

startVal=1024
for i in {10..24}; do

    echo "$i"
    val=$(($startVal * (2 ** $i)))
    ./exe/cudaPointerTest $val
    # sleep 3
done

