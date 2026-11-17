from dolfin import *
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
from datetime import datetime

def comparar_mha_mef(
    R_int=9.0, R_ext=11.0, H=2.0, P_int=30,
    E1=200e3, nu1=0.3, E2=70e3, nu2=0.33,
    V1=0.5,
    N_celulas=200, resolucao_malha=20, n_elem_z=10,
    callback=None
):
    """
    Executa a simulação comparativa MEF Heterogêneo vs MHA Homogeneizado.

    Parâmetros (todos opcionais, com defaults dos valores originais):
        R_int, R_ext    : Raio interno e externo (mm)
        H               : Espessura (mm)
        P_int           : Pressão interna (MPa=N/mm^2)
        E2, nu2         : Módulo de Young (MPa) e Poisson do Material 2 (Alumínio) 
        E1, nu1         : Módulo de Young (MPa) e Poisson do Material 1 (Aço) 
        V1              : Fração volumétrica do Material 1
        N_celulas       : Número de células unitárias (cada célula contém 2 camadas: uma de aço e uma de alumínio)
        resolucao_malha : Elementos por célula (a malha radial é calculada automaticamente)
        n_elem_z        : Elementos na direção axial
        callback        : Função callback(etapa: str) para feedback visual (ex: spinners do Streamlit).
                          Quando None, usa print().

    Retorna:
        dict com: R_vals, u_r_mef, u_r_mha, erro_abs, interfaces,
                  N_celulas, n_elements_r, n_elem_z, total_elementos,
                  resolucao_malha, espessura_celula, h1, h2
    """
    def notificar(etapa):
        if callback:
            callback(etapa)
        else:
            print(etapa)

    # =======================================================
    # 1. PARÂMETROS DERIVADOS E CONSTRUÇÃO DAS INTERFACES
    # =======================================================
    notificar("Calculando parâmetros e construindo interfaces...")

    V2 = 1.0 - V1
    espessura_celula = (R_ext - R_int) / N_celulas
    h1 = V1 * espessura_celula # Espessura da camada do material 1
    h2 = V2 * espessura_celula # Espessura da camada do material 2

    # Construção explícita das interfaces respeitando frações volumétricas
    interfaces = []
    raio_atual = R_int

    for i in range(N_celulas):
        raio_atual += h1
        interfaces.append(raio_atual)  # Interface Material 1 -> Material 2
        raio_atual += h2
        if i < N_celulas - 1:# A última "interface" será a borda externa do vaso, então devemos desconsiderá-la nas iterações
            interfaces.append(raio_atual)  # Interface Material 2 -> Material 1 da próxima célula

    # =======================================================
    # 2. CÁLCULO DOS COEFICIENTES HOMOGENEIZADOS (MHA)
    # Baseado na Teoria de Laminação (Homogeneização Assintótica 1D)
    # =======================================================
    notificar("Calculando coeficientes homogeneizados...")

    def get_C_matrix(E, nu):
        # Retorna C11 e C12 para material isotrópico
        C11 = E * (1 - nu) / ((1 + nu) * (1 - 2 * nu))
        C12 = E * nu / ((1 + nu) * (1 - 2 * nu))
        G = E / (2 * (1 + nu))
        return C11, C12, G

    C11_1, C12_1, G_1 = get_C_matrix(E1, nu1)
    C11_2, C12_2, G_2 = get_C_matrix(E2, nu2)

    # Coeficientes Efetivos (Média Harmônica na direção radial, Aritmética nas outras)
    C11_eff = 1.0 / (V1/C11_1 + V2/C11_2)
    C12_eff = C11_eff * (V1 * C12_1/C11_1 + V2 * C12_2/C11_2)
    C22_eff = (V1*C11_1 + V2*C11_2) - (V1*(C12_1**2)/C11_1 + V2*(C12_2**2)/C11_2) + (C12_eff**2)/C11_eff
    G_eff = 1.0 / (V1/G_1 + V2/G_2)

    print("Coeficientes heterogêneos")
    print("-"*50)
    print("Aço")
    print("C11_1 =", C11_1 / 1e3, "GPa")
    print("C12_1 =", C12_1 / 1e3, "GPa")
    print("Aluminio")
    print("C11_2 =", C11_2 / 1e3, "GPa")
    print("C12_2 =", C12_2 / 1e3, "GPa")
    print("-"*50)
    print("Coeficientes efetivos")
    print("-"*50)
    print("C11_eff =", C11_eff / 1e3, "GPa")
    print("C12_eff =", C12_eff / 1e3, "GPa")
    print("C22_eff =", C22_eff / 1e3, "GPa")
    print("G_eff =", G_eff / 1e3, "GPa")
    print("-"*50)

    # =======================================================
    # 3. MALHA E FRONTEIRAS (Comum para ambos os modelos)
    # =======================================================
    notificar("Gerando malha e definindo subdomínios...")

    # Malha adaptativa: número de elementos por célula respeita a proporção de cada material
    nel_1 = int(V1 * resolucao_malha)
    nel_2 = int(V2 * resolucao_malha)
    nel_celula = nel_1 + nel_2
    print(f'resolução da malha={resolucao_malha}\nNumero de elementos por célula={nel_celula}')

    n_elements_r = N_celulas * nel_celula
    print(f'O número de elementos axiais é {n_elem_z}')
    print(f'O número de elementos radiais é {n_elements_r}')
    print(f'O numero total de elementos é {n_elements_r * n_elem_z}')

    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), int(n_elements_r), int(n_elem_z))
    plot(mesh, 
    title=f"Domínio discretizado. N_cel = {N_celulas}, n_el/cel = {resolucao_malha} e N_z = {n_elem_z}"
    )

    boundaries = MeshFunction("size_t", mesh, mesh.topology().dim() - 1)
    boundaries.set_all(0)
    CompiledSubDomain("near(x[0], R_int)", R_int=R_int).mark(boundaries, 1) # Parede Interna
    CompiledSubDomain("near(x[1], 0.0)").mark(boundaries, 2)                # Base
    CompiledSubDomain("near(x[1], H)", H=H).mark(boundaries, 3)             # Topo
    ds_custom = Measure("ds", domain=mesh, subdomain_data=boundaries)

    V_space = VectorFunctionSpace(mesh, "CG", 1)
    u = TrialFunction(V_space)
    v = TestFunction(V_space)
    x = SpatialCoordinate(mesh)
    r = x[0]

    # Condições de Contorno (Travando Z para simular Estado Plano 1D do seu Notebook)
    bcs = [
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 2), # Trava base
        DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 3)  # Trava topo
    ]

    T = -Constant(P_int) * FacetNormal(mesh)
    L = inner(T, v) * r * ds_custom(1)

    # =======================================================
    # 4. MODELO 1: MEF HETEROGÊNEO (Múltiplas Camadas)
    # =======================================================
    notificar("Resolvendo modelo MEF Heterogêneo...")

    class PeriodicProperty(UserExpression):
        def __init__(self, val1, val2, interfaces, **kwargs):
            super().__init__(**kwargs)
            self.val1, self.val2 = val1, val2 # Valores da propriedade nas camadas
            self.interfaces = interfaces # lista com as posições das interfaces
        def eval(self, values, x):
            idx = 0
            for r_int in self.interfaces: # Loop para as posições radiais das interfaces, índices pares = material 1, ímpares = material 2
                if x[0] <= r_int: break # Verifica se está antes da interface
                idx += 1 # Incrementa o índice caso o valor de x[0] (coordenada radial) for maior que a posição da interface (r_int)
            values[0] = self.val1 if idx % 2 == 0 else self.val2 # Atribui o valor da propriedade (val1 se o índice for par, val2 se for ímpar)
        def value_shape(self): return ()

    E_func = PeriodicProperty(E1, E2, interfaces, degree=0)
    nu_func = PeriodicProperty(nu1, nu2, interfaces, degree=0)

    lmbda_func = (E_func * nu_func) / ((1.0 + nu_func) * (1.0 - 2.0 * nu_func))
    mu_func = E_func / (2.0 * (1.0 + nu_func))

    def eps(u):
        return sym(as_tensor([[u[0].dx(0), 0, u[0].dx(1)], [0, u[0]/r, 0], [u[1].dx(0), 0, u[1].dx(1)]]))

    def sigma_mef(u):
        return lmbda_func * tr(eps(u)) * Identity(3) + 2.0 * mu_func * eps(u)

    a_mef = inner(sigma_mef(u), eps(v)) * r * dx  # Multiplica-se a integral por r (O Jacobiano da métrica cilíndrica)
    u_mef = Function(V_space)
    solve(a_mef == L, u_mef, bcs)

    # =======================================================
    # 5. MODELO 2: MHA HOMOGENEIZADO (Material Equivalente)
    # =======================================================
    notificar("Resolvendo modelo MHA Homogeneizado...")

    def sigma_mha(u):
        # Tensor de tensão para o material homogeneizado transversalmente isotrópico
        err = u[0].dx(0)
        ett = u[0]/r
        ezz = u[1].dx(1)
        erz = 0.5 * (u[0].dx(1) + u[1].dx(0))

        # Leis constitutivas homogeneizadas
        srr = C11_eff*err + C12_eff*ett + C12_eff*ezz
        stt = C12_eff*err + C22_eff*ett + C12_eff*ezz
        szz = C12_eff*err + C12_eff*ett + C22_eff*ezz
        srz = 2.0 * G_eff * erz

        return as_tensor([[srr, 0, srz], [0, stt, 0], [srz, 0, szz]])

    a_mha = inner(sigma_mha(u), eps(v)) * r * dx
    u_mha = Function(V_space)
    solve(a_mha == L, u_mha, bcs)

    # =======================================================
    # 6. EXTRAÇÃO DE RESULTADOS
    # =======================================================
    notificar("Extraindo resultados...")

    R_vals = np.linspace(R_int, R_ext, 1000)
    Z_val = H / 2.0 # Extrai na metade da altura

    u_r_mef = [u_mef(r, Z_val)[0] for r in R_vals]
    u_r_mha = [u_mha(r, Z_val)[0] for r in R_vals]

    erro_abs = np.abs(np.array(u_r_mef) - np.array(u_r_mha))
    erro_abs_medio = erro_abs.mean()

    return {
        "R_vals": R_vals,
        "P_int": P_int,
        "H": H,
        "E1": E1,
        "nu1": nu1,
        "E2": E2,
        "nu2": nu2,
        "V1": V1,
        #Adicionar Coeficientes efetivos
        "u_r_mef": u_r_mef,
        "u_r_mha": u_r_mha,
        "erro_abs": erro_abs,
        "erro_abs_medio": erro_abs_medio,
        "interfaces": interfaces,
        "N_celulas": N_celulas,
        "n_elements_r": n_elements_r,
        "n_elem_z": n_elem_z,
        "total_elementos": n_elements_r * n_elem_z,
        "resolucao_malha": resolucao_malha,
        "espessura_celula": espessura_celula,
        "h1": h1,
        "h2": h2,
        "mesh": mesh,
        "Z_val": Z_val,
        "u_mef": u_mef,
        "u_mha": u_mha,
        "sigma_mef_func": sigma_mef,
        "sigma_mha_func": sigma_mha,
    }

