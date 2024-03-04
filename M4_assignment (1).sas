****************************************
M4 Assignment: Basic Procedures 1
******************************************


*Q1.1- Import data from the file m4_sneakers.csv and answer the following questions;
filename myfile '/home/u63275576/STAT674/M4/m4_sneakers.csv';
proc import datafile=myfile
            out=sneakers
            dbms=csv
            replace;
run;
proc print data = sneakers;
run;

*Q1.2- Write a libname statement to point to the folder where you saved the data file, then import (use proc import) it into a SAS dataet named as 'sneaker' and save it in the same folder, please refer to Module 3 Homework Q4 as an example; 
libname M4 '/home/u63275576/STAT674/M4';

proc import datafile=myfile
            out=M4.sneakers
            dbms=csv
            replace;
run;
proc print data = M4.sneakers;
run;


*Q1.3- Use a PRINT procedure to print the data. How many variables can you observe in the data portion?;
proc print data=m4.sneakers;
run;

*Q1.4- Use a proper SAS procedure to observe the descriptor portion of dataset, what is the format used in the original 
dataset for the variables 'item' and 'release'?;
proc contents data=m4.sneakers;
run;
*Q1.5- Use a data step to change the format of the variable 'release' to make it look like '08JUN2022'.
       Format variable 'volatility' with 3 decimal places. ;
data M4.sneakers;
set M4.sneakers;
format release date9.;
format volatility 8.3;
run;
proc print data=M4.sneakers;
run;

*Q2- Continue to use the data from Q1.1;
*Q2.1- Use a proper procedure to find out which sneaker has the most sales. Hint: use variable 'salesthisperiod';

proc sort data=m4.sneakers out=sorted_sneakers;
by descending salesthisperiod;
run;

proc print data=sorted_sneakers;
var item salesthisperiod; 
run;
*Q2.2- Use the variables 'retail' and 'lastsale' to compute its profit rate; 

data profit_rate; 
  set m4.sneakers;

  if lastsale ne 0 then
    profit_rate = (retail - lastsale) / lastsale;
  else
    profit_rate = .; 

run;

proc print data=profit_rate;
var item profit_rate; 
run;

*Q2.3- Use a data step to add a new variable with upper case 'BRAND', then add a label, such as 'UPCASE BRANDS';

data upcase_brand; 
  set m4.sneakers;

  upcase_brand = upcase(brand);
  label upcase_brand = 'UPCASE BRANDS';

run;

proc print data=upcase_brand;
run;

*Q3- Practice PROC FREQ and its options;
*Q3.1- Import the data set m4_fish.xlsx and answer the following questions;
filename myfile1 '/home/u63275576/STAT674/M4/m4_fish.xlsx';
proc import datafile=myfile1
            out=fish
            dbms=xlsx
            replace;
run;
proc print data = fish;
run;

*Q3.2- Use proc freq to create a frequency table to show the count for each species (including missing values);
proc freq data=fish; 
  tables species / missing;
run;

*Q3.3- Add an option to not print the cumulative frequency column.
       Hint: use options after the "/" in the tables statement;

proc freq data=fish; 
  tables species / missing nocum;
run;

*Q3.4- Create a cross-tabulation table of weight category and water type;
proc freq data = fish;
	tables weight_category * water_type / missing;
run;
*Q3.5- Similar to Q3.4, create a series of cross-tabulation tables using single or 
combinations of the options norow, nocol and nopercent in the table statement.
What are the impacts of each option? Based on the output, how can you tell which option(s) have been used?*/;

proc freq data = fish;
	tables weight_category * water_type / missing out=fish_freq nopercent;
run;

*Q4- Proc means with the data set m4_fish;
*Q4.1- Use proc means to find how many missing values are in variable 'water_type'.;
proc means data = fish missing;
	class water_type;
run;
*Q4.2- Use proc means to find average, min, max and standard deviation of variable 'length'.
       Briefly comment on the results;

proc means data=fish mean min max std;
  var length;
run;




