#!/usr/bin/env bash

readarray -d , -t excludes <<< "$1"

disable_list=( "${excludes[@]/#/--disable-rule=}" )

# tflint --config $tflint_config ${disable_list[@]} ${terraform_working_dir} 2>&1

echo "${disable_list[@]}"

