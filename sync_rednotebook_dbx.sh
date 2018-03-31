#!/bin/bash

SYNC_DIR=~/Dropbox/rednotebook-data
REDNOTEBOOK_DIR=~/.rednotebook/data
if [ ! -d $SYNC_DIR ]; then
    mkdir $SYNC_DIR
fi
if [ -e $REDNOTEBOOK_DIR/* ]; then
    mv $REDNOTEBOOK_DIR/* $SYNC_DIR
fi
rm -Rf $REDNOTEBOOK_DIR
ln -s $SYNC_DIR $REDNOTEBOOK_DIR

