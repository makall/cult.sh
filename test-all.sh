#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

set -o errexit

trap "./cult --report" EXIT

cd "$(dirname "$0")" || exit

./cult --begin --test-scenario "My Test Scenario"

./test.sh 1
./test.sh 2
./test.sh 3
./test.sh 3

./cult --test "My Test 4 A"
./cult --test "My Test 4 A"
./cult --test "My Test 4 A"
./cult --test "My Test 4 A"
./cult --test "My Test 4 A"
