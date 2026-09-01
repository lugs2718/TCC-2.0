// Configurações de documento e pacotes equivalentes

#import "../../imports.typ": *
#show: codly-init.with()

#set page(margin: (left: 3cm, top: 3cm, right: 2cm, bottom: 2cm), numbering: "1")
#set text(lang: "pt", region: "BR", size: 12pt)
#set par(justify: true, first-line-indent: 1.25cm)
#set math.equation(numbering: "(1)")


== Implementação do método dos elementos finitos via FEniCS

#task[
  - Objetivo M.1: Descrever o Modelo Computacional MEF: Escrever 2 a 3 parágrafos explicando como o domínio físico do cilindro foi modelado no FEniCS (axissimétrico 2D ou 1D radial). Quais elementos finitos foram usados (ex: elementos de Lagrange de grau 1)?
]


O vaso de pressão cilíndrico, submetido a uma pressão interna uniforme, constitui um problema de interesse fundamental na engenharia estrutural. Conforme demonstrado na seção anterior, esta configuração geométrica específica permite a adoção de um modelo unidimensional, simplificando significativamente a análise computacional. Contudo, as especificações da biblioteca FEniCS (@bleyer2018numericaltours, @logg2012automated) direcionaram a implementação para um domínio axissimétrico bidimensional no plano $r z$. Nessa formulação, a dimensão radial é definida pela espessura do vaso ($R_"ext" - R_"int" = 2$ mm), enquanto a dimensão axial é fixada em $H_z = 2$ mm. A malha foi discretizada utilizando elementos finitos de Lagrange de grau 2,

// ── Placeholder M.5a: Espaço de funções e campos vetoriais ──
```py
  V_space = VectorFunctionSpace(mesh, "CG", 1)
  u = TrialFunction(V_space)
  v = TestFunction(V_space)
  x = SpatialCoordinate(mesh)
  r = x[0]
```

uma escolha que assegura a precisão numérica necessária para capturar os gradientes de campo de deslocamento em domínios delgados, validando, por conseguinte, as formulações teóricas estabelecidas.

Para encapsular a solução, foi criada a função `comparar_mha_mef()`, que recebe os parâmetros geométricos do vaso e os parâmetros de discretização da malha. A função é responsável por

- Criar a malha do vaso;
- Aplicar as condições de contorno;
- Resolver o problema de elasticidade no domínio mesoscópico;
- Calcular os deslocamentos e tensões no vaso;
- Comparar os resultados com os obtidos pela homogêinização assintótica numérica;
- Calcular a resistência específica ($W_g = P_g / rho_g$) e a rigidez específica ($K_g = k_"eff" / (rho_g g_0)$).

```py
# TODO: Inserir código — Parâmetros geométricos e criação da malha
def comparar_mha_mef(
    R_int=9.0, R_ext=11.0, H=2.0, P_int=30e6,
    E1=200e9, nu1=0.3, E2=70e9, nu2=0.33,
    V1=0.5,
    N_celulas=200, resolucao_malha=20, n_elem_z=10,
    callback=None
):
    """
    Resolve numericamente o problema do vaso de pressão cilíndrico com microestrutura periódica.

    Args:
        R_int: Raio interno do vaso (m)
        R_ext: Raio externo do vaso (m)
        H: Altura do vaso (m)
        P_int: Pressão interna (Pa)
        E1, nu1: Módulo de Young e coeficiente de Poisson do material 1
        E2, nu2: Módulo de Young e coeficiente de Poisson do material 2
        V1: Fração volumétrica do material 1 (0 a 1)
        N_celulas: Número de células periódicas
        resolucao_malha: Número de elementos por célula na direção radial
        n_elem_z: Número de elementos na direção axial
        callback: Função opcional para processamento intermediário
    """

    # A função retorna as soluções em coordenadas cartesianas (u, v, sigma)
    # convertidas a partir das coordenadas axissimétricas (w, 0, sigma_rr, sigma_tt, sigma_rz)
    ...
    return u_cart, v_cart, sigma_rr_cart, sigma_tt_cart, sigma_rz_cart, mesh, V

```

#task[
  - Objetivo M.2: Detalhar a Implementação da Microestrutura: Explicar matematicamente e logicamente como você criou as camadas alternadas (Aço/Alumínio) no FEniCS. Nota: Explicar a lógica daquela sua classe PeriodicProperty que alterna as propriedades baseadas nos raios de interface, sem necessariamente colar todo o código.
]


