#!/usr/bin/env bash

. ./cult


./cult --scenario "Labeling"
./cult --case "Should print the current scenario, case and step properly"

./cult --step "Check scenario labeling"
grep --silent --regexp='Scenario: Labeling$' "$CULT_LOG"

./cult --step "Check case labeling"
grep --silent --regexp="Case: Should print the current scenario, case and step properly$" "$CULT_LOG"

./cult --step "Check step labeling"
grep --silent --regexp="Check step labeling$" "$CULT_LOG"

./cult --test '.ip != null' http://ip.jsontest.com/

./cult \
	--case "Should support comments in the body" \
	'http://echo.jsontest.com/hello/world' <<- EOF
		{
			# ignoring comment
			"hello": "world"
		}
	EOF

./cult \
	--case "Should populate faker placeholders" \
	'http://echo.jsontest.com/hello/world' <<- EOF
		{
			"fixed": "fixedValue",
			"email": "!email",
			"username": "!user_name",
			"value": "!pyint{'max_value': 10}",
			"cpf": "!cpf"
		}
	EOF
