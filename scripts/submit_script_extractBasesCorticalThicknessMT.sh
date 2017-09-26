#! /bin/bash
#
# This script has been created to run the /sbia/home/sotirasa/Code/Internal/BLSA-HCMA-Test/extractBasesMT
# command and is designed to be run via qsub, as in:
#		qsub /path/to/scriptname
#
# The script can be customized as needed.
#
################################## START OF EMBEDDED SGE COMMANDS #######################
### SGE will read options that are treated by the shell as comments. The
### SGE parameters must begin with the characters "#$", followed by the
### option.
###
### There should be no blank lines or non-comment lines within the block of
### embedded "qsub" commands.
###
############################ Stadard parameters to the "qsub" command ##########
#### Set the shell (under SGE).
#$ -S /bin/bash
####
#### Run the commands in the directory where the SGE "qsub" command was given:
#$ -cwd
####
#### save the standard output. By default, the output will be saved into your
#### home directory. The "-o" option lets you specify an alternative directory.
#$ -o /cbica/projects/pncNmf/directory_on_cbica/results/extractBasesMT.$JOB_ID.stdout
#### save the standard error:
#$ -e /cbica/projects/pncNmf/directory_on_cbica/results/extractBasesMT.$JOB_ID.stderr
####
#### My email address:
#$ -M Nicholas.Neufeld@uphs.upenn.edu
#### send mail at the beginning of the job
#$ -m b
#$ -m e
#$ -m a
##################################
#### Optional SGE "qsub" parameters that could be used to customize
#### the submitted job. In each case, remove the string:
####		REMOVE_THIS_STRING_TO_ENABLE_OPTION
#### but leave the characters:
#### 		#$
#### at the beginning of the line.
####
####
### Indicate that the job is short, and will complete in under 15 minutes so
### that SGE can give it priority.
### 	WARNING! If the job takes more than 15 minutes it will be killed.
#REMOVE_THIS_STRING_TO_ENABLE_OPTION$ -l short
####
####
#### Request that the job be given 6 "slots" (CPUS) on a single server instead
#### of 1. You MUST use this if your program is multi-threaded, you should NOT
#### use it otherwise. Most jobs are not multi-threaded and will not need this
#### option.
#$ -pe threaded 4
####
####
####
#### The "h_vmem" parameter gives the hard limit on the amount of memory
#### that a job is allowed to use. As of July, 2012, that limit is
#### 4GB. Please consult wit the SGE documentation on the Wiki for
#### current informaiton.
#### 
#### In order to use more memory in a single job, you MUST set the
#### "h_vmem" parameter. Jobs that exceed the "h_vmem" value (by even
#### a single byte) will be automatically killed by the scheduler.
#### 
#### Setting the "h_vmem" parameter too high will reduce the number
#### of machines available to run your job, or the number of instances
#### that can run at once.
#### 
####
#$ -l h_vmem=30G 
#### 
#REMOVE_THIS_STRING_TO_ENABLE_OPTION$ -l centos5=FALSE
#### 
################################## END OF DEFAULT EMBEDDED SGE COMMANDS###################

# Send some output to standard output (saved into the
# file ${sge_job_output_dir}/extractBasesMT.$JOB_ID.stdout) and standard error (saved
# into the file ${sge_job_output_dir}/extractBasesMT.$JOB_ID.stderr) to make
# it easier to diagnose queued commands

# in order to use module command
. /usr/share/Modules/init/bash
if [ $? != 0 ] ; then
	echo "Failure to load /usr/share/Modules/init/bash"
	exit 1
fi

/bin/echo "Command: /cbica/home/sotirasa/comp_space/ForNick/Test/extractBasesCorticalThicknessM"
/bin/echo "Arguments: List of input files: leftHemisphere: $1 rightHemisphere: $2 NumBases: $3 Output Directory: $4"
/bin/echo -e "Executing in: \c"; pwd
/bin/echo -e "Executing on: \c"; hostname
/bin/echo -e "Executing at: \c"; date
/bin/echo "----- STDOUT from ./extractBasesMT below this line -----"

/bin/echo "Command: /cbica/home/sotirasa/comp_space/ForNick/Test/extractBasesCorticalThicknessM" 1>&2
/bin/echo "Arguments: List of input files: leftHemisphere: $1 rightHemisphere: $2 NumBases: $3 Output Directory: $4"
( /bin/echo -e "Executing in: \c"; pwd ) 1>&2
( /bin/echo -e "Executing on: \c"; hostname ) 1>&2
( /bin/echo -e "Executing at: \c"; date ) 1>&2
/bin/echo "----- STDERR from ./extractBasesMT below this line -----" 1>&2

leftHemisphere=$1
rightHemisphere=$2
num_bases=$3
output_dir=$4

extractBasesMT=/cbica/projects/pncNmf/directory_on_cbica/scripts/extractBasesCorticalThicknessMT

# keep some extra information in the output directory
mkdir -p ${output_dir}/NumBases${num_bases}

# keep a copy of the command that was used 
date2save=$(date +"%m-%d-%y")
command="${extractBasesMT} OPNMF ${leftHemisphere} ${rightHemisphere} ${num_bases} outputDir ${output_dir} initMeth 1 saveInterm 1 negPos 0"
echo ${command} > ${output_dir}/NumBases${num_bases}/command_${date2save}.txt

"${extractBasesMT}" "OPNMF" "${leftHemisphere}" "${rightHemisphere}" "${num_bases}" "outputDir" "${output_dir}" "initMeth" "1" "saveInterm" "1" "negPos" "0" 

if [ $? != 0 ] ; then
	date_info=$(date)
	echo "${date_info} : Failure to execute extractBasesMT"
	echo "${date_info} : Failure to execute extractBasesMT, JobID: ${JOB_ID}, method: ${method}, number of bases: ${num_bases}" >> ${output_dir}/FailedExtractBasesExperimentsMT.txt
	exit 1
fi