/*

    # =======================================================
    # 1. PARÂMETROS GEOMÉTRICOS E FÍSICOS
    # =======================================================

    R_int, R_ext = 9.0, 11.0 #Raio interno e externo
    H = 2.0 # Expessura

    #Em resumo, enquanto aplicações estruturais leves podem operar próximas a 1 MPa

    #, os componentes críticos de Oil & Gas e sistemas de armazenamento de alta pressão operam tipicamente entre 10 MPa e 50 MPa
    P_int = 60e6 # Pressão interna

    # Material 1 (Ex: Aço) e Material 2 (Ex: Alumínio)

    E1, nu1 = 200e9, 0.3
    E2, nu2 = 70e9, 0.33

    # Número de camadas (Volume fraction 50/50)

    N_celulas = int(input("Digite o número de camadas: ")) # Número de períodos/células (Cada célula contém 1 camada de cada material)

    V1 = float(input("Digite a fração volumétrica da camada 1 (0 a 1): ")) # Fração de volume da camada 1
    V2 = 1-V1 # Fração de volume da camada 2
    espessura_celula = (R_ext - R_int) / N_celulas

    h1 = V1 * espessura_celula
    h2 = V2 * espessura_celula

    interfaces = []

    raio_atual = R_int

    for i in range(N_celulas):

        raio_atual += h1
        interfaces.append(raio_atual) # Adiciona a interface Material 1 -> Material 2
        raio_atual += h2
        if i < N_celulas - 1:
            interfaces.append(raio_atual) # Adiciona a interface Material 2 -> Material 1 da próxima célula

    print(interfaces)

    # 'interfaces' agora contém as posições exatas onde a propriedade deve mudar,
    # e a malha (mesh) tem nós milimetricamente posicionados nessas coordenadas!

    # =======================================================
    # 2. CÁLCULO DOS COEFICIENTES HOMOGENEIZADOS (MHA)
    # Baseado na Teoria de Laminação (Homogeneização Assintótica 1D)
    # =======================================================

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
    C22_eff = (V1*C11_1 + V2*C11_2) - (V1*(C12_1**2)/C11_1 + V2*(C12_2**2)/C11_2) + (C12_eff**2)/C11_eff # Esse eu ainda não calculei
    G_eff = 1.0 / (V1/G_1 + V2/G_2) # Nem esse

# 800 elementos em R para garantir 20 elementos DENTRO de cada camada

    # Usamos um multiplicador para garantir que a proporção vire números inteiros de elementos
    resolucao_malha = 20 # Mude isso para refinar mais ou menos a malha

    # Número de elementos dentro de uma única célula para cada material
    nel_1 = int(V1 * resolucao_malha)
    nel_2 = int(V2 * resolucao_malha)
    nel_celula = nel_1 + nel_2

    # Total de elementos radiais na malha inteira
    n_elements_r = N_celulas * nel_celula
    n_elements_z = 10

    print(f'Número de elementos em r {n_elements_r}')
    print(f'Número de elementos em r {n_elements_z}')

    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), n_elements_r, n_elements_z)


*/


A microestrutura heterogênea do cilindro foi modelada definindo-se propriedades mecânicas alternadas para seções concêntricas na direção radial. Computacionalmente, isso foi implementado no FEniCS por meio de uma classe que herda de `UserExpression`, nomeada `PeriodicProperty` @bleyer2018numericaltours. Essa classe recebe como parâmetros os valores das propriedades de cada material (`val1` e `val2`, correspondentes ao módulo de elasticidade $E$ e ao coeficiente de Poisson $nu$) e um vetor de coordenadas radiais que definem as interfaces entre as camadas. Durante a montagem das matrizes do MEF, a função de avaliação da classe verifica a posição espacial radial (coordenada $r$) do ponto de integração e atribui as propriedades do material correspondente, gerando assim a alternância periódica requerida pelo modelo.

```py
class PeriodicProperty(UserExpression):
        def __init__(self, val1, val2, interfaces, **kwargs):
            super().__init__(**kwargs)
            self.val1, self.val2 = val1, val2
            self.interfaces = interfaces
        def eval(self, values, x):
            idx = 0
            for r_int in self.interfaces:
                if x[0] <= r_int: break
                idx += 1
            values[0] = self.val1 if idx % 2 == 0 else self.val2
        def value_shape(self): return ()
```

// Explicar que foi necessário alterar a definição do número de camadas para garantir que o número de elementos por camada seja um número inteiro e então ser possível modificar a fração volumétrica livremente sem perder a precisão da malha. Agora, o número de elementos por camada é calculado a partir de variáveis auxiliares N_celulas e resolucao_malha.

