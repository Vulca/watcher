#!/usr/bin/env bash

eexit() {
  echo -e "\e[91;1m!!! ${1}"
  echo -e ""
  echo -e "*************************"
  echo -e "*** INSTALL FAILED ******"
  echo -e "*************************\e[0m"
  exit
}

eecho() {
  echo -e "\e[34;1m${1}\e[0m"
}

eprintf() {
  printf "\e[93;1m${1}\e[0m"
}


eecho "*************************"
eecho "*** WATCHER INSTALLER ***"
eecho "*************************"
eecho ""

eecho "--- Pulling from github"
git clone https://github.com/terminusfoundation/watcher.git .

eecho "--- Testing if phinx.yml production environment is set up"
if [ ! -f ./phinx.yml ]; then
  eexit("phinx.yml is not configured yet. please copy phinx.yml.dist to phinx.yml and set it up.")
fi

[[ $(php vendor/bin/phinx test -e production | grep 'success') ]] || eexit "phinx.yml isn't configured correctly"

eecho "--- phinx.yml works, ensure it is assumed unchanged by git"
git update-index --assume-unchanged phinx.yml

eecho "--- Ensuring fresh dependencies"
rm -rf ./vendor/*
composer install

eecho "--- Testing if settings.php is set up"
if [ ! -f ./config.php ]; then
  eexit("config.php is not configured yet. please copy config.php.dist to config.php and set it up.")
fi

eecho "\$config = require '_preflight.php';" | php -a
[[ $(echo "\$config = require '_preflight.php';" | php -a | grep 'ERROR') ]] && eexit "settings.php misconfigured"


eecho "--- Setting up the database"
php vendor/bin/phinx migrate -e production

eecho ""
eecho "***********************"
eecho "*** INSTALL DONE! *****"
eecho "***********************"