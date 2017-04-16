*
[Dataset Name] Airlines Delay

[Experimental Units] Flight

[Number of Observations] 573,903   *(Changes: we picked 3 months of data flights from Jan to March 2008)*

[Number of Features] 29 

[Data Source] http://stat-computing.org/dataexpo/2009/2008.csv.bz2

[Data Dictionary] https://www.kaggle.com/giovamata/airlinedelaycauses

[Unique ID Schema] Composite key, a combination of the columns: UniqueCarrier, FlightNum, Year, Month and DayofMonth .
;



* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-2_project1/blob/master/DelayedFlight.csv?raw=true;


* load raw Flights dataset over the wire;
filename tempfile TEMP;
proc http
    method="get"
    url="&inputDatasetURL."
    out=tempfile
    ;
run;
proc import
    file=tempfile
    out=flights_raw
    dbms=csv;
run;
filename tempfile clear;


* check raw flights dataset for duplicates with respect to its composite key;
proc sort nodupkey data=flights_raw dupout=flights_raw_dups out=_null_;
    by Month DayofMonth FlightNum;
run;


* build analytic dataset from flights dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data flights_analytic_file_AA;
    retain
        Month
        DayofMonth
        UniqueCarrier
        ArrDelay
        DepDelay
        Origin
        Cancelled
    ;
    keep
        Month
        DayofMonth
        UniqueCarrier
        ArrDelay
        DepDelay
        Origin
        Cancelled
    ;
    set flights_raw;
run;

*This dataset is for calculating delay for each unique carriers across time to see which carrier have the lowest delay time;

data flights_analytic_file_KV;
    retain
        Year
        Month
        DayofMonth
        FlightNum
        UniqueCarrier
        Distance
        ArrTime
        CRSArrTime
    ;
    keep
       Year
       Month
       DayofMonth
       FlightNum
       UniqueCarrier
       Distance
       ArrTime
       CRSArrTime
    ;
    set flights_raw;
run;


data flights_analytic_file_AK;
    retain
        Year
        Month
        DayofMonth
        FlightNum
        UniqueCarrier
        Distance
        ArrTime
        CRSArrTime
        ArrDelay
		DepDelay
		Cancelled
		Diverted
		CarrierDelay
		WeatherDelay
		NASDelay
		SecurityDelay
		LateAircraftDelay
    ;
    keep
       Year
       Month
       DayofMonth
       FlightNum
       UniqueCarrier
       Distance
       ArrTime
       CRSArrTime
       ArrDelay
	   DepDelay
	   Cancelled
	   Diverted
	   CarrierDelay
	   WeatherDelay
	   NASDelay
	   SecurityDelay
	   LateAircraftDelay
    ;
    set flights_raw;
run;
