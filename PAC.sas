data ball;
	set sashelp.baseball;
run;

proc print data=ball;
run;

proc princomp data=ball out=ball2 outstat=ball3 plots=all;
	var nAtBat nHits nHome nRuns nRBI nBB CrAtBat CrHits CrHome CrRuns CrRbi CrBB nOuts nAssts nError Salary;
	id Name;
run;