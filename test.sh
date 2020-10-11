#!/usr/bin/env sh
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

set -e

cd "$(dirname "$0")" || exit

export CULT_CASE="Test case $1"

./cult --test "My Test $1 A"

./cult --test "My Test $1 B" \
	--assert '.json.hello == "world"' \
	--assert='.json.tester == "curl"' \
	-a '.status == 200' \
	http://echo.jsontest.com/hello/world/tester/curl

./cult --test "My Test $1 C" --assert='.status == 200' http://ifconfig.me
