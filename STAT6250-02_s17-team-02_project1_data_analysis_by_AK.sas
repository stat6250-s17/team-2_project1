*
This file uses the following analytic dataset to address several research
questions regarding flight delay in US airports
Dataset Name: DelayedFlight.csv created in external file
STAT6250-02_s17-team-02_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';

/*
...................................................................................................
Question 1:  what is the number of delayed departure flights arrived within 15 minutes of the scheduled arrival time? 
Rationale: To identify the number of flight that made an acceptable delay(arrived within 15 min. of the scheduled time)
...................................................................................................
*/ 


DATA flights_analytics_q1;
    SET  flights_analytic_file;
    KEEP UniqueCarrier WeatherDelay;
    IF WeatherDelay not in ('0','NA') ;
RUN;

data flights_analytics_q1_temp;
	SET flights_analytics_q1;
	UniqueCarrier = UniqueCarrier;
	newWeatherDelay = input(WeatherDelay,best4.);
	drop WeatherDelay; 
    rename newWeatherDelay=WeatherDelay;
run;

proc means mean noprint data=flights_analytics_q1_temp;
    class UniqueCarrier;
    var WeatherDelay;
    output out=flights_analytic_file_temp;
run;

proc sort data=flights_analytic_file_temp(where=(_STAT_="MEAN"));
    by descending WeatherDelay;
run;

proc print noobs data=flights_analytic_file_temp(obs=10);
    id UniqueCarrier;
    var WeatherDelay;
	title 'Top Ten Carrier Worst Affected by Weather Condition'; 
run;




