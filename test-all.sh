#!/usr/bin/env bash
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

cd "$(dirname "$0")" || exit

. ./cult

./cult --scenario "My Test Scenario"

./test.sh 1
./test.sh 2
./test.sh 3
./test.sh 3

./cult --step "My Test 4 A"
./cult --step "My Test 4 A"
./cult --step "My Test 4 A"
./cult --step "My Test 4 A"
./cult --step "My Test 4 A"
