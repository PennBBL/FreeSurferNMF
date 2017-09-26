#!/bin/bash      

# needs two arguments : 
# 	the path to the Overlay directory of the result whose snapshots one wants to take
# 	the path to the directory where the results are going to be saved

scriptDir="/data/joy/BBL/studies/STOP_PD/next_level_chead_directory/scripts/";

source $FREESURFER_HOME/SetUpFreeSurfer.sh

overlay=$1;
overlay=$(echo ${overlay%/})

output_path=$2;
output_path=$(echo ${output_path%/})

echo ${overlay};
rev_overlay=$(echo ${overlay} | rev)
cut_overlay=$(echo ${rev_overlay} | cut -f2- -d "/")
path=$(echo ${cut_overlay} | rev)

# first read min, median and max values
hist_path="${path}/DataPerVertex"
hist_file="${hist_path}/histInfo.txt"

#echo "Reading histogram values"
index=0
declare -a lineinfo
while read line
do
	echo ${line}
	lineinfo[${index}]=$(echo ${line})
	index=$(( ${index} + 1 ))
done < ${hist_file}

# path for standard figures
#help_path=$(echo ${overlay} | rev | cut -f3-4 -d "/" | rev)
fig_path="${output_path}/Figures_Rh/tkViews"
if [ ! -d "${fig_path}" ]; then	
	mkdir -p ${fig_path}
fi
	
# path for figures with color bar	
fig_color_path="${output_path}/Figures_Rh/ColorBar"
if [ ! -d "${fig_color_path}" ]; then	
	mkdir -p ${fig_color_path}
fi

index=0		
for f in $(find ${overlay} -name "*rh.mgh")
do
	mgh_name=$(echo ${f##*/})
	new_name=$(echo ${mgh_name%.*})
        echo ${mgh_name}
        echo ${new_name}
        # write standard figures
	if [ ! -f "${fig_path}/${new_name}_lat.tiff" ] || [ ! -f "${fig_path}/${new_name}_inf.tiff" ] || [ ! -f "${fig_path}/${new_name}_sup.tiff" ] || [ ! -f "${fig_path}/${new_name}_med.tiff" ]
	then
		echo "${fig_path}/${new_name}"
		echo " figures WITH annotation"
		
		echo "creating necessary TCL script"
		${scriptDir}writeTCLscript.sh ${fig_path} ${new_name} ${fig_color_path} ${fig_label_path}
		
		echo "calling tksurfer to take the snapshots"
		
		min=$(echo ${lineinfo[${index}]} | cut -d " " -f1 )
		max=$(echo ${lineinfo[${index}]} | cut -d " " -f2 )
		mid=$(echo ${lineinfo[${index}]} | cut -d " " -f3 )
		echo ${lineinfo[${index}]}
		index=$(( ${index} + 1 ))
		echo "min : ${min}"
		echo "max : ${max}"
		echo "mid : ${mid}"
		
		tksurfer fsaverage rh inflated -overlay ${overlay}/${mgh_name} -fminmax ${min} ${max} -fmid ${mid} -tcl "${fig_path}/${new_name}_shotscript.tcl"
	fi
		
done
