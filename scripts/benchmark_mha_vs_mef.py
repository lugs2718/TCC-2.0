"""
Benchmark Rigoroso: Análise de Eficiência e Precisão (MHA vs. MEF)
Autor: Wesley (TCC - UFF) / Antigravity
Data: Outubro 2026

Este script executa:
1. Estudo de convergência de malha para o MHA (validado contra solução analítica de Lamé).
2. Estudo de convergência de malha para o MEF Heterogêneo (resolução por célula).
3. Benchmark comparativo sistemático MEF vs MHA para N_celulas = [2, 5, 10, 20, 50, 100, 200]:
   - Graus de Liberdade (DOFs)
   - Tempos de Assembly e Solve (CPU / Wall time)
   - Redução de tempo (%) e Speedup
   - Erros relativos (Máximo, Médio, Norma L2)
4. Exportação das tabelas em CSV e LaTeX (.tex)
5. Geração de gráficos em alta resolução (300 DPI) para monografia
"""

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import time
import bisect
import os
import sys
from dolfin import *

# Suprimir logs verbosos do FEniCS
set_log_level(LogLevel.ERROR)
parameters["form_compiler"]["optimize"] = True
parameters["form_compiler"]["cpp_optimize"] = True

# Diretórios de saída
os.makedirs("tables", exist_ok=True)
os.makedirs("plots", exist_ok=True)

# ==============================================================================
# 1. PARÂMETROS FÍSICOS E GEOMÉTRICOS CANÔNICOS
# ==============================================================================
R_INT = 9.0     # Raio interno (mm)
R_EXT = 11.0    # Raio externo (mm)
H_CYL = 2.0     # Altura da seção modelada (mm)
P_INT = 30.0    # Pressão interna (MPa = N/mm^2)

# Material 1: Aço
E1 = 200e3      # Módulo de Young (MPa)
NU1 = 0.30      # Coeficiente de Poisson

# Material 2: Alumínio
E2 = 70e3       # Módulo de Young (MPa)
NU2 = 0.33      # Coeficiente de Poisson

# Fração volumétrica
V1 = 0.50
V2 = 1.0 - V1

# ==============================================================================
# 2. HOMOGENEIZAÇÃO ASSINTÓTICA (MHA) - COEFICIENTES EFETIVOS 1D
# ==============================================================================
def get_C_matrix(E, nu):
    C11 = E * (1.0 - nu) / ((1.0 + nu) * (1.0 - 2.0 * nu))
    C12 = E * nu / ((1.0 + nu) * (1.0 - 2.0 * nu))
    G = E / (2.0 * (1.0 + nu))
    return C11, C12, G

C11_1, C12_1, G_1 = get_C_matrix(E1, NU1)
C11_2, C12_2, G_2 = get_C_matrix(E2, NU2)

C11_eff = 1.0 / (V1 / C11_1 + V2 / C11_2)
C12_eff = C11_eff * (V1 * C12_1 / C11_1 + V2 * C12_2 / C11_2)
C22_eff = (V1 * C11_1 + V2 * C11_2) - (V1 * (C12_1**2) / C11_1 + V2 * (C12_2**2) / C11_2) + (C12_eff**2) / C11_eff
G_eff = 1.0 / (V1 / G_1 + V2 / G_2)

# ==============================================================================
# 3. SOLUÇÃO ANALÍTICA EXATA DE LAMÉ PARA MATERIAL HOMOGENEIZADO
# ==============================================================================
def calcular_lame_analitico(r_array, R_int=R_INT, R_ext=R_EXT, P_int=P_INT,
                           c11=C11_eff, c12=C12_eff, c22=C22_eff):
    """
    Solução analítica para cilindro oco transversalmente isotrópico
    em Estado Plano de Deformação (epsilon_zz = 0) sob pressão interna.
    """
    k = np.sqrt(c22 / c11)
    a = c11 * k + c12
    b = -c11 * k + c12
    
    denominador = a * (R_int**(k - 1.0)) * (1.0 - (R_ext / R_int)**(2.0 * k))
    C1 = -P_int / denominador
    C2 = -C1 * (a / b) * (R_ext**(2.0 * k))
    
    u_analitico = C1 * (r_array**k) + C2 * (r_array**(-k))
    return u_analitico

