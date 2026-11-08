import numpy as np
from itertools import combinations
from scipy.spatial import ConvexHull
import plotly.graph_objects as go

# ------------------------------------------------------------
# Restrições Ax <= b
# ------------------------------------------------------------
A = np.array([
    [ 1, -1,  1],   # x1 - x2 + x3 <= 1
    [ 1, -2,  0],   # x1 - 2*x2   <= 4
    [-1,  0,  0],   # x1 >= 0
    [ 0, -1,  0],   # x2 >= 0
    [ 0,  0, -1],   # x3 >= 0
], dtype=float)

b = np.array([1, 4, 0, 0, 0], dtype=float)

# Caixa para cortar a região ilimitada
M = 5.0
A_box = np.vstack([A, np.eye(3)])
b_box = np.concatenate([b, [M, M, M]])

# ------------------------------------------------------------
# Vértices: interseções de triplas de restrições factíveis
# ------------------------------------------------------------
verts = []
for i, j, k in combinations(range(len(A_box)), 3):
    Msub = A_box[[i, j, k]]
    bsub = b_box[[i, j, k]]
    if abs(np.linalg.det(Msub)) < 1e-10:
        continue
    x = np.linalg.solve(Msub, bsub)
    if np.all(A_box @ x <= b_box + 1e-9):
        verts.append(x)

verts = np.unique(np.round(np.array(verts), 8), axis=0)
print("Vértices da região (truncada):")
print(verts)

# ------------------------------------------------------------
# Envoltória convexa
# ------------------------------------------------------------
hull = ConvexHull(verts)

# ------------------------------------------------------------
# Plotagem com plotly
# ------------------------------------------------------------
fig = go.Figure()

# Malha da região factível
fig.add_trace(go.Mesh3d(
    x=verts[:, 0], y=verts[:, 1], z=verts[:, 2],
    i=hull.simplices[:, 0],
    j=hull.simplices[:, 1],
    k=hull.simplices[:, 2],
    color='steelblue',
    opacity=0.35,
    name='Região factível',
    flatshading=True,
))

# Vértices em vermelho
fig.add_trace(go.Scatter3d(
    x=verts[:, 0], y=verts[:, 1], z=verts[:, 2],
    mode='markers+text',
    marker=dict(size=5, color='red'),
    text=[f"({v[0]:.2f},{v[1]:.2f},{v[2]:.2f})" for v in verts],
    textposition='top center',
    name='Vértices',
))

# Planos correspondentes às restrições (opcional, ajuda a visualizar)
u = np.linspace(0, M, 20)
U, W = np.meshgrid(u, u)

# x1 - x2 + x3 = 1  =>  x3 = 1 + x2 - x1
fig.add_trace(go.Surface(
    x=U, y=W, z=1 + W - U,
    opacity=0.15, showscale=False,
    colorscale=[[0, 'gray'], [1, 'gray']],
    name='x1-x2+x3=1',
))

fig.update_layout(
    title='Questão 6 — região factível (truncada em x ≤ 5)',
    scene=dict(
        xaxis_title='x1',
        yaxis_title='x2',
        zaxis_title='x3',
        aspectmode='cube',
    ),
    margin=dict(l=0, r=0, b=0, t=40),
)

fig.show()