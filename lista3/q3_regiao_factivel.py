from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

# Vértices da região factível do problema 3
vertices = np.array([
    [0.0, 0.0],
    [1.0, 0.0],
    [6.0 / 5.0, 3.0 / 5.0],
])

fig, ax = plt.subplots(figsize=(7, 5))

# Preenche a região factível
ax.fill(
    vertices[:, 0],
    vertices[:, 1],
    color="tab:blue",
    alpha=0.25,
    label="Região factível",
)

# Retas das restrições ativas
x_upper = np.linspace(0.0, 6.0 / 5.0, 200)
x_lower = np.linspace(1.0, 6.0 / 5.0, 100)

ax.plot(
    x_upper,
    x_upper / 2.0,
    color="tab:red",
    linewidth=2,
    label=r"$x_2=x_1/2$  ($x_3=0$)",
)

ax.plot(
    x_lower,
    3.0 * x_lower - 3.0,
    color="tab:green",
    linewidth=2,
    label=r"$x_2=3x_1-3$  ($x_4=0$)",
)

ax.plot([0.0, 1.0], [0.0, 0.0], color="black", linewidth=1.5, label=r"$x_2=0$")

ax.scatter(vertices[:, 0], vertices[:, 1], color="black", zorder=5)

labels = [r"$(0,0)$", r"$(1,0)$", r"$(6/5,3/5)$"]
offsets = [(-12, -12), (8, -12), (-40, 8)]

for (x, y), label, off in zip(vertices, labels, offsets):
    ax.annotate(
        label,
        (x, y),
        xytext=off,
        textcoords="offset points",
        fontsize=10,
    )

ax.axhline(0, color="gray", linewidth=0.8)
ax.axvline(0, color="gray", linewidth=0.8)

ax.set_xlim(-0.15, 1.45)
ax.set_ylim(-0.15, 0.85)
ax.set_xlabel(r"$x_1$")
ax.set_ylabel(r"$x_2$")
ax.set_title("Questão 3: região factível")
ax.grid(True, linestyle=":", alpha=0.6)
ax.legend(loc="upper right")
ax.set_aspect("equal", adjustable="box")

out = Path(__file__).resolve().parent / "regiao_factivel_q3.png"
fig.tight_layout()
fig.savefig(out, dpi=200)
print(f"Figura salva em: {out}")