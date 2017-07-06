#!/bin/bash

set -e

ROOT_DIR=/home/hadoop/
PACKAGE_DIR=$ROOT_DIR/packages


ZK_PACKAGE_NAME="zookeeper-3.4.10"
HADOOP_PACKAGE_NAME=
HBASE_PACKAGE_NAME=

ZK_PACKAPGE_ADDRESS="http://mirror.bit.edu.cn/apache/zookeeper/stable/zookeeper-3.4.10.tar.gz"



# check user account
who=`whoami`
if [ "$who" != "hadoop" ]
then
	echo "Must run in hadoop account."
	exit -1
fi
# end of checking user account




# download package
mkdir -p $PACKAGE_DIR
echo "downloading zookeeper package"
cd $PACKAGE_DIR && rm -rf zookeeper-3.4.10.tar.gz && wget $ZK_PACKAPGE_ADDRESS
