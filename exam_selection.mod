# Sets
set patients := 1..100;
set hospitals := 1..5;


# Parameters
param r{i in patients}; 						#risk of each patient
param capacity{j in hospitals}; 				#capacity of each hospital
param base >= 1;
param preferable_hospital {patients, hospitals} >= 0; #hospitals preferred by the patient 

# Variables
var x{i in patients, j in hospitals} binary; # indica se o paciente i é alocado no hospital j.

# Objective function
maximize Risk: 
	sum{i in patients, j in hospitals} base^preferable_hospital[i,j] * x[i,j] * r[i];

# Constraints
# a patient can be tested in only one hospital
subject to one_exam_per_patient{i in patients}:
    sum{j in hospitals} x[i,j] <= 1;

# maximum no. of tests per hospital
subject to capacity_hospitals{j in hospitals}:
    sum{i in patients} x[i,j] <= capacity[j];
    
# consider the preferable hospital of the patient
#subject to select_hospitals {i in patients}:
	#sum{j in hospitals} x[i,j] * preferable_hospital[i,j] <= 1;
