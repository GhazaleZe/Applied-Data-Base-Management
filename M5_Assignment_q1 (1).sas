** the code is taken from the SUGI paper directly ;
*Q1.0 - Examine the original data set named BEST as created below. 
	How many observations does it contain?
	How many patients?
	How many observations for each patient?
;
data best;
	input patient 1-2 arm $ 4-5 bestres $ 6-7 delay 9-10;
datalines;
01 A CR 0
02 A PD 1
03 B PR 1 
04 B CR 2
05 C SD 1
06 C SD 3
07 C PD 2
01 A CR 0
03 B PD 1
;
run;
proc print data=best;
	title 'Original data';
run;
title;

**Q1.1	Create a data set (EX1) ordered by PATIENT and eliminate any observations that have the exact same information for all variables.Compare EX1 to BEST:  
	How many observations does it contain?
	How many patients?
	How many observations for each patient?
	Which, if any, observations were removed?
	Was the goal achieved, why or why not?
;
proc sort data=best nodup out=ex1;
	by patient;
run; 
proc print data=ex1;
	title 'Question 1 / Example 1';
run;
title;

**Q1.2 - paper example 2 - NODUP option;
*	Create a data set ordered by ARM and eliminate any observations that have the exact same
information for all variables. There can be two approaches.
**Approach 1: PROC SORT with BY variable ARM.Was the goal achieved? Why or why not?;
proc sort data=best nodup out=ex2_1;
	by arm;
run; 
proc print data=ex2_1;
	title 'Question 2 / Example 2 Version 1';
run;

**Approach 2: PROC SORT with BY variables ARM and PATIENT. Was the goal achieved? Why or why 
not?;
proc sort data=best nodup out=ex2_2;
	by arm patient;
run; 
proc print data=ex2_2;
	title 'Question 2 / Example 2 Version 2';
run;

**Q1.3	Similar to question 1, but using NODUPKEY option. Now you have created dataset EX3.;
proc sort data=best nodupkey out=ex3;
	by patient;
run; 
proc print data=ex3;
	title 'Question 3 / Example 3';
run;

**1.3.1	Compare it to BEST: any difference in number of observations for each patient?
	    Which, if any, observations were removed?

**1.3.2	Compare it to EX1:  any difference in number of observations for each patient?
	    Which, if any, observations were removed?


**Q1.4	Similar to question 2, but using NODUPKEY option. Now you have created dataset EX4;
proc sort data=best nodupkey out=ex4;
	by arm;
run; 
proc print data=ex4;
	title 'Question 4 / Example 4';
run;
title;
**1.4.1 Compare it to BEST: any difference in number of observations for each patient?
	    Which, if any, observations were removed?
**1.4.2 Compare it to EX2_1:any difference in number of observations for each patient?
	    Which, if any, observations were removed?



**Q1.5	Let's work on understanding the impact on the data set of sorting by variables ARM 
and BESTRES with the NODUPKEY option. any difference in number of observations for each patient?
	  Which, if any, observations were removed?;
proc sort data=best nodupkey out=ex5;
	by arm bestres;
run;
proc print data=ex5;
	title 'Question 5 / Example 5';
run;
title;




