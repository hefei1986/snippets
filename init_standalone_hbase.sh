#!/bin/bash

set -e

ROOT_DIR=/home/hadoop/
PACKAGE_DIR=$ROOT_DIR/packages
DATA_DIR=/$ROOT_DIR/cluster-data


ZK_PACKAGE_NAME="zookeeper-3.4.10"
HADOOP_PACKAGE_NAME=
HBASE_PACKAGE_NAME=

ZK_PACKAGE_ADDRESS="http://mirror.bit.edu.cn/apache/zookeeper/stable/zookeeper-3.4.10.tar.gz"
ZK_PACKAGE_FILE="$ZK_PACKAGE_NAME.tar.gz"
ZK_RUNTIME_DIR="$ROOT_DIR/zookeeper-current"



# check user account
who=`whoami`
if [ "$who" != "hadoop" ]
then
	echo "Must run in hadoop account."
	exit -1
fi
# end of checking user account



# Installing Zookeeper
# download package
mkdir -p $PACKAGE_DIR
echo "downloading zookeeper package"
cd $PACKAGE_DIR && rm -rf $ZK_PACKAGE_FILE && rm -rf $ZK_PACKAGE_NAME && wget $ZK_PACKAGE_ADDRESS && tar -xvzf $ZK_PACKAGE_FILE
if [ -e $ZK_RUNTIME_DIR ]
then
	cd $ZK_RUNTIME_DIR && bin/zkServer.sh stop
fi
cd $ROOT_DIR && rm -rf $ZK_PACKAGE_NAME && rm -rf $ZK_RUNTIME_DIR
cp -r $PACKAGE_DIR/$ZK_PACKAGE_NAME $ROOT_DIR && ln -s $ROOT_DIR/$ZK_PACKAGE_NAME $ZK_RUNTIME_DIR
mkdir -p $DATA_DIR

