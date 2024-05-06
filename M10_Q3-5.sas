libname mydata "/home/u63275576/STAT674/M10/";
data Got;
    set mydata.got;
run;

%let categorical_vars = sex religion occupation social_status allegiance_switched;


proc freq data=Got;
    tables &categorical_vars / missing;
run;

**Q3.2.1;
%let categorical_vars = sex ;

proc freq data=Got noprint;
    tables &categorical_vars / missing out=levels_counts;
run;

proc sort data=levels_counts out=sorted_levels_counts;
    by descending COUNT;
run;

proc print data= sorted_levels_counts;

**Q3.2.2;
%let categorical_vars = religion ;

proc freq data=Got noprint;
    tables &categorical_vars / missing out=levels_counts;
run;

proc sort data=levels_counts out=sorted_levels_counts;
    by descending COUNT;
run;

proc print data= sorted_levels_counts;

**Q3.2.3;
%let categorical_vars = intro_episode ;

proc freq data=Got noprint;
    tables &categorical_vars / missing out=levels_counts;
run;

proc sort data=levels_counts out=sorted_levels_counts;
    by descending COUNT;
run;

proc print data= sorted_levels_counts;

*Q3.3;
%let categorical_vars = intro_episode ;

proc freq data=Got noprint;
    tables &categorical_vars / missing out=levels_counts;
run;

proc sort data=levels_counts; 
	by descending COUNT;
run;
data levels_counts_call_symput;
	set levels_counts;
	if _n_=1 then Call symput("biggest",intro_episode);
run;

%put &biggest;

proc print data=levels_counts noobs;
	Where intro_episode=&biggest.;
	Title "Episode &biggest. introduced the most characters";
run;

**Q4.1;

%let myproc = freq;

PROC &myproc. Data=Got;
  TABLE featured_episode_count / out=frequency_counts;
RUN;

**Q4.2;
%let myproc = means;

PROC &myproc. Data=Got;
  VAR featured_episode_count;
RUN;

**Q5.1;

%let mydataset = Got;
%let myproc = freq;
%let myvar = icd10_dx_text ;

PROC &myproc. Data=&mydataset.;
  TABLE &myvar. / out=frequency_&myvar. ;
RUN;

%let mydataset = Got;
%let myproc = means;
%let myvar = dth_time_hrs;

PROC &myproc. Data=&mydataset. mean;
  VAR &myvar.;
RUN;


