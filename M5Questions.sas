filename myfile '/home/u63275576/STAT674/M4/m4_sneakers.csv';
proc import datafile=myfile
            out=sneakers
            dbms=csv
            replace;
run;
proc print data = sneakers;
run;

data sneakers_2;
    set sneakers;

    /* 2.1 showing the number of words in the item variable */
    number_of_words = countw(item);

    /* 2.2 For those items with more than 4 words, find the 4th word and store it in a new variable */
    if number_of_words > 4 then fourth_word = scan(item, 4);

    /* 2.3 Create a variable indicating whether the band’s name includes the special character "&" */
    There_is_ampersand = find(item, "&") > 0;

    /* 2.4 Variable showing the length of the Brand name */
    brand_length = length(brand);

    /* 2.5 Create a new variable combining item and its year of release */
	**combined_item_year = cats('(', put(year(release), 8.), ')');
	combined_item_year = catx(' ',item, cats('(', put(year(release), 8.), ')'));

    /* 2.6 Create a new variable that divides the items into price groups */
   length price_group $8;
    if retail <= 100 then
    	price_group = 'Low';
    else if retail > 100 and retail <199 then
    	price_group = 'Medium';
    else 
    	price_group = 'High';

run;
proc print data = sneakers_2;
run;
/* proc sort data= sneakers_2; */
/* by price_group; */
/* run; */


data priceHigh Y2021 Nike;
    set sneakers; 

    /* price higher than $200 */
    if retail > 200 then output priceHigh;

    /* items released in 2021 */
    if year(release) = 2021 then output Y2021;

    /* Nike items */
    if brand = 'Nike' then output Nike;
run;

proc print data = priceHigh;
    title "Dataset: priceHigh (Retail Price > $200)";
run;

proc print data = Y2021;
    title "Dataset: Y2021 (Items Released in 2021)";
run;

proc print data = Nike;
    title "Dataset: Nike (Brand: Nike)";
run;

** Q4;
proc freq data=sneakers_2;
    where price_group = 'Low';
    tables brand / out=BrandGroups;
run;


data MostItemsLow;
    set BrandGroups;
    by brand;
    
    if first.brand then max_counter = 0;
   
    if count > max_counter then do;
        max_counter = count;
        max_brand = brand;
    end;
    
    if last.brand then output;
    
    drop count;
run;

proc sort data=MostItemsLow out=SortedMostItemsLow;
    by max_counter;
run;

proc print data=SortedMostItemsLow;
    title "Brand with the Most Items in the Low Category";
run;

**Q5;
data BrandMatch;
    set sneakers; 

    first_word = scan(item, 1);

    It_is_Match = (upcase(first_word) = upcase(brand));

    output;
run;

proc freq data=BrandMatch;
    tables It_is_Match / nocum;
    title "Compare First Word of 'item' vs 'brand'";
run;

**Q6;

proc freq data=sneakers;
    where year(release) = 2022;
    tables brand / out=BrandCounts2022;
run;

data MostRelease_2022;
    set BrandCounts2022;
    by brand;

    if first.brand then max_counter = 0;

    if count > max_counter then do;
        max_counter = count;
        max_brand = brand;
    end;

    if last.brand then output;
    
    drop count;
run;

proc sort data=MostRelease_2022 out = SortedMostRelease_2022;
by max_counter;
run;

proc print data=SortedMostRelease_2022;
    title "Brand with the Most Releases in 2022";
run;

**Q6;
proc sort data=sneakers out=SortedByDate;
    by release;
    where not missing(release);
run;


proc print data=SortedByDate;
    title "Sorted Data Based on Dates";
run;
