# Sets
set S; # Set of suppliers
set C; # Set of customers

# Parameters
param p{i in S, j in C};
param cap{i in S};
param d{j in C};

# Decision variables
var x{i in S, j in C}, >= 0;

# Objective Function
minimize cost: sum{i in S, j in C} p[i,j]*x[i,j];

# Constraints
s.t. supply{i in S}: sum{j in C} x[i,j] <= cap[i];
demand{j in C}: sum{i in S} x[i,j] >= d[j];

# Call solver
solve;

# Print results
display cost, x;

# Add database
data;

set S:= a,b;
set C:= 1,2,3;

param p:=
a	1	10
a	2	17
a	3	32
b	1	22
b	2	14
b	3	8;

param cap:=
a	1500
b	1000;

param d:=
1	1000
2	250
3	1250;

end;

