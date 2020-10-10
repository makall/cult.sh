#!/usr/bin/env sh
# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

cd "$(dirname "$0")" || exit

export CULT_CASE="Test case $1"

./cult --test "My Test $1 A"
./cult --test "My Test $1 B"
./cult --test "My Test $1 C"
