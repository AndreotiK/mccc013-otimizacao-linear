
# ============================================================
# Lista 1 - Questao 7
# Problema de transporte entre fontes, fabricas e mercados
# Objetivo: minimizar o custo total de transporte
# ============================================================

# ------------------------------------------------------------
# 1. Variaveis de decisao
# ------------------------------------------------------------
# x[i,j,k] representa a quantidade transportada, em toneladas,
# da fonte i para a fabrica j e, posteriormente, para o mercado k.
#
# Indices:
# i = 1, 2    -> fontes de materia-prima
# j = 1, 2    -> fabricas A e B
# k = 1, 2, 3 -> mercados 1, 2 e 3
#
# Restricao de nao negatividade:
# nao e possivel transportar uma quantidade negativa.
# ------------------------------------------------------------

var x{1..2, 1..2, 1..3} >= 0;


# ------------------------------------------------------------
# 2. Funcao objetivo
# ------------------------------------------------------------
# O objetivo e minimizar o custo total de transporte.
#
# O custo de cada rota completa e a soma de dois trechos:
# fonte -> fabrica + fabrica -> mercado.
#
# Exemplo:
# x[1,1,1] = fonte 1 -> fabrica A -> mercado 1
# Custo = 1 + 4 = 5 por tonelada.
#
# Cada coeficiente representa o custo por tonelada
# da respectiva rota completa.
# ------------------------------------------------------------

minimize Custo_Total:
    5*x[1,1,1] + 3*x[1,1,2] + 2*x[1,1,3]
  + 4.5*x[1,2,1] + 5.5*x[1,2,2] + 3.5*x[1,2,3]
  + 6*x[2,1,1] + 4*x[2,1,2] + 3*x[2,1,3]
  + 4.5*x[2,2,1] + 5.5*x[2,2,2] + 3.5*x[2,2,3];


# ------------------------------------------------------------
# 3. Restricoes de oferta das fontes
# ------------------------------------------------------------
# Fonte 1:
# A soma de todas as quantidades que saem da fonte 1,
# considerando as duas fabricas e os tres mercados,
# nao pode ultrapassar 10 toneladas.
# ------------------------------------------------------------

s.t. Oferta_Fonte_1:
    sum{j in 1..2, k in 1..3} x[1,j,k] <= 10;


# Fonte 2:
# A soma de todas as quantidades que saem da fonte 2
# nao pode ultrapassar 15 toneladas.
# ------------------------------------------------------------

s.t. Oferta_Fonte_2:
    sum{j in 1..2, k in 1..3} x[2,j,k] <= 15;


# ------------------------------------------------------------
# 4. Restricoes de demanda dos mercados
# ------------------------------------------------------------
# Mercado 1:
# Deve receber exatamente 8 toneladas.
# Somamos as quantidades provenientes de todas as fontes
# e que passam por todas as fabricas.
# ------------------------------------------------------------

s.t. Demanda_Mercado_1:
    sum{i in 1..2, j in 1..2} x[i,j,1] = 8;


# Mercado 2:
# Deve receber exatamente 14 toneladas.
# ------------------------------------------------------------

s.t. Demanda_Mercado_2:
    sum{i in 1..2, j in 1..2} x[i,j,2] = 14;


# Mercado 3:
# Deve receber exatamente 3 toneladas.
# ------------------------------------------------------------

s.t. Demanda_Mercado_3:
    sum{i in 1..2, j in 1..2} x[i,j,3] = 3;


# ------------------------------------------------------------
# 5. Resolucao do problema
# ------------------------------------------------------------
# Solicita ao solver que encontre a solucao otima.
# ------------------------------------------------------------

solve;


# ------------------------------------------------------------
# 6. Exibicao dos resultados
# ------------------------------------------------------------
# Custo_Total: custo minimo encontrado.
# x: quantidade transportada em cada uma das 12 rotas.
# ------------------------------------------------------------

display Custo_Total, x;


# Finaliza o modelo
end;