def preencher_tabela(resultados):
    '''
        Função para preencher as tabelas de input e output cada vez que a função comparar_mha_mef é executada

        Parâmetros:
            nome_tabela (str): Nome do arquivo .csv onde a tabela será salva
            resolucao_malha (int): Resolução da malha
            N_celulas (int): Número de células
            nel_celula (int): Número de elementos por célula
            n_elements_r (int): Número de elementos radiais
            n_elem_z (int): Número de elementos axiais
            R_vals (np.array): Array de valores de raio
            Z_val (float): Valor de altura
            u_mef (np.array): Array de deslocamentos radiais do MEF
            u_mha (np.array): Array de deslocamentos radiais do MHA
            erro_abs (np.array): Array de erros absolutos
    '''
    nome_tabela_in = os.path.join("tables", "inputs.csv")
    nome_tabela_out = os.path.join("tables", "outputs.csv")

    # Criar as tabelas se elas ainda não existirem
    if not os.path.exists(nome_tabela_in):
        tabela_in = pd.DataFrame({
            "Horário da execução": [],
            "Raio interno (mm)": [],
            "Raio externo (mm)": [],
            "Altura (mm)": [],
            "Pressão Interna (MPa)": [],
            "Fração volumétrica 1":[],
            "Fração volumétrica 2":[], 
            "Módulo de elasticidade 1 (MPa)":[],
            "Módulo de elasticidade 2 (MPa)":[],
            "Coeficiente de Poisson 1":[],
            "Coeficiente de Poisson 2":[],
            "Numero de Células": [],
            "Numero de Elementos por Celula": [],
            "Numero de Elementos Radiais": [],
            "Numero de Elementos Axiais": [],
            "Numero Total de Elementos": []
        })
        tabela_in.to_csv(nome_tabela_in, index=False)

    else:
        tabela_in = pd.read_csv(nome_tabela_in)

    # Adicionar linha de dados na tabela
    if not os.path.exists(nome_tabela_out):
        tabela_out = pd.DataFrame({
            "Horário da execução": [],
            "Deslocamento MEF (mm)": [],
            "Deslocamento MHA (mm)": [],
            "Erro Absoluto (mm)": [],
            "Tensões MEF (MPa)": [],
            "Tensões MHA (MPa)": [],
            'Tensão equivalente de Von Mises MEF (MPa)':[],
            'Tensão equivalente de Von Mises MHA (MPa)':[],
            'Tensão específica do compósito MEF':[],
            'Tensão específica do compósito MHA':[]
        })
        tabela_out.to_csv(nome_tabela_out, index=False)
    else:
        tabela_out = pd.read_csv(nome_tabela_out)

    tabela_in_add = pd.DataFrame({
            "Horário da execução": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "Raio interno (mm)": [R_int],
            "Raio externo (mm)": [R_ext],
            "Altura (mm)": [H],
            "Pressão Interna (MPa)": [P_int],
            "Fração volumétrica 1":[V1],
            "Fração volumétrica 2":[1-V1],
            "Módulo de elasticidade 1 (MPa)":[E1],
            "Módulo de elasticidade 2 (MPa)":[E2],
            "Coeficiente de Poisson 1":[nu1],
            "Coeficiente de Poisson 2":[nu2],
            "Numero de Células": [N_celulas],
            "Numero de Elementos por Celula": [resolucao_malha],
            "Numero de Elementos Radiais": [N_celulas*resolucao_malha],
            "Numero de Elementos Axiais": [n_elem_z],
            "Numero Total de Elementos": [N_celulas*resolucao_malha* n_elem_z]
    })

    tabela_out_add = pd.DataFrame({
        "Horário da execução": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "Posição radial (mm)": resultados["R_vals"],
        "Deslocamento MEF (mm)": resultados["u_r_mef"],
        "Deslocamento MHA (mm)": resultados["u_r_mha"],
        "Erro Absoluto (mm)": resultados["erro_abs"],
        "Erro Absoluto médio (mm)": resultados["erro_abs_medio"],
        "Tensões MEF (MPa)": resultados["sig_rr_mef"],
        "Tensões MHA (MPa)": resultados["sig_rr_mha"],
        'Tensão equivalente de Von Mises MEF (MPa)':resultados["von_mises_mef"],
        'Tensão equivalente de Von Mises MHA (MPa)':resultados["von_mises_mha"],
        'Tensão específica do compósito MEF':resultados["von_mises_mef_especifica"],
        'Tensão específica do compósito MHA':resultados["von_mises_mha_especifica"]
    })

    # Concatenar as novas linhas para obter as tabelas completas
    tabela_in = pd.concat([tabela_in_add, tabela_in], ignore_index=True)
    tabela_out = pd.concat([tabela_out_add, tabela_out], ignore_index=True)

    # Salvar as tabelas
    tabela_in.to_csv(nome_tabela_in, index=False)
    tabela_out.to_csv(nome_tabela_out, index=False)

