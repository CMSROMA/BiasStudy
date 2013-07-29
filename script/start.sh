
#!/bin/bash
#append=local

usage(){
    echo "Usage: `basename $0` joblist_file" > /dev/stderr
}

case $# in 
    0)
	echo -n "Error: " > /dev/stderr
	usage
	exit 1
	;;
    *)
	;;
esac

taskName=ttHhadCS_btagloose
queue=1nd

fixed=0
noPois=1
onlyB=1
nToy=4000
nJobs=1

muGen=$1
jobNumb=$2

let nJobs_=$nJobs-1

#for jobNumb in `seq 0 $nJobs_`
#  do
#exp3_3 pow2_2 exp2_2  exp3_2
#1exp 1pow 2pol pow2_1 exp2_1 exp3_1 1pol  3pol 4pol 
#  for fitFun in  2pol 3pol 4pol 1exp 1pow 
mkdir -p log/
mkdir -p log/$taskName
mkdir -p batch/
mkdir -p batch/${taskName}
echo "################ Task ${taskName} ##############"    


#  for fitFun in  3pol 
  for fitFun in  2pol 3pol 4pol 1exp 1pow
    do
    for genFun in 1exp 1pow 2pol 
#    for genFun in 1exp 1pow 3pol 
#    for genFun in 1exp 
      do
#      for mass in 110 115 130 140
      for mass in 110 115 120 125 130 140
#      for mass in 110
	do

	echo "Processing jobNumb: $jobNumb, fitFun: $fitFun, genFun: $genFun, mass: $mass" > /dev/stdout    
	
#	analysis_=`echo $PWD | sed 's|/batch||'`
#	analysis=`basename $analysis_`
	
	sample=g$genFun'_f'$fitFun'_m'$mass'_j'$jobNumb'_mu'$muGen
	jobname=$taskName"_"$sample
#	stderr_file=log/$taskname/`basename $sample_ .list`-err.log
	stdout_file=`pwd`/log/$taskName/`basename ${sample}_ .list`-out.log
	#bsub -u $USER@cern.ch -L /bin/bash -J $jobname -q $queue -eo $stderr_file -oo $stdout_file $analysis.sh 
	if [ "$queue" = "local" ]; then  
	    ./script/TestFit.sh $nToy $jobNumb $mass $genFun $fitFun $muGen $fixed $noPois ${onlyB} ${taskName} &> log/${taskName}/$mass-$genFun-$fitFun-$jobNumb'_'$nJobs-$muGen.log
	else
	    cat <<EOF >  batch/$taskName/${jobname}.sh
#!/bin/sh
`pwd`/script/TestFit.sh $nToy $jobNumb $mass $genFun $fitFun $muGen $fixed $noPois  ${onlyB} $taskName 
EOF
    echo "bsub -J $jobname -q $queue -o $stdout_file < `pwd`/batch/$taskName/${jobname}.sh"
	    bsub -J $jobname -q $queue -o $stdout_file < `pwd`/batch/$taskName/${jobname}.sh
	fi
	done
      done
  done
#done

	