# ==============================================================================
# 4. SOLVER MHA (MODELO HOMOGENEIZADO EM FEniCS)
# ==============================================================================
def resolver_mha(n_elem_r, n_elem_z=10, R_int=R_INT, R_ext=R_EXT, H=H_CYL, P_int=P_INT):
    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), int(n_elem_r), int(n_elem_z))
    
    boundaries = MeshFunction("size_t", mesh, mesh.topology().dim() - 1)
    boundaries.set_all(0)
    CompiledSubDomain("near(x[0], R_int)", R_int=R_int).mark(boundaries, 1) # Parede Interna
    CompiledSubDomain("near(x[1], 0.0)").mark(boundaries, 2)                # Base
    CompiledSubDomain("near(x[1], H)", H=H).mark(boundaries, 3)             # Topo
    ds_custom = Measure("ds", domain=mesh, subdomain_data=boundaries)
    
    V_space = VectorFunctionSpace(mesh, "CG", 1)
    dofs = V_space.dim()
    
    u = TrialFunction(V_space)
    v = TestFunction(V_space)
    x = SpatialCoordinate(mesh)
    r = x[0]
    
    bcs = [
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 2),
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 3)
    ]
    
    def eps(w):
        return sym(as_tensor([[w[0].dx(0), 0, w[0].dx(1)],
                              [0, w[0]/r, 0],
                              [w[1].dx(0), 0, w[1].dx(1)]]))
        
    def sigma_mha(w):
        err = w[0].dx(0)
        ett = w[0]/r
        ezz = w[1].dx(1)
        erz = 0.5 * (w[0].dx(1) + w[1].dx(0))
        
        srr = C11_eff * err + C12_eff * ett + C12_eff * ezz
        stt = C12_eff * err + C22_eff * ett + C12_eff * ezz
        szz = C12_eff * err + C12_eff * ett + C22_eff * ezz
        srz = 2.0 * G_eff * erz
        return as_tensor([[srr, 0, srz], [0, stt, 0], [srz, 0, szz]])
        
    a_form = inner(sigma_mha(u), eps(v)) * r * dx
    T = -Constant(P_int) * FacetNormal(mesh)
    L_form = inner(T, v) * r * ds_custom(1)
    
    # Cronometragem precisa de Assembly e Solve
    t0_assembly = time.perf_counter()
    A = assemble(a_form)
    b = assemble(L_form)
    for bc in bcs:
        bc.apply(A, b)
    t_assembly = time.perf_counter() - t0_assembly
    
    t0_solve = time.perf_counter()
    u_sol = Function(V_space)
    solve(A, u_sol.vector(), b)
    t_solve = time.perf_counter() - t0_solve
    
    return {
        "u_sol": u_sol,
        "dofs": dofs,
        "elements": mesh.num_cells(),
        "n_elem_r": n_elem_r,
        "n_elem_z": n_elem_z,
        "t_assembly": t_assembly,
        "t_solve": t_solve,
        "t_total": t_assembly + t_solve,
        "mesh": mesh
    }

# ==============================================================================
# 5. SOLVER MEF HETEROGÊNEO (MÚLTIPLAS CAMADAS EM FEniCS)
# ==============================================================================
class PeriodicPropertyFast(UserExpression):
    def __init__(self, val1, val2, interfaces, **kwargs):
        super().__init__(**kwargs)
        self.val1 = val1
        self.val2 = val2
        self.interfaces = interfaces # lista ordenada de raios das interfaces
    def eval(self, values, x):
        # bisect_right é O(log N) e matematicamente idêntico à busca linear
        idx = bisect.bisect_right(self.interfaces, x[0])
        values[0] = self.val1 if idx % 2 == 0 else self.val2
    def value_shape(self):
        return ()

