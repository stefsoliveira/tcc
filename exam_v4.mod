#Parameters
set PATIENTS := 1..500; 
set HOSPITALS := 1..5;

param risk{PATIENTS}; #risk for the woman to have cancer
param patient_hospital{HOSPITALS, PATIENTS};
param capacity{HOSPITALS};

#Variables
var Y{PATIENTS} binary; # = 1 if the woman i is selected to do the test, 0 otherwise

#Objective function
maximize Risk: sum{i in PATIENTS} risk[i]* Y[i];

#constraints
#maximum no. of tests per month
subject to maximum_tests{j in HOSPITALS}: 
	sum {k in PATIENTS} patient_hospital[j,k]*Y[k] <= capacity[j];