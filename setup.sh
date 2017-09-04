#!/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    SUDO="sudo"
fi

if which apt-get >/dev/null; then
    $SUDO apt-get install -y git dialog expect
elif which yum >/dev/null; then
    $SUDO yum install -y git dialog expect
elif which brew >/dev/null; then
    brew install git dialog expect
fi

if [ "$0" = "sh" ]; then
    cd ~ && git clone https://github.com/luyuhuang/myssh.git .myssh && cd .myssh
    if [ $? -ne 0 ]; then
        echo FAILED
        exit 1
    fi
fi

dir=$(pwd)

$SUDO ln -s $dir/myssh /usr/local/bin/myssh
if [ $? -ne 0 ]; then
    echo FAILED
    exit 1
fi

cat << EOF
-------------------------------------
MySSH have been installed in:
    /usr/local/bin

Use 'myssh -h' to print usage.
enjoy it!
-------------------------------------
EOF

