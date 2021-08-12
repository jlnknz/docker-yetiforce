#!/usr/bin/env sh

set -eu;

WITNESS_FILE=/app/.app-yeti-installed

if [ -f ${WITNESS_FILE} ]; then
  echo "YetiForce package already exists at its destination.";
  exit 0;
fi

touch ${WITNESS_FILE};

cd /app
unzip /yetiforce-from-github-complete.zip

rm /app/.user.ini
rm /app/public_html/.user.ini

echo "YetiForce package has been unzipped to its destination. All good."