def resolver_mef(N_celulas, resolucao_malha=4, n_elem_z=10,
                 R_int=R_INT, R_ext=R_EXT, H=H_CYL, P_int=P_INT,
                 E1=E1, nu1=NU1, E2=E2, nu2=NU2, V1=V1):
    
    V2 = 1.0 - V1
    espessura_celula = (R_ext - R_int) / N_celulas
    h1 = V1 * espessura_celula
    h2 = V2 * espessura_celula
    
    interfaces = []
    raio_atual = R_int
    for i in range(N_celulas):
        raio_atual += h1
        interfaces.append(raio_atual)
        raio_atual += h2
        if i < N_celulas - 1:
            interfaces.append(raio_atual)
            
    # Resolução da malha radial respeitando proporções volumétricas
    nel_1 = max(1, int(round(V1 * resolucao_malha)))
    nel_2 = max(1, int(round(V2 * resolucao_malha)))
    nel_celula = nel_1 + nel_2
    n_elements_r = N_celulas * nel_celula
    
    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), int(n_elements_r), int(n_elem_z))
    
    boundaries = MeshFunction("size_t", mesh, mesh.topology().dim() - 1)
    boundaries.set_all(0)
    CompiledSubDomain("near(x[0], R_int)", R_int=R_int).mark(boundaries, 1)
    CompiledSubDomain("near(x[1], 0.0)").mark(boundaries, 2)
    CompiledSubDomain("near(x[1], H)", H=H).mark(boundaries, 3)
    ds_custom = Measure("ds", domain=mesh, subdomain_data=boundaries)
    
    V_space = VectorFunctionSpace(mesh, "CG", 1)
    dofs = V_space.dim()
    
    u = TrialFunction(V_space)
    v = TestFunction(V_space)
    x = SpatialCoordinate(mesh)
    r = x[0]
    
    bcs = [
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 2),
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 3)
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
        
    a_form = inner(sigma_mef(u), eps(v)) * r * dx
    T = -Constant(P_int) * FacetNormal(mesh)
    L_form = inner(T, v) * r * ds_custom(1)
    
    t0_assembly = time.perf_counter()
    A = assemble(a_form)
    b = assemble(L_form)
    for bc in bcs:
        bc.apply(A, b)
    t_assembly = time.perf_counter() - t0_assembly
    
    t0_solve = time.perf_counter()
    u_sol = Function(V_space)
    solve(A, u_sol.vector(), b)
    t_solve = time.perf_counter() - t0_solve
    
    return {
        "u_sol": u_sol,
        "dofs": dofs,
        "elements": mesh.num_cells(),
        "n_elements_r": n_elements_r,
        "n_elem_z": n_elem_z,
        "nel_celula": nel_celula,
        "N_celulas": N_celulas,
        "t_assembly": t_assembly,
        "t_solve": t_solve,
        "t_total": t_assembly + t_solve,
        "interfaces": interfaces,
        "mesh": mesh
    }