def testar_multiplos_parametros(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1, **kwargs):
    """
    Testa múltiplos conjuntos de parâmetros combinando-os em todas as permutações possíveis (grid search).
    Retorna um DataFrame do pandas com os resultados comparativos (erro máximo, erro médio, etc.).
    
    Parâmetros:
        lista_n_elem_z (list): Lista de valores para n_elem_z
        lista_resolucao_malha (list): Lista de valores para resolucao_malha
        lista_N_celulas (list): Lista de valores para N_celulas
        lista_V1 (list): Lista de valores para V1 (fração volumétrica do material 1)
        **kwargs: Outros parâmetros fixos para repassar à função comparar_mha_mef (ex: R_int, P_int)
    """
    resultados_tabela = []
    
    # Gera todas as combinações possíveis de parâmetros
    combinacoes = list(itertools.product(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1))
    
    total = len(combinacoes)
    print(f"Iniciando testes para {total} combinações de parâmetros...")
    
    for i, (n_elem_z, res_malha, n_cel, v1) in enumerate(combinacoes):
        print(f"[{i+1}/{total}] Testando: n_elem_z={n_elem_z}, res={res_malha}, N_celulas={n_cel}, V1={v1}")
        
        try:
            # Combina os argumentos da iteração com os passados em kwargs (evita conflito de múltiplos valores)
            sim_kwargs = kwargs.copy()
            sim_kwargs.update({
                "n_elem_z": n_elem_z,
                "resolucao_malha": res_malha,
                "N_celulas": n_cel,
                "V1": v1,
                "callback": lambda x: None
            })
            
            # Executa a simulação silenciando os prints internos com um callback vazio
            res = comparar_mha_mef(**sim_kwargs)
            
            # Calcula métricas de comparação baseadas no array de erro absoluto
            erro_maximo = np.max(res["erro_abs"])
            erro_medio = np.mean(res["erro_abs"])
            
            # Salva os resultados detalhados desta simulação específica
            nome_arquivo = f"resultados_nZ{n_elem_z}_res{res_malha}_cel{n_cel}_V1_{v1}.csv"
            salvar_resultados(res, filename=nome_arquivo)
            
            resultados_tabela.append({
                "n_elem_z": n_elem_z,
                "resolucao_malha": res_malha,
                "N_celulas": n_cel,
                "V1": v1,
                "total_elementos": res["total_elementos"],
                "erro_maximo": erro_maximo,
                "erro_medio": erro_medio
            })
            
        except Exception as e:
            print(f"Erro na simulação [{i+1}/{total}]: {e}")
            resultados_tabela.append({
                "n_elem_z": n_elem_z,
                "resolucao_malha": res_malha,
                "N_celulas": n_cel,
                "V1": v1,
                "total_elementos": None,
                "erro_maximo": None,
                "erro_medio": None
            })
            
    # Converte os resultados em uma tabela comparativa (DataFrame)
    df_comparativo = pd.DataFrame(resultados_tabela)
    return df_comparativo

