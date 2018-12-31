#!/bin/bash

apt install python3-pip
pip3 install virtualenv virtaulenvwrapper

export VIRTUALENVWRAPPER_PYTHON=`which python3`
source `which virtualenvwrapper.sh`
