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


eecho "--- Ensuring fresh dependencies"
rm -rf ./vendor/*
composer install


eecho ""
eecho "***********************"
eecho "*** INSTALL DONE! *****"
eecho "***********************"