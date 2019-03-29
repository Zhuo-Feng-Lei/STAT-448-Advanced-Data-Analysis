libname biz "/home/zlei50/STAT 448";
data train;
set biz.loantraining;
if region="MIDWEST";
run;

data test;
set biz.loantesting;
if region="MIDWEST";
run;

proc hpsplit data=train maxdepth=7 cvmodelfit seed=448;
class default Urban_Rural New_Business Real_Estate Great_Recession;
model default = Total_Employees Proportion_Guaranteed Disburse_Gross Term Urban_Rural New_Business Real_Estate Great_Recession;
grow entropy;
prune costcomplexity;
code file="/home/zlei50/STAT 448/treeresults.sas";
run;

data scored;
set test;
%include "/home/zlei50/STAT 448/treeresults.sas";
actual=default;
if p_default0>.5 then predicted=0;
else if p_default1>.5 then predicted=1;
run;


proc print data = scored (obs=10);
run;

proc freq data=scored;
tables actual*predicted /norow nocol;
run;