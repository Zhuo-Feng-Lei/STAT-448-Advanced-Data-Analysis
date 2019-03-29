libname biz "/home/zlei50/STAT 448";

proc stepdisc data = biz.loantraining method = stepwise sls=0.05 sle=0.05;
	class default;
	var Total_Employees Proportion_Guaranteed Disburse_Gross Term;
	where franchise_code<2;
run;

proc discrim data=biz.loantraining testdata=biz.loantesting outstat=disc1 manova wcov crossvalidate pool=test;
	class default;
	var Total_Employees Proportion_Guaranteed Disburse_Gross Term;
	priors proportional;
	where franchise_code<2;
run;

proc discrim data=biz.loantraining outstat=disc1 manova wcov crossvalidate pool=test;
	class default;
	var Total_Employees Proportion_Guaranteed Disburse_Gross Term;
	priors proportional;
	where franchise_code<2;
run;

proc discrim data=dataName outstat=outDataName
pool=test manova simple wcov ;
class categoricalResponse;
var var1--varN;
priors equal;
run;