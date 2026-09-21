# YouTube Example

# Decision variables
var xa1, >=0;
var xa2, >=0;
var xa3, >=0;
var xb1, >=0;
var xb2, >=0;
var xb3, >=0;

# Objective Function
minimize cost: 10*xa1 + 17*xa2 + 32*xa3 + 22*xb1 + 14*xb2 + 8*xb3;

# Constraints
s.t. s_1: xa1 + xa2 +xa3 <= 1500;
s_2: xb1 + xb2 + xb3 <= 1000;

d_1: xa1 + xb1 >= 1000;
d_2: xa2 + xb2 >= 250;
d_3: xa3 + xb3 >= 1250;

# Call solver
solve;

# Print the results
display cost, xa1, xa2, xa3, xb1, xb2, xb3;

end;