São necessários pelo menos `N_celulas * (int(V1 * resolucao_malha) + int(V2 * resolucao_malha))`#margin-note["Colocar em um anexo talvez"] elementos na direção radial. Onde `nel_celula` é o número de elementos por célula, `resolucao_malha` é o número de elementos por unidade de espessura, V1 e V2 as frações volumétricas de cada material, e N_celulas o número de células. Para garantir que o número de elementos por camada seja um número inteiro e então ser possível modificar a fração volumétrica livremente sem perder a precisão da malha, pois haverá sempre um nó na interface entre as camadas, capturando a descontinuidade do deslocamento entre as camadas. Caso contrário, o deslocamento seria interpolado entre as camadas, e a precisão do método seria perdida. #margin-note[Jogar no chat para ver se ele concorda.]


#task[

  - Objetivo M.4: Detalhar a Malha: Justificar o uso de 800 elementos radiais. Explicar que, para o MEF capturar corretamente os saltos de propriedade, é necessário garantir que existam vários elementos finitos dentro de cada camada da microestrutura.
]

#let P_int = $30$

Dada a natureza axissimétrica do problema, o domínio computacional foi definido como uma seção retangular no plano $r z$, com dimensão radial correspondente à espessura do vaso ($R_"ext" - R_"int" = 2$ mm, com raio interno de 9 mm e externo de 11 mm)#margin-note[Verificar se este caso se enquadraria em um vaso de paredes finas calculando o fator $r/t$. Sendo r o raio interno e t a espessura, no sadd deve ter] e altura $H_z = 2$ mm na direção axial. A malha de elementos finitos foi estruturada com 10 elementos na direção axial e 800 elementos na direção radial. Essa elevada discretização radial justifica-se por duas razões principais: primeiro, para capturar com precisão os elevados gradientes de tensão (variando desde a pressão interna de #P_int MPa até 0 MPa na face externa); segundo, para garantir que cada camada da microestrutura heterogênea — que se torna cada vez mais fina em simulações com maior número de camadas — contenha múltiplos elementos, evitando assim descontinuidades numéricas imprecisas no interior de um mesmo elemento.

// ── Placeholder M.4: Lógica de refinamento da malha ──
```py
# TODO: Inserir código — Cálculo do número de elementos por camada
# Malha adaptativa: número de elementos por célula respeita a proporção de cada material
nel_1 = int(V1 * resolucao_malha)
nel_2 = int(V2 * resolucao_malha)
nel_celula = nel_1 + nel_2
n_elements_r = N_celulas * nel_celula

mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), int(n_elements_r), int(n_elem_z))

```


#task[

  - Objetivo M.6: Mostrar como foram inclusos os coeficientes efetivos no código
]

Para o cálculo dos coeficientes efetivos, emprega-se a função `get_C_matrix(E, nu)`, que retorna os coeficientes de rigidez $C_11$, $C_12$ e $G$ para um material isotrópico. Assim, os coeficientes efetivos são calculados conforme as equações @eq:Chat11_Calculation, @eq:Chat12_Calculation e @eq:Chatg_Calculation.

```py
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

```


#task[
  - Objetivo M.5: Forma fraca do problema de elasticidade: Mostrar a forma final usada para a equação de equilíbrio e como ela foi implementada no código.
]


=== Formulação variacional do problema axissimétrico

/*A resolução numérica pelo MEF requer que a equação de equilíbrio seja expressa em sua forma fraca (ou variacional). Partindo da forma forte do problema de elasticidade linear (@eq:OriginalPDE), a formulação fraca consiste em encontrar o campo de deslocamentos $bold(u) in cal(V)$ tal que*/

O programa FEniCS utiliza uma formulação simplificada da forma fraca do problema de elasticidade @bleyer2018numericaltours, formulado inicialmente na @eq:WeakFormEquation, sendo a forma fraca geral definida como

$
  a(bold(u), bold(v)) = L(bold(v)), quad forall bold(v) in cal(V)_0,
$ <eq:WeakFormGeneral>

onde $cal(V)$ é o espaço de funções admissíveis e $cal(V)_0$ o subespaço das funções teste que se anulam nas fronteiras de Dirichlet. A forma bilinear $a(dot, dot)$ e o funcional linear $L(dot)$ são definidos, respectivamente, por

$
  a(bold(u), bold(v)) = integral_Omega bold(sigma)(bold(u)) : bold(epsilon.alt)(bold(v)) d Omega, quad
  L(bold(v)) = integral_Omega bold(f) dot bold(v) d Omega + integral_(Gamma_u) bold(t) dot bold(v) d S.
$

