# pip install numpy matplotlib
import numpy as np
import matplotlib.pyplot as plt

fig, axes = plt.subplots(1, 2, figsize=(12, 5))

# ============================================================
# (1) CONE CONVEXO: gerado por dois vetores independentes
#     C = { lam1*a1 + lam2*a2 : lam1, lam2 >= 0 }
# ============================================================
ax = axes[0]

a1 = np.array([1.0, 0.5])
a2 = np.array([0.5, 1.0])
L  = 3.0   # comprimento de truncagem (o cone real é ilimitado)

# Polígono truncado [0, L*a1, L*a1 + L*a2, L*a2]
poly = np.array([[0, 0], L*a1, L*a1 + L*a2, L*a2])
ax.fill(poly[:, 0], poly[:, 1], alpha=0.25, color='tab:blue',
        label='C (cone convexo, truncado)')

# Raios de fronteira
ax.plot([0, L*a1[0]], [0, L*a1[1]], 'r--', lw=1)
ax.plot([0, L*a2[0]], [0, L*a2[1]], 'r--', lw=1)

# Vetores geradores
ax.quiver(0, 0, *a1, angles='xy', scale_units='xy', scale=1,
          color='crimson', width=0.008)
ax.quiver(0, 0, *a2, angles='xy', scale_units='xy', scale=1,
          color='crimson', width=0.008)
ax.text(*(1.10*a1), r'$a_1$', color='crimson', fontsize=13)
ax.text(*(1.10*a2), r'$a_2$', color='crimson', fontsize=13)

# Teste do ponto médio: p, q in C  =>  (p+q)/2 in C
p   = 1.5*a1
q   = 1.5*a2
mid = 0.5*(p + q)
ax.plot(*p, 'ko'); ax.plot(*q, 'ko'); ax.plot(*mid, 'go', ms=8)
ax.plot([p[0], q[0]], [p[1], q[1]], 'g-', lw=1)
ax.annotate('p', p, textcoords='offset points', xytext=(5,  5))
ax.annotate('q', q, textcoords='offset points', xytext=(5,  5))
ax.annotate(r'$(p+q)/2 \in C$', mid,
            textcoords='offset points', xytext=(5, -18), color='green')

ax.set_xlim(-1, 5); ax.set_ylim(-1, 5)
ax.set_aspect('equal'); ax.grid(True, alpha=0.3)
ax.axhline(0, color='k', lw=0.5); ax.axvline(0, color='k', lw=0.5)
ax.set_title('Cone CONVEXO\n(gerado por $a_1,a_2$ independentes)')
ax.legend(loc='upper left', fontsize=8)

# ============================================================
# (2) CONE NÃO CONVEXO: união dos semi-eixos positivos
#     C = {(t,0):t>=0}  U  {(0,t):t>=0}
# ============================================================
ax = axes[1]

L = 4
t = np.linspace(0, L, 200)
ax.plot(t, np.zeros_like(t), 'r-', lw=2)
ax.plot(np.zeros_like(t), t, 'r-', lw=2)
ax.scatter(t, np.zeros_like(t), s=10, color='tab:orange', alpha=0.7)
ax.scatter(np.zeros_like(t), t, s=10, color='tab:orange', alpha=0.7,
           label='C = semi-eixo x⁺ ∪ semi-eixo y⁺')

# Teste do ponto médio: p, q in C  mas  (p+q)/2 NÃO in C
p   = np.array([0.7*L, 0.0])
q   = np.array([0.0,   0.7*L])
mid = 0.5*(p + q)
ax.plot(*p, 'ko'); ax.plot(*q, 'ko'); ax.plot(*mid, 'go', ms=8)
ax.plot([p[0], q[0]], [p[1], q[1]], 'g-', lw=1)
ax.annotate('p', p, textcoords='offset points', xytext=(5,  5))
ax.annotate('q', q, textcoords='offset points', xytext=(5,  5))
ax.annotate(r'$(p+q)/2 \notin C$', mid,
            textcoords='offset points', xytext=(5, -18), color='green')

ax.set_xlim(-1, 5); ax.set_ylim(-1, 5)
ax.set_aspect('equal'); ax.grid(True, alpha=0.3)
ax.axhline(0, color='k', lw=0.5); ax.axvline(0, color='k', lw=0.5)
ax.set_title('Cone NÃO CONVEXO\n(união de dois semi-eixos)')
ax.legend(loc='upper right', fontsize=8)

plt.tight_layout()
plt.show()