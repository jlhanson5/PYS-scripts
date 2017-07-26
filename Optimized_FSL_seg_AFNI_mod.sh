
for i in 70032	70038	70040	70056	70057	70090	70128	70138	70216	70268	70275	70289	70298	70351	70368	70381	70431	70452	70491	70510	70542	70571	70585	70610	71008	71011	71029	71048	71052	71060	71061	71066	71074	71079	71083	71090	71103	71130	71135	71141	71146	71154	71230	71249	71295	71309	71325	71330	71339	71366	71372	71379	71399	71478	71483	71507	71562	71634	71659	71669	71690	71737	71761	71765	71779	71790	71819	71869	71874	71911	71926	71993	72015	72021	72038	72040	72043	72064	72121	72133	72158	72182	72188	72197	72211	72220	72237	72239	72242	72260	72270	72274	72279


do

cd /home/jamielh/Volumes/Hanson/Pitt_PYS/proc/VBM/FSL/${i}

/usr/share/fsl/5.0/bin/flirt -searchcost mutualinfo -v -ref ${i}_t1w_brain.nii.gz -in /usr/share/fsl/5.0/data/standard/tissuepriors/avg152T1_brain.img -omat ${i}_T1_avg152.mat

/usr/share/fsl/5.0/bin/fast -v -R 0.3 -p -H 0.1 -a ${i}_T1_avg152.mat -o ${i}_priors ${i}_t1w_brain.nii.gz  

3dNwarpApply -prefix ${i}_priors_prob_1_AFNI.nii.gz -source ${i}_priors_prob_1.nii.gz -master /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -nwarp '/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/'${i}'/anat/Qwarp/'${i}'_t1w_ss_U_3dQWarp_WARP.nii.gz'

3dNwarpFuncs -nwarp '/home/jamielh/Volumes/Hanson/Pitt_PYS/proc/'${i}'/anat/Qwarp/'${i}'_t1w_ss_U_3dQWarp_WARP.nii.gz' -prefix ${i}_jacobians.nii.gz

3dZeropad -master /usr/share/fsl/5.0/data/standard/MNI152_T1_1mm_brain.nii.gz -prefix ${i}_jacobian_MNI.nii.gz ${i}_jacobians.nii.gz

3dcalc -a ${i}_jacobian_MNI.nii.gz -b ${i}_priors_prob_1_AFNI.nii.gz -expr 'a*b' -prefix ${i}_priors_prob_1_AFNI_mod.nii.gz

done

#10032	10044	10055	10060	10075	10086	10088	10099	10115	10132	10138	10176	10188	10193	10211	10276	10314	10337	10348	10356	10375	10380	10386	10392	10439	10462	10491	10528	10558	10562	10603	10625	10637	10646	10647	10675	10685	10697	10705	11033	11073	11078	11096	11109	11114	11128	11139	11168	11184	11192	11209	11263	11300	11388	11393	11397	11398	11399	11426	11490	11515	11525	11551	11564	11625	11669	11703	11749	11790	11802	11821	11894	11954	11974	12029	12043	12129	12202	12222	12260	12309	12311	12320	12328	12334	12340	12356	12386	12388	12423	12445	12485	12574	12610	12640	12664	12690	12694	12708	12718	12742	12756	12766	12785	12793	12814	12860	12911	12990	13008	13012	
