*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset Name] Airlines Delay

[Experimental Units] Flight

[Number of Observations] 573,903   *(Changes: we picked 3 months of data flights
from Jan to March 2008)*

[Number of Features] 29 

[Data Source] http://stat-computing.org/dataexpo/2009/2008.csv.bz2

[Data Dictionary] https://www.kaggle.com/giovamata/airlinedelaycauses

[Unique ID Schema] Composite key, a combination of the columns: UniqueCarrier,
FlightNum, Year, Month and DayofMonth .
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

* build analytic dataset from flights dataset with the least number of columns
and minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;

data flights_analytic_file;
    retain
       Year
       Month
       DayofMonth
       UniqueCarrier
       ArrDelay
       DepDelay
       Origin
       Cancelled
       FlightNum
       Distance
       ArrTime
       CRSArrTime
       DepDelay
       Diverted
       WeatherDelay
       NASDelay
       SecurityDelay
       LateAircraftDelay
    ;
    keep
       Year
       Month
       DayofMonth
       UniqueCarrier
       ArrDelay
       DepDelay
       Origin
       Cancelled
       FlightNum
       Distance
       ArrTime
       CRSArrTime
       DepDelay
       Diverted
       WeatherDelay
       NASDelay
       SecurityDelay
       LateAircraftDelay
    ;
    set flights_raw;
run;


*
Use Where to create a subset data that meets our criteria "arrived
within 15 minutes of the scheduled arrival time".
;

data Delay15;
    set flights_analytic_file;
    where ArrDelay<15;
run;

*
Use PROC MEANS to compute the mean of DepDelay for each Origin 
"Departure Airports", and output the results to a temportatry dataset "temp".
Use PROC SORT extract and sort just the means the temporary dateset
;

proc means data=flights_analytic_file;
    class Origin;
    var DepDelay;
    output out=temp;
run;

proc sort data=temp (where=(_STAT_="MEAN"));
    by descending DepDelay;
run;


