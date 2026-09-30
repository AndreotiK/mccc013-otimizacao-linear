/* Problema 4 - Ração animal (variáveis explícitas) */
/* Unidades: toneladas para quantidades, preços por kg, teores por kg.
   Como x está em toneladas, a contribuição nutricional é teor * x,
   e o limite mínimo/máximo (por kg) é multiplicado pelo total da ração. */

var xMG >= 0;  # Milho para Gado
var xCG >= 0;  # Cal para Gado
var xSG >= 0;  # Soja para Gado
var xFG >= 0;  # Farinha de Peixe para Gado

var xMO >= 0;  # Milho para Ovelha
var xCO >= 0;  # Cal para Ovelha
var xSO >= 0;  # Soja para Ovelha
var xFO >= 0;  # Farinha de Peixe para Ovelha

var xMGa >= 0; # Milho para Galinha
var xCGa >= 0; # Cal para Galinha
var xSGa >= 0; # Soja para Galinha
var xFGa >= 0; # Farinha de Peixe para Galinha

minimize custo:
    0.20 * (xMG + xMO + xMGa) +
    0.12 * (xCG + xCO + xCGa) +
    0.24 * (xSG + xSO + xSGa) +
    0.12 * (xFG + xFO + xFGa);

# Disponibilidade dos ingredientes (toneladas)
s.t. disp_milho:   xMG + xMO + xMGa <= 6;
s.t. disp_cal:     xCG + xCO + xCGa <= 10;
s.t. disp_soja:    xSG + xSO + xSGa <= 4;
s.t. disp_farinha: xFG + xFO + xFGa <= 5;

# Produção total de cada ração (toneladas)
s.t. prod_gado:    xMG + xCG + xSG + xFG = 10;
s.t. prod_ovelha:  xMO + xCO + xSO + xFO = 6;
s.t. prod_galinha: xMGa + xCGa + xSGa + xFGa = 8;

# Restrições nutricionais - GADO (total 10 t)
s.t. vit_gado_min:  8*xMG + 6*xCG + 10*xSG + 4*xFG >= 60;
s.t. prot_gado_min: 10*xMG + 10*xCG + 12*xSG + 8*xFG >= 60;
s.t. calc_gado_min: 6*xMG + 10*xCG + 6*xSG + 9*xFG >= 70;
s.t. gord_gado_min: 8*xMG + 6*xCG + 6*xSG + 9*xFG >= 40;
s.t. gord_gado_max: 8*xMG + 6*xCG + 6*xSG + 9*xFG <= 80;

# Restrições nutricionais - OVELHA (total 6 t)
s.t. vit_ovelha_min:  8*xMO + 6*xCO + 10*xSO + 4*xFO >= 36;
s.t. prot_ovelha_min: 10*xMO + 10*xCO + 12*xSO + 8*xFO >= 36;
s.t. calc_ovelha_min: 6*xMO + 10*xCO + 6*xSO + 9*xFO >= 36;
s.t. gord_ovelha_min: 8*xMO + 6*xCO + 6*xSO + 9*xFO >= 24;
s.t. gord_ovelha_max: 8*xMO + 6*xCO + 6*xSO + 9*xFO <= 36;

# Restrições nutricionais - GALINHA (total 8 t)
s.t. vit_galinha_min:  8*xMGa + 6*xCGa + 10*xSGa + 4*xFGa >= 32;
s.t. vit_galinha_max:  8*xMGa + 6*xCGa + 10*xSGa + 4*xFGa <= 48;
s.t. prot_galinha_min: 10*xMGa + 10*xCGa + 12*xSGa + 8*xFGa >= 48;
s.t. calc_galinha_min: 6*xMGa + 10*xCGa + 6*xSGa + 9*xFGa >= 48;
s.t. gord_galinha_min: 8*xMGa + 6*xCGa + 6*xSGa + 9*xFGa >= 32;
s.t. gord_galinha_max: 8*xMGa + 6*xCGa + 6*xSGa + 9*xFGa <= 64;

solve;

# Custos e valor de cada ingrediente
printf "\nCusto total: R$%5.2f\n\n", custo*1000;

printf "INGREDIENTES (EM TONELADAS):\n\n";
printf "INGREDIENTES PARA GADO:\n";
printf "Milho:               %.1fkg\n", xMG;
printf "Cal:                 %.1fkg\n", xCG; 
printf "Soja:                %.1fkg\n", xSG; 
printf "Farinha de peixe:    %.1fkg\n\n", xFG;

printf "INGREDIENTES PARA OVELHA:\n";
printf "Milho:               %.1fkg\n", xMO;
printf "Cal:                 %.1fkg\n", xCO; 
printf "Soja:                %.1fkg\n", xSO; 
printf "Farinha de peixe:    %.1fkg\n\n", xFO;

printf "INGREDIENTES PARA GADO:\n";
printf "Milho:               %.1fkg\n", xMGa;
printf "Cal:                 %.1fkg\n", xCGa; 
printf "Soja:                %.1fkg\n", xSGa; 
printf "Farinha de peixe:    %.1fkg\n\n", xFGa;


data;
end;