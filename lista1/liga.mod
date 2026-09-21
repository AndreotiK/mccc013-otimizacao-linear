# ============================================================
# Questão 1 - Lista 1
# Produção de uma liga com 30% de metal A e 70% de metal B
# ============================================================

# ---------- Conjunto ----------
set LIGAS;   # Conjunto das ligas disponíveis no mercado

# ---------- Parâmetros ----------
param A {i in LIGAS};      # Porcentagem de metal A na liga i
param B {i in LIGAS};      # Porcentagem de metal B na liga i
param preco {i in LIGAS};  # Preço por tonelada da liga i

# ---------- Variáveis de decisão ----------
var x {i in LIGAS} >= 0;

# ---------- Função objetivo ----------
minimize custo: sum {i in LIGAS} preco[i] * x[i];

# ---------- Restrições ----------
s.t. massa: sum {i in LIGAS} x[i] = 1;
s.t. metalA: sum {i in LIGAS} (A[i]/100) * x[i] = 0.30;
s.t. metalB: sum {i in LIGAS} (B[i]/100) * x[i] = 0.70;

# ---------- Resolver ----------
solve;

# ---------- Impressão personalizada ----------
printf "\n===== SOLUÇÃO ÓTIMA =====\n";
printf "Liga   Quantidade (ton)   Proporção (%%)\n";
printf "----------------------------------------\n";
for {i in LIGAS} {
    printf "%-6s %10.4f %15.2f%%\n", i, x[i], x[i]*100;
}
printf "----------------------------------------\n";
printf "Custo total: $%.4f\n", custo;

# ---------- Seção de dados ----------
data;

set LIGAS := L1 L2 L3 L4 L5;

param A := 
  L1 10
  L2 25
  L3 50
  L4 75
  L5 95;

param B := 
  L1 90
  L2 75
  L3 50
  L4 25
  L5 5;

param preco := 
  L1 5
  L2 4
  L3 3
  L4 2
  L5 1.5;

end;