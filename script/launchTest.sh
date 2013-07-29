#!/bin/bash

nToy=50000
plotStep=1000
mass=120
nJobs=5
let nJobs_=$nJobs-1
winSize=10
jobNumb=0
muGen=$1

mergeDir=TestSWResults/mergeDir
if [ ! -e "$mergeDir" ]; then mkdir $mergeDir; fi

# 1pow pow2_1 pow2_2
# 1pol 
# exp2_1 exp2_2 exp3_1 exp3_2 exp_3_3

#

# time ./build/TestSW.exe -t 1000 -p $plotStep  -m $mass -w $winSize -wide -pG -sigGen \
#     -gen 1pow -fit pow2_2 \
#     -f events_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_0.0_350.0_0.0_-1_-1_0_4_cs-ws.root \
#     -dataf histo_massgg_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_2.5_350.0_2.6_-1_-1_0_4.root #> log/$mass.log
# exit 0

# 

for jobNumb in `seq 0 $nJobs_`
  do
#exp3_3 pow2_2 exp2_2  exp3_2
  for fitFun in  1exp 1pow 2pol pow2_1 exp2_1 exp3_1 1pol  3pol 4pol 
    do
    for genFun in 1exp 1pow 2pol
      do
      for mass in 110 115 120 130 140
	do
	  (
# 		if [ ! -e "log/log/$mass-$genFun-$fitFun-$jobNumb'_'$nJobs.log" ]; then
# 		    echo "Starting $mass $genFun $fitFun $jobNumb/$nJobs"
#	      if [ "$muGen" != "0" ]; then  muGenString="-sigGen -muGen $muGen"; else muGenString=""; fi		    
	      ./build/TestSW.exe -v -t $nToy -p $plotStep -nJ $nJobs -j $jobNumb -m $mass -w $winSize -wide -pG \
		  -gen $genFun -fit $fitFun -p $step -sigGen -muGen $muGen  \
		  -f events_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_0.0_350.0_0.0_-1_-1_0_4_cs-ws.root \
		  -dataf histo_massgg_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_2.5_350.0_2.6_-1_-1_0_4.root &> log/$mass-$genFun-$fitFun-$jobNumb'_'$nJobs-$muGen.log
	    echo "Done $mass $genFun $fitFun $jobNumb/$nJobs"
	    
# 		else
# 		    echo "Already done: $mass $genFun $fitFun $jobNumb/$nJobs"
# 		fi
	  ) &
	done 		# fit fun
#	  wait
      done   # mass
      wait
    done # genFun
    wait
done # jobNumb


