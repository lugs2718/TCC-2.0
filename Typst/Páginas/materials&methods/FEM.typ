// Configurações de documento e pacotes equivalentes

#import "../../imports.typ": *
#show: codly-init.with()

#set page(margin: (left: 3cm, top: 3cm, right: 2cm, bottom: 2cm), numbering: "1")
#set text(lang: "pt", region: "BR", size: 12pt)
#set par(justify: true, first-line-indent: 1.25cm)
#set math.equation(numbering: "(1)")


#figure(
  align(center)[
    #diagram(
      node-stroke: 1pt + rgb("#1a73d0"),
      node-fill: rgb("#f5f9fd"),
      edge-stroke: 1.2pt + rgb("#666666"),
      node-corner-radius: 5pt,

      node(
        (0, 0),
        [*1. Definição do Problema*

          - Vaso de pressão multicamadas
        ],
        width: 6cm,
      ),

      node(
        (0, 1),
        [*2. Parâmetros Iniciais*
          - Geometria
          - Fração volumétrica
          - Condições de contorno
        ],
        width: 5cm,
      ),

      node((-1, 2), [*3a. Modelo Analítico*  Homogeneização Assintótica (MHA)], width: 4.5cm),
      node((1, 2), [*3b. Modelo Numérico*  Elementos Finitos (MEF - FEniCS)], width: 4.5cm),

      node((0, 3), [*4. Verificação*  Comparação (Tensões e Deslocamentos)], width: 5cm),

      node((0, 4), [*5. Análise de Viabilidade*  Resistência ($W_g$) e Rigidez ($K_g$)], width: 6cm),

      // Conexões diretas
      edge((0, 0), (0, 1), "-|>"),

      // Bifurcação para os modelos
      edge((0, 1), (-1, 2), "-|>"),
      edge((0, 1), (1, 2), "-|>"),

      // Junção dos modelos para comparação
      edge((-1, 2), (0, 3), "-|>"),
      edge((1, 2), (0, 3), "-|>"),

      // Conclusão
      edge((0, 3), (0, 4), "-|>"),
    )
  ],
  caption: [Fluxograma geral da metodologia adotada. Fonte: Autor.],
) <fig-fluxograma>

A modelagem numérica de estruturas elásticas microperiódicas com alto contraste de propriedades exige uma transição rigorosa entre as formulações matemáticas contínuas desenvolvidas no Capítulo 3 e a sua representação no domínio discreto. Este capítulo expõe a metodologia prática e o fluxo computacional adotados para a simulação de vasos de pressão cilíndricos multicamadas por meio do Método dos Elementos Finitos (MEF). São detalhados a estratégia de discretização espacial do domínio axissimétrico, a lógica de programação para a geração da microestrutura bimetálica periódica via FEniCS, o equacionamento das condições de contorno de pressão e simetria longitudinal, e o protocolo de cálculo de métricas de eficiência estrutural baseados no código computacional real de projeto implementado no arquivo principal `MHA vs FEM - main - EDITAR APENAS ESSE.py`.

== Discretização e Configuração da Malha <sec:discretizacao_malha>

A precisão de um solucionador de elementos finitos para problemas com heterogeneidades de alta frequência e gradientes de tensão severos é intrinsecamente governada pelas características geométricas do domínio computacional e pelo refinamento espacial da malha de discretização [35]. Esta seção detalha a definição do domínio, a escolha da classe de elementos finitos e o equacionamento para o posicionamento exato dos nós nas interfaces de transição elástica de acordo com a rotina algorítmica real.

=== Geometria do Domínio Computacional Axissimétrico

Conforme discutido na formulação teórica da elasticidade de revolução (Seção 3.4), a invariância circunferencial ($partial_theta = 0$) e a hipótese de deformação plana generalizada reduzem o problema elástico tridimensional (3D) de um cilindro oco para uma seção transversal bidimensional (2D) contida no plano radial-axial $r-z$ [190].

Para manter total consistência físico-matemática e dimensional com o código numérico desenvolvido, o domínio computacional espacial, denotado por $Omega_("rz")$, é representado geometricamente por uma seção retangular plana cujas dimensões de projeto em escala real de simulação são dadas por:

$ Omega_("rz") = { (r, z) in bb(R)^2 : R_("int") <= r <= R_("ext") , quad 0 <= z <= H } $ <eq:dominio_mef>

