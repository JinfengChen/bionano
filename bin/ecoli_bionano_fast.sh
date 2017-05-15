#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mem=100G
#SBATCH --time=20:00:00
#SBATCH --output=ecoli_bionano.sh.stdout
#SBATCH -p intel
#SBATCH --workdir=./

#sbatch --array 1 run_speedseq_qsub.sh

module load samtools
PATH=$PATH:~/BigData/software/SVcaller/ROOT/bin/
genome=Fairchild_canu1_3.quiver_round1_pilon.fasta

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

asm=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/bin/ecoli_bionano_fast
ref=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/input/ecoli/MG1655_BSSSI_0kb_0labels.cmap
perl ~/BigData/00.RD/Assembly/bionano/install/Irys-scaffolding/KSU_bioinfo_lab/assemble_XeonPhi/AssembleIrysXeonPhi.pl --assembly_dir $asm --genome 5 -p ecoli -d
perl ../install/Irys-scaffolding/KSU_bioinfo_lab/map_tools/cmap_stats.pl --input ~/BigData/00.RD/Assembly/bionano/bin/ecoli_bionano_fast/default_t_150/contigs/ecoli_default_t_150_refineFinal1/ECOLI_DEFAULT_T_150_REFINEFINAL1.cmap

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"
