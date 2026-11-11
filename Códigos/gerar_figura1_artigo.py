"""
Geração da Figura 1 Corrigida para o Artigo VIII SEMMAT
Gera uma grade 2x2 com os 4 casos:
 (a) 2 células unitárias (4 camadas)
 (b) 20 células unitárias (40 camadas)
 (c) 40 células unitárias (80 camadas)
 (d) 100 células unitárias (200 camadas) -> Corrigido o título que exibia 40 células

Salva em alta resolução (300 DPI) em artigos semmat/Figura_1_corrigida.png
"""

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import os
import bisect
from dolfin import *

set_log_level(LogLevel.ERROR)
parameters["form_compiler"]["optimize"] = True
parameters["form_compiler"]["cpp_optimize"] = True

# Parâmetros
R_int = 9.0
R_ext = 11.0
H = 2.0
P_int = 30.0
E1 = 200e3
nu1 = 0.30
E2 = 70e3
nu2 = 0.33
V1 = 0.50
V2 = 1.0 - V1

# MHA Coeficientes
C11_1 = E1 * (1.0 - nu1) / ((1.0 + nu1) * (1.0 - 2.0 * nu1))
C12_1 = E1 * nu1 / ((1.0 + nu1) * (1.0 - 2.0 * nu1))
G_1 = E1 / (2.0 * (1.0 + nu1))

C11_2 = E2 * (1.0 - nu2) / ((1.0 + nu2) * (1.0 - 2.0 * nu2))
C12_2 = E2 * nu2 / ((1.0 + nu2) * (1.0 - 2.0 * nu2))
G_2 = E2 / (2.0 * (1.0 + nu2))

C11_eff = 1.0 / (V1 / C11_1 + V2 / C11_2)
C12_eff = C11_eff * (V1 * C12_1 / C11_1 + V2 * C12_2 / C11_2)
C22_eff = (V1 * C11_1 + V2 * C11_2) - (V1 * (C12_1**2) / C11_1 + V2 * (C12_2**2) / C11_2) + (C12_eff**2) / C11_eff
G_eff = 1.0 / (V1 / G_1 + V2 / G_2)

# Resolver MHA uma vez na malha convergida
mesh_mha = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), 40, 10)
b_mha = MeshFunction("size_t", mesh_mha, mesh_mha.topology().dim() - 1)
b_mha.set_all(0)
CompiledSubDomain("near(x[0], R_int)", R_int=R_int).mark(b_mha, 1)
CompiledSubDomain("near(x[1], 0.0)").mark(b_mha, 2)
CompiledSubDomain("near(x[1], H)", H=H).mark(b_mha, 3)
ds_mha = Measure("ds", domain=mesh_mha, subdomain_data=b_mha)

V_mha = VectorFunctionSpace(mesh_mha, "CG", 1)
u_m = TrialFunction(V_mha)
v_m = TestFunction(V_mha)
x_m = SpatialCoordinate(mesh_mha)
r_m = x_m[0]

bcs_mha = [
    DirichletBC(V_mha.sub(1), Constant(0.0), b_mha, 2),
    DirichletBC(V_mha.sub(1), Constant(0.0), b_mha, 3)
]

def eps_m(w):
    return sym(as_tensor([[w[0].dx(0), 0, w[0].dx(1)],
                          [0, w[0]/r_m, 0],
                          [w[1].dx(0), 0, w[1].dx(1)]]))

def sig_m(w):
    err = w[0].dx(0)
    ett = w[0]/r_m
    ezz = w[1].dx(1)
    erz = 0.5 * (w[0].dx(1) + w[1].dx(0))
    srr = C11_eff * err + C12_eff * ett + C12_eff * ezz
    stt = C12_eff * err + C22_eff * ett + C12_eff * ezz
    szz = C12_eff * err + C12_eff * ett + C22_eff * ezz
    srz = 2.0 * G_eff * erz
    return as_tensor([[srr, 0, srz], [0, stt, 0], [srz, 0, szz]])

a_mha = inner(sig_m(u_m), eps_m(v_m)) * r_m * dx
L_mha = inner(-Constant(P_int) * FacetNormal(mesh_mha), v_m) * r_m * ds_mha(1)
u_mha_sol = Function(V_mha)
solve(a_mha == L_mha, u_mha_sol, bcs_mha)

R_vals = np.linspace(R_int, R_ext, 1000)
u_r_mha = [u_mha_sol(r, H / 2.0)[0] for r in R_vals]

# Classe de propriedades periódicas rápida
class PeriodicPropertyFast(UserExpression):
    def __init__(self, val1, val2, interfaces, **kwargs):
        super().__init__(**kwargs)
        self.val1 = val1
        self.val2 = val2
        self.interfaces = interfaces
    def eval(self, values, x):
        idx = bisect.bisect_right(self.interfaces, x[0])
        values[0] = self.val1 if idx % 2 == 0 else self.val2
    def value_shape(self): return ()