onde:
- $R_("int") = 9,0 "m"$ representa o raio interno do cilindro cilíndrico de referência;
- $R_("ext") = 11,0 "m"$ representa o raio externo do cilindro;
- A largura do domínio equivale à espessura total da parede do vaso, dada por $t = R_("ext") - R_("int") = 2,0 "m"$;
- A dimensão axial (altura do retângulo de revolução) é fixada em $H = 2,0 "m"$.

Essa escala geométrica em metros é rigorosamente compatível com as unidades das constantes constitutivas elásticas eloficiais (Pascals, $10^9 "Pa"$) e da pressão nominal aplicada ($30 "MPa"$, ou $3,0 times 10^7 "Pa"$) utilizadas no script principal, evitando inconsistências de fator de escala numérico durante a montagem das equações elásticas.

=== Escolha do Elemento Finito (Lagrange de Grau 1)

Na implementação do solucionador no FEniCS, as componentes do vetor de deslocamento $bold(u) = (u_r, u_z)$ e o campo de funções de teste virtuais $bold(v) = (v_r, v_z)$ são interpolados espacialmente utilizando *elementos finitos de Lagrange de grau 1* ($P_1$), configurando um espaço de funções contínuas de Galerkin (`VectorFunctionSpace(mesh, "CG", 1)`) [926, 1249].

A adoção de polinômios lineares, em conjunto com uma malha altamente refinada e estruturada, é uma premissa metodológica fundamental para a simulação elástica eficiente de cilindros concêntricos sob pressão pelas seguintes razões elásticas e computacionais [1249]:

1. *Invariância de Deformação e Tensão por Elemento:* Como a deformação $bold(epsilon)$ depende das derivadas primeiras do campo de deslocamento ($bold(epsilon) = 1/2(bold(nabla) u + bold(nabla)^T u)$), o uso de funções de interpolação lineares ($P_1$) garante que as deformações e as tensões no interior de cada elemento finito individual sejam de classe $C^{-1}$, ou seja, constantes ao longo de cada triângulo [605]. Isso é perfeitamente congruente com a física de meios laminados periódicos (onde o material e as propriedades elásticas também são assumidos como constantes por trecho/elemento), fornecendo degraus de tensões constantes por subcamada elástica sem introduzir suavizações ou gradientes parabólicos espúrios na interface de descontinuidade elástica [1249].
2. *Minimização Drástica do Custo Computacional:* Como o presente estudo conduz simulações com um elevado número de células periódicas (até $N = 200$) e resoluções de malha extremamente refinadas, a adoção de elementos $P_1$ limita significativamente o número total de graus de liberdade globais a serem resolvidos. Isso reduz drasticamente o tempo de CPU e os requisitos de memória RAM, permitindo a execução de varreduras paramétricas e tabelas de erros quase que instantaneamente.
3. *Resolução Radial por Refinamento Dinâmico:* A potencial limitação de menor precisão local de elementos lineares em gradientes acentuados é completamente mitigada pelo emprego de uma altíssima densidade radial de elementos finitos, garantindo que as curvas globais hiperbólicas de deslocamento e tensão sejam perfeitamente discretizadas de forma facetada e suave.

=== Configuração de Alta Discretização e Densidade Radial

A malha do domínio $Omega_("rz")$ é estruturada de forma mapeada, contendo $N_z$ divisões na direção axial e $N_r$ divisões na direção radial, resultando em uma malha de elementos triangulares obtidos pela divisão diagonal do retângulo espacial [926, 927]. Essa discretização ao longo do raio $r$ é governada pela resolução espacial requerida para capturar os degraus microscópicos locais de descontinuidade constitutiva nas subcamadas [927].

No algoritmo implementado no arquivo principal `MHA vs FEM - main.py`, a densidade de elementos radiais respeita de forma exata e proporcional as frações volumétricas elásticas de cada camada, definindo-se no script [927]:
- `V1`: Fração volumétrica do Material 1;

- `V2`: Fração volumétrica do Material 2;

- `N_cel`: Número de células periódicas;

- `resolucao_malha`: Número de elementos radiais por célula periódica;

- `nel_1 = int(V1 * resolucao_malha)`: número de elementos na camada do Material 1 (Aço) por célula periódica [927];

- `nel_2 = int(V2 * resolucao_malha)`: número de elementos na camada do Material 2 (Alumínio) por célula periódica, com $V_2 = 1 - V_1$ [927];