# =======================================================
# 7. STUBS PARA IMPLEMENTAÇÃO FUTURA (Extraídos para escopo global)
# =======================================================
def calcular_plotar_tensoes(resultados, plotting=False):
    """
    Calcula e plota as componentes de tensão para os modelos MEF e MHA.
    Os valores calculados são salvos no dicionário `resultados`.
    """
    print("Calculando tensões projetadas...")
    mesh = resultados["mesh"]
    Z_val = resultados["Z_val"]
    R_vals = resultados["R_vals"]
    
    # Projeta as funções de tensão no espaço tensorial
    V_sig = TensorFunctionSpace(mesh, "DG", 0, shape=(3,3))
    sig_mef_proj = project(resultados["sigma_mef_func"](resultados["u_mef"]), V_sig)
    sig_mha_proj = project(resultados["sigma_mha_func"](resultados["u_mha"]), V_sig)
    
    sig_rr_mef, sig_tt_mef, sig_zz_mef, sig_rz_mef = [], [], [], []
    sig_rr_mha, sig_tt_mha, sig_zz_mha, sig_rz_mha = [], [], [], []

    for r in R_vals:
        s_mef = sig_mef_proj(r, Z_val)
        sig_rr_mef.append(s_mef[0])
        sig_tt_mef.append(s_mef[4])
        sig_zz_mef.append(s_mef[8])
        sig_rz_mef.append(s_mef[2])
        
        s_mha = sig_mha_proj(r, Z_val)
        sig_rr_mha.append(s_mha[0])
        sig_tt_mha.append(s_mha[4])
        sig_zz_mha.append(s_mha[8])
        sig_rz_mha.append(s_mha[2])

    resultados["sig_rr_mef"] = np.array(sig_rr_mef)
    resultados["sig_tt_mef"] = np.array(sig_tt_mef)
    resultados["sig_zz_mef"] = np.array(sig_zz_mef)
    resultados["sig_rz_mef"] = np.array(sig_rz_mef)
    
    resultados["sig_rr_mha"] = np.array(sig_rr_mha)
    resultados["sig_tt_mha"] = np.array(sig_tt_mha)
    resultados["sig_zz_mha"] = np.array(sig_zz_mha)
    resultados["sig_rz_mha"] = np.array(sig_rz_mha)

    if plotting:
        fig, axs = plt.subplots(2, 2, figsize=(12, 8))
        fig.suptitle('Distribuição de Tensões (MPa)', fontsize=16)
        
        axs[0, 0].plot(R_vals, resultados["sig_rr_mef"], 'b-', label='MEF')
        axs[0, 0].plot(R_vals, resultados["sig_rr_mha"], 'r--', label='MHA')
        axs[0, 0].set_title('Tensão Radial ($\sigma_{rr}$)')
        
        axs[0, 1].plot(R_vals, resultados["sig_tt_mef"], 'b-', label='MEF')
        axs[0, 1].plot(R_vals, resultados["sig_tt_mha"], 'r--', label='MHA')
        axs[0, 1].set_title('Tensão Circunferencial ($\sigma_{\\theta\\theta}$)')
        
        axs[1, 0].plot(R_vals, resultados["sig_zz_mef"], 'b-', label='MEF')
        axs[1, 0].plot(R_vals, resultados["sig_zz_mha"], 'r--', label='MHA')
        axs[1, 0].set_title('Tensão Axial ($\sigma_{zz}$)')
        
        axs[1, 1].plot(R_vals, resultados["sig_rz_mef"], 'b-', label='MEF')
        axs[1, 1].plot(R_vals, resultados["sig_rz_mha"], 'r--', label='MHA')
        axs[1, 1].set_title('Tensão Cisalhante ($\sigma_{rz}$)')
        
        for ax in axs.flat:
            ax.set_xlabel('Raio (mm)')
            ax.set_ylabel('Tensão (MPa)')
            ax.legend()
            ax.grid(True, alpha=0.3)
            for r_int in resultados["interfaces"]:
                ax.axvline(r_int, color='k', linestyle=':', alpha=0.1)

        plt.tight_layout()
        plt.savefig('plots/comparacao_tensoes.png')
        plt.show()

    

