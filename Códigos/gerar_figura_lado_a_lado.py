"""
Gera a Figura 1 Composta Lado a Lado para o Artigo VIII SEMMAT
Utiliza a mesma implementação de excelência visual de bench_tempos_e_reducao.png
Painel (a): Perfis de deslocamento radial u_r(r) para N_cel = 2, 20, 40, 100 e MHA
Painel (b): Custo computacional e redução percentual de tempo (>95%), baseado na tabela de benchmark

Salva em 300 DPI em artigos semmat/Figura_1_lado_a_lado.png
"""

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import bisect
from dolfin import *

set_log_level(LogLevel.ERROR)
parameters["form_compiler"]["optimize"] = True
parameters["form_compiler"]["cpp_optimize"] = True

# Parâmetros Físicos
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

# Coeficientes Efetivos MHA
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

# Solver MHA
def resolver_mha():
    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), 30, 10)
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
    
    def eps(w):
        return sym(as_tensor([[w[0].dx(0), 0, w[0].dx(1)],
                              [0, w[0]/r, 0],
                              [w[1].dx(0), 0, w[1].dx(1)]]))
        
    def sig_mha(w):
        err = w[0].dx(0)
        ett = w[0]/r
        ezz = w[1].dx(1)
        erz = 0.5 * (w[0].dx(1) + w[1].dx(0))
        srr = C11_eff * err + C12_eff * ett + C12_eff * ezz
        stt = C12_eff * err + C22_eff * ett + C12_eff * ezz
        szz = C12_eff * err + C12_eff * ett + C22_eff * ezz
        srz = 2.0 * G_eff * erz
        return as_tensor([[srr, 0, srz], [0, stt, 0], [srz, 0, szz]])
        
    a = inner(sig_mha(u), eps(v)) * r * dx
    L = inner(-Constant(P_int) * FacetNormal(mesh), v) * r * ds(1)
    u_sol = Function(V_space)
    solve(a == L, u_sol, bcs)
    return u_sol

u_mha_sol = resolver_mha()
r_eval = np.linspace(R_int, R_ext, 1000)
u_r_mha = np.array([u_mha_sol(r, H / 2.0)[0] for r in r_eval])

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
        
    a = inner(sigma_mef(u), eps(v)) * r * dx
    L = inner(-Constant(P_int) * FacetNormal(mesh), v) * r * ds(1)
    u_sol = Function(V_space)
    solve(a == L, u_sol, bcs)
    
    u_r_mef = np.array([u_sol(r_val, H / 2.0)[0] for r_val in r_eval])
    return u_r_mef

# Executar perfis MEF para os casos do artigo
lista_N_perfis = [2, 20, 40, 100]
perfis_mef = {}
print("Calculando perfis MEF para o Painel (a)...")
for N in lista_N_perfis:
    perfis_mef[N] = resolver_mef_caso(N)

# Carregar dados de benchmark rigorosos para o Painel (b)
df_bench = pd.read_csv("tables/tabela_eficiencia_mha_vs_mef.csv")

# ==============================================================================
# RENDERIZAR FIGURA 1 LADO A LADO
# ==============================================================================
fig, (ax_a, ax_b) = plt.subplots(1, 2, figsize=(15.5, 6))

# ------------------------------------------------------------------------------
# PAINEL (a): Perfis de Deslocamento Radial
# ------------------------------------------------------------------------------
ax_a.plot(r_eval, u_r_mha, 'k--', linewidth=2.5, label='MHA (Homogeneizado Contínuo)')

estilos = {
    2: ('#1f77b4', '-'),
    20: ('#2ca02c', '-'),
    40: ('#ff7f0e', '-'),
    100: ('#9467bd', '-')
}

for N in lista_N_perfis:
    cor, lin = estilos[N]
    ax_a.plot(r_eval, perfis_mef[N], color=cor, linestyle=lin, linewidth=1.5,
              label=f'MEF: $N_{{cél}}={N}$ ({2*N} camadas)', alpha=0.85)

ax_a.set_xlabel('Raio $r$ (mm)', fontsize=12)
ax_a.set_ylabel('Deslocamento Radial $u_r$ (mm)', fontsize=12)
ax_a.set_title('(a) Convergência dos Perfis de Deslocamento Radial ($z = H/2$)', fontsize=13, pad=12)
ax_a.legend(fontsize=10.5, loc='best')
ax_a.grid(True, alpha=0.35)

# ------------------------------------------------------------------------------
# PAINEL (b): Eficiência Computacional e Redução de Tempo (>95%)
# Exatamente com a mesma lógica e clareza de bench_tempos_e_reducao.png
# ------------------------------------------------------------------------------
cores = ['#1f77b4', '#d62728']

n_cel_arr = df_bench["N_celulas"].to_numpy()
t_mef_arr = df_bench["Tempo_Total_MEF_s"].to_numpy()
t_mha_arr = df_bench["Tempo_Total_MHA_s"].to_numpy()
red_pct_arr = df_bench["Reducao_Tempo_pct"].to_numpy()

linha_mef, = ax_b.plot(n_cel_arr, t_mef_arr, 'o-', color=cores[0], linewidth=2.2, markersize=7, label="Tempo MEF Heterogêneo")
linha_mha, = ax_b.plot(n_cel_arr, t_mha_arr, 's--', color=cores[1], linewidth=2.0, markersize=7, label="Tempo MHA Homogeneizado")

ax_b.set_xlabel("Número de Células Unitárias ($N_{células}$)", fontsize=12)
ax_b.set_ylabel("Tempo de Processamento (s)", color=cores[0], fontsize=12)
ax_b.tick_params(axis='y', labelcolor=cores[0])
ax_b.grid(True, which="both", ls="--", alpha=0.35)

ax_b_twin = ax_b.twinx()
barras = ax_b_twin.bar(n_cel_arr, red_pct_arr, width=n_cel_arr * 0.15, alpha=0.25, color='green', label="Redução Computacional (%)")
linha_meta = ax_b_twin.axhline(95.0, color='darkgreen', linestyle=':', linewidth=1.8, label="Meta 95% de Redução")

ax_b_twin.set_ylabel("Redução de Tempo do MHA vs. MEF (%)", color='green', fontsize=12)
ax_b_twin.tick_params(axis='y', labelcolor='green')
ax_b_twin.set_ylim(0, 105)

# Anotações claras nas barras com valores percentuais positivos
for _, row in df_bench.iterrows():
    val = row["Reducao_Tempo_pct"]
    if val > 0:
        ax_b_twin.annotate(f"{val:.1f}%",
                           (row["N_celulas"], val),
                           textcoords="offset points", xytext=(0, 4), ha='center',
                           fontsize=9.5, color='darkgreen', weight='bold')

# Legenda unificada
linhas_todas = [linha_mef, linha_mha, barras, linha_meta]
labels_todos = [l.get_label() for l in linhas_todas]
ax_b.legend(linhas_todas, labels_todos, loc='upper left', fontsize=10, framealpha=1)

ax_b.set_title('(b) Custo Computacional e Comprovação da Redução > 95%', fontsize=13, pad=12)

plt.tight_layout()
os.makedirs("artigos semmat", exist_ok=True)
caminho_final = "artigos semmat/Figura_1_lado_a_lado.png"
plt.savefig(caminho_final, dpi=300)
plt.close()
print(f"Nova Figura 1 lado a lado gerada com sucesso em '{caminho_final}'!")
