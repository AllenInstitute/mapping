#!/bin/bash
#SBATCH --job-name=part1_job    # Job name
#SBATCH --mail-type=BEGIN,END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=clare.morris@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request (per node)
#SBATCH --time=48:00:00               # Time limit hrs:min:sec
#SBATCH --output=part1_jobs_%j.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=150G                     # Request the amount of space your jobs needs on /scratch/fast
 
singularity exec docker://alleninst/mapping_on_hpc Rscript part1_jobs.R > part1_jobs_logfile
