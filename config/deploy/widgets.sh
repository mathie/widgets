#!/bin/sh

export DATABASE_URL="postgresql://postgres@${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/widgets?pool=5"

cd /srv/widgets

# Create the database if it doesn't already exist, and migrate it to the latest
# version. Should be safe enough for this sort of project, but probably not the
# sort of thing you'll want to do in production!
/sbin/setuser widgets bundle exec rake db:create
/sbin/setuser widgets bundle exec rake db:migrate

exec /sbin/setuser widgets bundle exec \
  unicorn -p ${PORT} -c config/unicorn.rb \
    >> /var/log/rails.log 2>&1