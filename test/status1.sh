#!/bin/sh
root_dir=$(dirname "$0")/..

ruby $root_dir/main.rb $root_dir/src/status1.rb
status=$?
exit $status
