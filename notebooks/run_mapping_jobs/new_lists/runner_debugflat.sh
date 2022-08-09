#!/bin/bash
#SBATCH --job-name=debug_flatlists_job    # Job name
#SBATCH --mail-type=BEGIN,END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=clare.morris@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=10                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request (per node)
#SBATCH --time=8:00:00               # Time limit hrs:min:sec
#SBATCH --output=logfiles/FINAL_new_lists_job_%j.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=150G                     # Request the amount of space your jobs needs on /scratch/fast
 
singularity exec docker://alleninst/mapping_on_hpc example_update_select.marker_cl.dat.R > logfiles/debug_flatlists_logfile