def resolver_mef_caso(N_celulas):
    esp_cel = (R_ext - R_int) / N_celulas
    h1 = V1 * esp_cel
    h2 = V2 * esp_cel
    interfaces = []
    r_curr = R_int
    for i in range(N_celulas):
        r_curr += h1
        interfaces.append(r_curr)
        r_curr += h2
        if i < N_celulas - 1:
            interfaces.append(r_curr)
            
    resolucao_malha = 4
    nel_celula = 4
    n_elements_r = N_celulas * nel_celula
    n_elem_z = 10
    
    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), int(n_elements_r), int(n_elem_z))
    b = MeshFunction("size_t", mesh, mesh.topology().dim() - 1)
    b.set_all(0)
    CompiledSubDomain("near(x[0], R_int)", R_int=R_int).mark(b, 1)
    CompiledSubDomain("near(x[1], 0.0)").mark(b, 2)
    CompiledSubDomain("near(x[1], H)", H=H).mark(b, 3)
    ds = Measure("ds", domain=mesh, subdomain_data=b)
    
    V_space = VectorFunctionSpace(mesh, "CG", 1)
    u = TrialFunction(V_space)
    v = TestFunction(V_space)
    x = SpatialCoordinate(mesh)
    r = x[0]
    
    bcs = [
        DirichletBC(V_space.sub(1), Constant(0.0), b, 2),
        DirichletBC(V_space.sub(1), Constant(0.0), b, 3)
    ]
    
    E_func = PeriodicPropertyFast(E1, E2, interfaces, degree=0)
    nu_func = PeriodicPropertyFast(nu1, nu2, interfaces, degree=0)
    lmbda_func = (E_func * nu_func) / ((1.0 + nu_func) * (1.0 - 2.0 * nu_func))
    mu_func = E_func / (2.0 * (1.0 + nu_func))
    
    def eps(w):
        return sym(as_tensor([[w[0].dx(0), 0, w[0].dx(1)],
                              [0, w[0]/r, 0],
                              [w[1].dx(0), 0, w[1].dx(1)]]))
        
    def sigma_mef(w):
        return lmbda_func * tr(eps(w)) * Identity(3) + 2.0 * mu_func * eps(w)
        
    a_mef = inner(sigma_mef(u), eps(v)) * r * dx
    L_mef = inner(-Constant(P_int) * FacetNormal(mesh), v) * r * ds(1)
    u_mef_sol = Function(V_space)
    solve(a_mef == L_mef, u_mef_sol, bcs)
    
    u_r_mef = [u_mef_sol(r_val, H / 2.0)[0] for r_val in R_vals]
    return u_r_mef, interfaces, mesh.num_cells()

# Criar a grade 2x2 da Figura 1
fig, axs = plt.subplots(2, 2, figsize=(14, 10))
casos = [
    (2, "(a)", axs[0, 0]),
    (20, "(b)", axs[0, 1]),
    (40, "(c)", axs[1, 0]),
    (100, "(d)", axs[1, 1])
]

for N_cel, label_letra, ax in casos:
    print(f"Gerando painel {label_letra} para N_celulas = {N_cel}...")
    u_r_mef, interfaces, num_elem = resolver_mef_caso(N_cel)
    
    ax.plot(R_vals, u_r_mef, 'b-', label=f'MEF ({N_cel} células / {2*N_cel} camadas)', linewidth=1.5)
    ax.plot(R_vals, u_r_mha, 'r--', label='MHA (Homogeneizado)', linewidth=2.0)
    
    # Linhas de interface sutis (apenas para N pequenos para não poluir)
    if N_cel <= 20:
        for r_int in interfaces:
            ax.axvline(r_int, color='gray', linestyle=':', alpha=0.3)
            
    ax.set_xlabel('Raio r (mm)', fontsize=11)
    ax.set_ylabel('Deslocamento Radial $u_r$ (mm)', fontsize=11)
    ax.set_title(f'{label_letra} $N_{{células}} = {N_cel}$ ({2*N_cel} camadas), Total de elementos = {num_elem}', fontsize=12, pad=8)
    ax.legend(fontsize=10, loc='best')
    ax.grid(True, alpha=0.3)

plt.tight_layout()
os.makedirs("artigos semmat", exist_ok=True)
caminho_figura = "artigos semmat/Figura_1_corrigida.png"
plt.savefig(caminho_figura, dpi=300)
plt.close()
print(f"Figura 1 corrigida salva com sucesso em '{caminho_figura}'!")
