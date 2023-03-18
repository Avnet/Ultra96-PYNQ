#! /bin/bash

set -x
set -e

# Prep to install ipycanvas Jupyter Lab extension, it needs npm, PYNQ provides nodejs
#curl -L https://www.npmjs.org/install.sh | sh

source /etc/profile.d/pynq_venv.sh

# Install the package then install / compile it as a Jupyter Lab extension
pip3 install ipycanvas orjson
#jupyter labextension install @jupyter-widgets/jupyterlab-manager ipycanvas --no-build
#jupyter lab build
#jupyter labextension install ipycanvas
