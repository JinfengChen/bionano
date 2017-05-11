echo "Step1.summary BNX raw bionano data"
sbatch Step1_BNS_stats.sh
echo "Step2.Assembly BNX to CMAP"
#1. add path of pipelineCL.py ~/BigData/00.RD/Assembly/bionano/install/Solve_03062017Rel/PIPELINE/Pipeline/pipelineCL.py 
#to /rhome/cjinfeng/BigData/00.RD/Assembly/bionano/install/Irys-scaffolding/KSU_bioinfo_lab/assemble_XeonPhi/assemble.pl
#2. create /rhome/cjinfeng/tools and links Assembler and RefAligner into it.
#3. update optArguments_*.xml in KSU_bioinfo_lab/assemble_XeonPhi with lastest bionano version from Iryview
Step2_CMAP_assembly.sh
sbatch assembly_commands.sh
sbatch -p highmem assembly_commands_relaxed_t_150.sh
sbatch assembly_commands_strict_t_150.sh

