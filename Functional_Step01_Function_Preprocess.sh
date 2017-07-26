

# specifying directories
home=/home/jamielh/Volumes/Hanson/Pitt_PYS/proc

# for i loop
for i in $1
do

# changing directories
cd $home
cd ${i}
mkdir fmri
cd fmri
mkdir faces
cd faces

# Copy skull-stripped T1 (that have been preprocessing with AFNI Qwarp)
3dcopy ../../anat/Qwarp/${i}_t1w_ss_U.nii.gz ./${i}_t1w_ss_U

# Despike and Slice Time Correction EPI
3dDespike -prefix ${i}_faces_run1_d+orig ~/Volumes/Hanson/Pitt_PYS/orig/${i}/fmri/faces/${i}_faces_run1.nii.gz
3dTshift -TR 2.0s -tpattern altplus -heptic -prefix ${i}_faces_run1_dt+orig ${i}_faces_run1_d+orig

# Intra-subject Registration (aka Motion Correction)
3dvolreg -prefix ${i}_faces_run1_dtv+orig -twopass -1Dmatrix_save ${i}_faces_run1_m.aff12.1D -verbose -base ${i}_faces_run1_dt+orig[164] -dfile ${i}_faces_run1_motion.txt -float ${i}_faces_run1_dt+orig

# 'Deobliqueing' EPI
3dWarp -oblique2card -quintic -prefix ${i}_faces_run1_dtvd.nii.gz ${i}_faces_run1_dtv+orig

# Running FSL's Boundary Based Registration (then resampling back to EPI's original space)
cp ../../anat/${i}_t1w_c.nii.gz ./
cp ../../anat/Qwarp/${i}_t1w_ss_U.nii.gz ./
3dcopy ${i}_faces_run1_dtv+orig ${i}_faces_run1_dtv.nii.gz
epi_reg --epi=${i}_faces_run1_dtv --t1=${i}_t1w_c --t1brain=${i}_t1w_ss_U --out=${i}_faces_run1_dtvF
epi_reg --epi=${i}_faces_run1_dtvd --t1=${i}_t1w_c --t1brain=${i}_t1w_ss_U --out=${i}_faces_run1_dtvdF
3dresample -inset ${i}_faces_run1_dtvdF.nii.gz -prefix ${i}_faces_run1_dtvdFr -dxyz 3.1 3.1 3.1  

# Smoothing
3dmerge -1blur_fwhm 6 -doall -prefix ${i}_faces_run1_dtvdFr_06mm ${i}_faces_run1_dtvdFr+orig

# Converting to Percent Signal Change
3dTstat -mean -prefix ${i}_faces_run1_mean ${i}_faces_run1_dtvdFr_06mm+orig
3dClipLevel ${i}_faces_run1_dtvdFr_06mm+orig > clip.txt
x="$(more clip.txt)"

3dcalc -a ${i}_faces_run1_dtvdFr_06mm+orig -b ${i}_faces_run1_mean+orig -expr "(a/b*100)*step(b-$x)" -prefix ${i}_faces_run1_dtvdFr_06mm_perc+orig

done

