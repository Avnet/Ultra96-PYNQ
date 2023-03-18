#! /bin/bash

set -x
set -e

# Pull in env vars like PYNQ_JUPYTER_NOTEBOOKS to this script
. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

pip3 install pynq-dpu==2.5.1 --no-build-isolation
cd $PYNQ_JUPYTER_NOTEBOOKS
pynq get-notebooks pynq-dpu -p .
