#Sets
set patient:= 1..45; #no. of patients to be allocated 
set days:= 1..5;  #planning horizon 
set shift := 1..2; #no. of shift in a day - morning and afternoon
set S := 1..2; #shift with no patients allocated
set D := 1..5; #day corresponding to have no patients allocated
set N:= 1..5; 

#Parameters
param availability{i in patient, j in days};
param costpershift{i in patient, j in days, s in shift};
param emptycost{n in N, l in D, m in S};
var emptyshift{n in N, l in D, m in S} integer;


#Decision variable
var patientassignment{i in patient,j in days,s in shift} binary; 
# = 1 if patient i is available on jth day working on sth shift, 0 otherwise


#Objective function
minimize Cost: 
sum{i in patient, j in days, s in shift} costpershift[i,j,s]*patientassignment[i,j,s]
+ sum{ n in N, l in D, m in S}emptycost[n,l,m]*emptyshift[n,l,m];


#constraints

#maximum no. of shifts per day
subject to maximum_shifts_perday {i in patient,j in days}:
 sum{s in shift} patientassignment[i,j,s]*availability[i,j] <= 1;

#patients per shift
subject to schedule{j in days, s in shift, l in D, m in S}: 
sum{i in patient} availability[i,j]*patientassignment[i,j,s] + sum{n in N} emptyshift[n,l,m]=4;




