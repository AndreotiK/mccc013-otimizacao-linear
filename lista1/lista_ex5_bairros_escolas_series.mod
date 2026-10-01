# Definição dos conjuntos
set BAIRROS;
set ESCOLAS;
set SERIES;

# Definição dos parâmetros
param A{BAIRROS, SERIES} >= 0; # População de alunos do bairro i na série s
param C{ESCOLAS, SERIES} >= 0; # Capacidade da escola j para alunos da série s
param d{BAIRROS, ESCOLAS} >= 0; # Distância entre o bairro i e a escola j

# Variáveis de decisão
var x{i in BAIRROS, j in ESCOLAS, s in SERIES} >= 0; # Quantidade de alunos do bairro i, da série s, alocados na escola j.

# Função objetivo
# A função abaixo busca minimizar o valor da soma da distância total percorrida por todos os alunos, utilizando da lógica de atribuição da quantidade de alunos nos índices i, j, s multiplicada pela distância entre o bairro i e a escola j. 
minimize dist_total:
    sum{i in BAIRROS, j in ESCOLAS, s in SERIES} d[i,j] * x[i,j,s];

# Restrições
# Garante que todos os alunos do bairro i da série s sejam alocados, somando as alocações em todas as escolas j e igualando à população A[i,s].
s.t. demanda{i in BAIRROS, s in SERIES}:
    sum{j in ESCOLAS} x[i,j,s] = A[i,s];

# Garante que a soma dos alunos de todos os bairros i alocados na escola j para a série s não ultrapasse a capacidade C[j,s].
s.t. capacidade{j in ESCOLAS, s in SERIES}:
    sum{i in BAIRROS} x[i,j,s] <= C[j,s];

solve;
end;