- `nel_celula = nel_1 + nel_2`: número total de elementos radiais contidos em cada período elástico básico (célula unitária) [927].

Dessa forma, o número total de elementos na direção radial ($N_r$, ou `n_elements_r`) e axial ($N_z$, ou `n_elem_z`) são estabelecidos diretamente no gerador `RectangleMesh` por [927]:

$ N_r = N_("cel") times "resolucao_malha" $ <eq:nr_mef_v3>
$ N_z = n_("elem_z") $ <eq:nz_mef_v3>

```python
# Trecho de discretização espacial do domínio de parede do vaso
nel_1 = int(V1 * resolucao_malha)
nel_2 = int(V2 * resolucao_malha)
nel_celula = nel_1 + nel_2
n_elements_r = N_celulas * nel_celula

mesh = RectangleMesh(
    Point(R_int, 0.0), Point(R_ext, H),
    int(n_elements_r), int(n_elem_z)
)
```

Adotando-se a configuração padrão de simulação com $N_{"cel"} = 200$ células periódicas, `resolucao_malha` = 20 e $N_z = 10$, a malha radial totaliza *$N_r = 4.000$ elementos radiais*, gerando uma discretização de $80.000$ elementos triangulares no domínio bidimensional [266, 927]. Essa altíssima densidade radial garante que cada subcamada individual de aço ou alumínio (cuja espessura de período para $N=200$ é de apenas $5,0{ "mm"}$ no aço e $5,0{ "mm"}$ no alumínio) contenha exatamente *10 elementos lineares internos*, permitindo mapear com riqueza de detalhes elásticos as flutuações e tensões microscópicas [63, 831].

=== O Alinhamento dos Nós com as Interfaces Físicas

No Método dos Elementos Finitos, a distribuição das propriedades mecânicas do material (módulo de elasticidade $E$ e coeficiente de Poisson $nu$) é avaliada e integrada numericamente nos pontos de integração Gaussiana localizados no interior de cada elemento finito [59].

Se um elemento finito cruzar espacialmente a fronteira física que divide uma camada de aço de uma camada de alumínio, as propriedades elásticas integradas para aquele elemento sofrerão uma média suave artificial ("borramento" interfacial) [59, 60]. Como consequência física direta, o salto descontínuo abrupto na tensão circunferencial ($sigma_(theta theta)$) e a mudança de inclinação (*kinks*) no deslocamento radial ($u_r$), característicos da interface de contato perfeito bimetálica, seriam suavizados, arruinando completamente a acurácia física e a consistência local da simulação numérica [60, 142].

Para blindar o modelo contra essa perda de precisão, a fronteira de cada subcamada material *deve coincidir estritamente com as bordas dos elementos finitos* [60]. Ou seja, os nós da malha espacial devem estar localizados exatamente sobre as coordenadas radiais das interfaces elásticas [60, 142].

Essa restrição é perfeitamente satisfeita no código real ao impor o arredondamento inteiro de `nel_1` e `nel_2` por célula periódica através da função `int()` em Python [927]. Ao garantir que $n_{"el_cam1"}, n_{"el_cam2"} in bb(N)$, a espessura de cada camada física se torna um múltiplo inteiro exato do tamanho local do elemento ($h_r = t / N_r$) [63, 64]. O gerador de malhas realiza a transição de propriedades de forma abrupta a cada nó interfacial, erradicando por completo oscilações numéricas parasitárias próximas às interfaces (fenômeno de Gibbs elástico) e garantindo a convergência estrita da simulação heterogênea para o limite assintótico homogeneizado do MHA [64, 154].

A simulação numérica de meios altamente heterogêneos e microperiódicos, como o cilindro bimetálico composto por camadas alternadas de aço carbono e liga de alumínio, impõe desafios significativos de modelagem geométrica. À medida que o número de períodos $N_{"cell"}$ aumenta, a espessura de cada subcamada individual encolhe de forma inversamente proporcional, tornando a reconstrução física de cada interface no ambiente de CAD tradicional e o posterior corte da malha (*mesh partitioning*) processos manuais altamente ineficientes, propensos a erros de precisão numérica e impossíveis de serem automatizados de forma paramétrica [47].

