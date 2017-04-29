
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
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

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,
%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';

title1
'Research Question: What is the number of delayed departure flights arrived within 15 minutes of the scheduled arrival time?'
;

title2
'Rationale: To identify the number of flight that made an acceptable delay (arrived within 15 min. of the scheduled time)'
;

/*

Methodology: using PROC CONTENTS to get then number of observation on the 
subset dataset Delay15.

Limitations: it will be helpful to know the precentage of flights that meets our
condition because the presentage tells more than the number by it self. Also,
PROC CONTENTS lists all the information about the dataset not the number of rows
only.

Possible Follow-up Steps: find the precentage of flights that meet the 
condition

*******************************************************************************;
*/ 


proc contents data=Delay15 varnum;
run;



title1
'Research Question: Considering delayed departure time, which three airports have the worst performance?'
;

title2
'Rationale: To identify the 3 airports that have the highest frequency of delayed flights)'
;

/*
*******************************************************************************;

Methodology: Use PROC PRINT to print just the first 3 observations from the 
temporary dataset.

Limitations: This methodology does not account for Origion with missing data.

Possible Follow-up Steps: checking the number of missing values in DepDelay
so that the means computed is more accurate.
*******************************************************************************;
*/

proc print noobs data=temp(obs=3);
    id Origin;
    var DepDelay;
run;

title1
'Research Question: What is the percentage of the delayed flights were cancelled per carrier?'
;

title2
'Rationale: To identify the frequency of cancelled flights per carrier)'
;

/* 
*******************************************************************************;

Limitations: This methodology does not account for missing data.

Possible Follow-up Steps: checking the Cancelled variable for any missing data 
so that the means computed is more accurate.

*******************************************************************************;
*/

proc freq data=flights_analytic_file;
    table Cancelled*UniqueCarrier;
run;
