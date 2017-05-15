#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mem=200G
#SBATCH --time=40:00:00
#SBATCH --output=Step3_Hybrid_assembly.sh.stdout
#SBATCH -p intel
#SBATCH --workdir=./

#sbatch --array 1 run_speedseq_qsub.sh

#module unload perl/5.20.2
#module load perl/5.16.3

start=`date +%s`

CPU=$SLURM_NTASKS
if [ ! $CPU ]; then
   CPU=2
fi

N=$SLURM_ARRAY_TASK_ID
if [ ! $N ]; then
    N=1
fi

echo "CPU: $CPU"
echo "N: $N"

fasta=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/input/Pacbio_assembly/genome_ref.fa
cmap=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/bin/Fairchild_bionano/default_t_150/contigs/Fairchild_default_t_150_refineFinal1/FAIRCHILD_DEFAULT_T_150_REFINEFINAL1.cmap
config=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/bin/hybridScaffold_config.xml
output=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/bin/Fairchild_hybridscaffold
refaligner=/rhome/cjinfeng/tools/RefAligner
bnx=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/input/Fairchild/RawMolecules_citrus.bnx
denovo_dir=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/install/Irys-scaffolding/KSU_bioinfo_lab/assemble_XeonPhi
/usr/bin/perl ~/BigData/00.RD/Assembly/bionano/install/Solve_03062017Rel/HybridScaffold/03062017/hybridScaffold.pl \
     -n $fasta \
     -b $cmap \
     -c $config \
     -r $refaligner \
     -o $output \
     -B 2 \
     -N 2 \
     -m $bnx \
     -p $denovo_dir \
     -q $denovo_dir/optArguments_medium.xml \
     -f
 
end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"