Para contornar essa barreira operacional, adota-se neste trabalho a estratégia de *Mapeamento Implícito de Propriedades* via vetor de interfaces discretas. Em vez de discretizar as interfaces físicas na própria malha, o domínio espacial é particionado por uma malha estruturada única e contínua no plano $r z$ (conforme discutido na #inline-note[Ajustar seção discretizacao_malha]/*@sec:discretizacao_malha*/). As propriedades elásticas locais dos materiais de fase (módulo de Young, coeficiente de Poisson e a respectiva matriz constitutiva) são injetadas diretamente nos pontos de integração Gaussiana através de expressões analíticas espaciais periódicas de busca indexada programadas no ambiente FEniCS [562].

=== Formulação Matemática do Mapeamento Periódico

Considere o cilindro de parede espessa definido no intervalo radial $r in [R_{"int"}, R_{"ext"}]$, cuja espessura total de parede é $t = R_{"ext"} - R_{"int"}$. O cilindro é composto por $N_{"cell"}$ células periódicas unitárias (RVEs) [562].

A espessura de uma célula periódica unitária (período $Y$) é calculada a partir do número de células e da espessura total do vaso por [562]:

$ L_c = frac(R_{"ext"} - R_{"int"}, N_{"cell"}) $ <eq:L_c>

Sendo $V_1$ e $V_2 = 1 - V_1$ as frações volumétricas dos Materiais 1 (Aço) e 2 (Alumínio), respectivamente, as espessuras individuais de cada subcamada dentro de uma célula são expressas por [562]:

$ h_1 = V_1 L_c , quad h_2 = V_2 L_c $ <eq:h_camadas>

A partição espacial radial do cilindro é dividida de forma discreta em um vetor de raios interfaciais ${r_k}$, pré-calculado e alinhado de forma exata com as coordenadas de nós correspondentes da malha espacial. Para cada célula periódica $i in {0, 1, dots, N_{"cel"} - 1}$, as posições das interfaces são calculadas algoritmicamente por [562]:

- Interface interna da célula $i$ (Material 1 para Material 2):
  $ r_{(2i+1)} = R_{"int"} + i L_c + h_1 $ <eq:interface_interna>

- Interface de contorno entre a célula $i$ e a célula $i+1$ (Material 2 para o Material 1 da célula subsequente):
  $ r_{(2i+2)} = R_{"int"} + (i + 1) L_c $ <eq:interface_externa>

onde o índice de célula $i$ estende-se até $N_{"cel"} - 2$ para a interface de transição de células, uma vez que a última face externa coincide com o limite do raio externo $R_{"ext"}$ do cilindro [562]. Essa formulação genérica permite simular de forma robusta e rigorosa frações volumétricas quaisquer das fases, sem limitações de simetria geométrica elástica [562].

A função degrau discreta que governa a distribuição espacial do Módulo de Young local $E(r)$ e do Coeficiente de Poisson local $nu(r)$ ao longo da parede do cilindro baseia-se na identificação de qual intervalo de subcamada indexada $k$ contém a coordenada do ponto de integração Gaussiana $r = x[0]$ [25, 562]:

$
  E(r) = cases(
    E_1 "se" k "é par (Aço)",
    E_2 "se" k "é ímpar (Alumínio)"
  )
$ <eq:mapeamento_E_v2>

$
  nu(r) = cases(
    nu_1 "se" k "é par (Aço)",
    nu_2 "se" k "é ímpar (Alumínio)"
  )
$ <eq:mapeamento_nu_v2>

=== Algoritmo de Implementação via `UserExpression` no FEniCS

No ambiente computacional FEniCS, o mapeamento espacial contínuo expresso pelas @eq:mapeamento_E_v2 e @eq:mapeamento_nu_v2 é implementado de forma nativa e extremamente eficiente através de subclasses da classe base `UserExpression` [562]. Esta abordagem baseada em pesquisa indexada permite que as propriedades elásticas sejam avaliadas em tempo real durante o processo de montagem da matriz de rigidez global, eliminando gargalos de memória [35, 562].

A classe customizada desenvolvida para este propósito, denominada `PeriodicProperty`, é estruturada em Python conforme a rotina real de cálculo implementada no script [25, 562]:

```python
class PeriodicProperty(UserExpression):
    def __init__(self, val1, val2, interfaces, **kwargs):
        super().__init__(**kwargs)
        self.val1, self.val2 = val1, val2 # Propriedades elásticas das fases
        self.interfaces = interfaces      # Vetor de coordenadas das interfaces radiais

    def eval(self, values, x):
        idx = 0                           # Inicializa o índice da camada como par
        # Varredura sequencial para localizar a camada correspondente
        for r_int in self.interfaces:
            if x[0] <= r_int:
                break
            idx += 1

        # Atribuição condicional baseada na paridade do índice do segmento
        values[0] = self.val1 if idx % 2 == 0 else self.val2

    def value_shape(self):
        return () # Retorna um escalar (campo de propriedades elásticas)
```

Durante a execução do solver, as instâncias de `PeriodicProperty` são utilizadas para construir os campos escalares do Módulo de Young e do Coeficiente de Poisson no domínio discreto, escrevendo-se [562]:

```python
E_func = PeriodicProperty(E1, E2, interfaces, degree=0)
nu_func = PeriodicProperty(nu1, nu2, interfaces, degree=0)
```

Adota-se o parâmetro `degree=0` (interpolação constante por trecho) para garantir que a propriedade mude de forma abrupta e descontínua exatamente nas coordenadas das interfaces físicas, simulando com fidelidade a transição bimetálica real sem suavizações artificiais indesejadas [35, 562].

=== Transição Sem Costura entre o Modelo Detalhado e o Modelo Homogeneizado (MHA)

A grande elegância metodológica desta arquitetura de programação é a facilidade de transição entre o modelo microscópico detalhado (altamente heterogêneo e oscilatório) e o modelo macroscópico equivalente homogeneizado pelo MHA [47, 562].

No FEniCS, as formas bilinear $a(u,v)$ e linear $L(v)$ são acopladas ao tensor constitutivo de quarta ordem $cal{C}$ [35, 562]. Para alternar as análises mecânicas, o operador computacional simplesmente substitui o argumento de rigidez elástica [562]:

1. *Modelo Detalhado (MEF-D):* O tensor constitutivo local $cal{C}(r)$ é calculado em cada ponto de integração a partir dos campos oscilatórios $E(r)$ e $nu(r)$ fornecidos pela classe `PeriodicProperty`, gerando o comportamento real em zigue-zague dos deslocamentos e as oscilações de tensão [47, 562].
2. *Modelo Homogeneizado (MHA):* O tensor constitutivo é inicializado diretamente como uma matriz ortotrópica constante $hat{cal{C}}$, cujos coeficientes efetivos ($hat{C}_{11}$, $hat{C}_{12}$, $hat{C}_{22}$ e $hat{G}$) são calculados analiticamente através das equações de Backus deduzidas no Capítulo 3 e aplicadas no script [47, 562].

Esta simplicidade operacional e algorítmica demonstra o elevado nível de maturidade computacional da simulação, reduzindo o tempo de preparação do modelo e viabilizando estudos paramétricos de otimização estrutural de vasos de pressão multicamadas [47, 562].

== Propriedades dos Materiais e Cenários de Carga <sec:propriedades_cenarios>

Para a execução das simulações numéricas via Método dos Elementos Finitos (MEF) e a consequente avaliação da precisão do Método de Homogeneização Assintótica (MHA), torna-se indispensável definir com precisão os parâmetros físicos e mecânicos que caracterizam as fases constituintes do cilindro bimetálico. Esta seção detalha as propriedades elásticas, as densidades volumétricas, os limites de escoamento adotados para o aço e o alumínio, bem como justifica a escolha do cenário de carregamento termomecânico imposto ao modelo [47, 48].

=== Propriedades Mecânicas e Físicas das Fases Constituintes

O cilindro periódico analisado é composto pelo par metálico bimetálico formado por aço carbono e liga de alumínio, ambos tratados individualmente como meios homogêneos e isotrópicos em nível de subcamada microestrutural [47]. As propriedades mecânicas de entrada (módulo de Young $E$ e coeficiente de Poisson $nu$), associadas às propriedades físicas de massa específica ($rho$) e resistência mecânica elástica limite ($sigma_y$), são sumarizadas na @tab:propriedades_fases [47, 48]:

#figure(
  caption: [Propriedades elásticas, físicas e limites de resistência das fases constituintes do cilindro bimetálico conforme implementação no script de projeto.],
  table(
    columns: (1.5fr, 1.0fr, 1.2fr, 1.3fr),
    align: (left, center, center, center),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6edf5") } else if calc.even(y) { rgb("f8fafc") } else { none },
    [*Propriedade*], [*Símbolo*], [*Fase 1: Aço*], [*Fase 2: Alumínio*],
    [Módulo de Elasticidade], [$E$], [$200 "GPa"$ ($2,0 times 10^11 "Pa"$)], [$70 "GPa"$ ($7,0 times 10^10 "Pa"$)],

    [Coeficiente de Poisson], [$nu$], [$0,30$], [$0,33$],
    [Densidade Volumétrica], [$rho$], [$7800 "kg/m"^3$], [$2700 "kg/m"^3$],
    [Limite de Escoamento],
    [$sigma_y$],
    [$400,0 "MPa"$ ($4,0 times 10^8 "Pa"$)],
    [$270,0 "MPa"$ ($2,7 times 10^8 "Pa"$)],
  ),
) <tab:propriedades_fases> #margin-note([Isso é um quadro, não uma tabela])

