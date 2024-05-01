**********************
PROC SQL Part 2;
**********************;
**Q1;
**** Write the proc sql statements to create a table merging the datasets ONE and TWO on
       their common variable x keeping only the matching observations in both data sets;
**** Recall the problems that were encountered when using merge in a data step to 
       combine these data sets. Did you have the same problems merging these data sets in a PROC SQL?
****;

data one;
   input x $;
   datalines;
cat
catnap
catnip
;
run;
data two;
   input x $3. y ;
   datalines;
cat 111
dog 222
;
run;

proc sql;
	create table Q1 as
	select one.x as x , two.y
	from one inner join two
	on one.x = two.x;
quit;

proc sql;
	select * from Q1;
quit;

**Q2  Write the proc sql statements to create a table merging the datasets SINGLE and DOUBLE on
      their common variable ID, keeping all observations from SINGE and the matching observations from DOUBLE;
data single;
   input id $ var;
   datalines;
a 1
b 2
c 3
;
run;
data double;
   input id $ var;
   datalines;
a 11
c 33
;
run;

proc sql;
	create table Q2 as
	select single.id as id_single, single.var as var_single, double.id as id_double, double.var as var_double
	from single left join double
	on single.id = double.id;
quit;

proc sql;
	select * from Q2;
quit;

**Q3 Use PROC SQL to merge the data sets FRUITS and COLORS,on the key variable ID.
	 keeping all observations common to both data sets and print the resulting data set;
**** Are the results what you expected? If not, what is different?   ; 
    
data fruits;
   input id $ fruit $;
   datalines;
a apple
a apple
b banana
c coconut
c coconut
c coconut
;
run;
data colors;
   input id $ color $;
   datalines;
a amber
b brown
b black
c cocoa
c cream
;
run;

proc sql;
	create table Q3 as
	select fruits.id as id_fruits, fruits.fruit, colors.color 
	from fruits inner join colors
	on fruits.id = colors.id;
quit;

proc sql;
	select * from Q3;
quit;

**Q4 In question 3, the resulting data set has repeated observations of the combinations of 
	 fruits and colors. Re-write the SQL query to produce a merged data set that 
	 does not contain duplicate observations;
	 
proc sql;
	create table Q4 as
	select distinct fruits.id as id_fruits, fruits.fruit, colors.color 
	from fruits inner join colors
	on fruits.id = colors.id;
quit;

proc sql;
	select * from Q4;
quit;

**Q5 There are two datasets below about sales reports of toys during the holiday of two stores A and B; 
data A_Sales;
input TOYS $ 1-13 Store $ 14-16 Brand $17-18 Qty_sold 19-23;
datalines;
Cars          A X 23
Cars          A Y 12
Dolls         A X 25
Dolls         A Y 30
ActionFigures A X 18
ActionFigures A Y 26
;
run;
data B_Sales;
input TOYS $ 1-13 Store $ 14-16 Brand $17-18 Qty_sold 19-23;
datalines;
Cars          B X 15
Cars          B Y 20
Dolls         B X 32
Dolls         B Y 29
ActionFigures B X 15
ActionFigures B Y 20
;
run;
**Q5.1 use a data step to stack the data sets A_Sales and B_Sales to create a new table named REPORT;

data REPORT;
    set A_Sales B_Sales;
run;

proc sql;
select * from REPORT;
quit;

**Q5.2 Use PROC SQL to summarize the total quantity sold by store;

proc sql;

	select store, SUM(Qty_sold) as total_Qty
	from REPORT
	Group by store;
quit;


**Q5.3 Use PROC SQL to summarize the total sales by brand.Which brand has higher sales? ;

proc sql;

	select Brand, SUM(Qty_sold) as total_Qty_Brand
	from REPORT
	Group by Brand;
quit;


**Q5.4 Use PROC SQL to summarize the total sales by toy type. Which toy was the bestseller?;

proc sql;

	select TOYS, SUM(Qty_sold) as total_Qty_TOYS
	from REPORT
	Group by TOYS;
quit;


