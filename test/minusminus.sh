#!/bin/sh
root_dir=$(dirname "$0")/..

ruby $root_dir/main.rb $root_dir/src/minusminus.rb
if [[ $? -eq 1 ]]; then
    exit 0
else
    exit 1
fi
