#!/bin/bash
#SBATCH --job-name=3_4_applied_job    # Job name
#SBATCH --mail-type=BEGIN,END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=clare.morris@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=50                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request (per node)
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=logfiles/3_4_applied_job_%j.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=450G                     # Request the amount of space your jobs needs on /scratch/fast
 
singularity exec docker://alleninst/mapping_on_hpc Rscript R_scripts/flat_3_4_applied.R > logfiles/3_4_applied_logfile
