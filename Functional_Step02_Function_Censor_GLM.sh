
# specifying directories
home=/home/jamielh/Volumes/Hanson/Pitt_PYS/proc

# for i loop
for i in 10099	10528	10637	10647	10705	11490	11790	12574	12756	70040	70289	70491	70542	71083	72133	72260
do

# changing directories
cd /home/jamielh/Volumes/Hanson/Pitt_PYS/proc/${i}/fmri/faces/preprocessed

# can adjust censoring cutoffs, depending on study and age group
1d_tool.py -infile ${i}_faces_run1_m.aff12.1D -set_nruns 1 -show_censor_count -censor_motion .2 ${i}_strict_run1  -censor_prev_TR

# concatenating censor binary 1D
cat ${i}_strict_run1_censor.1D ${i}_strict_run2_censor.1D >> ${i}_faces_CENSOR.1D 

# first order GLM as BLOCK (based on run onsets and block order that DP gave)
3dDeconvolve -input ${i}_faces_run1_dtvdF_06mm_perc+orig ${i}_faces_run2_dtvdF_06mm_perc+orig -nfirst 0 -polort A \
-num_stimts 10 -basis_normall 1 \
-censor ${i}_faces_CENSOR.1D  \
-local_times \
-stim_times 1 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Multiple_Blocks/Anger.1D 'BLOCK(18.5,1)' \
-stim_label 1 Anger \
-stim_times 2 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Multiple_Blocks/Control.1D 'BLOCK(18.5,1)' \
-stim_label 2 Control \
-stim_times 3 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Multiple_Blocks/Fear.1D 'BLOCK(18.5,1)' \
-stim_label 3 Fear \
-stim_times 4 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Multiple_Blocks/Neutral.1D 'BLOCK(18.5,1)' \
-stim_label 4 Neutral \
-stim_file 5 ${i}_faces_motion.txt[1] \
-stim_label 5 roll \
-stim_base 5 \
-stim_maxlag 5 1 \
-stim_file 6 ${i}_faces_motion.txt[2]  \
-stim_label 6 pitch \
-stim_base 6 \
-stim_maxlag 6 1 \
-stim_file 7 ${i}_faces_motion.txt[3]  \
-stim_label 7 yaw \
-stim_base 7 \
-stim_maxlag 7 1 \
-stim_file 8 ${i}_faces_motion.txt[4]  \
-stim_label 8 I_S \
-stim_base 8 \
-stim_maxlag 8 1 \
-stim_file 9 ${i}_faces_motion.txt[5]  \
-stim_label 9 R_L \
-stim_base 9 \
-stim_maxlag 9 1 \
-stim_file 10 ${i}_faces_motion.txt[6]  \
-stim_label 10 A_P \
-stim_base 10 \
-stim_maxlag 10 1 \
-num_glt 8 \
-glt_label 1 Anger_v_Control \
-gltsym 'SYM: +Anger -Control' \
-glt_label 2 Anger_v_Neutral \
-gltsym 'SYM: +Anger -Neutral' \
-glt_label 3 Fear_v_Control \
-gltsym 'SYM: +Fear -Control' \
-glt_label 4 Fear_v_Neutral \
-gltsym 'SYM: +Fear -Neutral' \
-glt_label 5 AngerFear_v_Control \
-gltsym 'SYM: +.5*Anger +5*Fear -Control' \
-glt_label 6 AngerFear_v_Neutral \
-gltsym 'SYM: +.5*Anger +5*Fear -Neutral' \
-glt_label 7 Neutral_v_Control \
-gltsym 'SYM: +Neutral -Control' \
-glt_label 8 AllFaces_v_Control \
-gltsym 'SYM: +.3333*Anger +.3333*Fear +.3333*Neutral -Control' \
-xjpeg ${i}_glm_matrix_MultBlocks.jpg -tout -bucket ${i}_faces_dtvdF_06mm_perc_GLM_MultBlocks