A escolha desses materiais reflete um cenário clássico de alto contraste de rigidez elástica (com a razão de módulos $E_{{"aço"}}/E_{{"alu"}} approx 2,86$), o qual representa o cenário ideal e mais rigoroso para testar os limites do Garfo de Hill elástico e a capacidade do MHA de suavizar as oscilações de alta frequência espacial sem perda de consistência energética [47, 48].

A massa linear $M_{{"lin"}}$ (expressa em kg por metro de comprimento axial do cilindro) é calculada diretamente a partir da área da seção transversal da parede do vaso $A_{{"wall"}} = pi (R_{"ext"}^2 - R_{{"int"}}^2)$ e da densidade média do material [562]. Para os raios de projeto ($R_{{"int"}} = 9,0 "m"$ e $R_{{"ext"}} = 11,0 "m"$), a área do costado resulta em $A_{{"wall"}} approx 125,66 "m"^2$ [562]. A densidade equivalente macroscópica ($hat(rho)$) do compósito com fração volumétrica simétrica ($V_1 = V_2 = 0,5$) é regida estritamente pela regra aditiva simples [47, 562]:

$
  hat(rho) = V_1 rho_{{"aço"}} + V_2 rho_{{"alu"}} = 0,5 (7800) + 0,5 (2700) = 5250 "kg/m"^3
