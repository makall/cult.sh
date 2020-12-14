#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

TEST_COUNT="${1:-0}"

cd "$(dirname "$0")" || exit

. ./cult

./cult \
	--case "Test case $TEST_COUNT" \
	--step "My Test $TEST_COUNT B" \
	--test '.json.hello == "world"' \
	--test '.json.tester == "curl"' \
	--test ".status == 200" \
	'http://echo.jsontest.com/hello/world/tester/curl'

./cult --step "My Test $TEST_COUNT C" -v myIP '.json' --assert '.status == 200' 'http://ifconfig.me'

./cult --step "My IP did not change" --test ".json == \$myIP" 'http://ifconfig.me'

./cult --print '.'

./cult -a '.status == 200' -a ".json.json.hello == \$myIP" https://postman-echo.com/post <<- EOF
	{ "hello": \$myIP }
EOF

./cult --scenario 'My Scenario'
echo "Some comment"

echo "Some text on stderr" >&2

./cult --case 'My Case'
echo "Another comment"

#echo "$blah"
./cult --step 'My Step'
echo "Last comment"