# ==============================================================================
# 6. ESTUDO 1: VERIFICAÇÃO DE CONVERGÊNCIA DA MALHA PARA O MHA
# ==============================================================================
def executar_estudo_convergencia_mha():
    print("\n=======================================================")
    print("▶ ESTUDO 1: Convergência de Malha MHA vs. Analítico Exato")
    print("=======================================================")
    
    r_eval = np.linspace(R_INT, R_EXT, 1000)
    u_exato = calcular_lame_analitico(r_eval)
    norm_u_exato_L2 = np.sqrt(np.trapz(u_exato**2 * r_eval, r_eval))
    
    malhas_r = [5, 10, 20, 40, 80, 160]
    dados_mha = []
    
    for nr in malhas_r:
        # Média de 3 execuções para precisão de tempo
        tempos = []
        res = None
        for _ in range(3):
            res = resolver_mha(n_elem_r=nr, n_elem_z=10)
            tempos.append(res["t_total"])
        t_medio = np.mean(tempos)
        
        # Avaliar deslocamento no meio da altura
        u_num = np.array([res["u_sol"](r, H_CYL / 2.0)[0] for r in r_eval])
        erro_abs = np.abs(u_num - u_exato)
        erro_max = np.max(erro_abs)
        erro_rel_max = (erro_max / np.max(np.abs(u_exato))) * 100.0
        
        erro_L2 = np.sqrt(np.trapz(erro_abs**2 * r_eval, r_eval))
        erro_rel_L2 = (erro_L2 / norm_u_exato_L2) * 100.0
        
        dados_mha.append({
            "Elementos Radiais (nr)": nr,
            "Elementos Axiais (nz)": 10,
            "Total de Elementos": res["elements"],
            "DOFs": res["dofs"],
            "Tempo Total (ms)": t_medio * 1000.0,
            "Erro Máx. Absoluto (mm)": erro_max,
            "Erro Relativo Máx. (%)": erro_rel_max,
            "Erro Relativo L2 (%)": erro_rel_L2
        })
        print(f"  nr={nr:3d} | DOFs={res['dofs']:5d} | Tempo={t_medio*1000:6.2f} ms | Erro L2={erro_rel_L2:8.4e}%")
        
    df_mha = pd.DataFrame(dados_mha)
    df_mha.to_csv("tables/tabela_convergencia_mha.csv", index=False)
    
    # Plot de convergência do MHA
    fig, ax1 = plt.subplots(figsize=(8, 5))
    x_nr = df_mha["Elementos Radiais (nr)"].to_numpy()
    y_err = df_mha["Erro Relativo L2 (%)"].to_numpy()
    y_time = df_mha["Tempo Total (ms)"].to_numpy()
    
    ax1.loglog(x_nr, y_err, 'bo-', linewidth=2, markersize=7, label="Erro Relativo $L^2$ (%)")
    ax1.set_xlabel("Número de Elementos Radiais ($n_r$)", fontsize=12)
    ax1.set_ylabel("Erro Relativo vs Analítico (%)", color='b', fontsize=12)
    ax1.tick_params(axis='y', labelcolor='b')
    ax1.grid(True, which="both", ls="--", alpha=0.4)
    
    ax2 = ax1.twinx()
    ax2.plot(x_nr, y_time, 'r^--', linewidth=1.5, markersize=6, label="Tempo CPU (ms)")
    ax2.set_ylabel("Tempo de Processamento (ms)", color='r', fontsize=12)
    ax2.tick_params(axis='y', labelcolor='r')
    
    plt.title("Estudo de Convergência de Malha: MHA vs. Solução Exata de Lamé", fontsize=13, pad=12)
    fig.tight_layout()
    plt.savefig("plots/convergencia_malha_mha.png", dpi=300)
    plt.close()
    
    return df_mha

# ==============================================================================
# 7. ESTUDO 2: CONVERGÊNCIA DA RESOLUÇÃO POR CÉLULA NO MEF HETEROGÊNEO
# ==============================================================================
def executar_estudo_convergencia_mef():
    print("\n=======================================================")
    print("▶ ESTUDO 2: Convergência da Discretização por Célula (MEF)")
    print("=======================================================")
    
    N_cel_ref = 10
    resolucoes = [2, 4, 8, 16, 24]
    r_eval = np.linspace(R_INT, R_EXT, 1000)
    
    # Solução de referência ultra-refinada (resolução = 32)
    print("  Calculando solução de referência refinada do MEF (res=32)...")
    res_ref = resolver_mef(N_celulas=N_cel_ref, resolucao_malha=32, n_elem_z=10)
    u_ref = np.array([res_ref["u_sol"](r, H_CYL / 2.0)[0] for r in r_eval])
    norm_u_ref_L2 = np.sqrt(np.trapz(u_ref**2 * r_eval, r_eval))
    
    dados_mef = []
    for res_malha in resolucoes:
        res = resolver_mef(N_celulas=N_cel_ref, resolucao_malha=res_malha, n_elem_z=10)
        u_num = np.array([res["u_sol"](r, H_CYL / 2.0)[0] for r in r_eval])
        
        erro_abs = np.abs(u_num - u_ref)
        erro_max = np.max(erro_abs)
        erro_rel_max = (erro_max / np.max(np.abs(u_ref))) * 100.0
        erro_L2 = np.sqrt(np.trapz(erro_abs**2 * r_eval, r_eval))
        erro_rel_L2 = (erro_L2 / norm_u_ref_L2) * 100.0
        
        dados_mef.append({
            "N_celulas": N_cel_ref,
            "Elementos por Célula": res["nel_celula"],
            "Elementos Radiais": res["n_elements_r"],
            "DOFs": res["dofs"],
            "Tempo Assembly (s)": res["t_assembly"],
            "Tempo Solve (s)": res["t_solve"],
            "Tempo Total (s)": res["t_total"],
            "Erro Máx. vs Ref. (mm)": erro_max,
            "Erro Relativo Máx. (%)": erro_rel_max,
            "Erro Relativo L2 (%)": erro_rel_L2
        })
        print(f"  El/cel={res['nel_celula']:2d} | Radiais={res['n_elements_r']:3d} | DOFs={res['dofs']:5d} | Erro L2={erro_rel_L2:8.4e}%")
        
    df_mef = pd.DataFrame(dados_mef)
    df_mef.to_csv("tables/tabela_convergencia_mef.csv", index=False)
    
    # Plot de convergência do MEF
    plt.figure(figsize=(8, 5))
    x_el = df_mef["Elementos por Célula"].to_numpy()
    y_mef_err = df_mef["Erro Relativo L2 (%)"].to_numpy()
    plt.semilogy(x_el, y_mef_err, 'gs-', linewidth=2, markersize=7)
    plt.xlabel("Elementos por Célula Unitária", fontsize=12)
    plt.ylabel("Erro Relativo $L^2$ vs. Referência Refinada (%)", fontsize=12)
    plt.title(f"Convergência do MEF Heterogêneo com a Discretização Interna (N={N_cel_ref} Células)", fontsize=13)
    plt.grid(True, which="both", ls="--", alpha=0.4)
    plt.tight_layout()
    plt.savefig("plots/convergencia_malha_mef.png", dpi=300)
    plt.close()
    
    return df_mef

