#!/usr/bin/env bash

PWD=$(pwd)

tmp_dir=$PREFIX/tmp/mapd-core

mkdir -p $tmp_dir
rm -rf $tmp_dir/*
cd $tmp_dir

git clone --depth 1 https://github.com/mapd/mapd-core.git

cd $tmp_dir/mapd-core/scripts
PREFIX_OLD=$PREFIX

source mapd-deps-osx.sh > $PREFIX/mapd-deps-osx.log &2>1

PREFIX=$PREFIX_OLD
cd $PWD
rm -rf $tmp_dir
