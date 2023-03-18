#! /bin/bash

set -x
set -e

# Pull in env vars like PYNQ_JUPYTER_NOTEBOOKS to this script
. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

cd $PYNQ_JUPYTER_NOTEBOOKS
git clone https://github.com/FredKellerman/PYNQ-juliabrot -b v1.0.3
cd PYNQ-juliabrot
rm -rf .git
rm .gitignore
echo "https://github.com/FredKellerman/PYNQ-juliabrot" > github-url.txt
chown -R xilinx:xilinx ./
