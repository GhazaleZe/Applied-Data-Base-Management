

libname mydata "/home/u63275576/STAT674/M9/";
data customers;
    set mydata.customers;
run;

data items;
    set mydata.items;
run;

data list;
    set mydata.list;
run;

data orders;
    set mydata.orders;
run;

data prices;
    set mydata.prices;
run;

data salesrep;
    set mydata.salesrep;
run;


*Q6.2;

proc sql;
	create table bookYear as
	select YEARPUB, Count(*) as BooksPublished
	from list
	group by YEARPUB;
Quit;
proc sql;
select * from bookYear;
quit;

proc sql;
	select YEARPUB, BooksPublished
	from bookYear
	where BooksPublished = (select Min(BooksPublished) from bookYear);
quit;

* Q6.3;


proc sql;
    create table orders2008 as
    select orderno, year(dateord) as year_order
    from orders 
    where year(dateord) = 2008;
quit;
proc sql;
    create table year_book_name as
    select items.quantity,
           list.TITLE,
           list.bookid
    from orders2008 as o
    inner join items as items on o.orderno = items.orderno
    inner join list as list on items.bookid = list.bookid;
quit;

proc sql;
	select bookid, TITLE, SUM(quantity) as quantity
	from year_book_name
	group by bookid, TITLE 
	order by quantity;
quit;

* Q6.4;

proc sql;

		create table listprime as
		select *, monotonic() as rownum
        from list order by Isbn;
quit;

proc sql;
    create table isbn_check as
    select a.isbn, 
           b.isbn as prev_isbn,
           count(case when a.isbn < b.isbn then 1 end) as num_incorrect
    from listprime as a
    left join listprime as b
    on a.rownum = b.rownum + 1
    group by a.isbn;
quit;

proc sql;
	select * from isbn_check;
quit;

*Q6.5;

proc sql;

	create table rep_order as
	select orders.orderno,salesrep.id, salesrep.name, salesrep.salesid 
	from orders inner join salesrep
	on orders.salesid = salesrep.salesid;
quit;

proc sql;
	create table mostSale as
	select rep_order.orderno,rep_order.id, rep_order.name,  items.dateship, items.quantity
	from rep_order inner join items on rep_order.orderno = items.orderno
	where year(items.dateship) = 2014;
quit;
	
proc sql;
	create table final as 
		select id, name , sum (quantity) as NumberOfBooks
		from mostSale
		group by id, name
		order by NumberOfBooks Desc;
quit;

proc sql;
    SELECT SUBSTR(name, 1, 1) || ' ' || SCAN(name, -1, ' ') AS formatted_name, NumberOfBooks
    FROM final;
quit;


