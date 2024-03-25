/***
STAT674 Assignment 6
You may need to use multiple data steps and PROCs for a question.  	
***/

/*Q1: Customer information in a bank is separated in two datasets as below.*/
libname M6 '/home/u63275576/STAT674/M6';
data cust_demo;
length ID 3 Gender $1 income $5;
input ID Gender $ income $;
datalines;
123 F 10k
234 M 15K
345 F 20K
678 F 21K
987 M 25K
;
run;



data cust_balance;
length ID 3 zipcode $5 balance $6;
input ID zipcode $ balance $;
datalines;
123 14528 500k
234 37482 650k
987 63783 540k
678 78392 320k
345 02934 700k
;
run;


**Q1.1  Create a dataset that combines the above two datasets by stacking;

data stack stakedQ1;
set cust_demo cust_balance;
run; 
proc print data = stakedQ1;
run;
**Q1.2  Create another dataset that combines by interleaving.
        What's the difference between the two combined versions? ;
proc sort data = cust_balance out = cust_balance_sorted ;
by ID;
run;
data interleave stakedQ12;
set cust_demo cust_balance_sorted;
by ID;
run; 

proc print data = stakedQ12;
run;

**Q1.3 Create a 3rd dataset that combines by merging.
       What's the difference between SET and MERGE?;

data stakedQ13;
merge cust_demo cust_balance_sorted;
by ID;
run; 

proc print data = stakedQ13;
run;


/*Q2: below you will create two datasets about a store's sales information*/

data product;
input Item $ 1-7 Material $ 8-14 cost 16-18 price 19-21;
datalines;
shirts cotton  32 61
pants  leather 23 56
suits  cotton  78 102
belts  silk    31 57
shoes  leather 32 70
;
run;


data SalesReport;
input Item $ 1-7 sales_volume 8-15;
datalines;
suits  5150
shoes  3152
belts  2156
pants  1032
shirts 620
;
run;

**Q2.1  Merge these two data sets, and create the following two new variables in the dataset:
		-- a new variable "profit_per_piece" by using cost and price,
   		-- a new variable "total_profit" by using profit_per_piece and sales_volume;
proc sort data = product out = product ;
by Item;
run;
proc sort data = SalesReport out = SalesReport ;
by Item;
run;
		
data MergeQ21;
merge product SalesReport;
by Item;
profit_per_piece = price - cost;
total_profit = profit_per_piece * sales_volume;
run;

proc print data = MergeQ21;
run;
 
**Q2.2 	Find out the grand total profit of all items, and save this result to a dataset;

proc means noprint data = MergeQ21;
var total_profit;
output out = Q22 Sum(total_profit) = GrandTotal;
run;

proc print data = Q22;
run;

**Q2.3 Combine the grand total profit dataset with the dataset you created in Q2.1;

data Q23;
if _N_ = 1 then set Q22;
set MergeQ21;
run;

proc print data = Q23;
run;


**Q2.4 Calculate the percentage of each item's total profit to the store's grand total profit. 
       Which item makes the most profit?  How much (%) does it contribute to the store's overall profit?;
data Q24;
    set Q23;
    percentage_total_profit = (total_profit / GrandTotal)*100;
run;

proc sort data = Q24 out=Q24_sorted;
by descending percentage_total_profit ;
run;
proc print data = Q24_sorted;
run;


*Q3: The company hired new employees and new interns this year, 
      and their information is separated into two different data sets as below.;

data New_Employee;
length name $15;
input name $ team training_course work_experience;
datalines;
Bohr,Neils 1 0 3
Zook,Carla 2 2 2
Penrose,Roger 1 3 1
Martinez,Maria 3 1 2
Orfali,Philip 2 1 1
;
run;


data New_Intern;
length name $15 major $20;
input name $ team training_course major $;
datalines;
Capalleti,Jimmy 3 1 FashionDesign
Chen,Len 2 0 BusinessAnalytics
Cannon,Annie 1 0 Mathematics
Davis,Brad 3 0 Art
Einstein,Albert 1 1 ComputerScience
;
run;



**Q3.1  Combine these two datasets by using an appropriate data step. Is it better to merge or stack?
;
data stack Q31;
set new_employee new_intern;
run;
proc print data = Q31;
run;
**Q3.2 Below is the data with manager info.  
       Use a data step to show, for each of the new employees and interns, 
		-- who their manager is, and
    		-- which department they will work in.
  	   Hint: If you used the dataset "Manager" without modifying the variable 'name', 
       the final result seemed wrong. Use a comment to explain why.
       It doesn't work becuase there is 2 variable "name" and it's not the vaiable we use in by statement so it igor the second one;


proc sort data = Q31 out = Q31;
by team;
run;

data Manager;
length Manager_Name $15 department $10;
input Manager_Name $ team department $;
datalines;
Wilson,Kenneth 1 Operation
Bardeen,John 2 Marketing
Sorrell,Joseph 3 Design
;
run;

proc sort data = Manager out = Manager;
by team;
run;

data Q32;
merge Q31 Manager;
by team;
run;

proc print data = Manager;
run;

proc print data = Q32;
run;



**Q3.3 Use data step(s) and PROCs to show which department has the most new people (including both new employees and interns) this year;

proc FREQ data = Q32;
    tables department / out = DepartmentCounts;
run;




