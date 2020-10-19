#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

set -o errexit

cd "$(dirname "$0")" || exit

./cult \
	--test-case "Test case $1" \
	--test "My Test $1 B" \
	--assert '.json.hello == "world"' \
	--assert '.json.tester == "curl"' \
	-a '.status == 200' \
	'http://echo.jsontest.com/hello/world/tester/curl'

./cult --test "My Test $1 C" -v myIP '.json' --assert '.status == 200' 'http://ifconfig.me'

# shellcheck disable=SC2016
./cult --test "My IP did not change" --assert '.json == $myIP' 'http://ifconfig.me'

./cult --print '.'

./cult -a '.status == 200' -a '.json.json.hello == $myIP' https://postman-echo.com/post <<- EOF
{
"hello": \$myIP
}
EOF