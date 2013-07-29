#!/bin/bash


case $# in 
    10)
	nToy=$1
	jobNumb=$2
	mass=$3
	genFun=$4
	fitFun=$5
	muGen=$6
	fixed=$7
	noPois=$8
	onlyB=$9
	taskName=${10}
	;;
    *)
	echo "Wrong number of parameters"
	exit 1
	;;
esac

nJobs=1
plotStep=1
winSize=10

echo " ***** ${taskName} ********* "
#export local_output_dir=./output
export xrootd_server=pccmsrm27
export output_dir=/cms/local/meridian/TestFit/${taskName}

#CMSSW_DIR=/afs/cern.ch/cms/CAF/CMSPHYS/PHYS_EGAMMA/electrons/meridian/CMSSW425/src
CMSSW_DIR=/afs/cern.ch/work/m/meridian/CMSSW536Hgg/
BASE_DIR=/afs/cern.ch/work/m/meridian/fitCS

#shapeFile=${BASE_DIR}/events_45.0_25.0_-10000.0_-10000.0_-10000.0_-10000.0_70.0_0.0_0.0_-10000.0_0.0_0.0_0.0_0.0_0.0_300.0_0.0_-1_0_0_1_4_cs_metTagWS.root
#shapeFile=${BASE_DIR}/events_45.0_25.0_-10000.0_-10000.0_-10000.0_-10000.0_60.0_0.0_0.0_-10000.0_0.0_0.0_0.0_0.0_0.0_300.0_0.0_-1_0_0_1_4_cs_w_metTagWS.root
#shapeFile=${BASE_DIR}/events_met70_2012_ebeb-ws.root
shapeFile=${BASE_DIR}/HGG_cat7_cs_btagloose.root
signalShapeFile=${BASE_DIR}/histogg_cat7.root

cd ${CMSSW_DIR}/src
eval `scramv1 runtime -sh`

if [ -n "${WORKDIR:-x}" ]; then
    WORKDIR=${TMPDIR}
fi
cd ${WORKDIR}
echo "Running in directory `pwd` on `uname -a`"

xrd ${xrootd_server} mkdir ${output_dir}

sample=$taskName"_"g$genFun'_f'$fitFun'_m'$mass'_s'$muGen'_j'$jobNumb
mkdir -p ${sample}
cd ${sample}
#export sample=`dirname $1 | sed 's|.*filelist/||'`
#export index=`basename $1 .list | sed 's|.*-||'`
#dir=`pwd`/batch
#mkdir -p batch
#source $dir/base_script

#mkdir TestSWResults
#mkdir SWplots
#mkdir log
#shapeFile=events_45.0_25.0_-10000.0_-10000.0_-10000.0_-10000.0_60.0_0.0_0.0_-10000.0_0.0_0.0_0.0_0.0_0.0_300.0_0.0_-1_0_0_1_4_cs_metTagWS.root

#shapeFile=events_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_2.5_350.0_2.6_-1_-1_0_4_cs-ws.root
#shapeFile=events_55.0_25.0_-10000.0_-10000.0_30.0_20.0_3.5_2.5_350.0_0.0_-1_-1_0_4_cs-ws-test.root

options="-t $nToy -p $plotStep -nJ $nJobs -j $jobNumb -m $mass -w $winSize -wide -pG -gen $genFun -fit $fitFun -f $shapeFile -dataf ${signalShapeFile}" 

#only B fit
if [ "$onlyB" != "0" ]; then
    onlyBOpt=" -b"
    options=${options}${onlyBOpt}
fi

command="${BASE_DIR}/build/TestSW.exe"

if [ "$noPois" != "0" ]; then
    echo "no poisson smearing of data events"  
    command="${BASE_DIR}/build/TestSW_noPois.exe"
fi

if [ "$muGen" != "0" ]; then
    muString=" -sigGen -muGen $muGen"
    options=$options$muString
fi

if [ "$fixed" != "0" ]; then
    fixString=" -fixed"
    options=$options$fixString
fi

echo "$command $options"

mkdir -p log
mkdir -p log/${taskName}

$command $options > log/${taskName}/${sample}.log

#mkdir -p output/
#mv TestSWResults output/
#mv SWplots output/
#mv log output/


echo "$sample done"

cd SWplots
tar cvzf ../$sample.tar.gz * ../log/*
cd ..

for file in TestSWResults/*.root; do 
    xrd ${xrootd_server} rm ${output_dir}/`basename $file`
    xrdcp $file root://${xrootd_server}//${output_dir}/`basename $file`; 
done
xrd ${xrootd_server} rm ${output_dir}/$sample.tar.gz
xrdcp $sample.tar.gz root://${xrootd_server}//${output_dir}/$sample.tar.gz

echo "$sample copy done"

#tar -xzf $sample.tar.gz output/
#xrdcp $sample.tar.gz root://eoscms//eos/cms/store/caf/user/shervin/
#rfcp $sample.tar.gz /castor/cern.ch/user/s/shervin/

exit 0

