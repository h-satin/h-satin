#!/bin/bash
function aliasadd() {
    test -f ~/.aliases.sh || touch ~/.aliases.sh
    echo "alias $1=\"$2\"" >> ~/.aliases.sh
    source ~/.aliases.sh
}
source ~/.aliases.sh

function alscreen() {
    echo "Starting Screen::>> screen -d -m -S $1.$USER zsh -ic $1"
    screen -d -m -S $1.$USER zsh -ic $1
}

function lscreen() {
    echo "Checking Screen::>> screen -ls"
    screen -ls
}

function tchscreen() {
    echo "Checking Screen::>> screen -ls"
    screen -R $1.$USER
}

function klscreen() {
    echo "Killing Screen::>> screen -X -S $1.$USER quit"
    screen -X -S $1.$USER quit
    echo "Screens Remaining::>> screen -ls"
    screen -ls
}

function runhsk() {
    echo "Starting Handshake Server...."
    dbup;
    sleep 2;
    alscreen server;
    alscreen webpack;
    alscreen indexup;
    alscreen sidekq;
}

function resetscreens() {
    # klscreen server;
    klscreen webpack;
    klscreen indexup;
    klscreen sidekq;

    echo "Killed screens, but checking if puma server process is still running!"
    echo ""

    ps aux | grep puma;

    if [ -f ~/handshake/tmp/pids/server.pid ]; then
        echo "Process ID: $(cat ~/handshake/tmp/pids/server.pid)"
        kill -9 $(cat ~/handshake/tmp/pids/server.pid)
    fi

    echo "Starting the screens again!!"

    sleep 2;

    alscreen server;
    alscreen webpack;
    alscreen indexup;
    alscreen sidekq;
}

function whoport() {
    if [[ "$1" == "" ]]; then
        echo "netstat -ltnp"
        netstat -ltnp
    else
        echo "netstat -ltnp | grep ':$1'"
        netstat -ltnp | grep ":$1"
    fi
}
