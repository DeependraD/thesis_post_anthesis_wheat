data blocks;
do trt=1 to 4;
  do plot=1 to 33;
    output;
  end;
end;
run;

data trt;
do rowgroup=1 to 5;
  do row=(rowgroup-1)*4+1 to rowgroup*4;
    do colgroup=1 to 4;
	  do col=(colgroup-1)*3+1 to colgroup*3;
	    block=rowgroup*100+colgroup;
		output;
	  end;
	end;
  end;
end;
run;

proc optex data=trt seed=1010;
class row rowgroup col colgroup block / PARAM=EFFECT; /*Parameterization does seem to have an effect. Need to check this*/
model rowgroup|colgroup row(rowgroup) col(colgroup) ;
blocks design=blocks iter=10;
class trt;
model trt;
output out=des;
run;

proc tabulate data=des;
class row col;
var trt;
table row, trt=' ' *col *sum=' ';
run;

proc sort data=des;
by rowgroup row colgroup col;
run;

data des2;
merge des trt;
by rowgroup row colgroup col;
if trt=. then rand=ranuni(1); else rand=2;
run;

proc sort data=des2;
by rand;
run;

data des2;
set des2;
if rand<2 then trt=_N_+4;
run;

proc sort data=des2;
by rowgroup row colgroup col;
run;

/*Check if analysis works*/
data des2;
set des2;
dummy=normal(12)+row+col;
run;

title 'Dummy analysis';
proc mixed data=des2;
class row col trt rowgroup colgroup;
model dummy=trt rowgroup|colgroup row(rowgroup) col(colgroup);
lsmeans rowgroup|colgroup row(rowgroup) col(colgroup) trt;
run;

proc freq data=des2;
table rowgroup*colgroup;
run;

proc tabulate data=des2;
class row col;
var trt;
table row, trt=' ' *col *sum=' ';
run;

data des3;
set des2;
keep rowgroup row colgroup col trt;
run;

PROC EXPORT DATA= WORK.DES3 
            OUTFILE= "D:\hpp\veroeff\16\Dhakal\SAS files for paper\dhakal.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="design"; 
RUN;


