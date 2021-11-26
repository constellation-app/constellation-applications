#!/bin/bash

# Remove any local configuration files which is sometimes required to reset 
# Constellation and remove old/redundant cached files that can cause unexpected 
# errors to occur when upgrading to newer versions of Constellation.

# Author        : arcturus
# Version       : 1.0
# Last Modified : 26/11/2021

app_name="constellation"
default_linux_userdir="${HOME}/.${app_name}"
default_mac_userdir="${HOME}/Library/Application Support/${app_name}"

function os_not_supported {
    echo "Sorry, $1 is not supported by this script" && exit 1
}

function try_bat {
    echo "For Windows try using reset.bat" && exit 0
}

function ask_directory {
    echo "The directory $directory was not found."
    echo ""
    echo "What is the location of your Constellation user direcotory? You can find it by running Constellation and selecting Help -> About and look for the user directory location."
    echo ""

    read -p "Enter the location (or Ctrl + C to cancel): " directory
}

function no_files_removed {
    echo "No files removed. Bye!" && exit 0
}

function remove_files {
    rm -rf $1
    echo "Files removed"
}

directory=""

# check the OS and try to guess the constellation folder
case "$OSTYPE" in
    linux*)   directory=$default_linux_userdir ;;
    darwin*)  directory=$default_mac_userdir ;;
    win*)     try_bat ;;
    msys*)    os_not_supported "MSYS / MinGW / Git Bash" ;;
    cygwin*)  directory=$default_linux_userdir ;;
    bsd*)     directory=$default_linux_userdir ;;
    solaris*) os_not_supported "Solaris" ;;
    *)        os_not_supported "$OSTYPE" ;;
esac

if [ ! -d $directory ]
then
    ask_directory ""
fi

if [ -d $directory ]
then
    echo "WARNING: The contents of $directory will be removed and cannot be undone."
    read -p "Are you sure you want to proceed? (yes/no): " answer

    case $answer in
        [Yy]* ) remove_files "$directory" ;;
        [Nn]* ) no_files_removed ;;
        * ) echo "Please answer yes or no." && no_files_removed ;;
    esac
else
    echo "The directory $directory does not exist." && no_files_removed
fi
