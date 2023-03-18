#!/bin/bash

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Enabled plugins for JupyterLab
sudo mkdir -p $target/root/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension
sudo cp $script_dir/plugin.jupyterlab-settings $target/root/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/
