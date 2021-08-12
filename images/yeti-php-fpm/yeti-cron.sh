#!/bin/sh
# We do not use crond because it brings problems when using docker user namespace or not running as cron
# https://serverfault.com/questions/836091/crond-cant-set-groups-operation-not-permitted
# I have tried playing with docker capabilities, but it is just cleaner to run the script every 2 minutes like this
# - Disadvantages:
#    - we won't know at what exact time the script will be run
#    - no email sent in case of failure, as this is the case for normal cron tasks
# - Advantage: no concurrent runs
#

# We *do* allow commands with non-zero return statuses,
# as cron tasks may fail and need to be re-run later
set -u;

while [ true ]; do
  sleep 120;
  /bin/sh /var/www/html/cron/cron.sh >/var/www/html/cache/logs/cron.log 2>&1;
done
