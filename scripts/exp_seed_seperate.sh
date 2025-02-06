#!/bin/bash

SCRIPT_PATH=/home/vagrant/scripts/debug_workload.sh
OUTPUT_PATH=/home/vagrant/pm-workloads/FAST_FAIR/concurrent_pmdk/output/
DOWNLOAD_PATH=/home/vagrant/download/pmrace_results

KICKTHETIRES=$1


if [ -z $KICKTHETIRES ] ; then
	TIMEOUT=10m
	SEED_MAX=1000
else
	TIMEOUT=30s
	SEED_MAX=10

	echo Running seed analysis for Kick-the-tires
fi

rm $DOWNLOAD_PATH/* -fr

SEED_ID=0

for seed in seeds/full/ff/* ; do
	rm seeds/sample/ff/* 

	echo $SEED_ID
	echo $seed
	cp $seed seeds/sample/ff/

	mkdir $DOWNLOAD_PATH/seed$SEED_ID -p 

	timeout $TIMEOUT $SCRIPT_PATH fast_fair sample

	rm $OUTPUT_PATH/seed0/*/ -rf
	rm $OUTPUT_PATH/seed0/*.log -rf
	cp $OUTPUT_PATH/seed0/* $DOWNLOAD_PATH/seed$SEED_ID
	cp $seed $DOWNLOAD_PATH/seed$SEED_ID/

	SEED_ID=$(expr $SEED_ID + 1)

	if [ $SEED_ID -eq $SEED_MAX ] ; then
		exit
	fi
done

