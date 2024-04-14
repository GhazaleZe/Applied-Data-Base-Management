
data NormalDistribution;
    do j = 1 to 100;
        x = rand("Normal", 0, 1);
        output;
    end;
    drop j;
run;
proc print data = NormalDistribution;
run;
proc means data=NormalDistribution mean;
run;

**3;
data MeansOf600;
    do n = 1 to 600;
        do j = 1 to 100;
            x = rand("Normal", 0, 1);
            output;
        end;
    end;
run;

proc means data=MeansOf600 noprint;
    by n;
    var x;
    output out=MeansOf600_100 mean=mean;

run;

proc print data = MeansOf600_100;
run;

*4;


proc means data=MeansOf600_100 mean noprint;
	var mean;
    output out=final_mean_results_600_100 mean=mean;
run;

proc print data = final_mean_results_600_100;
run;

** for 500;


data MeansOf600_500;
    do n = 1 to 600;
        do j = 1 to 500;
            x = rand("Normal", 0, 1);
            output;
        end;
    end;
run;

proc means data=MeansOf600_500 noprint;
    by n;
    var x;
    output out=MeansOf600_500 mean=mean500;
run;

proc print data = MeansOf600_500;
run;

*4prime;


proc means data=MeansOf600_500 mean noprint;
	var mean500;
    output out=final_mean_results_600_500 mean=mean;
run;

proc print data = final_mean_results_600_500;
run;


**B;

data MeansOf600_100;
    set MeansOf600_100(keep=n mean);
run;

data MeansOf600_500;
    set MeansOf600_500(keep=n mean500);
run;

proc print data = MeansOf600_500;
run;
**dataOK;

data Combined;
    merge MeansOf600_100 MeansOf600_500;
    by n;
run;


proc sgplot data=Combined;
    title 'Scatter Plot comparing 100 vs 500 Sample';
    scatter x=n y=mean/ markerattrs=(color=blue);

    scatter x=n y=mean500 / markerattrs=(color=red);
run;

** for N(2,4)*************************;

data MeansOf24;
    do n = 1 to 600;
        do j = 1 to 100;
            x = rand("Normal", 2, 4);
            output;
        end;
    end;
run;

proc means data=MeansOf24 noprint;
    by n;
    var x;
    output out=MeansOf24 mean=mean2_4;

run;

proc print data = MeansOf24;
run;

data MeansOf24;
    set MeansOf24(keep=n mean2_4);
run;

data Combined_new;
    merge Combined MeansOf24;
    by n;
run;


proc sgplot data=Combined_new;
    title 'Scatter Plot comparing 100 vs 500 of N(0,1) vs 100 sample of N(2,4)';
    scatter x=n y=mean/ markerattrs=(color=blue);

    scatter x=n y=mean500 / markerattrs=(color=red);
    scatter x=n y=mean2_4 / markerattrs=(color=orange);
run;
/* proc means data=MeansOf600_100 mean noprint; */
/* 	var mean; */
/*     output out=final_mean_results_600_100 mean=mean; */
/* run; */
/*  */
/* proc print data = final_mean_results_600_100; */
/* run; */



