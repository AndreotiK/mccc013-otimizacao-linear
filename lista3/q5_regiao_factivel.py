from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(7, 6))

# Criando uma malha para preencher a região factível ilimitada
x1 = np.linspace(-5, 12, 400)
x2 = np.linspace(-2, 6, 400)
X1, X2 = np.meshgrid(x1, x2)

# Restrições
# 1. -x1 + 2x2 <= 6  =>  x1 >= 2x2 - 6
# 2. x2 <= 4
regiao = (-X1 + 2*X2 <= 6) & (X2 <= 4)

ax.contourf(X1, X2, regiao, levels=[0.5, 1.5], colors=['tab:blue'], alpha=0.25)

# Retas de restrição
# Reta 1: -x1 + 2x2 = 6 => x1 = 2x2 - 6
x2_reta = np.linspace(-3, 5, 100)
x1_reta = 2 * x2_reta - 6
ax.plot(x1_reta, x2_reta, color="tab:red", linewidth=2, label=r"$-x_1 + 2x_2 = 6$")

# Reta 2: x2 = 4
ax.axhline(4, color="tab:green", linewidth=2, label=r"$x_2 = 4$")

# Seta indicando a direção ilimitada (crescimento de x1)
ax.annotate('', xy=(11.5, 0), xytext=(5, 0),
            arrowprops=dict(facecolor='black', shrink=0, width=2, headwidth=10))
ax.text(6, 0.3, "Direção ilimitada\n(para \(x_1 \\to +\\infty\))", fontsize=10)

# Configurações do gráfico
ax.axhline(0, color="gray", linewidth=0.8)
ax.axvline(0, color="gray", linewidth=0.8)
ax.set_xlim(-5, 12)
ax.set_ylim(-2, 6)
ax.set_xlabel(r"\(x_1\)")
ax.set_ylabel(r"\(x_2\)")
ax.set_title("Questão 5: região factível ilimitada")
ax.grid(True, linestyle=":", alpha=0.6)
ax.legend(loc="upper right")

out = Path(__file__).resolve().parent / "regiao_factivel_q5.png"
fig.tight_layout()
fig.savefig(out, dpi=200)
print(f"Figura salva em: {out}")