
# for i loop
for i in 70032	70038	70040	70056	70057	70090	70128	70138	70216	70268	70275	70289	70298	70351	70368	70381	70431	70452	70491	70510	70542	70571	70585	70610	71008	71011	71029	71048	71052	71060	71061	71066	71074	71079	71083	71090	71103	71130	71135	71141	71146	71154	71230	71249	71295	71309	71325	71330	71339	71366	71372	71379	71399	71478	71483	71507	71562	71634	71659	71669	71690	71737	71761	71765	71779	71790	71819	71869	71874	71911	71926	71993	72015	72021	72038	72040	72043	72064	72121	72133	72158	72182	72188	72197	72211	72220	72237	72239	72242	72260	72270	72274	72279
do

# change directories
cd /home/jamielh/Volumes/Hanson/Pitt_PYS/proc/VBM/FSL/${i}

# affine transforms of MNI priors to subject space (for segmentation)
/usr/share/fsl/5.0/bin/flirt -searchcost mutualinfo -v -ref ${i}_t1w_brain.nii.gz -in /usr/share/fsl/5.0/data/standard/tissuepriors/avg152T1_brain.img -omat ${i}_T1_avg152.mat

# segmentation with priors
/usr/share/fsl/5.0/bin/fast -v -R 0.3 -p -H 0.1 -a ${i}_T1_avg152.mat -o ${i}_priors ${i}_t1w_brain.nii.gz  

# apply QWarp to prob. segments
3dNwarpApply -prefix ${i}_priors_prob_1_AFNI.nii.gz -source ${i}_priors_prob_1.nii.gz -master /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -nwarp '/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/'${i}'/anat/Qwarp/'${i}'_t1w_ss_U_3dQWarp_WARP.nii.gz'

# generate jacobians (from QWarp), then reformat to MNI space
3dNwarpFuncs -nwarp '/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/'${i}'/anat/Qwarp/'${i}'_t1w_ss_U_3dQWarp_WARP.nii.gz' -prefix ${i}_jacobians.nii.gz
3dZeropad -master /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -prefix ${i}_jacobian_MNI.nii.gz ${i}_jacobians.nii.gz

# "modulating" FSL segments w/ AFNI jacobians
3dcalc -a ${i}_jacobian_MNI.nii.gz -b ${i}_priors_prob_1_AFNI.nii.gz -expr 'a*b' -prefix ${i}_priors_prob_1_AFNI_mod.nii.gz

done
