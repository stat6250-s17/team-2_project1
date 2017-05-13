*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*
This file uses the following analytic dataset to address several research
questions regarding delayed flight for a bunch of carriers.

Dataset Name: DelayedFlight created in external file
STAT6250-02_s17-team-2_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';


title1
'Research Question: What is the average flight delay time for each carrier?'
;

title2
'Rationale: We want to know which carriers are better and have the lowest flight delay time.'
;

footnote1
'Based on the above output, Messa Airline Inc. (YV) has the longest flight delay time on average which is 55.29 minutes.'
;

footnote2
'Frontier Airlines has the lowest flight delay time which is 27.92 minutes.'
;

footnote3
'It would be interesting to look at the flight ticket cost to help with the question which airline is better but we do not have the access to those data.' 
;


*
Methodology: Use PROC MEANS to compute the mean of ArrDelay (arrive delay time), 
and output the results to a temporary dataset. Use PROC SORT extract and sort 
just the means of the temporary dataset and we want to sort by UniqueCarrier.

Limitations: This methodology does not account for missing values for arrive 
delay time and as well as missing labels for carrier names. 

Possible Follow-up Steps: We can clean the data and convert missing values to
"." so that SAS knows it's a missing value and exclude it from the calculation
of Mean. 
;

proc means mean noprint data=flights_analytic_file;
    class UniqueCarrier;
    var ArrDelay;
    output out=flights_analytic_file_temp;
run;

proc sort data=flights_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending ArrDelay;
run;

proc print noobs data=flights_analytic_file_temp(obs=20);
    id UniqueCarrier;
    var ArrDelay;
run;
title;
footnote;


title1
'Research Question: What is the average flight delay time correspoding to the month of the year?'
'Research Question: Number of flight for each carrier?'
;
  
title2
'Rational: We want to know which months tend to have higher delay time so we can avoid traveling during those months.'
;
'Rationale: For investors who want to invest in airline stock, they might want to know which carrier has the most number of flights and which carrier has the lowest number of flights'
  
footnote1
'October seems to be the month that has the lowest flight delay time which is about 31.39 minutes on average.'
'Southwest Airlines Co. (WN)  seems to have the highest number of flight with 114664 flights in three months compared to other carriers.'
;
  

footnote2
'December has the highest flight delay time which is about 49.48 minutes on average.'
'Aloha Airlines Inc. (AQ) seems to have the lowest number of flight with only 750 flights in three months compared to other carriers.'
;
  
footnote3
'So the best month to travel with the lowest flight delay time is October. It would be interesting to look a bit deeper at the months across all the carriers.'
'This might not be a good comparison by just looking at the lowest and highest number of flight. We also need to take into the account of how many aircrafs they have and the size of the aircraft and we do not access to those data.'
 ;
  
*
Methodology: Use PROC MEANS to compute mean of ArrDelay, and output the 
results to a temporary dataset. use PROC SORT extract and sort by the month 
from the temporary dataset.
 
Limitations: This methodology does not account for missing values for arrive 
delay time and as well as missing labels for months. 
 
Possible Follow-up Steps: We can clean the data and convert missing values cell
to "." so that SAS knows it's a missing value and exclude it from the 
calculation of Mean. 
;
 
proc means mean noprint data=flights_analytic_file;
    class Month;
    var ArrDelay;
    output out=flights_analytic_file_temp;
run;
 
proc sort data=flights_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending ArrDelay;
run;
 
proc print noobs data=flights_analytic_file_temp(obs=20);
    id Month;
    var ArrDelay;
run;
title;
footnote;
 

title1
'Research Question: Number of flight for each carrier?'
;

title2
'Rationale: For investors who want to invest in airline stock, they might want to know which carrier has the most number of flights and which carrier has the lowest number of flights'

footnote1
'Southwest Airlines Co. (WN)  seems to have the highest number of flight with 114664 flights in three months compared to other carriers.'
;

footnote2
'Aloha Airlines Inc. (AQ) seems to have the lowest number of flight with only 750 flights in three months compared to other carriers.'
;

footnote3
'This might not be a good comparison by just looking at the lowest and highest number of flight. We also need to take into the account of how many aircrafs they have and the size of the aircraft and we do not access to those data.'
;


*
Methodology: Use PROC FREQ to count all the number of flight across all carriers.

Limitations: This methodology does not account for missing values for some carriers.

Possible Follow-up Steps: We can clean the data and convert missing values cell
to "." so that SAS knows it's a missing value and exclude it from the 
calculation of Mean. We can also collect data regarding number of aircraft and
aircraft size to add more dept into this reserach question. 
;

proc freq data = flights_analytic_file order=freq;
	table UniqueCarrier;
run;
title;
footnote;
