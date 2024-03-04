#!/bin/bash

set -e

sudo -u ec2-user -i <<'EOF'

# PARAMETERS
ENVS=(
python3
pytorch_p36
)

mkdir -p /opt/.sagemaker

# Install Neptune client library
for env in $ENVS; do
    source /home/ec2-user/anaconda3/bin/activate $env
    pip install neptune
    source /home/ec2-user/anaconda3/bin/deactivate
done

# Install Jupyter extension
source /home/ec2-user/anaconda3/bin/activate JupyterSystemEnv
pip install neptune-notebooks
jupyter nbextension enable --py neptune-notebooks --sys-prefix
jupyter labextension install neptune-notebooks
source /home/ec2-user/anaconda3/bin/deactivate
EOF
