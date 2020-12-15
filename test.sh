#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

TEST_COUNT="${1:-0}"

cd "$(dirname "$0")" || exit

. ./cult

./cult \
	--case "Test case $TEST_COUNT" \
	--step "My Test $TEST_COUNT B" \
	--test '.hello == "world"' \
	--test '.tester == "curl"' \
	--var 'hello' '.hello' \
	'http://echo.jsontest.com/hello/world/tester/curl'

./cult --print '.'

./cult -a '.json.hello == "world"' https://postman-echo.com/post <<- EOF
	{ "hello": \$hello }
EOF

./cult --scenario 'My Scenario'
echo "Some comment"

echo "Some text on stderr" >&2

./cult --case 'My Case'
echo "Another comment"

#echo "$blah"
./cult --step 'My Step'
echo "Last comment"


