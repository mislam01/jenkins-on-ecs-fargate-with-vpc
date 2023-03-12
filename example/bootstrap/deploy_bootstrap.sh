#!/usr/bin/env bash
set -e

###source vars.sh

# Start from a clean slate
rm -rf .terraform

terraform init \
    -backend=false

terraform plan \
    -var-file=../init.auto.tfvars \
    -lock=false \
    -input=false \
    -out=tf.plan

terraform apply \
    -input=false \
    -auto-approve=true \
    -lock=true \
    tf.plan