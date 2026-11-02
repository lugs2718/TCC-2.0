import numpy as np
import matplotlib.pyplot as plt
import os
import pandas as pd

def carregar_dados_fem(filename="resultados_deslocamento.csv"):
    """
    Carrega os resultados salvos das simulações FEM/MHA.
    """
    try:
        dados = np.loadtxt(filename, delimiter=",", skiprows=1)
        return {
            "R_vals": dados[:, 0],
            "u_r_mef": dados[:, 1],
            "u_r_mha": dados[:, 2],
            "erro_abs": dados[:, 3]
        }
    except Exception as e:
        print(f"Erro ao carregar {filename}: {e}")
        return None

def calcular_solucao_Lame_mha(R_vals, R_int=9.0, R_ext=11.0, P_int=30, #MPa = N/mm²
                                   E1=200e3, nu1=0.3, E2=70e3, nu2=0.33, V1=0.5):
    """
    Calcula a solução analítica exata para o cilindro de Lame
    em estado plano de deformação.
    """
    
    V2 = 1.0 - V1
    
    def get_C_matrix(E, nu):
        C11 = E * (1 - nu) / ((1 + nu) * (1 - 2 * nu))
        C12 = E * nu / ((1 + nu) * (1 - 2 * nu))
        return C11, C12
    
    C11_1, C12_1 = get_C_matrix(E1, nu1)
    C11_2, C12_2 = get_C_matrix(E2, nu2)
    
    # Propriedades homogeneizadas (MHA)
    C11 = 1.0 / (V1/C11_1 + V2/C11_2)
    C12 = C11 * (V1 * C12_1/C11_1 + V2 * C12_2/C11_2)
    C22 = (V1*C11_1 + V2*C11_2) - (V1*(C12_1**2)/C11_1 + V2*(C12_2**2)/C11_2) + (C12**2)/C11
    
    # Parâmetros da solução analítica (ortotrópico)
    k = np.sqrt(C22 / C11)
    a = C11 * k + C12
    b = -C11 * k + C12
    
    # Constantes de integração dadas as condições de contorno
    denominador = a * (R_int**(k - 1)) * (1 - (R_ext / R_int)**(2 * k))
    C1 = -P_int / denominador
    C2 = -C1 * (a / b) * (R_ext**(2 * k))
    
    # Deslocamento radial
    u_analitico = C1 * (R_vals**k) + C2 * (R_vals**(-k))
    return u_analitico

def comparar_FEM_Analitico():
    resultados = carregar_dados_fem("resultados_deslocamento.csv")
    if not resultados:
        return
    
    R_vals = resultados["R_vals"]
    u_r_mef = resultados["u_r_mef"]
    u_r_mha = resultados["u_r_mha"]
    
    # Calcular solução analítica para comparar
    u_analitico = calcular_solucao_Lame_mha(R_vals)
    
    plt.figure(figsize=(10, 6))
    
    plt.plot(R_vals, u_r_mef, 'b-', label='MEF (Heterogêneo)', linewidth=1.5, alpha=0.7)
    plt.plot(R_vals, u_r_mha, 'g--', label='MHA (Numérico FEniCS)', linewidth=2.5)
    plt.plot(R_vals, u_analitico, 'r:', label='MHA (Analítico Exato)', linewidth=2.5)
    
    plt.xlabel('Raio (m)', fontsize=12)
    plt.ylabel('Deslocamento Radial (m)', fontsize=12)
    plt.title('Validação: FEM vs MHA vs Solução Analítica', fontsize=14)
    plt.legend(fontsize=11)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    import os
    if not os.path.exists('plots'):
        os.makedirs('plots')
    plt.savefig('plots/validacao_analitica.png', dpi=300)
    plt.show()

    tabela_comparativa_analitica(resultados, u_analitico)

