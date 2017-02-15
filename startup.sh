#!/bin/bash
set -ueo pipefail

# Set defaults for variables that can be overridden by the env
COUNT=${COUNT:-1}
OPTIONS=${OPTIONS:-"-v -r 1 -c 10"}

# Number of runs we have performed
RUNS=0

# Write URLS to the urls.txt file
echo -e "$URLS" > /root/urls.txt

# Loop forever, either running the siege $COUNT times, or sleeping
while true; do
  if [ ${RUNS} -ge ${COUNT} ]; then
    echo "$(date): Sleeping"
    sleep 60
  else
    echo "Running: siege ${OPTIONS}"
    siege ${OPTIONS} -H "Cookie: ${COOKIE}"
    RUNS=$(( RUNS + 1 ))
  fi
done
