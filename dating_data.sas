data asiandating;
infile '/home/zlei50/Speed_Dating_Data_sub.csv' dsd;
length field $15;
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
if age_o = age then sameage=1;
else sameage=0;
if age-5 <= age_o <= age+5 then fiveyrgap=1;
else fiveyrgap=0;
if age ne . and age_o ne . ;
if 18<=age_o<=25 then agegroup=1;
	else if 26<=age_o<=30 then agegroup=2;
		else if 31<=age_o<=39 then agegroup=3;
			else if age_0>=40 then agegroup=4; 
if field = "law" then field = "Law";
if field = "chemistry" then field = "Chemistry";
if field = "business" then field = "Business";
if field = "medicine" then field = "Medicine";
if field = "biology" then field = "Biology";
if field = "MBA" then field = "Business (MBA)";
run;

proc freq data = asiandating;
	tables age*match;
run;

proc freq data = asiandating;
	tables field*attr_o;
run;

proc glm data = asiandating plots = diagnostics;
	class race;
	model int_corr = race;
	lsmeans race/adjust = t;
	where race<5;
run;

proc tabulate data = asiandating;
	class agegroup;
	var int_corr;
	tables agegroup,int_corr*(mean std n);
run;

proc glm data = asiandating plots = diagnostics;
	class agegroup;
	model int_corr = agegroup;
	lsmeans agegroup/adjust = tukey cl;
run;

proc logistic data = asiandating desc; 
	model match = order samerace int_corr sameage fiveyrgap attr_o sinc_o intel_o fun_o amb_o shar_o like_o prob_o met_o / selection = forward sle=0.5 lackfit rsquare; 
run;

title1 'Career/Field Amongst Matches';
proc freq data = asiandating order=freq;
	tables field;
	where match = 1 and race = 4;
run;

proc sgplot data = asiandating;
	vbar field;
	where match = 1 and race = 4;
	xaxis fitpolicy= stackedalwaysthin;
run;

proc tabulate data = asiandating;
	class field;
	var int_corr;
	tables field,int_corr*(mean std n);
run;

proc sort data = asiandating;
	by field;
run;
