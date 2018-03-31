#!/bin/bash

echo "new postgres user name: $USER"
echo 'input postgres user password: '
read -s PASSWD

sudo -u postgres psql -c "
    CREATE USER $USER WITH password '$PASSWD';
    ALTER ROLE $USER SET client_encoding to 'utf8';
    ALTER ROLE $USER SET default_transaction_isolation to 'read committed';
    ALTER ROLE $USER SET timezone to 'UTC';

    CREATE database django owner $USER;
" postgres
