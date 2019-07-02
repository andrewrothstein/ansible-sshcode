#!/usr/bin/env sh
VER=v0.8.0
DIR=~/Downloads
APPNAME=sshcode
MIRROR=https://github.com/cdr/$APPNAME/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=$3
    URL=$MIRROR/$APPNAME-$OS-$PLATFORM.$SUFFIX
    LFILE=$DIR/$APPNAME-$OS-$PLATFORM-$VER.$SUFFIX

    if [ ! -e $LFILE ];
    then
        wget -q -O $LFILE $URL
    fi

    printf "    # %s\n" $URL
    printf "    %s-%s: sha256:%s\n" $OS $PLATFORM `sha256sum $LFILE | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl linux amd64 tar
dl darwin amd64 tar



