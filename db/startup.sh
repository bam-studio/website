#!/bin/bash
set -e

DNS_NAME=$1
MNT_DIR=$2

mkdir -p $MNT_DIR

mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $DNS_NAME:/ $MNT_DIR

mkdir -p $MNT_DIR/bam-studio/mongo/data/db

mongod --dbpath $MNT_DIR/bam-studio/mongo/data/db