# first order GLM as EVENT (based on run onsets and block order that DP gave)
3dDeconvolve -input ${i}_faces_run1_dtvdF_06mm_perc+orig ${i}_faces_run2_dtvdF_06mm_perc+orig -nfirst 0 -polort A \
-num_stimts 22 -basis_normall 1 \
-censor ${i}_faces_CENSOR.1D  \
-local_times \
-stim_times 1 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Anger_B1.1D 'BLOCK(18.5,1)' \
-stim_label 1 Anger_B1 \
-stim_times 2 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Anger_B2.1D 'BLOCK(18.5,1)' \
-stim_label 2 Anger_B2 \
-stim_times 3 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Anger_B3.1D 'BLOCK(18.5,1)' \
-stim_label 3 Anger_B3 \
-stim_times 4 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Anger_B4.1D 'BLOCK(18.5,1)' \
-stim_label 4 Anger_B4 \
-stim_times 5 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Control_B1.1D 'BLOCK(18.5,1)' \
-stim_label 5 Control_B1 \
-stim_times 6 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Control_B2.1D 'BLOCK(18.5,1)' \
-stim_label 6 Control_B2 \
-stim_times 7 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Control_B3.1D 'BLOCK(18.5,1)' \
-stim_label 7 Control_B3 \
-stim_times 8 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Control_B4.1D 'BLOCK(18.5,1)' \
-stim_label 8 Control_B4 \
-stim_times 9 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Fear_B1.1D 'BLOCK(18.5,1)' \
-stim_label 9 Fear_B1 \
-stim_times 10 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Fear_B2.1D 'BLOCK(18.5,1)' \
-stim_label 10 Fear_B2 \
-stim_times 11 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Fear_B3.1D 'BLOCK(18.5,1)' \
-stim_label 11 Fear_B3 \
-stim_times 12 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Fear_B4.1D 'BLOCK(18.5,1)' \
-stim_label 12 Fear_B4 \
-stim_times 13 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Neutral_B1.1D 'BLOCK(18.5,1)' \
-stim_label 13 Neutral_B1 \
-stim_times 14 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Neutral_B2.1D 'BLOCK(18.5,1)' \
-stim_label 14 Neutral_B2 \
-stim_times 15 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Neutral_B3.1D 'BLOCK(18.5,1)' \
-stim_label 15 Neutral_B3 \
-stim_times 16 ~/Volumes/Hanson/Pitt_PYS/proc/Timing_Files/Faces/Order_AC/Individual_Blocks/Neutral_B4.1D 'BLOCK(18.5,1)' \
-stim_label 16 Neutral_B4 \
-stim_file 17  ${i}_faces_motion.txt[1] \
-stim_label 17 roll \
-stim_base 17 \
-stim_maxlag 17 1 \
-stim_file 18 ${i}_faces_motion.txt[2]  \
-stim_label 18 pitch \
-stim_base 18 \
-stim_maxlag 18 1 \
-stim_file 19 ${i}_faces_motion.txt[3]  \
-stim_label 19 yaw \
-stim_base 19 \
-stim_maxlag 19 1 \
-stim_file 20 ${i}_faces_motion.txt[4]  \
-stim_label 20 I_S \
-stim_base 20 \
-stim_maxlag 20 1 \
-stim_file 21 ${i}_faces_motion.txt[5]  \
-stim_label 21 R_L \
-stim_base 21 \
-stim_maxlag 21 1 \
-stim_file 22 ${i}_faces_motion.txt[6]  \
-stim_label 22 A_P \
-stim_base 22 \
-stim_maxlag 22 1 \
-num_glt 13  \
-glt_label 1 Anger_v_Control \
-gltsym 'SYM: +.25*Anger_B1 +.25*Anger_B2 +.25*Anger_B3 +.25*Anger_B4 -.25*Control_B1 -.25*Control_B2 -.25*Control_B3 -.25*Control_B4' \
-glt_label 2 Anger_v_Neutral \
-gltsym 'SYM: +.25*Anger_B1 +.25*Anger_B2 +.25*Anger_B3 +.25*Anger_B4 -.25*Neutral_B1 -.25*Neutral_B2 -.25*Neutral_B3 -.25*Neutral_B4' \
-glt_label 3 Anger_Habituation \
-gltsym 'SYM: +Anger_B4 -Anger_B1' \
-glt_label 4 Fear_v_Control \
-gltsym 'SYM: +.25*Fear_B1 +.25*Fear_B2 +.25*Fear_B3 +.25*Fear_B4 -.25*Control_B1 -.25*Control_B2 -.25*Control_B3 -.25*Control_B4' \
-glt_label 5 Fear_v_Neutral \
-gltsym 'SYM: +.25*Fear_B1 +.25*Fear_B2 +.25*Fear_B3 +.25*Fear_B4 -.25*Neutral_B1 -.25*Neutral_B2 -.25*Neutral_B3 -.25*Neutral_B4' \
-glt_label 6 Fear_Habituation \
-gltsym 'SYM: +Fear_B4 -Fear_B1' \
-glt_label 7 AngerFear_v_Control \
-gltsym 'SYM: +.125*Anger_B1 +.125*Anger_B2 +.125*Anger_B3 +.125*Anger_B4 +.125*Fear_B1 +.125*Fear_B2 +.125*Fear_B3 +.125*Fear_B4 -.25*Control_B1 -.25*Control_B2 -.25*Control_B3 -.25*Control_B4' \
-glt_label 8 AngerFear_v_Neutral \
-gltsym 'SYM: +.125*Anger_B1 +.125*Anger_B2 +.125*Anger_B3 +.125*Anger_B4 +.125*Fear_B1 +.125*Fear_B2 +.125*Fear_B3 +.125*Fear_B4 -.25*Neutral_B1 -.25*Neutral_B2 -.25*Neutral_B3 -.25*Neutral_B4' \
-glt_label 9 AngerFear_Habituation \
-gltsym 'SYM: +.5*Anger_B4 +.5*Fear_B4 -.5*Anger_B1 -.5*Fear_B1' \
-glt_label 10 Neutral_v_Control \
-gltsym 'SYM: +.25*Neutral_B1 +.25*Neutral_B2 +.25*Neutral_B3 +.25*Neutral_B4 -.25*Control_B1 -.25*Control_B2 -.25*Control_B3 -.25*Control_B4' \
-glt_label 11 Neutral_Habituation \
-gltsym 'SYM: +Neutral_B4 -Neutral_B1' \
-glt_label 12 Control_Habituation \
-gltsym 'SYM: +Control_B4 -Control_B1' \
-glt_label 13 AllFaces_v_Control \
-gltsym 'SYM: +.0833*Anger_B1 +.0833*Anger_B2 +.0833*Anger_B3 +.0833*Anger_B4 +.0833*Fear_B1 +.0833*Fear_B2 +.0833*Fear_B3 +.0833*Fear_B4 +.0833*Neutral_B1 +.0833*Neutral_B2 +.0833*Neutral_B3 +.0833*Neutral_B4 -.25*Control_B1 -.25*Control_B2 -.25*Control_B3 -.25*Control_B4' \
-xjpeg ${i}_glm_matrix_IndivBlocks.jpg -tout -bucket ${i}_faces_dtvdF_06mm_perc_GLM_IndivBlocks

done

