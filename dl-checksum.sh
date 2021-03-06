#!/usr/bin/env sh
DIR=~/Downloads
APPNAME=sshcode
MIRROR=https://github.com/cdr/${APPNAME}/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=${4:-tar.gz}
    local platform="${os}-${arch}"
    local url=$MIRROR/$ver/${APPNAME}-$platform.$suffix
    local lfile=$DIR/${APPNAME}-$platform-$ver.$suffix

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver linux amd64
    dl $ver darwin amd64
}

dl_ver ${1:-v0.10.0}
