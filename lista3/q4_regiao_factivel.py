from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

# Vértices da região factível do problema 4
vertices = np.array([
    [0.0, 0.0],
    [2.0, 0.0],
    [1.5, 0.5],
    [0.0, 1.5],
])

fig, ax = plt.subplots(figsize=(7, 6))

# Preenche a região factível
ax.fill(
    vertices[:, 0],
    vertices[:, 1],
    color="tab:blue",
    alpha=0.25,
    label="Região factível",
)

# Retas das restrições
# x1 + x2 = 2 -> x2 = 2 - x1
x1_r1 = np.linspace(0, 2, 100)
ax.plot(x1_r1, 2 - x1_r1, color="tab:red", linewidth=2, label=r"$x_1 + x_2 = 2$")

# 4x1 + 6x2 = 9 -> x2 = 1.5 - (2/3)x1
x1_r2 = np.linspace(0, 1.5, 100)
ax.plot(x1_r2, 1.5 - (2/3)*x1_r2, color="tab:green", linewidth=2, label=r"$4x_1 + 6x_2 = 9$")

# Destacando a aresta ótima (interseção das retas 2x1 + 3x2 = 4.5)
ax.plot([0, 1.5], [1.5, 0.5], color="tab:orange", linewidth=4, linestyle="--", label="Soluções ótimas")

ax.scatter(vertices[:, 0], vertices[:, 1], color="black", zorder=5)

labels = [
    r"$(0,0)$", 
    r"$(2,0)$", 
    r"$(1.5, 0.5)$", 
    r"$(0, 1.5)$"
]
offsets = [(-15, -15), (10, -15), (10, 5), (-40, 10)]

for (x, y), label, off in zip(vertices, labels, offsets):
    ax.annotate(
        label, (x, y), xytext=off, textcoords="offset points", fontsize=10,
    )

# Configurações do gráfico
ax.axhline(0, color="gray", linewidth=0.8)
ax.axvline(0, color="gray", linewidth=0.8)
ax.set_xlim(-0.2, 2.5)
ax.set_ylim(-0.2, 2.0)
ax.set_xlabel(r"\(x_1\)")
ax.set_ylabel(r"\(x_2\)")
ax.set_title("Questão 4: região factível e soluções ótimas")
ax.grid(True, linestyle=":", alpha=0.6)
ax.legend(loc="upper right")
ax.set_aspect("equal", adjustable="box")

out = Path(__file__).resolve().parent / "regiao_factivel_q4.png"
fig.tight_layout()
fig.savefig(out, dpi=200)
print(f"Figura salva em: {out}")