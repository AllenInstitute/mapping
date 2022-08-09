#!/bin/bash
#SBATCH --job-name=end5_FLAT_SS_job    # Job name
#SBATCH --mail-type=BEGIN,END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=clare.morris@alleninstitute.org     # Where to send mail  
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request (per node)
#SBATCH --time=240:00:00               # Time limit hrs:min:sec
#SBATCH --output=end5_FLAT_SS_job_%j.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=300G                     # Request the amount of space your jobs needs on /scratch/fast
mkdir $TMPDIR/tmp
singularity exec --bind=/scratch/fast/$SLURM_JOBID/tmp:/tmp docker://alleninst/mapping_on_hpc Rscript R_scripts/SS_FLAT.R > logfiles/end5_FLAT_SS_job_logfile
