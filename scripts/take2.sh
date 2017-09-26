#!/bin/bash

num_bases='2 4 6 8 10 12 14 16 18 20 22 24 26 28 30'
for num_bases in $num_bases
do
./takeScreenShotLhOverlay.sh /data/joy/BBL/studies/STOP_PD/directory_on_chead/results_folder/NumBases$num_bases/OPNMF/Overlay/ /data/joy/BBL/studies/STOP_PD/directory_on_chead/results_folder/NumBases$num_bases/OPNMF/
./takeScreenShotRhOverlay.sh /data/joy/BBL/studies/directory_on_chead/results_folder/NumBases$num_bases/OPNMF/Overlay/ /data/joy/BBL/studies/STOP_PD/directory_on_chead/results_folder/NumBases$num_bases/OPNMF/
done
