#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

set -o errexit

cd "$(dirname "$0")" || exit

export CULT_CASE="Test case $1"

./cult --test 'Should extract values' 'http://time.jsontest.com'

IFS=$'\n' read -r -d '' TIME DATE < <(./cult -e '.json.time' -E '.json.date') || true

./cult -t "Extracted date time: $DATE $TIME" -a "\"$DATE\" != "null"" -a "$TIME != null"

./cult --test "My Test $1 B" \
	--assert='.json.hello == "world"' \
	--assert '.json.tester == "curl"' \
	-a '.status == 200' \
	'http://echo.jsontest.com/hello/world/tester/curl'

./cult --test "My Test $1 C" --assert='.status == 200' 'http://ifconfig.me'
