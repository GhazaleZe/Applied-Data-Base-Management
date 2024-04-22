filename myfile '/home/u63275576/STAT674/M4/m4_sneakers.csv';
proc import datafile=myfile
            out=sneakers
            dbms=csv
            replace;
run;
proc print data = sneakers;
run;

Proc sql;
select * from sneakers;
quit;
* Q1.1;

PROC SQL;
    CREATE TABLE sneakers_year AS
    SELECT *, YEAR(release) AS year
    FROM sneakers;
QUIT;

PROC SQL;
	SELECT 	brand, year, count(year) as frequency
	from sneakers_year
	group by brand, year
	order by brand;
QUIT;
* Q1.2;

proc sql;

select item, brand, Max(retail) as highest_retail_price
from sneakers
group by brand;
quit;

* Q1.3;

proc sql;
select item, brand, Min(retail) as lowest_retail_price
from sneakers
group by brand;
quit;

* Q1.4;
proc sql;
select item, brand, retail,release, 
	highestBid,	numberOfBids,	
	case
		when retail < 100 then "Low"
		when (retail>=100 and retail <= 199) then "Medium"
		else "High"
	end as retail_Categorical
from sneakers;
quit;

*Q1.5;
proc sql;
    CREATE TABLE sneakers_prime AS
    SELECT 
        UPCASE(brand) AS brand,
        item,
        release FORMAT=date9. AS release_date_format
    FROM 
        sneakers
    ORDER BY 
        brand ASC,
        release DESC;
quit;

proc sql;
select * from sneakers_prime;
quit;

***Q2*********************;

proc sql;
    CREATE TABLE WORK.stocks AS
    SELECT *
    FROM sashelp.stocks;
quit;

proc sql;
select * from work.stocks;
quit;

*Q2.2;
proc sql;
    CREATE TABLE WORK.stocks_prime AS
    SELECT 
        *,
        close - open AS price_change,
        PUT(Date, DATE9.) AS date2 FORMAT=$10.,
        PUT(high - low, DOLLAR10.1) AS volatility,
        'SASHELP.stocks' AS dataSource,
        TODAY() AS today FORMAT=DATE9.,
        'Ghazaleh Zehtab' AS author
    FROM WORK.stocks;
quit;

proc sql;
select * from WORK.stocks_prime ;
quit;

***** Q3;

PROC IMPORT OUT=work.salaries
            DATAFILE="/home/u63275576/STAT674/M8/salaries.xlsx"
            DBMS=XLSX
            REPLACE;
RUN;

proc sql;
select * from salaries;
quit;
