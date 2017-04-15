

*******************************************************************************;
*
This file uses the following analytic dataset to address several research
questions regarding flight delay in US airports
Dataset Name: DelayedFlight.csv created in external file
STAT6250-02_s17-team-02_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';


/*
...................................................................................................

Question 1:  what is the number of delayed departure flights arrived within 15 minutes of the scheduled arrival time? 

Rationale: To identify the number of flight that made an acceptable delay(arrived within 15 min. of the scheduled time)
...................................................................................................

*/ 


data Two;
    set one;
    where ArrDelay<15;
run;

* to find number of ibservation that meet codition;
proc contents data=two varnum;
run;


/*
Question 2: Considering delayed departure time, which three airports have the worst performance? 

(Rationale: To identify the airport that has the highest frequency of delayed flights)
*/
proc means data=one;
    class Origin;
    var DepDelay;
    output out=temp;
run;

proc sort data=temp;
    by descending Origin;
run;

proc print noobs data=temp(obs=3);
    id Origin;
    var DepDelay;
run;


/* 
Question 3: what percentage of the delayed flights were cancelled per carrier? 

(Rationale: To identify the frequency of cancelled flights per carrier)
*/

proc freq data=one;
    table Cancelled*UniqueCarrier;

run;