$ <eq:densidade_efetiva>

Resultando em uma massa linear de $659.715 "kg/m"$ para o cilindro bimetálico, o que representa um alívio de peso de exatamente $32,69%$ em comparação a uma estrutura fabricada exclusivamente em aço maciço ($980.148 "kg/m"$), confirmando a elevada eficiência de peso da hibridização de materiais [47, 48].

=== Cenários de Carregamento e Pressão de Projeto

Para submeter o modelo numérico axissimétrico e a formulação analítica do MHA a condições operacionais realistas e severas, estabeleceu-se uma *pressão interna de projeto estável de $30 "MPa"$* ($3,0 times 10^7 "Pa"$) aplicada de forma contínua na fronteira radial interna do cilindro ($r = R_{{"int"}}$) [47, 48, 562].

Esta escolha de carregamento é amplamente fundamentada em aplicações de vasos de pressão modernos na engenharia automotiva e aeroespacial [47]. Conforme ilustrado na literatura técnica e normativa, a faixa de $30$ a $35 "MPa"$ representa a pressão nominal de operação para reservatórios de alta performance Tipo III (que utilizam liner metálico de alumínio ou aço recobertos por enrolamento filamentar composto, CFRP) para o armazenamento seguro de hidrogênio gasoso comprimido ($H_2$) [47, 48].

A imposição deste patamar de solicitação induz um estado de tensões internas elevadas na parede do cilindro de parede grossa ($R_{{"int"}}/t = 4,5$), permitindo-nos avaliar:
1. *O escoamento inicial das fases:* Onde o aço (com escoamento de $400,0 "MPa"$) e o alumínio (escoamento de $270,0 "MPa"$) são testados sob as tensões equivalentes locais de Von Mises calculadas pelo MEF [47];
2. *A precisão microscópica do MHA:* Provando se a solução analítica homogeneizada da modelagem assintótica consegue prever as tensões médias e as deformações globais em regime elástico linear mesmo sob pressões internas severas de $300 "bar"$ ($30 "MPa"$) [47, 48].

As condições de contorno de Neumann de pressão interna foram aplicadas no contorno radial interno $Gamma_{{"int"}}$ por meio da forma linear de trabalho virtual descrita na Seção 3.4, garantindo a perfeita integração espacial ponderada pelo raio $r$ exigida pelo FEniCS [48, 562].
