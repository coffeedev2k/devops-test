#!/usr/bin/env bash
until nc -z -v -w30 postgre 5432
do
    echo "Waiting a second until the database is receiving connections..."
    sleep 1
done

flask db upgrade # construct the data model

cd /app

gunicorn -w 4 -b 127.0.0.1:80 app:app # start the web application