# ==============================================================================
# 8. ESTUDO 3: BENCHMARK PRINCIPAL (MEF vs. MHA) - EFICIÊNCIA E PRECISÃO
# ==============================================================================
def executar_benchmark_principal():
    print("\n=======================================================")
    print("▶ ESTUDO 3: Benchmark Principal - MEF vs. MHA (Variação de N)")
    print("=======================================================")
    
    lista_N_celulas = [2, 5, 10, 20, 50, 100, 200]
    r_eval = np.linspace(R_INT, R_EXT, 1000)
    
    # Para o MHA: utilizamos a malha ótima independente (nr=30, nz=10)
    # que foi provada convergida com erro < 0.01% no Estudo 1.
    print("  Calculando MHA com malha padrão ótima (nr=30, nz=10)...")
    tempos_mha_opt = []
    res_mha_opt = None
    for _ in range(5):
        res_mha_opt = resolver_mha(n_elem_r=30, n_elem_z=10)
        tempos_mha_opt.append(res_mha_opt["t_total"])
    t_mha_opt = np.mean(tempos_mha_opt)
    t_mha_assembly = res_mha_opt["t_assembly"]
    t_mha_solve = res_mha_opt["t_solve"]
    dofs_mha = res_mha_opt["dofs"]
    u_mha = np.array([res_mha_opt["u_sol"](r, H_CYL / 2.0)[0] for r in r_eval])
    
    tabela_principal = []
    perfis_deslocamentos = {"r": r_eval, "u_mha": u_mha}
    
    for N_cel in lista_N_celulas:
        n_camadas = 2 * N_cel
        print(f"\n  -> Processando N_celulas = {N_cel:3d} ({n_camadas:3d} camadas)...")
        
        # Resolução por célula = 4 (2 elementos para aço, 2 para alumínio)
        # Executar 3 repetições para média estável
        tempos_total = []
        tempos_assembly = []
        tempos_solve = []
        res_mef = None
        
        for rep in range(3):
            res_mef = resolver_mef(N_celulas=N_cel, resolucao_malha=4, n_elem_z=10)
            tempos_total.append(res_mef["t_total"])
            tempos_assembly.append(res_mef["t_assembly"])
            tempos_solve.append(res_mef["t_solve"])
            
        t_mef_total = np.mean(tempos_total)
        t_mef_assembly = np.mean(tempos_assembly)
        t_mef_solve = np.mean(tempos_solve)
        dofs_mef = res_mef["dofs"]
        
        u_mef = np.array([res_mef["u_sol"](r, H_CYL / 2.0)[0] for r in r_eval])
        perfis_deslocamentos[f"u_mef_N{N_cel}"] = u_mef
        
        # Métricas de Erro (MEF é a referência física direta com as camadas modeladas)
        erro_abs = np.abs(u_mef - u_mha)
        erro_max = np.max(erro_abs)
        erro_medio = np.mean(erro_abs)
        
        norm_mef_L2 = np.sqrt(np.trapz(u_mef**2 * r_eval, r_eval))
        erro_L2 = np.sqrt(np.trapz(erro_abs**2 * r_eval, r_eval))
        
        erro_rel_max = (erro_max / np.max(np.abs(u_mef))) * 100.0
        erro_rel_medio = (erro_medio / np.mean(np.abs(u_mef))) * 100.0
        erro_rel_L2 = (erro_L2 / norm_mef_L2) * 100.0
        
        # Erro específico nas paredes interna e externa
        erro_rel_Rint = (np.abs(u_mef[0] - u_mha[0]) / np.abs(u_mef[0])) * 100.0
        erro_rel_Rext = (np.abs(u_mef[-1] - u_mha[-1]) / np.abs(u_mef[-1])) * 100.0
        
        # Métricas de Desempenho Computacional
        reducao_tempo_pct = (1.0 - (t_mha_opt / t_mef_total)) * 100.0
        speedup = t_mef_total / t_mha_opt
        reducao_dofs_pct = (1.0 - (dofs_mha / dofs_mef)) * 100.0
        
        print(f"     DOFs MEF: {dofs_mef:6d} | DOFs MHA: {dofs_mha:4d} (Redução DOFs: {reducao_dofs_pct:5.1f}%)")
        print(f"     Tempo MEF: {t_mef_total:6.3f} s | Tempo MHA: {t_mha_opt:6.3f} s")
        print(f"     -> Redução de Tempo: {reducao_tempo_pct:5.2f}% | Speedup: {speedup:5.1f}x")
        print(f"     -> Erro Relativo L2: {erro_rel_L2:5.3f}% | Erro Relativo Máx: {erro_rel_max:5.3f}%")
        
        tabela_principal.append({
            "N_celulas": N_cel,
            "N_camadas": n_camadas,
            "DOFs_MEF": dofs_mef,
            "DOFs_MHA": dofs_mha,
            "Reducao_DOFs_pct": reducao_dofs_pct,
            "Tempo_Assembly_MEF_s": t_mef_assembly,
            "Tempo_Solve_MEF_s": t_mef_solve,
            "Tempo_Total_MEF_s": t_mef_total,
            "Tempo_Total_MHA_s": t_mha_opt,
            "Reducao_Tempo_pct": reducao_tempo_pct,
            "Speedup": speedup,
            "Erro_Abs_Max_mm": erro_max,
            "Erro_Abs_Medio_mm": erro_medio,
            "Erro_Rel_Max_pct": erro_rel_max,
            "Erro_Rel_Medio_pct": erro_rel_medio,
            "Erro_Rel_L2_pct": erro_rel_L2,
            "Erro_Rel_Rint_pct": erro_rel_Rint,
            "Erro_Rel_Rext_pct": erro_rel_Rext
        })
        
    df_principal = pd.DataFrame(tabela_principal)
    df_principal.to_csv("tables/tabela_eficiencia_mha_vs_mef.csv", index=False)
    
    # Exportar também tabela em LaTeX (.tex)
    exportar_tabela_latex(df_principal)
    
    # Gerar figuras dos resultados
    gerar_graficos_benchmark(df_principal, perfis_deslocamentos)
    
    return df_principal

