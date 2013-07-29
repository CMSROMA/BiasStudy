#!/bin/bash


#  hadd TestSWResults/mergeDir/biasCheck-sigGen_1-fpow2_2.root TestSWResults/biasCheck-sigGen_1-g*_fpow2_2_m1*.root
#  hadd TestSWResults/mergeDir/biasCheck-sigGen_1-fpow2_1.root TestSWResults/biasCheck-sigGen_1-g*_fpow2_1_m1*.root
#  hadd TestSWResults/mergeDir/biasCheck-sigGen_1-fexp.root TestSWResults/biasCheck-sigGen_1-g*_f*exp*.root
#  hadd biasCheck-sigGen_1.root biasCheck-sigGen_1-fpow2_* biasCheck-sigGen_1-fexp.root biasCheck-sigGen_1-fpol.root 


 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1-fpow2_2.root TestSWResults/biasCheck-sigGen_1-g*_fpow2_2_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1-fpow2_1.root TestSWResults/biasCheck-sigGen_1-g*_fpow2_1_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1-f1pow.root TestSWResults/biasCheck-sigGen_1-g*_f1pow_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1-fexp.root TestSWResults/biasCheck-sigGen_1-g*_f*exp*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1-fpol.root TestSWResults/biasCheck-sigGen_1-g*_f*pol*.root
hadd -f TestSWResults/mergeDir/biasCheck-sigGen_1.root TestSWResults/mergeDir/biasCheck-sigGen_1-fpow2_* TestSWResults/mergeDir/biasCheck-sigGen_1-fexp.root TestSWResults/mergeDir/biasCheck-sigGen_1-fpol.root TestSWResults/mergeDir/biasCheck-sigGen_1-f1pow.root

 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10-fpow2_2.root TestSWResults/biasCheck-sigGen_10-g*_fpow2_2_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10-fpow2_1.root TestSWResults/biasCheck-sigGen_10-g*_fpow2_1_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10-f1pow.root TestSWResults/biasCheck-sigGen_10-g*_f1pow_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10-fexp.root TestSWResults/biasCheck-sigGen_10-g*_f*exp*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10-fpol.root TestSWResults/biasCheck-sigGen_10-g*_f*pol*.root
 hadd -f TestSWResults/mergeDir/biasCheck-sigGen_10.root TestSWResults/mergeDir/biasCheck-sigGen_10-fpow2_* TestSWResults/mergeDir/biasCheck-sigGen_10-fexp.root TestSWResults/mergeDir/biasCheck-sigGen_10-fpol.root TestSWResults/mergeDir/biasCheck-sigGen_10-f1pow.root

 hadd -f TestSWResults/mergeDir/biasCheck-fpow2_2.root TestSWResults/biasCheck_g*_fpow2_2_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-fpow2_1.root TestSWResults/biasCheck_g*_fpow2_1_m1*.root
 hadd -f TestSWResults/mergeDir/biasCheck-fexp.root TestSWResults/biasCheck_g*_f*exp*.root
 hadd -f TestSWResults/mergeDir/biasCheck-f1pow.root TestSWResults/biasCheck_g*_f1pow*.root
 hadd -f TestSWResults/mergeDir/biasCheck-fpol.root TestSWResults/biasCheck_g*_f*pol*.root
hadd -f TestSWResults/mergeDir/biasCheck.root TestSWResults/mergeDir/biasCheck-fpow2_* TestSWResults/mergeDir/biasCheck-fexp.root TestSWResults/mergeDir/biasCheck-fpol.root  TestSWResults/mergeDir/biasCheck-f1pow.root


