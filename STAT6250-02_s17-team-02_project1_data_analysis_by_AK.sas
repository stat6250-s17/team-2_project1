*******************************************************************************;
*******************************************************************************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*
This file uses the following analytic dataset to address several research
questions regarding flight delay in US airports

Dataset Name: DelayedFlight.csv created in external file having three months
STAT6250-02_s17-team-02_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X 
"cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
;
* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';

title1
'Research Question: What is the average flight delay due to weather for each carrier?'
;

title2
'Rationale: We want to know which carriers are better and have the lowest
 delay due to weather based on flight time.'
;

footnote1
'Based on the above output, Aloha Airlines Inc. (AQ) has the longest delay on
 average which is 58.9 minutes.'
;

footnote2
'SkyWest Airlines has the second longest delay time which is 38.83 minutes.'
;

footnote3
'It would be interesting to look at the weather data and delay due to weather to
 question which airline is better but we do not have the access to those data.' 
;

/*
*******************************************************************************;
Methodology: Use PROC PRINT to print just the first ten observations from
 the temporary dataset created in the corresponding data-prep file.

Limitations: This dataset has only data for year 2013.  

Possible Follow-up Steps: Missing values are already excluded in data-prep 
 file. We can increase the number of years by laoding all data in github rep-
 -ository but maintaing same file struture.
*******************************************************************************;
*/



proc print noobs data=flights_analytic_file_temp_q1(obs=10);
    id UniqueCarrier;
    var WeatherDelay;
	title 'Top Ten Carrier Worst Affected by Weather Condition'; 
run;

 title;
 footnote;





title1
'Research Question: What is the average flight delay due to weather for each Origin Airport?'
;

title2
'Rationale: We want to know which origin airport are most impacted due to weather delay .'
;

footnote1
'Based on the above output, Rock Springs Airport, WY: Rock Springs Sweetwater County(RKS) has 
the longest delay on average which is 86 minutes.'
;

footnote2
'Oxnard/Ventura Aipport, CA: Oxnard has the second longest delay time which is 77 minutes.'
;

footnote3
'It would be interesting to look at the location data and their weather data and delay due 
to weather to question which airport is better but we do not have the access to those data.' 
;

/*
*******************************************************************************;
Methodology: Use PROC PRINT to print just the first ten observations from
 the temporary dataset created in the corresponding data-prep file.

Limitations: This dataset has limited to one year data.

Possible Follow-up Steps: Missing values of WetherDelay are already excluded in 
 data-prep file. We can increase the number of years by laoding all data in github 
 repository but maintaing same file struture.
*******************************************************************************;
*/





proc print noobs data=flights_analytic_file_temp_q2(obs=10);
    id Origin;
    var WeatherDelay;
	title 'Top Ten Airport Worst Affected by Weather Condition'; 
run;

 title;
 footnote;
 
 
 
 

title1
'Research Question: What is the percentage of the diverted flights  per carrier?'
;

title2
'Rationale: To identify the frequency of diverted flights per carrier'
;

footnote1 
'The table above shows the frequency and the precentage of diverted flights for each 
 carrier based on the total number of diverted flights'
;


/* 
*******************************************************************************;
Methodology: Using PROC FREQ command percentage of diverted flights will be shown
from sorted dataset
 
Limitations: This methodology does not account for missing data nor the number
of total flights per carrier .

Possible Follow-up Steps: checking the Cancelled variable for any missing data 
so that the means computed is more accurate.
*******************************************************************************;
*/


proc freq data = flights_analytic_file_sorted;
    tables Diverted*UniqueCarrier;
	format Diverted Diverted_Fmt.; 
	label UniqueCarrier=Unique Carrier Code of AIrlines 
          Diverted=Flight Dieverted Status;
	by UniqueCarrier;
RUN;


 title;
 footnote;
