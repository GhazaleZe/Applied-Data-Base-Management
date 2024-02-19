****Assignment 2*****;
**** copy and paste your code and answers into a WORD file and submit ;

/*
Q1, Run the code provided below; then answer the following questions;*/

Data Cars ;
set sashelp.cars;
run;

/*Q1.1  Describe what the above code does. Use the hints below as a template.
        First line is a data statement that specify a name "Cars" for new dataset.
        Second line reads sashelp.cars dataset from existing datasets
        Third line is for executing the steps and creat the dataset.
        In the end, Cars dataset is created and saved to WORK library.
*/
/*Q1.2  Write proper code to view the DATA PORTION. Describe what information you have seen.*/
***ANSWER:      ;   
proc print data=cars;
run;
/*Q1.3 Write proper code to view the DESCRIPTOR PORTION. Describe what information you have seen.*/
***ANSWER:      ;   

/*Q1.3, Compare to DATA PORTION and DESCRIPTOR PORTION, what is the difference?*/
***ANSWER:      ;   
proc contents data=cars;
run;

*****;
/*Q2, Answer the following questions. ;*/
data q2 ;
length ;
input BRAND TYPE YEAR PRICE_RANGE ;
datalines;
BMW SUV 2021 40K-120K 
TOYOTA SEDAN 2022 21K-45K
Chevrolet SUV 2022 30K-52K
TOYOTA SUV 2022 3OK-55K
MERCEDES_BENZ SUV 2022 52K-100K
;
RUN;
*Q2.1, Did the code run properly? If no, explain what did the errors mean? Describe all variable types.;*/ 
***ANSWER:      ;   

*** No, it didn't runs proparly since itt couldn't handel the charates input.

*Q2.2 Modify the code to read the instream raw data.;*/
***ANSWER:      ;   

data q2;
  length BRAND $20 TYPE $10 YEAR 4 PRICE_RANGE $10;
  infile datalines;
  input BRAND TYPE YEAR PRICE_RANGE;
  datalines;
BMW SUV 2021 40K-120K 
TOYOTA SEDAN 2022 21K-45K
Chevrolet SUV 2022 30K-52K
TOYOTA SUV 2022 30K-55K
MERCEDES_BENZ SUV 2022 52K-100K
;
run;


*Q3 - impor the m2_marketing_campaign.xlsx file properly, and observe how many obs and variables
      there are in the dataset;

/*ANSWER:      */
proc import datafile="/home/u63275576/STAT674/M2/m2_marketing_campaign.xlsx" 
            out=marketing_campaign
            dbms=xlsx replace;
run;

proc contents data=marketing_campaign;
run;

*Q4 -  Download the data files m2_d1 � m2_d6 to your computer.  Use a text viewer, such as Notepad, to check them.   
       Slide 16 of lecture M2a summarizes 5 most popular INPUT styles. Which one to use depends on the features
       of the data in the flat file.  
	   For each data file, write an appropriate DATA step to read it in, and then save to a permanent library.  
       You should have created a library m2 for this module. ;
       
**m2_d1;
libname M2 '/home/u63275576/STAT674/M2';
data d1_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d1.txt';
   input 
    Brand $1-10
    City $11-22
    Type $23-28
    Quantity 29-32;
run;

data M2.d1_dataset; 
  set d1_dataset; 
run;
**m2_d2;

data d2_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d2.txt' truncover dlm=' ';
  length Brand $ 10;
  length City $12;
   input Brand $ City $ Type $ Quantity;
run;

data M2.d2_dataset; 
  set d2_dataset; 
run;

**m2_d3;

data d3_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d3.dat' truncover dlm=' ';
  length Brand $ 10;
  length City $12;
   input Brand $ City $ Type $ Quantity;
run;

data M2.d3_dataset; 
  set d3_dataset; 
run;


**m2_d4;

data d4_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d4.dat';
   input 
    Brand $1-10
    City $11-25
    Type $26-32
    Quantity $33-38;
    
run;

data M2.d4_dataset; 
  set d4_dataset; 
run;


**m2_d5;

data d5_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d5.txt' truncover dlm=' ';
  length Brand $ 10;
  length City $12;
  length Type $5;
  length Quantity $8;
   input Brand $ City $ Type $ Quantity $;
run;

data M2.d5_dataset; 
  set d5_dataset; 
run;

**m2_d6;

data d6_dataset;
  infile '/home/u63275576/STAT674/M2/m2_d6.txt' truncover dlm=' ';
  length Brand $ 10;
  length City $12;
  length Type $5;
  length Quantity $8;
   input Brand $ City $ Type $ Quantity $;
run;

data M2.d6_dataset; 
  set d6_dataset; 
run;



