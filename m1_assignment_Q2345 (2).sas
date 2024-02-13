**********************************************************************;
*STAT 674 - M1 Assignment;
**********************************************************************;

*Q2: Below is a data step.  Run it and answer the questions.;
;
/** to RUN it, you need to select the statements until you have the run; statement, and then click the 
    little running icon from the menu**/
data tree;
  infile "/home/u63275576/STAT674/M1/M1_data.dat";  /*Replace the ... with the path to your M1 folder here */
  input tree barea volume;
  label barea="Basal area";
  label volume="Timber volume";
run;
proc print data=tree;
run;
*question 2.1: How many observations are there in the dataset 'tree'?;
/* Answer: 
10

*/
*Question 2.2. How many variables are there in this dataset? ;
/* Answer: 
3

*/

**********************************************************************;
*Q3: Run the data step and the three PROC steps to answer Question 3 below;
data dst;
   input group $4. +1 letter $1. +1 number 1.;
   datalines;
grp1 a 1 
grp2 z 2
grp1 A 3
grp2 Z 4
grp1   .
grp2 a .
grp1   5
;
run;

proc print data=dst;
   title 'Q3 - Original Order';
run;
proc sort data=dst;
   by letter;
run;
proc print data=dst;
   title 'Q3 - Sorted by Letter';
run;
title;  
*Question 3: Describe the sort order that SAS used to sort the column 'letter', and 
             write your answers down in the comment below. 
/* Answer: 
It employs a sorting algorithm that prioritizes capital letters in alphabetical order followed by lowercase letters in the same manner.

*/

*Q4: run this code exactly as provided;
DATA info;
   City = 'Newark';
   Country = 'US'
   CountryCode = 01;
   CityCode = 22;
RUN;
*Question 4.1: Did it run properly? what went wrong? You may need to check the LOG to find out;
/*Answer :
No it doesn't run properly and has the syntacs error for missing ";" 
*/
*Question 4.2: Copy the code and paste below, and revise it to fix the programming mistakes.  Resubmit it. 
			   Go to the LOG window and find the statement that described the running of this data step.
               How many observations and variables were created ?;

DATA info;
   City = 'Newark';
   Country = 'US';
   CountryCode = 01;
   CityCode = 22;
RUN;  			   

/*Answer: 
The data set WORK.INFO has 1 observations and 4 variables.
*/

*Q5: Run the datasetp below;
DATA test;
   ^CourseID = 'STAT674';
   _CourseTitle = 'Applied Data Base Management';
   1stclassDay = 'Today';
RUN;

*Question 5.1: Did it run properly?  Check the LOG window to see what went wrong and explain why;
/*Answer :
No, it didn't run properly it has error "Statement is not valid or it is used out of proper order."
*/
*Question 5.2: Copy the code and paste below, and revise it to fix the programming mistakes. 
               Resubmit it. How many variables are there in the dataset?  How many obs? ;   
DATA test;
   CourseID = 'STAT674';
   CourseTitle = 'Applied Data Base Management';
   stclassDay = 'Today';
RUN;
/*Answer:
The data set WORK.TEST has 1 observations and 3 variables.
*/

libname M1 "/home/u63275576/STAT674/M1";

Data m1.test;
  X=1;
Run;
