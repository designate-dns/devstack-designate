#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for f in lib/* extras.d/* exercises/*; do
    echo "Installing symlink for $f"
    rm ../devstack/$f || true
    ln -s $DIR/$f ../devstack/$f
done

for f in patches/*; do
    echo "Applying patch $f"
    patch -p1 --forward --no-backup-if-mismatch -d ../devstack/ < $f
done

# Cleanup any rejects...
find ../devstack -name *.rej -exec rm {} \;