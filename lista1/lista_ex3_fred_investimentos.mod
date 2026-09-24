/* Problema 3 - Investimento de Fred
   Modelo GUSEK/MathProg
*/

set ANOS := 1..5;
set ANOS_Z := 2..5;

var x{t in ANOS} >= 0;   # depósito de 1 ano no início do ano t
var y{t in ANOS} >= 0;   # depósito de 2 anos no início do ano t
var z{t in ANOS_Z} >= 0; # certificado de 3 anos no início do ano t

param inicial := 2200;
param taxa1 := 0.08;
param taxa2 := 0.17;
param taxa3 := 0.27;

maximize final: (1+taxa1)*x[5] + (1+taxa2)*y[4] + (1+taxa3)*z[3];

s.t. fluxo1: x[1] + y[1] = inicial;
s.t. fluxo2: x[2] + y[2] + z[2] = (1+taxa1)*x[1];
s.t. fluxo3: x[3] + y[3] + z[3] = (1+taxa1)*x[2] + (1+taxa2)*y[1];
s.t. fluxo4: x[4] + y[4] + z[4] = (1+taxa1)*x[3] + (1+taxa2)*y[2];
s.t. fluxo5: x[5] + y[5] + z[5] = (1+taxa1)*x[4] + (1+taxa2)*y[3] + (1+taxa3)*z[2];

solve;

printf "\n===== SOLUÇÃO ÓTIMA =====\n";
printf "Ano   Depósito 1 ano   Depósito 2 anos   Certificado 3 anos\n";
printf "------------------------------------------------------------\n";

# Ano 1 (sem certificado)
printf "%2d %15.2f %15.2f %15s\n", 1, x[1], y[1], "-";

# Anos 2 a 5 (com certificado)
for {t in ANOS_Z} {
    printf "%2d %15.2f %15.2f %15.2f\n", t, x[t], y[t], z[t];
}

printf "------------------------------------------------------------\n";
printf "Valor final no início do 6º ano: $%.2f\n", final;

end;