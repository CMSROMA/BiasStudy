#!/bin/tcsh

script/start.sh 0 1 > & ! log/0_1.log &
script/start.sh 0 2 > & ! log/0_2.log &
script/start.sh 0 3 > & ! log/0_3.log &
script/start.sh 0 4 > & ! log/0_4.log &
script/start.sh 0 5 > & ! log/0_5.log &

#script/start.sh 1 1 > & ! log/1_1.log &
#script/start.sh 1 2 > & ! log/1_2.log &
#script/start.sh 1 3 > & ! log/1_3.log &
#script/start.sh 1 4 > & ! log/1_4.log &
#script/start.sh 1 5 > & ! log/1_5.log &
#script/start.sh 3 1 > & ! log/3_1.log &
#script/start.sh 3 2 > & ! log/3_2.log &
#script/start.sh 3 3 > & ! log/3_3.log &
#script/start.sh 3 4 > & ! log/3_4.log &
#script/start.sh 3 5 > & ! log/3_5.log &
