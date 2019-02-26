libname biz "/home/zlei50/STAT 448" ;
proc print data=biz.loantraining(obs=20);
run;
proc print data=biz.loantesting (obs=20);
run;

proc contents data = biz.loantesting;
run;

proc contents data = biz.loantraining;
run;
/* scatterplot matrix to check for multicolinearity */
proc sgscatter data = biz.loantraining;
	matrix Approval_Date Approval_Year Balance_Gross Bank_Approval Default_Amount Default_Date Disburse_Date Disburse_Gross Franchise_Code Great_Recession Jobs_Created Jobs_Kept Loan_ID NAICS New_Business Proportion_Guaranteed Real_Estate SBA_Approval Term Total_Employees Urban_Rural Zip;
run;

proc logistic data = biz.training;
	/* class statement for categorical variables */
	class Name City State Region Bank Bank_State NACIS Franchise_Code Urban_Rural Revolving_Credit Low_Doc New_Business Real_Estate Great_Recession;
	model default = Approval_Date Approval_Year Balance_Gross Bank Bank_Approval Bank_State City Default_Amount Default_Date Disburse_Date Disburse_Gross Franchise_Code Great_Recession Jobs_Created Jobs_Kept Loan_ID Low_Doc NAICS Name New_Business Proportion_Guaranteed Real_Estate Region Revolving_Credit SBA_Approval State Term Total_Employees Urban_Rural Zip;
run;	

/* score model using testing data */
score data = biz.loantesting out = testResults.name;

proc freq data=testResultsDataName;
tables f_response*i_response;
run;

proc logistic data = biz.loantraining;
	class Region Urban_Rural(param=ref ref="1") New_Business(param=ref ref="1") Real_Estate(param=ref ref="1") Great_Recession(param=ref ref="1");
	model default = Total_Employees Proportion_Guaranteed Disburse_Gross Term Region Urban_Rural New_Business Real_Estate Great_Recession / selection = stepwise sls = 0.5 sle=0.5 lackfit rsquare;
	score data=biz.loantesting out=testResults;
run;

proc logistic data = biz.loantraining;
	class Region Urban_Rural(param=ref ref="1") New_Business(param=ref ref="1") Real_Estate(param=ref ref="1") Great_Recession(param=ref ref="1");
	model default = Total_Employees Proportion_Guaranteed Disburse_Gross Term Region Urban_Rural New_Business Real_Estate Great_Recession / selection = stepwise sle=0.5 lackfit rsquare;
	where franchise_code<2;
	score data=biz.loantesting out=testResults;
run;
/* Misclassification table */
proc freq data=testResults;
	tables f_default*i_default;
run;

/* Discriminant Analysis */
proc discrim data=biz.loantraining outstat=disc1 manova wcov crossvalidate pool=test;
	class default;
	var Total_Employees term Proportion_Guaranteed Disburse_Gross Jobs_Created Jobs_Kept;
run;