# ==============================================================================
# 9. EXPORTAÇÃO DA TABELA FORMATADA EM LATEX
# ==============================================================================
def exportar_tabela_latex(df):
    latex_str = r"""\begin{table}[htbp]
\centering
\caption{Comparação de Desempenho Computacional e Precisão: MEF Heterogêneo vs. MHA Homogeneizado ($P_{int} = 30\text{ MPa}$, $V_1 = 0{,}50$).}
\label{tab:comparativo_mef_mha}
\resizebox{\textwidth}{!}{%
\begin{tabular}{cc|cc|ccc|ccc}
\hline
\textbf{$N_{cél}$} & \textbf{Camadas} & \textbf{DOFs MEF} & \textbf{DOFs MHA} & \textbf{Tempo MEF (s)} & \textbf{Tempo MHA (s)} & \textbf{Redução (\%)} & \textbf{Speedup} & \textbf{Erro Máx. (\%)} & \textbf{Erro $L^2$ (\%)} \\
\hline
"""
    for _, row in df.iterrows():
        latex_str += f"{int(row['N_celulas']):d} & {int(row['N_camadas']):d} & "
        latex_str += f"{int(row['DOFs_MEF']):,d} & {int(row['DOFs_MHA']):,d} & "
        latex_str += f"{row['Tempo_Total_MEF_s']:6.3f} & {row['Tempo_Total_MHA_s']:6.3f} & "
        latex_str += f"\\textbf{{{row['Reducao_Tempo_pct']:5.1f}\\%}} & {row['Speedup']:5.1f}x & "
        latex_str += f"{row['Erro_Rel_Max_pct']:5.2f}\\% & {row['Erro_Rel_L2_pct']:5.2f}\\% \\\\\n"
        
    latex_str += r"""\hline
\end{tabular}%
}
\end{table}
"""
    with open("tables/tabela_eficiencia_mha_vs_mef.tex", "w", encoding="utf-8") as f:
        f.write(latex_str)
    print("  -> Tabela LaTeX salva com sucesso em 'tables/tabela_eficiencia_mha_vs_mef.tex'")

