home=/home/jamielh/Volumes/Hanson/UGA_CTAPS/proc

for i in $1


do

cd $home
cd ${i}
cd anat

mkdir Qwarp
cd Qwarp

3dUnifize -input ../${i}_t1w_ss.nii.gz -prefix ${i}_t1w_ss_U.nii.gz -GM

3dQwarp -blur 0 1 -source ${i}_t1w_ss_U.nii.gz -base /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -prefix ${i}_t1w_ss_U_3dQWarp.nii.gz -superhard -patchmin 5  -Qfinal -allineate -allineate_opts '-nmatch 80% -twopass -conv 0.005 -num_rtb 200'

done
