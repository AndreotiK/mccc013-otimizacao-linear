# =========================================================
# Problema 2 - Refinaria de Petróleo
# Modelo parametrizado (set + param + data)
# =========================================================

# Sets
set P;   # Conjunto de processos produtivos

# Parameters
param usoA{j in P};      # barris de crú A usados por execução
param usoB{j in P};      # barris de crú B usados por execução
param prodG{j in P};     # barris de gasolina produzidos por execução
param prodO{j in P};     # barris de óleo de aquecimento produzidos
param custo{j in P};     # custo por execução

param dispA;             # disponibilidade de crú A
param dispB;             # disponibilidade de crú B
param precoG;            # preço de venda da gasolina
param precoO;            # preço de venda do óleo de aquecimento

# Decision variables
var x{j in P} >= 0;      # número de execuções de cada processo

# Lucro unitário por processo (calculado a partir dos parâmetros)
param lucro{j in P} := precoG*prodG[j] + precoO*prodO[j] - custo[j];

# Objective Function
maximize LucroTotal:
    sum{j in P} lucro[j] * x[j];

# Constraints
s.t. RestricaoA:
    sum{j in P} usoA[j] * x[j] <= dispA;

s.t. RestricaoB:
    sum{j in P} usoB[j] * x[j] <= dispB;

# Call solver
solve;

# ---------- Impressão personalizada ----------
printf "\n===== SOLUÇÃO ÓTIMA =====\n";
printf "Processo   Execuções (milhões)   Lucro unitário (milhões $)\n";
printf "-----------------------------------------------------------\n";
for {j in P} {
    printf "%-8s %18.4f %25.2f\n", j, x[j], lucro[j];
}
printf "-----------------------------------------------------------\n";
printf "Lucro total: $%.4f milhões\n", LucroTotal;

# =========================================================
# Dados
# =========================================================
data;

set P := P1 P2 P3;

param usoA :=
P1   3
P2   1
P3   5;

param usoB :=
P1   5
P2   1
P3   3;

param prodG :=
P1   4
P2   1
P3   3;

param prodO :=
P1   3
P2   1
P3   4;

param custo :=
P1   51
P2   11
P3   40;

param dispA := 8;
param dispB := 5;
param precoG := 38;
param precoO := 33;

end;