def calcular_von_mises(resultados, plotting=False):
    """
    Calcula e plota a Tensão de Von Mises para os resultados.
    Chama automaticamente calcular_plotar_tensoes caso as tensões ainda não estejam no dicionário.
    """
    if "sig_rr_mef" not in resultados:
        calcular_plotar_tensoes(resultados)
        
    s_rr_mef, s_tt_mef, s_zz_mef, s_rz_mef = resultados["sig_rr_mef"], resultados["sig_tt_mef"], resultados["sig_zz_mef"], resultados["sig_rz_mef"]
    s_rr_mha, s_tt_mha, s_zz_mha, s_rz_mha = resultados["sig_rr_mha"], resultados["sig_tt_mha"], resultados["sig_zz_mha"], resultados["sig_rz_mha"]
    
    vm_mef = np.sqrt(0.5 * ((s_rr_mef - s_tt_mef)**2 + (s_tt_mef - s_zz_mef)**2 + (s_zz_mef - s_rr_mef)**2 + 6*(s_rz_mef**2)))
    vm_mha = np.sqrt(0.5 * ((s_rr_mha - s_tt_mha)**2 + (s_tt_mha - s_zz_mha)**2 + (s_zz_mha - s_rr_mha)**2 + 6*(s_rz_mha**2)))
    
    resultados["von_mises_mef"] = vm_mef
    resultados["von_mises_mha"] = vm_mha
    
    R_vals = resultados["R_vals"]
    
    if plotting:
        plt.figure(figsize=(8, 5))
        plt.plot(R_vals, vm_mef, 'b-', label='MEF')
        plt.plot(R_vals, vm_mha, 'r--', label='MHA')
        for r_int in resultados["interfaces"]:
            plt.axvline(r_int, color='k', linestyle=':', alpha=0.1)
        plt.xlabel('Raio (mm)')
        plt.ylabel('Tensão de Von Mises (MPa)')
        plt.title('Distribuição da Tensão Equivalente de Von Mises')
        plt.legend()
        plt.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.savefig('plots/comparacao_von_mises.png')
        plt.show()
        
    return vm_mef, vm_mha

