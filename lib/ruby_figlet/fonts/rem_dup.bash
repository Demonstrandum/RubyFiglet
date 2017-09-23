#!/bin/bash

# This variable will always be in lower case.  That means that if you do
# l=Hello the result will be $l==hello.
typeset -l l

for f in *
do
  l=$f # Forces to lowercase due to typeset
  if [ "$l" != "$f" -a -e "$l" ]
  then
    rm -f "$f"
  fi
done