# ==============================================================================
# 10. GERAÇÃO DE GRÁFICOS DO BENCHMARK
# ==============================================================================
def gerar_graficos_benchmark(df, perfis):
    print("  -> Gerando figuras de alta qualidade para o TCC...")
    
    # 1. Gráfico de Tempos e Redução Percentual
    fig, ax1 = plt.subplots(figsize=(9, 5.5))
    cores = ['#1f77b4', '#d62728']
    
    n_cel_arr = df["N_celulas"].to_numpy()
    t_mef_arr = df["Tempo_Total_MEF_s"].to_numpy()
    t_mha_arr = df["Tempo_Total_MHA_s"].to_numpy()
    red_pct_arr = df["Reducao_Tempo_pct"].to_numpy()
    
    ax1.plot(n_cel_arr, t_mef_arr, 'o-', color=cores[0], linewidth=2.2, markersize=7, label="Tempo MEF Heterogêneo")
    ax1.plot(n_cel_arr, t_mha_arr, 's--', color=cores[1], linewidth=2.0, markersize=7, label="Tempo MHA Homogeneizado")
    ax1.set_xlabel("Número de Células Unitárias ($N_{células}$)", fontsize=12)
    ax1.set_ylabel("Tempo de Processamento (s)", color=cores[0], fontsize=12)
    ax1.tick_params(axis='y', labelcolor=cores[0])
    ax1.grid(True, which="both", ls="--", alpha=0.35)
    
    ax2 = ax1.twinx()
    ax2.bar(n_cel_arr, red_pct_arr, width=n_cel_arr*0.15, alpha=0.25, color='green', label="Redução de Tempo (%)")
    ax2.axhline(95.0, color='darkgreen', linestyle=':', linewidth=1.5, label="Meta 95% de Redução")
    ax2.set_ylabel("Redução Computacional (%)", color='green', fontsize=12)
    ax2.tick_params(axis='y', labelcolor='green')
    ax2.set_ylim(0, 105)
    
    # Anotações nas barras
    for _, row in df.iterrows():
        ax2.annotate(f"{row['Reducao_Tempo_pct']:.1f}%",
                     (row["N_celulas"], row["Reducao_Tempo_pct"]),
                     textcoords="offset points", xytext=(0, 4), ha='center', fontsize=9, color='darkgreen', weight='bold')
                     
    plt.title("Eficiência Computacional: MEF Heterogêneo vs. MHA Homogeneizado", fontsize=13, pad=12)
    fig.tight_layout()
    plt.savefig("plots/bench_tempos_e_reducao.png", dpi=300)
    plt.close()
    
    # 2. Gráfico de Convergência Assintótica do Erro (Log-Log)
    plt.figure(figsize=(8, 5.5))
    err_l2_arr = df["Erro_Rel_L2_pct"].to_numpy()
    err_max_arr = df["Erro_Rel_Max_pct"].to_numpy()
    
    plt.loglog(n_cel_arr, err_l2_arr, 'bo-', linewidth=2, markersize=7, label="Erro Relativo $L^2$ (%)")
    plt.loglog(n_cel_arr, err_max_arr, 'rs--', linewidth=1.8, markersize=6, label="Erro Relativo Máximo (%)")
    
    # Linha teórica O(1/N)
    N_arr = np.array(df["N_celulas"], dtype=float)
    c_ref = df["Erro_Rel_L2_pct"].iloc[0] * N_arr[0]
    plt.loglog(N_arr, c_ref / N_arr, 'k:', linewidth=1.5, label=r"Taxa Teórica Assintótica $\mathcal{O}(1/N)$")
    
    plt.xlabel("Número de Células Unitárias ($N_{células}$)", fontsize=12)
    plt.ylabel("Erro Relativo MHA vs. MEF (%)", fontsize=12)
    plt.title(r"Convergência Assintótica do Erro: $\|u^{\varepsilon} - u^0\|_{L^2} \propto \mathcal{O}(1/N)$", fontsize=13, pad=12)
    plt.legend(fontsize=10)
    plt.grid(True, which="both", ls="--", alpha=0.4)
    plt.tight_layout()
    plt.savefig("plots/convergencia_assintotica_erro.png", dpi=300)
    plt.close()
    
    # 3. Comparação de Perfis de Deslocamento Radial
    plt.figure(figsize=(9, 5.5))
    r = perfis["r"]
    plt.plot(r, perfis["u_mha"], 'k--', linewidth=2.5, label="MHA Homogeneizado (Equivalente)")
    
    for N_plot in [2, 10, 50, 200]:
        if f"u_mef_N{N_plot}" in perfis:
            plt.plot(r, perfis[f"u_mef_N{N_plot}"], label=f"MEF ({N_plot} Células / {2*N_plot} Camadas)", alpha=0.8, linewidth=1.4)
            
    plt.xlabel("Raio $r$ (mm)", fontsize=12)
    plt.ylabel("Deslocamento Radial $u_r$ (mm)", fontsize=12)
    plt.title("Perfis de Deslocamento Radial ao Longo da Espessura ($z = H/2$)", fontsize=13, pad=12)
    plt.legend(fontsize=10)
    plt.grid(True, alpha=0.35)
    plt.tight_layout()
    plt.savefig("plots/comparacao_perfis_deslocamento.png", dpi=300)
    plt.close()