def calcular_resistencia_especifica(resultados, densidade_1=7800.0, densidade_2=2700.0, plotting=False):
    """
    Calcula a Tensão Específica de Von Mises (Tensão / Densidade) para avaliar o benefício peso/resistência.
    Material 1 (default Aço): 7800 kg/m³
    Material 2 (default Alumínio): 2700 kg/m³
    """
    if "von_mises_mef" not in resultados:
        calcular_von_mises(resultados)
        
    R_vals = resultados["R_vals"]
    interfaces = resultados["interfaces"]
    
    densidade_mef = np.zeros_like(R_vals)
    for i, r in enumerate(R_vals):
        idx = 0
        for r_int in interfaces:
            if r <= r_int: break
            idx += 1
        densidade_mef[i] = densidade_1 if idx % 2 == 0 else densidade_2
        
    V1 = resultados.get("h1") / resultados.get("espessura_celula")
    V2 = resultados.get("h2") / resultados.get("espessura_celula")
    densidade_eff = V1 * densidade_1 + V2 * densidade_2
    
    vm_mef_esp = resultados["von_mises_mef"] / densidade_mef
    vm_mha_esp = resultados["von_mises_mha"] / densidade_eff
    
    resultados["von_mises_mef_especifica"] = vm_mef_esp
    resultados["von_mises_mha_especifica"] = vm_mha_esp
    
    if plotting:
        plt.figure(figsize=(8, 5))
        plt.plot(R_vals, vm_mef_esp, 'b-', label='MEF')
        plt.plot(R_vals, vm_mha_esp, 'r--', label='MHA')
        for r_int in resultados["interfaces"]:
            plt.axvline(r_int, color='k', linestyle=':', alpha=0.1)
        plt.xlabel('Raio (mm)')
        plt.ylabel('Tensão de Von Mises Específica (MPa / kg/m³)')
        plt.title('Distribuição de Tensão de Von Mises Específica')
        plt.legend()
        plt.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.savefig('plots/comparacao_resistencia_especifica.png')
        plt.show()
    
    return vm_mef_esp, vm_mha_esp

