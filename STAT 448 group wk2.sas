data cujail;
length crime_code $42. race $12. sex $6.
city $24. state $8. citizenship $8.
employment_status $25. ;
infile '/home/zlei50/CCSO_Data_sub.csv' dlm=','
dsd missover firstobs=2;
input booking_date :mmddyy10. jacket_number
crime_code $ race $ sex $
city $ state $ citizenship $ employment_status $
age_at_arrest days_in_jail hours_in_jail ;
format booking_date date9.;
run;

/* problem 1 */
proc freq data = cujail;
	tables crime_code / out = cujail2;
run;

proc sort data = cujail2;
	by descending count;
run;

proc print data = cujail2 (obs=10);
run;

/* problem 2 */
data cujailreal2;
	set cujail;
	if employment_status ^= "Student" then employment_status = "Not students";
run;

proc freq data = cujailreal2;
	table employment_status;
run;

/* problem 3 */
data cujail3;
	set cujail;
	if city = "CHAMPAIGN" or city = "URBANA" then city = "townie";
	else city = "non-townie";
run;

proc freq data = cujail3;
	table city;
run;

/* problem 4 */
proc sort data = cujail;
	by race;
run;

proc means data = cujail;
	by race;
	where race = "White" or race = "Black";
	var days_in_jail;
run;

/* problem 5 */
proc corr data = cujail;
var days_in_jail age_at_arrest;
where sex = 'Male' and citizenship = 'US' and age_at_arrest between 16 and 90;
run;

proc sgscatter data = cujail;
	matrix days_in_jail age_at_arrest;
run;
/* problem 6 */
proc sort data = cujail;
	by race;
run;

proc corr data = cujail;
	by race;
	var days_in_jail age_at_arrest;
	where sex = 'Male' and citizenship = 'US' and age_at_arrest between 16 and 90;
run;

proc sgscatter data = cujail;
	title "Days in Jail vs Age at Arrest";
	by race;
	plot days_in_jail*age_at_arrest;
	where sex = 'Male' and citizenship = 'US' and age_at_arrest between 16 and 90;
run; title;

proc sort data = cujail3;
	by city;
run;

proc corr data = cujail3;
	by city;
	var days_in_jail age_at_arrest;
	where sex = 'Male' and citizenship = 'US' and age_at_arrest between 16 and 90;
run;

proc sgscatter data = cujail3;
	title "Days In Jail vs Age At Arrest";
	by city;
	plot days_in_jail*age_at_arrest;
	where sex = 'Male' and citizenship = 'US' and age_at_arrest between 16 and 90;
run;