
* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';

/*
...................................................................................................
Question 1:  What is the average weather delay of each carrier?
Rationale: To identify the top 10 carriers which are most impacted due to weather condition?
Methodology: Using KEEP and IF Command we have only selected required variables and removed all records which are not delayed using weather.
			We have created new temp data set to change the data type from character to numeric to do statistical analysis. Use PROC MEAN to compute the mean of weather delay and store the result in temporary dataset. Used PROC SORT to sort the temporary dataset.
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

/*
...................................................................................................
Question 2:  What is the average weather delay of each airport?
Rationale: To identify the top 10 airports which are most impacted due to weather condition?
Methodology: Using KEEP and IF Command we have only selected required variables and removed all records which are not delayed using weather.
			We have created new temp data set to change the data type from character to numeric to do statistical analysis. Use PROC MEAN to compute the mean of weather delay and store the result in temporary dataset. Used PROC SORT to sort the temporary dataset.
...................................................................................................
*/ 


DATA flights_analytics_weather;
    SET  flights_analytic_file;
    KEEP Origin WeatherDelay;
    IF WeatherDelay not in ('0','NA') ;
RUN;

data flights_analytics_weather_2;
	SET flights_analytics_weather;
	Origin = Origin;
	newWeatherDelay = input(WeatherDelay,best4.);
	drop WeatherDelay; 
    rename newWeatherDelay=WeatherDelay;
run;

proc means mean noprint data=flights_analytics_weather_2;
    class Origin;
    var WeatherDelay;
    output out=flights_analytic_file_temp;
run;
proc sort data=flights_analytic_file_temp(where=(_STAT_="MEAN"));
    by  descending WeatherDelay;
run;

proc print noobs data=flights_analytic_file_temp(obs=10);
    id Origin;
    var WeatherDelay;
	title 'Top Ten Airport Worst Affected by Weather Condition'; 
run;



/*
...................................................................................................
Question 3:  What is the percentage diverted flights of each carrier?
Rationale: To identify the carriers which flights are diverted most of the time?
Methodology: Using PROC SORT commands sort the data set. Using PROC FREQ command percentage of diverted flights will be shown. 
...................................................................................................
*/ 

PROC SORT Data=flights_analytic_file Out=flights_analytic_file_sorted;
 BY UniqueCarrier;
RUN; 

PROC FORMAT;
VALUE Diverted_Fmt
 Low-0=Not Diverted
 0-1=Diverted;
 RUN; 

PROC FREQ DATA = flights_analytic_file_sorted;
    TABLES Diverted*UniqueCarrier;
	FORMAT Diverted Diverted_Fmt.; 
	LABEL UniqueCarrier=Unique Carrier Code of AIrlines 
          Diverted=Flight Dieverted Status;
	BY UniqueCarrier;
RUN;