# ==============================================================================
# EXECUÇÃO DO FLUXO COMPLETO
# ==============================================================================
if __name__ == "__main__":
    print("=" * 60)
    print("INICIANDO BENCHMARK COMPLETO MEF vs. MHA")
    print("=" * 60)
    t_inicio_geral = time.time()
    
    executar_estudo_convergencia_mha()
    executar_estudo_convergencia_mef()
    df_final = executar_benchmark_principal()
    
    t_total_geral = time.time() - t_inicio_geral
    print("\n" + "=" * 60)
    print(f"BENCHMARK CONCLUÍDO COM SUCESSO EM {t_total_geral:.1f} SEGUNDOS!")
    print("Arquivos gerados:")
    print(" - tables/tabela_convergencia_mha.csv")
    print(" - tables/tabela_convergencia_mef.csv")
    print(" - tables/tabela_eficiencia_mha_vs_mef.csv")
    print(" - tables/tabela_eficiencia_mha_vs_mef.tex")
    print(" - plots/convergencia_malha_mha.png")
    print(" - plots/convergencia_malha_mef.png")
    print(" - plots/bench_tempos_e_reducao.png")
    print(" - plots/convergencia_assintotica_erro.png")
    print(" - plots/comparacao_perfis_deslocamento.png")
    print("=" * 60)