def tabela_comparativa_analitica(resultados, u_analitico):
    import pandas as pd
    
    R_vals = resultados["R_vals"]
    u_r_mef = resultados["u_r_mef"]
    u_r_mha_mef = resultados["u_r_mha"]

    # 1. Tabela detalhada ponto a ponto
    tabela_valores = pd.DataFrame({
        "Raio (m)": R_vals,
        "MEF (m)": u_r_mef,
        "MHA Numérico (m)": u_r_mha_mef,
        "MHA Analítico (m)": u_analitico,
        "Erro MEF vs Analítico (m)": np.abs(u_r_mef - u_analitico),
        "Erro MHA Num. vs Analítico (m)": np.abs(u_r_mha_mef - u_analitico)
    })
    if not os.path.exists("tables"):
        os.makedirs("tables")

    tabela_valores.to_csv("tables/comparacao_deslocamentos_detalhada.csv", index=False)
    
    # 2. Tabela de erros máximos
    erro_maximo_mha_mef = np.max(np.abs(u_r_mha_mef - u_analitico))
    erro_maximo_mef = np.max(np.abs(u_r_mef - u_analitico))
    erro_maximo_mef_mha = np.max(np.abs(u_r_mef - u_r_mha_mef))

    tabela_erros = pd.DataFrame({
        "Comparação": [
            "MEF vs MHA Analítico", 
            "MHA (FEniCS) vs MHA Analítico", 
            "MEF vs MHA (FEniCS)"
        ],
        "Erro Máximo Absoluto (m)": [
            erro_maximo_mef, 
            erro_maximo_mha_mef, 
            erro_maximo_mef_mha
        ]
    })
    
    tabela_erros.to_csv("tabela_erros_maximos.csv", index=False)
    
    print("\n--- Tabela de Erros Máximos ---")
    print(tabela_erros.to_string(index=False))
    print("\n(Os dados detalhados ponto a ponto foram salvos em 'comparacao_deslocamentos_detalhada.csv')")
    
    return tabela_valores, tabela_erros

def calcular_Lame_isotropico(R_vals, R_int=9.0, R_ext=11.0, P_int=30, E=200e3, nu=0.3):
    """
    Calcula as tensões e deslocamentos analíticos para um cilindro homogêneo isotrópico.
    """
    a = R_int
    b = R_ext
    Pi = P_int
    r = R_vals
    
    # Tensões
    const_tensao = (a**2 * Pi) / (b**2 - a**2)
    sig_r = const_tensao * (1 - (b**2 / r**2))
    sig_theta = const_tensao * (1 + (b**2 / r**2))
    sig_z = nu * (sig_r + sig_theta) # Estado plano de deformação
    
    # Von Mises
    vm = np.sqrt(0.5 * ((sig_r - sig_theta)**2 + (sig_theta - sig_z)**2 + (sig_z - sig_r)**2))
    
    # Deslocamento
    eps_theta = (1 / E) * (sig_theta - nu * (sig_r + sig_z))
    u = r * eps_theta
    
    return {
        "u_r": u,
        "sig_r": sig_r,
        "sig_theta": sig_theta,
        "sig_z": sig_z,
        "von_mises": vm
    }

def calcular_solucao_Lame_mha_completa(R_vals, R_int=9.0, R_ext=11.0, P_int=30,
                                   E1=200e3, nu1=0.3, E2=70e3, nu2=0.33, V1=0.5):
    """
    Calcula a solução analítica exata (deslocamentos e tensões) para o cilindro de Lame
    em estado plano de deformação para o material homogeneizado (MHA).
    """
    V2 = 1.0 - V1
    
    def get_C_matrix(E, nu):
        C11 = E * (1 - nu) / ((1 + nu) * (1 - 2 * nu))
        C12 = E * nu / ((1 + nu) * (1 - 2 * nu))
        return C11, C12
    
    C11_1, C12_1 = get_C_matrix(E1, nu1)
    C11_2, C12_2 = get_C_matrix(E2, nu2)
    
    # Propriedades homogeneizadas (MHA)
    C11 = 1.0 / (V1/C11_1 + V2/C11_2)
    C12 = C11 * (V1 * C12_1/C11_1 + V2 * C12_2/C11_2)
    C22 = (V1*C11_1 + V2*C11_2) - (V1*(C12_1**2)/C11_1 + V2*(C12_2**2)/C11_2) + (C12**2)/C11
    
    k = np.sqrt(C22 / C11)
    a_param = C11 * k + C12
    b_param = -C11 * k + C12
    
    denominador = a_param * (R_int**(k - 1)) * (1 - (R_ext / R_int)**(2 * k))
    C1 = -P_int / denominador
    C2 = -C1 * (a_param / b_param) * (R_ext**(2 * k))
    
    u_analitico = C1 * (R_vals**k) + C2 * (R_vals**(-k))
    
    sig_r = C1 * a_param * (R_vals**(k - 1)) + C2 * b_param * (R_vals**(-k - 1))
    
    c_param = C12 * k + C22
    d_param = -C12 * k + C22
    sig_theta = C1 * c_param * (R_vals**(k - 1)) + C2 * d_param * (R_vals**(-k - 1))
    
    sig_z = C12 * ( (k + 1) * C1 * (R_vals**(k - 1)) - (k - 1) * C2 * (R_vals**(-k - 1)) )
    
    vm = np.sqrt(0.5 * ((sig_r - sig_theta)**2 + (sig_theta - sig_z)**2 + (sig_z - sig_r)**2))
    
    return {
        "u_r": u_analitico,
        "sig_r": sig_r,
        "sig_theta": sig_theta,
        "sig_z": sig_z,
        "von_mises": vm
    }

