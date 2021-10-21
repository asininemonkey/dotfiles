#!/usr/bin/env bash

sudo defaults write bluetoothaudiod "Enable AptX codec" -bool false
sudo defaults write bluetoothaudiod "Enable AAC codec" -bool true

sudo defaults read bluetoothaudiod
