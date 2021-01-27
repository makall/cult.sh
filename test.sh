#!/usr/bin/env bash

. ./cult

./cult --step 'step'
sleep 1
./cult --case 'case'
sleep 1
./cult --scenario 'scenario'
sleep 1

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
	--case "Should support comments in the body" \
	'http://echo.jsontest.com/hello/world' <<- EOF
		{
			"fixed": "fixedValue",
			"email": "!email",
			"username": "!user_name",
			"value": "!pyint{'max_value': 10}",
			"cpf": "!cpf"
		}
	EOF