def comparar_tensao_comp_homogeneos():
    """
    Gera o gráfico comparativo da resistência específica (Tensão de Von Mises)
    entre o cilindro MHA (compósito) e cilindros homogêneos de Aço e Alumínio puros.
    """
    R_int, R_ext = 9.0, 11.0
    P_int = 30 # MPa = N/mm²
    R_vals = np.linspace(R_int, R_ext, 1000)
    
    # Propriedades
    E_aco, nu_aco = 200e3, 0.3
    E_alu, nu_alu = 70e3, 0.33
    V_aco = 0.5
    
    # Soluções
    sol_aco = calcular_Lame_isotropico(R_vals, R_int, R_ext, P_int, E_aco, nu_aco)
    sol_alu = calcular_Lame_isotropico(R_vals, R_int, R_ext, P_int, E_alu, nu_alu)
    sol_comp = calcular_solucao_Lame_mha_completa(R_vals, R_int, R_ext, P_int, E_aco, nu_aco, E_alu, nu_alu, V_aco)
    
    tensao_aco = sol_aco["von_mises"]
    tensao_alu = sol_alu["von_mises"]
    tensao_comp = sol_comp["von_mises"]
    
    plt.figure(figsize=(10, 6))
    plt.plot(R_vals, tensao_aco, 'k-', linewidth=2, label='Aço Homogêneo (100% Aço)')
    plt.plot(R_vals, tensao_alu, 'b-', linewidth=2, label='Alumínio Homogêneo (100% Alumínio)')
    plt.plot(R_vals, tensao_comp, 'r--', linewidth=2.5, label='Compósito (50% Aço / 50% Alumínio)')
    
    plt.xlabel('Raio (mm)', fontsize=12)
    plt.ylabel('Tensão de Von Mises (MPa)', fontsize=12)
    plt.title('Comparação de Tensão de Von Mises: Compósito vs Homogêneos', fontsize=14)
    plt.legend(fontsize=11)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    
    import os
    if not os.path.exists('plots'):
        os.makedirs('plots')
    plt.savefig('plots/comparacao_resistencia_homogeneos.png', dpi=300)
    plt.show()

    # Salva também os dados numa tabela
    import pandas as pd
    tabela = pd.DataFrame({
        "Raio (mm)": R_vals,
        "Aço Homogêneo (MPa)": tensao_aco,
        "Alumínio Homogêneo (MPa)": tensao_alu,
        "Compósito (MPa)": tensao_comp
    })
    if not os.path.exists("tables"):
        os.makedirs("tables")
    tabela.to_csv("tables/tensao_homogeneos.csv", index=False)
    print("\nTabela 'tabela_tensao_homogeneos.csv' criada com sucesso.")
    print("Gráfico de tensão salva em 'plots/comparacao_tensao_homogeneos.png'")

    return tensao_aco, tensao_alu, tensao_comp

def comparar_resistencia_comp_homogeneos():
    """
    Gera o gráfico comparativo da resistência específica (Tensão de Von Mises / Densidade)
    entre o cilindro MHA (compósito) e cilindros homogêneos de Aço e Alumínio puros.
    """
    R_int, R_ext = 9.0, 11.0
    P_int = 30 # MPa = N/mm²
    R_vals = np.linspace(R_int, R_ext, 1000)

    # Propriedades
    densidade_aco = 7.8e-6 # kg/mm³
    densidade_alu = 2.7e-6
    V_aco = 0.5
    densidade_comp = V_aco * densidade_aco + (1 - V_aco) * densidade_alu
    
    # Soluções
    tensao_aco, tensao_alu, tensao_comp = comparar_tensao_comp_homogeneos()
    
    esp_aco = tensao_aco / densidade_aco
    esp_alu = tensao_alu / densidade_alu
    esp_comp = tensao_comp / densidade_comp
    
    plt.figure(figsize=(10, 6))
    plt.plot(R_vals, esp_aco, 'k-', linewidth=2, label='Aço Homogêneo (100% Aço)')
    plt.plot(R_vals, esp_alu, 'b-', linewidth=2, label='Alumínio Homogêneo (100% Alumínio)')
    plt.plot(R_vals, esp_comp, 'r--', linewidth=2.5, label='Compósito (50% Aço / 50% Alumínio)')
    
    plt.xlabel('Raio (mm)', fontsize=12)
    plt.ylabel('Tensão Específica de Von Mises (MPa / kg/m³)', fontsize=12)
    plt.title('Comparação de Resistência Específica: Compósito vs Homogêneos', fontsize=14)
    plt.legend(fontsize=11)
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    
    import os
    if not os.path.exists('plots'):
        os.makedirs('plots')
    plt.savefig('plots/comparacao_resistencia_homogeneos.png', dpi=300)
    plt.show()

    # Salva também os dados numa tabela
    import pandas as pd
    tabela = pd.DataFrame({
        "Raio (mm)": R_vals,
        "Aço Homogêneo (MPa / kg/m³)": esp_aco,
        "Alumínio Homogêneo (MPa / kg/m³)": esp_alu,
        "Compósito (MPa / kg/m³)": esp_comp
    })
    if not os.path.exists("tables"):
        os.makedirs("tables")
    tabela.to_csv("tables/resistencia_especifica_homogeneos.csv", index=False)
    print("\nTabela 'tabela_resistencia_especifica_homogeneos.csv' criada com sucesso.")
    print("Gráfico de resistência específica salvo em 'plots/comparacao_resistencia_homogeneos.png'")

    return esp_aco, esp_alu, esp_comp

