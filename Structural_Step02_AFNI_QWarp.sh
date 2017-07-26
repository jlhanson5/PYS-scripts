# set your own directory
home=/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/

# basic for i loop
for i in $1
do

# change and making new directories
cd $home
cd ${i}
cd anat
mkdir Qwarp
cd Qwarp

# AFNI bias correct
3dUnifize -input ../${i}_t1w_ss.nii.gz -prefix ${i}_t1w_ss_U.nii.gz -GM

# AFNI non-linear/diffemorphic (3dQwarp)... this takes a while
3dQwarp -blur 0 1 -source ${i}_t1w_ss_U.nii.gz -base /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -prefix ${i}_t1w_ss_U_3dQWarp.nii.gz -superhard -patchmin 5  -Qfinal -allineate -allineate_opts '-nmatch 80% -twopass -conv 0.005 -num_rtb 200'

done
