#! /bin/bash

set -x
set -e

# Upgrade from v3.0.0 & v3.0.1 to fix hierarchy detection for v3.0.x
python3 -m pip install pynqmetadata==0.1.2
