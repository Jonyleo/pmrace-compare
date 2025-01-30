#!/bin/bash

SCRIPT_PATH=/home/vagrant/scripts/debug_workload.sh
OUTPUT_PATH=/home/vagrant/pm-workloads/FAST_FAIR/concurrent_pmdk/output/
DOWNLOAD_PATH=/home/vagrant/download/pmrace_results

rm $DOWNLOAD_PATH/* -fr

SEED_ID=0

for seed in seeds/full/ff/* ; do
	rm seeds/sample/ff/* 

	echo $SEED_ID
	echo $seed
	cp $seed seeds/sample/ff/

	mkdir $DOWNLOAD_PATH/seed$SEED_ID -p 

	timeout 10m $SCRIPT_PATH fast_fair sample

	rm $OUTPUT_PATH/seed0/*/ -rf
	cp $OUTPUT_PATH/seed0/* $DOWNLOAD_PATH/seed$SEED_ID
	cp $seed $DOWNLOAD_PATH/seed$SEED_ID/

	SEED_ID=$(expr $SEED_ID + 1)
done