def gerar_tabela_ruptura():
    """
    Gera uma tabela com os limites de escoamento, tensões máximas atingidas 
    e estimativa de pressão de ruptura para os 3 casos.
    Adiciona também a massa do cilindro e a eficiência de pressão (P_ruptura / Massa).
    """
    R_int, R_ext = 9.0, 11.0
    P_int = 30 # MPa
    
    # Limites de escoamento típicos em MPa (Ajuste conforme os materiais do seu TCC)
    sigma_y_aco = 400.0 
    sigma_y_alu = 270.0 

    # Estimativa simples para o compósito via Regra das Misturas (fração volumétrica 50/50)
    sigma_y_comp = 0.5 * sigma_y_aco + 0.5 * sigma_y_alu 
    
    densidade_aco = 7.8e-6 # kg/mm³
    densidade_alu = 2.7e-6 # kg/mm³
    densidade_comp = 0.5 * densidade_aco + 0.5 * densidade_alu
    
    # Pega as tensões calculadas anteriormente
    tensao_aco, tensao_alu, tensao_comp = comparar_tensao_comp_homogeneos()
    
    max_tensao_aco = np.max(tensao_aco)
    max_tensao_alu = np.max(tensao_alu)
    max_tensao_comp = np.max(tensao_comp)
    
    # Pressão de ruptura (assumindo comportamento linear até o escoamento)
    p_ruptura_aco = P_int * (sigma_y_aco / max_tensao_aco)
    p_ruptura_alu = P_int * (sigma_y_alu / max_tensao_alu)
    p_ruptura_comp = P_int * (sigma_y_comp / max_tensao_comp)
    
    # Volume do cilindro por unidade de comprimento (mm³/mm)
    volume_por_mm = np.pi * (R_ext**2 - R_int**2)
    
    massa_aco = volume_por_mm * densidade_aco # kg/mm
    massa_alu = volume_por_mm * densidade_alu
    massa_comp = volume_por_mm * densidade_comp
    
    # Eficiência Estrutural (Pressão de Ruptura / Massa Linear) - (MPa / (kg/mm))
    eficiencia_aco = p_ruptura_aco / massa_aco
    eficiencia_alu = p_ruptura_alu / massa_alu
    eficiencia_comp = p_ruptura_comp / massa_comp
    
    import pandas as pd
    tabela_ruptura = pd.DataFrame({
        "Material": ["Aço 100%", "Alumínio 100%", "Compósito (50/50)"],
        "Lim. Escoamento (MPa)": [sigma_y_aco, sigma_y_alu, sigma_y_comp],
        "Tensão Max (MPa)": [max_tensao_aco, max_tensao_alu, max_tensao_comp],
        "Pressão de Ruptura Est. (MPa)": [p_ruptura_aco, p_ruptura_alu, p_ruptura_comp],
        "Massa Linear (kg/mm)": [massa_aco, massa_alu, massa_comp],
        "Eficiência Estrutural (MPa/(kg/mm))": [eficiencia_aco, eficiencia_alu, eficiencia_comp]
    })
    
    import os
    if not os.path.exists("tables"):
        os.makedirs("tables")
    tabela_ruptura.to_csv("tables/ruptura_e_eficiencia.csv", index=False)
    
    print("\n--- Tabela de Ruptura e Eficiência Estrutural ---")
    print(tabela_ruptura)
    print("\nTabela 'ruptura_e_eficiencia.csv' salva com sucesso em 'tables/'.")

if __name__ == "__main__":
    '''
    Cria uma tabela comparativa entre os métodos MHA e MEF com a solução analítica
    '''
    comparar_FEM_Analitico()
    comparar_tensao_comp_homogeneos()
    comparar_resistencia_comp_homogeneos()
    gerar_tabela_ruptura()
