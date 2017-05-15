echo "test ecoli"
mkdir ecoli_bionano_fast
cd ecoli_bionano_fast
mkdir bnx
cd bnx
ln -s /rhome/cjinfeng/BigData/00.RD/Assembly/bionano/install/omsim/test/ecoli/ecoli_output.label_1.1.subset.bnx Molecules_ecoli.bnx
cd ../..
perl ~/BigData/00.RD/Assembly/bionano/install/Solve_03062017Rel/HybridScaffold/03062017/scripts/fa2cmap_multi_color.pl -i ~/BigData/00.RD/Assembly/bionano/input/ecoli/MG1655.fasta -e BssSI 1
asm=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/bin/ecoli_bionano_fast
ref=/rhome/cjinfeng/BigData/00.RD/Assembly/bionano/input/ecoli/MG1655_BSSSI_0kb_0labels.cmap
perl ~/BigData/00.RD/Assembly/bionano/install/Irys-scaffolding/KSU_bioinfo_lab/assemble_XeonPhi/AssembleIrysXeonPhi.pl --assembly_dir $asm --genome 5 -p ecoli -d
perl ../install/Irys-scaffolding/KSU_bioinfo_lab/map_tools/cmap_stats.pl --input ~/BigData/00.RD/Assembly/bionano/bin/ecoli_bionano_fast/default_t_150/contigs/ecoli_default_t_150_refineFinal1/ECOLI_DEFAULT_T_150_REFINEFINAL1.cmap

echo "Step1.summary BNX raw bionano data"
sbatch Step1_BNS_stats.sh
echo "Step2.Assembly BNX to CMAP"
#1. add path of pipelineCL.py ~/BigData/00.RD/Assembly/bionano/install/Solve_03062017Rel/PIPELINE/Pipeline/pipelineCL.py 
#to /rhome/cjinfeng/BigData/00.RD/Assembly/bionano/install/Irys-scaffolding/KSU_bioinfo_lab/assemble_XeonPhi/assemble.pl
#2. create /rhome/cjinfeng/tools and links Assembler and RefAligner into it.
#3. update optArguments_*.xml in KSU_bioinfo_lab/assemble_XeonPhi with lastest bionano version from Iryview
sbatch Step2_CMAP_assembly.sh
#modify assembly_commands.sh and run three runs for different parameters.
sbatch assembly_commands_default_t_150.sh
sbatch assembly_commands_relaxed_t_150.sh
sbatch assembly_commands_strict_t_150.sh
echo "Step3.Hybrid_assembly"
sbatch Step3_Hybrid_assembly.sh

