* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-02_s17-team-02_project1_data_preparation.sas';

*Print average delay for each carrier;
proc means mean noprint data=flights_analytic_file_KV;
    class UniqueCarrier;
    var ArrDelay;
    output out=flights_analytic_file_KV_temp;
run;

proc sort data=flights_analytic_file_KV_temp(where=(_STAT_="MEAN"));
    by descending ArrDelay;
run;

proc print noobs data=flights_analytic_file_KV_temp(obs=20);
    id UniqueCarrier;
    var ArrDelay;
run;
