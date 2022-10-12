#!/bin/bash

set -x
set -e

# Pull in env vars like PYNQ_JUPYTER_NOTEBOOKS to this script
. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

# Ultra96 v1 has TI chip and is programmed differently
rm $PYNQ_JUPYTER_NOTEBOOKS/bluetooth_u96v2.ipynb