def salvar_resultados(resultados, filename="resultados.csv"):
    """
    Função para salvar array dos resultados do deslocamento em formato CSV.
    """
    R_vals = resultados["R_vals"]
    u_r_mef = resultados["u_r_mef"]
    u_r_mha = resultados["u_r_mha"]
    erro_abs = resultados["erro_abs"]
    
    # Criar um array 2D com as colunas
    dados = np.column_stack((R_vals, u_r_mef, u_r_mha, erro_abs))
    
    # Salvar usando numpy
    np.savetxt(filename, dados, delimiter=",", header="Raio,Deslocamento_MEF,Deslocamento_MHA,Erro_Absoluto", comments='')
    print(f"Resultados salvos com sucesso em '{filename}'")


if __name__ == "__main__":
    R_int=9.0
    R_ext=11.0
    H=2.0
    P_int=30.0
    E1=200e3
    nu1=0.3
    E2=70e3
    nu2=0.33
    V1=0.5
    N_celulas=2
    resolucao_malha=100
    n_elem_z=20
    plotting=True

    params = {
        "N_celulas": int(N_celulas),
        "resolucao_malha": int(resolucao_malha),
        "n_elem_z": int(n_elem_z),
        "R_int": R_int,
        "R_ext": R_ext,
        "H": H,
        "P_int": P_int,
        "E1": E1,
        "nu1": nu1,
        "E2": E2,
        "nu2": nu2,
        "V1": V1
    }
    resultados = comparar_mha_mef(**params)

    # Salvando os resultados para serem importados em outros códigos (ex: Excel, MATLAB)
    #salvar_resultados(resultados, "resultados_deslocamento.csv")

    R_vals = resultados["R_vals"]
    u_r_mef = resultados["u_r_mef"]
    u_r_mha = resultados["u_r_mha"]
    interfaces = resultados["interfaces"]
    N_celulas = resultados["N_celulas"]


    if plotting:
        plt.figure(figsize=(10, 6))
        plt.plot(R_vals, u_r_mef, 'b-', label=f'MEF (Heterogêneo - {N_celulas} Células)', linewidth=1.5)
        plt.plot(R_vals, u_r_mha, 'r--', label='MHA (Homogeneizado)', linewidth=2.5)

        # Adicionando linhas de grade sutis para visualizar as interfaces
        for r_int in interfaces:
            plt.axvline(r_int, color='k', linestyle=':', alpha=0.1)

        plt.xlabel('Raio (mm)', fontsize=12)
        plt.ylabel('Deslocamento Radial (mm)', fontsize=12)
        plt.title(f'Comparação: MEF vs Homogeneização Assintótica (MHA),\n número de células = {N_celulas}, número total de elementos = {resultados["total_elementos"]}', fontsize=14)
        plt.legend(fontsize=11)
        plt.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.savefig(f'plots/comparacao_mha_mef_{N_celulas}_celulas_nelemr{N_celulas*resolucao_malha}_nelemz_{n_elem_z}.png')
        #plt.show()

    # Chamando as novas funções de cálculo e plotagem
    #print("\nPlotando gráficos adicionais de tensões...")
    calcular_plotar_tensoes(resultados, plotting=plotting)
    calcular_von_mises(resultados, plotting=plotting)
    calcular_resistencia_especifica(resultados, plotting=plotting)

    # Preencher tabela geral de resultados
    print("Salvando resultados...")
    preencher_tabela(resultados)

    # Criar tabela comparativa para o número de elementos
    
    def tabela_comparativa_num_elementos():
        print('Criando tabela comparativa...')
        lista_n_elem_z = [10,10,10,10]
        lista_resolucao_malha = [5,5,5,5]
        lista_N_celulas = [10,20,50,100]
        lista_V1 = [0.5,0.5,0.5,0.5]
        df = testar_multiplos_parametros(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1, **params)
        df.to_csv('tabela_comparativa.csv', index=False)
        print('Tabela comparativa criada com sucesso!')
        print(df)

    # Tabela comparativa para a fração volumétrica
    def tabela_comparativa_fracao_volumetrica():
        print('Criando tabela comparativa...')
        lista_n_elem_z = [10,10,10,10]
        lista_resolucao_malha = [5,5,5,5]
        lista_N_celulas = [10,10,10,10]
        lista_V1 = [0.1,0.3,0.5,0.7,0.9]
        df = testar_multiplos_parametros(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1, **params)
        df.to_csv('tabela_comparativa.csv', index=False)
        print('Tabela comparativa criada com sucesso!')
        print(df)

    # Tabela comparativa para a resolução da malha
    def tabela_comparativa_resolucao_malha():
        print('Criando tabela comparativa...')
        lista_n_elem_z = [10,10,10,10]
        lista_resolucao_malha = [1,2,4,8]
        lista_N_celulas = [10,10,10,10]
        lista_V1 = [0.5,0.5,0.5,0.5]
        df = testar_multiplos_parametros(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1, **params)
        df.to_csv('tabela_comparativa.csv', index=False)
        print('Tabela comparativa criada com sucesso!')
        print(df)

    # Tabela comparativa para o número de células
    def tabela_comparativa_numero_de_celulas():
        print('Criando tabela comparativa...')
        lista_n_elem_z = [10,10,10,10]
        lista_resolucao_malha = [5,5,5,5]
        lista_N_celulas = [10,20,50,100]
        lista_V1 = [0.5,0.5,0.5,0.5]
        df = testar_multiplos_parametros(lista_n_elem_z, lista_resolucao_malha, lista_N_celulas, lista_V1, **params)
        df.to_csv('tabela_comparativa.csv', index=False)
        print('Tabela comparativa criada com sucesso!')
        print(df)
        
    #tabela_comparativa_num_elementos()
    #tabela_comparativa_fracao_volumetrica()
    #tabela_comparativa_resolucao_malha()
    #tabela_comparativa_numero_de_celulas()
    