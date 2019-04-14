data rrtable;
input region $ race $ count;
datalines;
midwest black 4122
midwest white 49659
northeast black 2664
northeast white 46186
south black 4796
south white 89039
west black 879
west white 45890
;
run;

proc freq data = rrtable;
tables race*region / riskdiff oddsratio;
where region in ("south","midwest");
weight count;
run;

/*Test of Association */
proc freq data=dataName;
tables rowVarName*columnVarName / chisq;
*weight n;
run;

data data;
input Age_Group $ Region $ count;
datalines;
21-25 Midwest 6866
21-25 Northeast 6444
21-25 South 11290
21-25 West 5407
26-30 Midwest 9004
26-30 Northeast 8638
26-30 South 14980 14980
26-30 West 6593
31-35 Midwest 9632
31-35 Northeast 8607
31-35 South 15893
31-35 West 7035
36-40 Midwest 9126
36-40 Northeast 8019
36-40 South 16073
36-40 West 7783
41-45 Midwest 9329
41-45 Northeast 8384
41-45 South 17742
41-45 West 9344
46-50 Midwest 9824
46-50 Northeast 8758
46-50 South 17857
46-50 West 10607
;
run;

proc freq data=data;
tables Age_Group*Region / chisq;
weight count;
run;

proc sgplot data=data;
scatter x=Age_Group y=Count / group=Region;
run;

data data4;
input Sex $ Race $ count;
datalines;
Female Black 3531
Female White 73153
Male Black 8930
Male White 157621
;
run;

proc freq data = data4;
tables Sex*Race / riskdiff oddsratio;
weight count;
run;


proc freq data=data;
tables Age_Group*Region / riskdiff oddsratio;
where Age_Group in ("21-25","46-50") and Region in ("South","Midwest");
weight count;
run;