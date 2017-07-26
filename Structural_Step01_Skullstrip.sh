
# set your own directory
home=/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/

# basic for i loop
for i in $1

do

# change and making new directories
cd $home
mkdir ${i}
cd ${i}

mkdir anat
cd anat

# doing bias correction in ANTS, then warping in ANTS, and finally warping skull-strip masks to subject space
N4BiasFieldCorrection -d 3 -i ~/Volumes/Hanson/Pitt_PYS/orig/${i}/anat/${i}_t1w.nii.gz -o ${i}_t1w_c.nii.gz -c ["500x500x500x500,.000001"]

ANTS 3 -m CC[/usr/share/fsl/5.0/data/standard/MNI152_T1_1mm.nii.gz,${i}_t1w_c.nii.gz,1,4] -o ${i}_t1w_c_1mm_100100100_ -i 100x100x100 -r Gauss[3,0] -t SyN[0.05]
ANTS 3 -m CC[/usr/share/fsl/5.0/data/standard/MNI152_T1_1mm.nii.gz,${i}_t1w_c.nii.gz,1,4] -o ${i}_t1w_c_1mm_100100100100_ -i 100x100x100x100 -r Gauss[3,0] -t SyN[0.05]

WarpImageMultiTransform 3 /home/jamielh/Volumes/Hanson/Pitt_PYS/proc/archive/MNI152_T1_1mm_brain_mask_filled.nii.gz ${i}_brain_mask_FILLED_100100100.nii.gz -R ${i}_t1w_c.nii.gz -i ${i}_t1w_c_1mm_100100100_Affine.txt ${i}_t1w_c_1mm_100100100_InverseWarp.nii.gz --use-NN

WarpImageMultiTransform 3 /home/jamielh/Volumes/Hanson/Pitt_PYS/proc/archive/MNI152_T1_1mm_brain_mask_filled.nii.gz ${i}_brain_mask_FILLED_100100100100.nii.gz -R ${i}_t1w_c.nii.gz -i ${i}_t1w_c_1mm_100100100100_Affine.txt ${i}_t1w_c_1mm_100100100100_InverseWarp.nii.gz --use-NN


# doing BET-fsl skull script, then flirt/fnirt-ing for warps, and then applying fnirt to skull-strip mask 
bet ${i}_t1w_c.nii.gz ${i}_t1w_c_bet.nii.gz -R
flirt -ref ${FSLDIR}/data/standard/MNI152_T1_2mm_brain -in ${i}_t1w_c_bet.nii.gz -omat ${i}_affine_transf.mat
fnirt --in=${i}_t1w_c.nii.gz --aff=${i}_affine_transf.mat --cout=${i}_nonlinear_transf --config=T1_2_MNI152_2mm

invwarp --ref=${i}_t1w_c.nii.gz --warp=${i}_nonlinear_transf --out=${i}_fnirt_inv
applywarp --ref=${i}_t1w_c.nii.gz --warp=${i}_fnirt_inv --in=/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/archive/MNI152_T1_1mm_brain_mask_filled.nii.gz --out=${i}_warped_mask_1mm.nii.gz --interp=nn

# using AFNI tool to fix the masks
3dmask_tool -inputs ${i}_brain_mask_FILLED_100100100.nii.gz -dilate_input 1 -fill_holes -prefix ${i}_brain_mask_FILLED_100100100_dil.nii.gz
3dmask_tool -inputs ${i}_brain_mask_FILLED_100100100100.nii.gz -dilate_input 1 -fill_holes -prefix ${i}_brain_mask_FILLED_100100100100_dil.nii.gz
3dmask_tool -inputs ${i}_warped_mask_1mm.nii.gz -dilate_input 1 -fill_holes -prefix ${i}_warped_mask_1mm_dil.nii.gz


# doing AFNI skullstrip
3dSkullStrip -input ${i}_t1w_c.nii.gz -prefix ${i}_t1w_c_ss.nii.gz -mask_vol
fslmaths ${i}_t1w_c_ss.nii.gz -uthr 2 -bin ${i}_subtract.nii.gz

# combining all the masks together
3dmask_tool -inputs ${i}_t1w_c_ss.nii.gz ${i}_t1w_c_bet.nii.gz ${i}_brain_mask_FILLED_100100100.nii.gz ${i}_brain_mask_FILLED_100100100100.nii.gz ${i}_warped_mask_1mm.nii.gz ${i}_brain_mask_FILLED_100100100_dil.nii.gz ${i}_brain_mask_FILLED_100100100100_dil.nii.gz ${i}_warped_mask_1mm_dil.nii.gz -frac .7 -prefix ${i}_MASK_COMBINED.nii.gz

done

#4004	4007	4011	4024	4038	4052	4061	4064	4066	4101	4104	4107	4110	4111	4112
#4133	4156	4157	4161	4171	4178	4182	4191	4197	4201	4202	4205	4214	4235	4243
#4248	4254	4259	4262	4264	4266	4279	4280	4302	4309	4317	4324	4326	4336	4340
#4344	4349	4350	4353	4359	4369	4381	4382	4400	4411	4416	4437	4462	4474	4481
#4488	4504	4514	4519	4524	4528	4529	4549	4556	4564	4567	4570	4574	4576	4577
#4580	4586	4592	4604	4615	4624	4626	4631	4634	4635	4638	4644	4648	4654	4657
#4658	4662	4663	4668	4677	4680	4684	4685	4690	4698	4720	4723	4738	4751	4752
#4756	4760	4779	4785	4790	4805	4809	4813	4815	4827	4841	4842	4851	4857	


