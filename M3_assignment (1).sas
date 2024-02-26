****************************************
M3 Assignment: create new variables in SAS code, and
put your answers in /*  */ as comments.  
Copy and paste your codes and results into a WORD file and submit.
DO NOT use the 'print code' button to print to PDF.  It may miss pages toward the end.
HINT: You can use put function to create a new variable with different format.
****************************************;
libname M3 '/home/u63275576/STAT674/M3';
*Q1(40 pts), Run the code below first,then answer the following questions.;
data stocks;
set sashelp.stocks;
run;


*Q1.1- Write a data step to create a new data set by removing variable 'adjclose'.
       How many variables and obs are there in the resulting dataset? ; 

***ANSWER:      ;  
data stocksQ1 (drop = AdjClose);
set stocks;
run;
Proc print data=stocksQ1;
run;

*Q1.2- In your dataset, add a new variable 'Date2' that will have the same value as Date but looks like 2005-01-01.
       Note that you need to have the month, day and year separated by '-', not '/' ;

***ANSWER:      ;  
data stocksQ12;
set stocks;
Date2 = Date;
format Date2 yymmdd10.;
run;
Proc print data=stocksQ12;
run;

*Q1.3- In your dataset, add a new variable 'Yearmonth' that will have only year and month part of 'Date' with format like '200512';

***ANSWER:      ;  
data stocksQ13;
set stocks;
Yearmonth = Date;
format Yearmonth yymmn6.;
run;
Proc print data=stocksQ13;
run;

*Q1.4- In your dataset, add a new variable 'high_char' by converting the numeric variable 'high' to a char variable.
How do you verify the 'high_char' is a char variable? ;

***ANSWER:      ;  

data stocksQ14;
set stocks;
high_char = put(high, 10.);;
format high_char $10.;
run;
Proc print data=stocksQ14;
run;

*Q1.5- Based on the change of price at oepn and close (Close - Open), create a flag variable with values 'green'(>0) or 'red'(<0) or 'neutral' (=0).;

***ANSWER:      ;  

data stocksQ15;
set stocks;
  Diff = Close - Open;

  if Diff > 0 then
    Flag = 'green';
  else if Diff < 0 then
    Flag = 'red';
  else
    Flag = 'neutral';

  drop Diff;
run;
Proc print data=stocksQ15;
run;



*Q2 import the datafile m3_Salary_Data.csv and answer the following questions;
filename myfile '/home/u63275576/STAT674/M3/m3_Salary_Data.csv';
proc import datafile=myfile
            out=m3_Salary_Data
            dbms=csv
            replace;
run;
proc print data = m3_Salary_Data;
run;

*Q2.1- Suppose the data was collected on Feb. 1, 2023, compute the year of their birth (the year must be an integer!!!);

data m3_Salary_Data;
  set m3_Salary_Data;

  CollectedDate = '01Feb2023'd;
  YearOfBirth = year(CollectedDate) - Age;

  format YearOfBirth 4.; 
proc print data = m3_Salary_Data;
run;

*Q2.2 - In your dataset, add a new variable 'Salarynew' with format to look like $30,000 ;

data m3_Salary_Data;
  set m3_Salary_Data;
  Salarynew = Salary;
  format Salarynew DOLLAR12.;
run;
proc print data = m3_Salary_Data;
run;


*************;
*Q3, Read the sashelp.baseball to answer the following questions;

data baseball;
set sashelp.baseball;
run;

*Q3.1- Create two variables as 'first_name', 'last_name'  to extract last, first name from 'name',  use upper case format for 'last_name' */

***ANSWER:      ;  

data baseball;
  set baseball;


  first_Name = scan(Name, 2, ',');
  last_Name = scan(Name, 1, ',');
  Last_Name = upcase(Last_Name);

run;

proc print data = baseball;
run;

*Q3.2- Use appropriate code to find out how many teams there are in the dataset and which team has the least number of players.*/

***ANSWER:      ;  
/* Find Teams*/
proc freq data=baseball noprint;
  tables Team / out=NumberOfTeams(keep=Team Count);
run;

proc sort data=NumberOfTeams;
  by Count;
run;

proc print data = NumberOfTeams;
run;




*Q4 - Import the admission data from file m3_admission_data.csv and 
      use conditional logic, write code to create a categorical variable based on the variable 'GRE':
  		<305  LOW 
		305-325: MEDIUM 
 		> 325: HIGH 
;

filename myfile '/home/u63275576/STAT674/M3/m3_admission_data.csv';
proc import datafile=myfile
            out=m3_admission_data
            dbms=csv
            replace;
run;
proc print data = m3_admission_data;
run;

data m3_admission_data;
set m3_admission_data;
  if GRE < 305 then
    GRE_Categorical = 'LOW';
  else if GRE >= 305 and GRE <= 325 then
    GRE_Categorical = 'MEDIUM';
  else
    GRE_Categorical = 'HIGH';
run;

Proc print data=m3_admission_data;
run;




