#!/bin/bash

#SBATCH --nodes=1                                                                                               
#SBATCH --ntasks=1                                                                                                  
#SBATCH --array=1-2                                                                                               
#SBATCH --time=00:02:00                                                                                                      
#SBATCH --partition=shas                                                                                         
#SBATCH --job-name=cont-run                                                                                             
#SBATCH --output=master.%A_%a.out                                                          

module purge

# Do work                                                                                                        
echo "Running some stuff..."     

# Check to see if task is head task and if iteration is withing bounds
# the $1 variable is equal to the first command line arguement provided to the job submission
if (($1 < 10)) && (($SLURM_ARRAY_TASK_ID == 1)); then
    # Set next iteration
    NEXT_ITER=$(($1+1))
    
    # Navagate to next Directory
    echo "Task $SLURM_ARRAY_TASK_ID: Navigating to ../exampledir$NEXT_ITER"
    cd ../exampledir$NEXT_ITER
    
    # Launch next script with next iteration 
    sbatch restartingJob.sh $NEXT_ITER
fi    
