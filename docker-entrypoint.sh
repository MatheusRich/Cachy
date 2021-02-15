#!/bin/sh
set -e

bundle check || bundle install --jobs 20 --retry 5
yarn install --check-files

# while ! pg_isready -h $FRETADAO_WEB_DB_HOST -p 5432 -q -U $FRETADAO_WEB_DB_USER; do
#   >&2 echo "Postgres is unavailable - sleeping..."
#   sleep 5
# done
# >&2 echo "Postgres is up - executing commands..."

# if [ -f $PID_FILE ]; then
#   rm $PID_FILE
# fi

>&2 echo "Checking database, this may take a while..."
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:schema:load

exec "$@"
