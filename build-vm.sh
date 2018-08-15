#!/usr/bin/env bash

echo "### Building VM"
vagrant up

if [ "$1" = "package" ]; then
    echo "Packaging built image into .box file."
    OUTFILE=fabric-tutorial-$(date -u +%Y%m%d.%H%M%S).box
    vagrant package --output $OUTFILE
    echo "Package created. Removing installed images."
    vagrant destroy -f

    echo "Package built: $(pwd)/$OUTFILE"
fi