Para problemas formulados em coordenadas cilíndricas sob hipótese de axissimetria, o elemento de volume diferencial é $d Omega = r d r d theta d z$. Como as grandezas são independentes de $theta$, a integração nessa direção contribui apenas com o fator $2 pi$, que pode ser cancelado em ambos os lados da igualdade. Consequentemente, a integração é realizada sobre o domínio bidimensional $Omega_(r z)$ no plano $r$–$z$, introduzindo-se o fator de ponderação $r$ no integrando:

$
  a(bold(u), bold(v)) = integral_(Omega_(r z)) bold(sigma)(bold(u)) : bold(epsilon.alt)(bold(v)) r thin d r thin d z.
$ <eq:BilinearAxisym>

Analogamente, o funcional de carga para a pressão interna $p$ aplicada na fronteira $Gamma_"int"$ torna-se

$
  L(bold(v)) = integral_(Gamma_"int") p thin bold(v) dot bold(n) thin r thin d S,
$

onde $bold(n)$ é o vetor normal unitário externo à superfície interna do cilindro.

Na implementação computacional via FEniCS, os campos de deslocamento e função teste são definidos como funções vetoriais sobre um espaço de elementos finitos de Lagrange de grau 2. Para cada modo de solição foi criado um problema variacional sepadado, cada um com seu próprio campo de deslocamentos `u_mha` para a homogenenização e `u_mef` para caso de elementos finitos. O tensor de deformações $bold(epsilon.alt)(bold(u))$ é obtido pelo gradiente simétrico do campo de deslocamentos, enquanto o tensor de tensões $bold(sigma)(bold(u))$ resulta da aplicação da lei constitutiva isotrópica (@eq:HookesLawCoeffs). Para as deformações, utiliza-se o operador de gradiente simétrico em coodenadas cilíndricas

```py
def eps(u):
    return sym(as_tensor([[u[0].dx(0), 0, u[0].dx(1)], [0, u[0]/r, 0], [u[1].dx(0), 0, u[1].dx(1)]]))
```

E para as tensões, no caso do MEF #margin-note[Falar que essa é a lei de Hooke]:

```py
def sigma_mef(u):
    return lmbda_func * tr(eps(u)) * Identity(3) + 2.0 * mu_func * eps(u)
```

E para o caso do MHA:

```py
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

```

As formas bilinear e linear #margin-note[Definir na revisão bibliográfica] são então declaradas utilizando as primitivas da biblioteca: o operador `inner` para a contração dupla e a medida de integração de contorno `ds` com marcador de fronteira para a aplicação da pressão. O fator geométrico $r$ (coordenada radial do ponto de integração) é incorporado explicitamente como multiplicador em ambas as formas, garantindo a correta representação do volume axissimétrico conforme a @eq:BilinearAxisym.

```py
r = x[0]
a_mef = inner(sigma_mef(u), eps(v)) * r * dx
a_mha = inner(sigma_mha(u), eps(v)) * r * dx
```

No que diz respeito ao carregamento, foi imposta uma condição de contorno de Neumann  na fronteira interna do domínio ($Gamma_"int"$), representando a pressão interna sob a qual vasos de pressão geralmente operam.

```py
T = -Constant(P_int) * FacetNormal(mesh)
L = inner(T, v) * r * ds_custom(1)
```

#task[
  - Objetivo M.3: Condições de Contorno e Carregamento: Formalizar em texto que a pressão interna de $10 "MPa"$ foi aplicada no contorno $Gamma_("int")$ e que as bordas superior e inferior foram restringidas para simular o estado plano de deformação.
]

#margin-note[Citação aqui] O valor da pressão foi definido como #P_int MPa, distribuído uniformemente ao longo da superfície interna do cilindro. Ademais, aplicaram-se condições de contorno de Dirichlet essenciais nas faces superior e inferior do domínio axissimétrico, restringindo os deslocamentos axiais (em $z$) nessas fronteiras, de forma a garantir as premissas de um estado plano de deformação e assegurar o comportamento puramente bidimensional do modelo. #margin-note[Citação aqui]

```py
# Condições de Contorno (Travando Z para simular Estado Plano 1D)
bcs = [
    DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 2), # Trava base
    DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 3)  # Trava topo
]
```

Com tudo isso em mãos, define-se o problema homogêneo assintótico com:

```py
a_mha = inner(sigma_mha(u), eps(v)) * r * dx
u_mha = Function(V_space)
solve(a_mha == L, u_mha, bcs)
```

Assim como o problema heterogêneo com:

```py
a_mef = inner(sigma_mef(u), eps(v)) * r * dx
u_mef = Function(V_space)
solve(a_mef == L, u_mef, bcs)
```



