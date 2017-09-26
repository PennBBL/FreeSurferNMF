#!/bin/bash      

# This is the script that creates the TCL script that is supposed to be called from within tksurfer
# by the scripts takeScreenShotLhOverlayFileTkSurfer and takeScreenShotRhOverlayFileTkSurfer

fig_path=$1
new_name=$2
fig_color_path=$3
fig_label_path=$4
script_name="${fig_path}/${new_name}_shotscript.tcl"
# create file
echo "# TCL script to be used with tksurfer" > ${script_name}

# start filling the script for standard figures
echo "make_lateral_view" >> ${script_name} 
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_path}/${new_name}_lat.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "rotate_brain_x 90" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_path}/${new_name}_inf.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "rotate_brain_x 180" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_path}/${new_name}_sup.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "make_lateral_view" >> ${script_name}
echo "rotate_brain_y 180" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_path}/${new_name}_med.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

# adding colorbar
echo "set colscalebarflag 1" >> ${script_name} 
echo "redraw" >> ${script_name} 
echo "UpdateAndRedraw" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "make_lateral_view" >> ${script_name} 
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_color_path}/${new_name}_lat.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "rotate_brain_x 90" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_color_path}/${new_name}_inf.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "rotate_brain_x 180" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_color_path}/${new_name}_sup.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "make_lateral_view" >> ${script_name}
echo "rotate_brain_y 180" >> ${script_name}
echo "redraw" >> ${script_name} 
echo "save_tiff ${fig_color_path}/${new_name}_med.tiff" >> ${script_name} 
echo -e "\n" >> ${script_name}

echo "exit" >> ${script_name} 

