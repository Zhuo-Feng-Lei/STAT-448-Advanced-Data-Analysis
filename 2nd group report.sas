data asiandating;
 infile '/home/zlei50/Speed_Dating_Data_sub.csv' dsd;
 input iid id gender idg condtn wave round position 
  order partner pid match int_corr samerace age_o 
  race_o dec_o attr_o sinc_o intel_o fun_o amb_o 
  shar_o like_o prob_o met_o age field $ race 
  imprace imprelig from $ goal date go_out sports 
  tvsports exercise dining museums art hiking gaming 
  clubbing reading tv theater movies concerts music 
  shopping yoga exphappy expnum dec attr sinc intel 
  fun amb shar like prob met match_es;
 if wave not in (6,7,8,9) and 1<=met_o<=2 and 1<=met<=2;
 if met_o=2 then met_o=0;
 if met=2 then met=0; 
run;


proc logistic data = asiandating;
	model match (event = "1") = age age_o amb amb_o art attr attr_o clubbing concerts condtn date dec dec_o dining exercise exphappy expnum field from fun fun_o gaming gender go_out goal hiking id idg iid imprace imprelig int_corr intel intel_o like like_o match match_es met met_o movies museums music order partner pid position prob prob_o race race_o reading round samerace shar shar_o shopping sinc sinc_o sports theater tv tvsports wave yoga;
run;
	
	
proc contents data = asiandating short;
run;

proc freq data = asiandating;
	table match*race;
run;
