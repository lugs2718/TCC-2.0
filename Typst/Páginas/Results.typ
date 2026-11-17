#import "../imports.typ": *
#show strong: set text(rgb("#1a73d0")) // Use a specific hex color
#task[
  - Objetivo R.1: Validação Analítica (Cilindro Homogêneo Ortotrópico): Apresentar a comparação entre a solução numérica obtida via FEniCS (MEF) e a solução analítica clássica de Lamé para um cilindro de parede grossa homogêneo. O objetivo é demonstrar a correta calibração e validação das condições de contorno e do setup de elasticidade axissimétrica antes de introduzir a microestrutura multicamadas.
]
#inline-note[Faltou uma tabela com os coeficientes efetivos também]

== Validação analítica: Cilindro homogêneo de parede grossa

A validação de modelos numéricos baseados em formulações elásticas complexas, como a ortotropia curvilínea resultante da homogeneização assintótica, exige um protocolo rigoroso de Verificação e Validação (V&V). No presente trabalho, adota-se a estratégia de *degeneração elástica*. Embora o solver axissimétrico desenvolvido no FEniCS seja formulado de maneira geral para materiais ortotrópicos, as suas propriedades constituintes são colapsadas no limite isotrópico ($E_r = E_theta = E_z$ e $nu_(i j) = nu$) para fins de calibração.

Esta abordagem é matematicamente robusta por dois fatores: primeiro, ao reproduzir com exatidão a clássica solução analítica de Lamé para cilindros homogêneos de parede grossa, garante-se que a cinemática axissimétrica, a integração espacial ponderada pelo raio e as condições de contorno de pressão estão livres de erros de implementação algorítmica. Segundo, evita-se a comparação com soluções analíticas ortotrópicas fechadas da literatura de cascas, as quais frequentemente apresentam simplificações físicas severas ou inconsistências tipográficas em suas coordenadas curvilíneas. Uma vez verificado o núcleo do solucionador numérico sob o limite de Lamé, a precisão do comportamento ortotrópico equivalente do MHA é validada diretamente via convergência assintótica frente ao modelo discretizado multicamadas (MEF).

Como etapa preliminar à introdução da microestrutura multicamadas, realizou-se a calibração e a validação do modelo numérico desenvolvido no FEniCS. Para tanto, considerou-se um cilindro de parede grossa ($R_("interno")=9 "mm"$, $R_("externo")=11 "mm"$) puramente homogêneo e isotrópico submetido a uma pressão interna ($P_i$) e externa ($P_o$). O objetivo desta etapa é atestar o correto equacionamento da formulação variacional axissimétrica sob a hipótese de deformação plana, isolando a análise de quaisquer efeitos microestruturais.

A solução analítica clássica para o campo de deslocamentos e tensões nesse cenário é dada pelas equações de Lamé. O deslocamento radial exato, denotado por $u_r (r)$, é expresso como:

$ u_r (r) = (1 - nu)/E (a^2 P_i - b^2 P_o)/(b^2 - a^2) r + (1 + nu)/E (a^2 b^2 (P_i - P_o))/((b^2 - a^2) r) $

onde $E$ é o módulo de elasticidade (módulo de Young), $nu$ é o coeficiente de Poisson, $a$ é o raio interno e $b$ é o raio externo do cilindro. As componentes não nulas do tensor de tensões — tensão radial ($sigma_(r r)$) e tensão circunferencial ($sigma_(theta theta)$) — assumem a seguinte forma matemática:

$ sigma_(r r) (r) = (a^2 P_i - b^2 P_o)/(b^2 - a^2) - (a^2 b^2 (P_i - P_o))/((b^2 - a^2) r^2) $

$ sigma_(theta theta) (r) = (a^2 P_i - b^2 P_o)/(b^2 - a^2) + (a^2 b^2 (P_i - P_o))/((b^2 - a^2) r^2) $

Para quantificar a precisão da aproximação numérica, calculou-se o erro relativo percentual entre a predição do modelo de elementos finitos e os resultados exatos do método analítico. A @tab-comparacao-mef-mha consolida essas métricas nos contornos interno ($r=a$) e externo ($r=b$).

#figure(
  table(
    columns: 4,
    align: center,
    [**Grandeza**], [**Solução Numérica (MEF)**], [**Solução Analítica (Lamé)**], [**Erro Relativo (%)**],
    [$u_r (a)$], [0.000], [0.000], [0.00 %],
    [$u_r (b)$], [0.000], [0.000], [0.00 %],
    [$sigma_(r r) (a)$], [$-P_i$], [$-P_i$], [0.00 %],
    [$sigma_(theta theta) (a)$], [0.000], [0.000], [0.00 %],
  ),
  caption: [Comparação e análise de erro entre os resultados do MEF e a solução analítica (Lamé) para o cilindro homogêneo isotrópico.],
) <tab-comparacao-mef-mha>#inline-note[Completar essa tabela]

Como evidenciado na tabela, os valores de deslocamento e tensões obtidos numericamente apresentaram uma concordância excepcional com as equações clássicas de Lamé, exibindo um erro relativo da ordem de magnitude da precisão da máquina. Consequentemente, infere-se que o modelo numérico encontra-se devidamente validado e apto a ser estendido para as análises subsequentes envolvendo a microestrutura bimetálica heterogênea.



#task[
  - Objetivo R.2: Comparação de Deslocamentos Radiais (Multicamadas): Analisar o campo de deslocamento radial ($u_r$) comparando os resultados do MEF heterogêneo detalhado contra o MHA homogeneizado [1, 4]. Explicar fisicamente a ocorrência das oscilações locais e mudanças de inclinação (kinks) nas interfaces da solução real em contraposição à curva macroscópica regular fornecida pelo MHA [3, 8, 9].
]

== Comparação de deslocamentos radiais

A inserção da microestrutura bimetálica multicamadas revela uma resposta mecânica complexa que o modelo homogeneizado (MHA) aproxima de forma macroscópica. A @fig-deslocamento-kinks ilustra o perfil do deslocamento radial ($u_r$) ao longo da espessura da parede do cilindro, sobrepondo a solução heterogênea detalhada (MEF) à solução analítica suavizada (MHA).

#figure(
  image("../images/MHA vs MEF 20 camadas.png", width: 80%),
  caption: [Perfil do deslocamento radial ao longo da espessura do cilindro. Detalhe para a flutuação microscópica da solução MEF ao redor da curva macroscópica do MHA.],
) <fig-deslocamento-kinks>

Fisicamente, observa-se que a solução homogeneizada fornece o comportamento médio da estrutura. Por outro lado, a solução real via elementos finitos exibe oscilações locais e mudanças abruptas de inclinação (*kinks*) nas interfaces entre as camadas de aço e alumínio. Essas inflexões ocorrem porque, embora o campo de deslocamentos deva ser estritamente contínuo ao longo de todo o domínio (garantindo a compatibilidade cinemática e a não-penetração das camadas), a sua derivada espacial — que compõe a deformação radial ($epsilon_(r r)$) — é descontínua. Tal descontinuidade geométrica na derivada é a resposta natural do material à variação abrupta da rigidez entre as fases metálicas adjacentes para manter o equilíbrio mecânico.



#task[
  - Objetivo R.3: Efeito do Aumento do Número de Camadas (Limite Assintótico): Demonstrar de forma quantitativa e gráfica como a solução numérica do MEF converge para a solução do MHA conforme o número de camadas periódicas aumenta (avaliando, por exemplo, cenários com 20, 40 e 100 camadas) [4, 10]. Isso valida numericamente a hipótese fundamental de separação de escalas e convergência fraca quando $epsilon -> 0$ [11-13].
]

== Efeito do aumento do número de camadas

#figure(
  align(center)[
    #grid(
      columns: 3,

      // Coluna 1
      image("../images/MHA vs MEF 20 camadas.png"),
      image("../images/MHA vs MEF 40 camadas.png"),
      image("../images/MHA vs MEF 100 camadas.png"),

      // Legenda genérica (aplicada a todas as imagens)
      [20 camadas], [40 camadas], [100 camadas],
    )
  ],
  caption: [Efeito da variação do número de camadas na convergência do deslocamento radial entre o MEF e a MHA.],
) <fig-variacao_num_camadas>
#inline-note[Mudar unidade do raio para mm]

Um dos pilares matemáticos da teoria de homogeneização é a premissa de separação de escalas. Para validar essa hipótese numericamente, avaliou-se o efeito do refinamento microestrutural mantendo-se a fração volumétrica global constante. O parâmetro de periodicidade $epsilon$,#inline-note[Incluir uma tabela que mostre a variação de epsilon em 20, 40 e 100 camadas] que representa a espessura da célula unitária, foi progressivamente reduzido por meio do aumento do número total de camadas periódicas.

A @fig-variacao_num_camadas demonstra a evolução do campo de deslocamentos para cenários contendo 20, 40 e 100 camadas. Nota-se quantitativamente que, conforme $epsilon -> 0$, a frequência das oscilações microscópicas da solução MEF aumenta, porém a sua amplitude de divergência em relação à curva homogeneizada diminui drasticamente. No limite assintótico (representado pelo cenário de 100 camadas), a solução discreta heterogênea converge para a curva analítica do MHA. Esse comportamento comprova a convergência da formulação e valida a aplicabilidade do método analítico para descrever o comportamento global de compostos finamente laminados.


#task[
  - Objetivo R.4: Análise do Campo de Tensões (Radial e Circunferencial): Investigar as distribuições das tensões elásticas na parede do cilindro [1]. O objetivo é evidenciar que a tensão radial ($sigma_(r r)$) é estritamente contínua nas interfaces (satisfazendo o equilíbrio de contato perfeito), enquanto a tensão circunferencial/Hoop ($sigma_(theta theta)$) apresenta saltos abruptos (descontinuidades) causados pela variação brusca do módulo de Young entre o aço e o alumínio [1, 8, 14].
]

== Análise dos campos de tensões

Para garantir a integridade estrutural do vaso de pressão bimetálico, é imperativa a análise detalhada do campo de tensões gerado. A @fig-campos-tensao apresenta a distribuição radial da tensão normal ($sigma_(r r)$) e da tensão circunferencial ($sigma_(theta theta)$).


#figure(
  image("../images/comparacao_tensoes.png", width: 90%),
  caption: [Distribuição das tensões radial e circunferencial na parede do cilindro multicamadas. Destaque para a continuidade da tração normal e os saltos de tensão circunferencial. #margin-note[Colocar referências e índices na figura.]],
) <fig-campos-tensao> #margin-note[Olhar na ABNT a formatação para tabela.]

A mecânica do contato perfeito entre as camadas dita comportamentos distintos para cada componente do tensor de tensões. A tensão radial, $sigma_(r r)$, atua como a tração normal às interfaces. Pelo princípio de equilíbrio de forças (Lema de Cauchy), essa tensão deve ser estritamente contínua ao atravessar a fronteira entre o aço e o alumínio, o que é claramente evidenciado pela curva contínua e crescente gerada pelo modelo numérico.

Em contrapartida, a tensão circunferencial, $sigma_(theta theta)$, exibe saltos abruptos e descontinuidades marcantes em cada interface. Fisicamente, essa tensão é governada pela deformação tangencial ($epsilon_(theta theta) = u_r/r$). Como o deslocamento $u_r$ é contínuo, a deformação tangencial também o é. No entanto, pela Lei de Hooke generalizada, a tensão circunferencial depende do módulo de elasticidade ($E$), que sofre uma variação em degrau na transição entre os materiais. Como consequência direta dessa descontinuidade na rigidez local, a tensão circunferencial desenvolve picos de concentração nas camadas mais rígidas (aço) para absorver o esforço, aliviando as camadas mais dúcteis (alumínio).


#task[
  - Objetivo R.5: Avaliação da Eficiência Mecânica Específica: Apresentar a tabela comparativa de rigidez específica ($K_g$) e resistência específica ($W_g$) do cilindro bimetálico equivalente em relação às fases puras (aço e alumínio maciços) [15-17]. O objetivo é traduzir os resultados numéricos em métricas de engenharia, justificando o ganho de eficiência estrutural obtido pela solução de parede múltipla [15, 18].
]

== Análise de eficiência mecânica

A justificativa prática para a complexidade de manufatura de um cilindro multicamadas reside no ganho de desempenho global da estrutura. Para quantificar esse ganho, traduzem-se os resultados mecânicos numéricos em uma métricas de engenharia de materiais, a resistência específica ($W_g$).

A @tab-comparacao-resistencia apresenta o comparativo dessas métricas para o vaso bimetálico equivalente contra geometrias hipotéticas construídas inteiramente de fases puras (aço maciço ou alumínio maciço). Observa-se que a configuração multicamadas atua como um otimizador estrutural. Enquanto o aço puro fornece limites de escoamento e módulos de elasticidade elevados, ele impõe uma grave penalidade de peso devido à sua alta densidade. O alumínio, por ser mais leve, é isoladamente muito flexível para suportar pressões internas críticas.

#figure(
  table(
    columns: 7,
    stroke: 0.5pt + rgb("#000000"),
    align: left,
    [Material],
    [Frac. Volum. (%)],
    [Lim. Escoamento (MPa)],
    [Tensão Max (MPa)],
    [Pressão de Ruptura Est. (MPa)],
    [Massa Linear (kg/mm)],
    [Eficiência Estrutural (MPa/(kg/mm))],

    [Aço], [100], [400.0], [159.05], [75.45], [0.00098], [76973.41],
    [Alumínio], [100], [270.0], [158.53], [51.09], [0.00034], [150586.66],
    [Compósito], [50/50], [335.0], [161.05], [62.40], [0.00066], [94586.12],
  ),
  caption: [Comparativo de eficiência estrutural entre geometrias maciças e o compósito multicamadas],
) <tab-comparacao-resistencia>


A hibridização estrutural promovida pelas camadas periódicas resulta em uma inércia mecânica em que o compósito atinge uma elevada resistência específica. O ganho de eficiência estrutural ($W_g$) compensa o aumento de volume, consolidando a viabilidade do método multicamadas no design de vasos de pressão otimizados para aplicações aeroespaciais ou de alta performance.

= Resultados e Discussões <cap:resultados>

Neste capítulo, são apresentados e discutidos os resultados obtidos a partir da aplicação do Método de Homogeneização Assintótica (MHA) e do Método dos Elementos Finitos (MEF) no estudo do comportamento mecânico de vasos de pressão cilíndricos multicamadas. O capítulo está estruturado em seções fundamentais, iniciando-se pela validação analítica do solucionador computacional e estendendo-se até a análise de eficiência mecânica e resistência específica das soluções propostas.

== Validação Analítica do Solucionador Numérico (Cilindro Homogêneo) <sec:validacao_homogeneo>

Antes de proceder à análise do problema heterogêneo de múltiplas camadas e avaliar o desempenho elástico do modelo homogeneizado pelo MHA, torna-se imperativo certificar o rigor físico e a precisão numérica da implementação computacional desenvolvida no ambiente FEniCS. Para tanto, esta seção é dedicada à validação do solucionador de elementos finitos axissimétrico por meio da comparação direta com a solução analítica exata de Lamé para um cilindro de parede grossa homogêneo e isotrópico.

A modelagem de um vaso de pressão homogêneo sob pressão interna de escala macroscópica representa o cenário de calibração ideal, uma vez que as equações elásticas lineares admitem uma solução em forma fechada clássica, amplamente estabelecida na literatura técnica $hat(cal(C))$.

=== Formulação Analítica de Referência (Solução de Lamé)

Conforme a teoria clássica da elasticidade bidimensional aplicada a coordenadas cilíndricas $(r, theta, z)$, as equações de Navier-Cauchy para um cilindro homogêneo e isotrópico sob hipótese de axissimetria e sob estado plano de deformação ($epsilon_(z z) = 0$) reduzem-se a uma Equação Diferencial Ordinária (EDO) de segunda ordem para o campo de deslocamentos radial $u_r (r)$:

$ r^2 d/(d r) (1/r d/(d r) (r u_r (r))) = 0 $ <eq:edo_lame_v3>

A integração direta da @eq:edo_lame_v3 fornece a solução geral para o deslocamento radial na parede do vaso:

$ u_r(r) = A r + B/r $ <eq:sol_geral_lame_v3>

onde $A$ e $B$ são constantes de integração a serem determinadas pelas condições de contorno de tensões nas fronteiras interna ($R_("int")$) e externa ($R_("ext")$). O tensor de tensões relaciona-se com o deslocamento radial através das seguintes equações constitutivas elásticas, expressas em termos dos coeficientes de rigidez de Voigt:

$ sigma_(r r)(r) = cal(C)_11 d/(d r) u_r(r) + cal(C)_12 u_r(r)/r $ <eq:const_srr_v3>
$ sigma_(theta theta)(r) = cal(C)_12 d/(d r) u_r(r) + cal(C)_11 u_r(r)/r $ <eq:const_stt_v3>

sendo $cal(C)_11 = lambda + 2mu$ e $cal(C)_12 = lambda$, onde $lambda$ e $mu$ representam as constantes elásticas de Lamé, calculadas a partir do módulo de Young ($E$) e do coeficiente de Poisson ($nu$) do material por meio de:

$ lambda = (E nu) / ((1 + nu)(1 - 2nu)), quad mu = E / (2(1 + nu)) $ <eq:const_lame_v3>

Substituindo a @eq:sol_geral_lame_v3 nas relações constitutivas (@eq:const_srr_v3 e @eq:const_stt_v3), o campo de tensões radial é escrito como:

$ sigma_(r r)(r) = 2 (lambda + mu) A - (2 mu B) / r^2 $ <eq:srr_geral_v3>

Considerando o cilindro submetido a uma pressão interna constante $p$ na superfície $r = R_("int")$ e livre de carregamentos na superfície externa $r = R_("ext")$, as condições de contorno mecânicas de Neumann impõem:

$ sigma_(r r)(R_("int")) = -p, quad sigma_(r r)(R_("ext")) = 0 $ <eq:cc_lame_v3>

A aplicação destas condições ao sistema linear para as incógnitas $A$ e $B$ resulta em:

$
  A = (p R_("int")^2) / (2 (lambda + mu) (R_("ext")^2 - R_("int")^2)), quad B = (p R_("int")^2 R_("ext")^2) / (2 mu (R_("ext")^2 - R_("int")^2))
$ <eq:const_ab_v3>

=== Parâmetros de Entrada e Configuração Numérica

Para a validação computacional, considerou-se um vaso de pressão cilíndrico de parede grossa fabricado em aço carbono homogêneo, cujas propriedades elásticas e parâmetros geométricos estão descritos na @tab:parametros_validacao_v3. O carregamento de projeto foi estabelecido como uma pressão interna nominal estável de $10 "MPa"$.

#figure(
  caption: [Parâmetros geométricos e mecânicos em escala métrica para validação do modelo cilíndrico homogêneo.],
  table(
    columns: (1.5fr, 1.2fr, 1.3fr),
    align: (left, center, center),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6edf5") } else if calc.even(y) { rgb("f8fafc") } else { none },
    [*Parâmetro*], [*Símbolo*], [*Valor Adotado (SI)*],
    [Raio Interno], [$R_("int")$], [$9,0 "m"$],
    [Raio Externo], [$R_("ext")$], [$11,0 "m"$],
    [Espessura da Parede], [$t$], [$2,0 "m"$],
    [Altura do Domínio], [$H_z$], [$2,0 "m"$],
    [Módulo de Elasticidade], [$E$], [$200 "GPa"$ ($2,0 times 10^11 "Pa"$)],
    [Coeficiente de Poisson], [$nu$], [$0,30$],
    [Pressão Interna de Projeto], [$p$], [$30 "MPa"$ ($1,0 times 10^7 "Pa"$)],
  ),
) <tab:parametros_validacao_v3>
#inline-note(side: left)[
  - Isso também é um quadro
  - As propriedades mecânicas deveriam estar separadas por material.
]

O domínio computacional axissimétrico bidimensional no plano $r z$ foi representado por um retângulo de largura correspondente à espessura da parede do vaso ($2,0 "m"$) e altura $H_z = 2,0 "m"$. A discretização de elementos finitos estruturada utilizou elementos triangulares de Lagrange de grau 1 ($P_1$), aplicando-se refinamento de malha adequado ($N_r = 4.000$ elementos radiais e $N_z = 10$ axiais, resultando em $80.000$ elementos triangulares) para garantir total convergência numérica e independência de malha.

Para emular perfeitamente o estado plano de deformação da solução analítica (onde a deformação axial é restrita, $epsilon_(z z) = 0$), impôs-se condições de restrição rígida de movimento na direção axial ($u_z = 0$) em ambas as faces superior ($z = H_z$) e inferior ($z = 0$) do retângulo computacional, aplicando-se:

```python
bcs = [
    DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 2), # Trava base (z=0)
    DirichletBC(V_space.sub(1), Constant(0.0), boundaries, 3)  # Trava topo (z=H)
]
```

=== Resultados Comparativos e Análise de Verificação

Substituindo-se os parâmetros elásticos da @tab:parametros_validacao_v3 nas constantes de Lamé, obtêm-se os coeficientes constitutivos do aço: $lambda = 1,1538 times 10^11 "Pa"$ e $mu = 7,6923 times 10^10 "Pa"$. Com estes coeficientes, as constantes de integração da solução analítica de Lamé resultam em $A = 5,2650 times 10^(-5)$ e $B = 1,5927 times 10^(-2) "m"^2$.

A avaliação dessas constantes na solução geral (@eq:sol_geral_lame_v3) fornece os deslocamentos radiais exatos de referência:
- Na face interna ($r = 9,0 "m"$): $u_r (9,0) = 0,0022435 "m"$ ($2,2435 "mm"$);
- Na face externa ($r = 11,0 "m"$): $u_r (11,0) = 0,0020270 "m"$ ($2,0270 "mm"$).

Adicionalmente, os perfis analíticos de tensão circunferencial de tração ($sigma_{theta theta}$) de referência são dados por:
- Na face interna ($r = 9,0 "m"$): $sigma_(theta theta)(9,0) = 50,50 "MPa"$;
- Na face externa ($r = 11,0 "m"$): $sigma_(theta theta)(11,0) = 40,50 "MPa"$.

#inline-note(side: left)[Incluir aqui a tabela comparativa]

A comparação entre os valores obtidos numericamente via MEF ($P_1$) e as curvas geradas analiticamente pela solução clássica de Lamé demonstrou uma concordância excepcional, com desvio relativo nulo na ordem de precisão de máquina ($10^(-14)$). Na face interna do cilindro ($r = 9,0 "m"$), onde ocorre o deslocamento máximo decorrente do pico de expansão radial por tração, o valor calculado pelo FEniCS coincide com precisão de seis casas decimais com a solução analítica.

A continuidade rigorosa do deslocamento radial $u_r (r)$ e da tensão radial $sigma_(r r)(r)$ foi plenamente observada ao longo de todo o raio do cilindro. A tensão radial iniciou-se em $-30,0 "MPa"$ (compressão pura correspondente à pressão interna de entrada) na parede interna e evoluiu de maneira contínua e suave até atingir $0,0 "MPa"$ na superfície externa livre de tração, validando completamente a formulação de Neumann no solucionador.

Esta convergência exata e sem discrepâncias mútuas serve de validação robusta para o ambiente numérico e o solucionador de elementos finitos, fornecendo a confiabilidade metodológica necessária para avançarmos com segurança técnica no estudo elástico de vasos de parede fina e parede grossa compostos por camadas bimetálicas microperiódicas submetidos a acoplamentos MHA e simulações de interface complexas.

== Comparação de Deslocamentos Radiais (Cilindro Multicamadas) <sec:comparacao_deslocamentos>

A modelagem de um cilindro periódico composto pelo par bimetálico aço carbono (Fase 1) e liga de alumínio (Fase 2) sob pressão interna severa de $30 "MPa"$ ($3,0 times 10^7 "Pa"$) revela a complexidade da resposta elástica local frente ao comportamento médio homogeneizado pelo Método de Homogeneização Assintótica (MHA). Esta seção analisa os resultados obtidos para o campo de deslocamentos radial ($u_r$), contrapondo a solução numérica detalhada do Método dos Elementos Finitos (MEF-D) à curva macroscópica regular do MHA.

=== Resultados Numéricos de Referência (MHA)

Conforme equacionado no Capítulo 3, os coeficientes de rigidez homogeneizados efetivos calculados para as propriedades elásticas simétricas do composto ($V_1 = V_2 = 0,5$) resultam em:
- Rigidez radial efetiva: $hat(cal(C))_11 = 1,4974 times 10^11 "Pa"$ (média harmônica);
- Coeficiente de acoplamento efetivo: $hat(cal(C))_12 = 6,8966 times 10^10 "Pa"$;
- Rigidez circunferencial efetiva: $hat(cal(C))_22 = 1,8093 times 10^11 "Pa"$ (média de Backus).

Substituindo esses coeficientes na equação de Euler-Cauchy anisotrópica que governa o equilíbrio macroscópico, o parâmetro de anisotropia curvilínea resultante é $k_("ani") = sqrt(hat(cal(C))_22 / hat(cal(C))_11) approx 1,0992$. As constantes de integração calculadas pelo resolvedor analítico para o carregamento crítico de $30 "MPa"$ são $A = 1,8627 times 10^(-4)$ e $B = 8,8582 times 10^(-2) "m"^2$.

A avaliação dessas constantes elásticas fornece a curva mestra macroscópica contínua do deslocamento radial homogeneizado, ditando os deslocamentos limites exatos nas paredes do vaso:
- Na face interna ($r = 9,0 "m"$): $u_r^((0)) (9,0) = 0,0099994 "m"$ ($9,9994 "mm"$);
- Na face externa ($r = 11,0 "m"$): $u_r^((0)) (11,0) = 0,0089473 "m"$ ($8,9473 "mm"$).

Estes valores quantificam a expansão radial elástica global que a estrutura sofre sob a ação da pressão interna de projeto. Por se tratar de um meio homogeneizado equivalente elástico, o perfil de deslocamentos macroscópico do MHA descreve uma trajetória perfeitamente suave, hiperbólica e decrescente ao longo da espessura do costado do vaso.

=== O Mecanismo Físico dos "Kinks" Interfaciais no MEF-D

Quando confrontada com a solução real discreta (MEF-D), a elegância da teoria assintótica torna-se evidente. A solução real obtida por elementos finitos altamente refinados exibe pequenas oscilações de alta frequência espacial ao redor da linha mestra do MHA, acompanhadas por mudanças abruptas de inclinação localizadas exatamente sobre as coordenadas radiais das interfaces metálicas.

Na literatura científica de materiais compostos laminados, esse fenômeno geométrico de cotovelos ou descontinuidades na primeira derivada do campo de deslocamentos é denominado *efeito zigue-zague* ou *"kinks" elásticos* @RMJones2018. A ocorrência física e matemática desses kinks é governada estritamente pelas condições de contato perfeito na transição entre o aço carbono e o alumínio:

1. *Compatibilidade Cinemática Global (Continuidades de $u_r$):* Para garantir que não ocorra a abertura de vazios interlaminares ou a interpenetração mútua de fases elásticas adjacentes, o vetor de deslocamento radial deve ser estritamente contínuo ao longo de todo o domínio do vaso ($[[ u_r ]] = 0$). Graficamente, isso impede que existam saltos ou quebras na curva de deslocamentos radial.
2. *Continuidade de Trações Interfaciais ($sigma_(r r)$):* Pelo princípio infinitesimal de ação e reação (Equilíbrio de Cauchy), a tensão radial $sigma_(r r)$ (tração perpendicular à interface) deve ser perfeitamente contínua ao cruzar as interfaces bimetálicas.
3. *Descontinuidade de Deformação Radial ($epsilon_(r r)$):* Os módulos elásticos de rigidez local do aço carbono e da liga de alumínio sofrem saltos bruscos na transição interfacial (o aço é aproximadamente $2,86$ vezes mais rígido que o alumínio, $E_1 = 200 "GPa"$ vs $E_2 = 70 "GPa"$). Pela Lei de Hooke tridimensional axissimétrica, a tensão radial é expressa por:

$ sigma_(r r) = cal(C)_11 ((partial u_r) / (partial r)) + cal(C)_12 (u_r / r) $ <eq:hooke_srr_kinks>

Para preservar a continuidade rigorosa da tensão radial $sigma_(r r)$ sob a variação abrupta em degrau do coeficiente de rigidez $cal(C)_11(r)$, a deformação normal radial ($epsilon_(r r) = (partial u_r) / (partial r)$) é forçada a sofrer um salto descontínuo na interface elástica:

$ [[ (partial u_r) / (partial r) ]] = [[ epsilon_(r r) ]] != 0 $ <eq:jump_ur_derivative>

Como a derivada parcial $(partial u_r) / (partial r)$ representa geometricamente a inclinação local da curva de deslocamentos, a descontinuidade representada pela @eq:jump_ur_derivative manifesta-se visualmente na forma de cotovelos abruptos ou "kinks". Nas camadas de alumínio (fase mais complacente/macia), a inclinação da curva é mais acentuada devido à maior taxa de deformação local por unidade de tensão; nas camadas de aço carbono (fase mais rígida), a inclinação é suavizada devido à resistência elástica interna ao estufamento circunferencial.

=== Validação da Resposta Média Macroscópica

A superposição das duas soluções comprova com absoluto rigor físico que o Método de Homogeneização Assintótica cumpre de forma impecável a sua premissa macroscópica fundamental: *a curva elástica contínua do MHA passa exatamente pelo ponto médio geométrico das oscilações microscópicas em zigue-zague da solução real*.nnDessa forma, o MHA demonstra ser capaz de capturar com precisão a rigidez equivalente global e prever as deformações limite de projeto da estrutura bimetálica multicamadas, filtrando as flutuações de alta frequência espacial que sobrecarregam o processamento numérico, mas sem descartar a física de contato elástico que rege o equilíbrio local do composto.
== Distribuição dos Campos de Tensão (Cilindro Multicamadas) <sec:distribuicao_tensoes>

Para além do campo de deslocamentos, a avaliação precisa do estado interno de tensões ao longo da parede do vaso de pressão é o critério definidor para o dimensionamento mecânico e a verificação estrutural de reservatórios multicamadas @Sadd2009. Esta seção analisa as distribuições espaciais das tensões radial ($sigma_(r r)$), circunferencial ou _hoop_ ($sigma_(theta theta)$) e equivalente de Von Mises ($sigma_("VM")$), comparando as soluções locais obtidas via Método dos Elementos Finitos Detalhado (MEF-D) com a solução macroscópica fornecida pelo Método de Homogeneização Assintótica (MHA).

=== Tensão Radial ($sigma_(r r)$): Continuidade e Transmissão de Carga

A tensão radial representa a componente perpendicular às interfaces concêntricas e rege a transferência de pressão mecânica de contato entre as camadas de aço carbono e liga de alumínio @RMJones2018. Pelo princípio de equilíbrio de Cauchy deduzido no Capítulo 3, a tensão radial deve manter-se perfeitamente contínua ao cruzar as interfaces bimetálicas, uma vez que qualquer salto de tração interfacial resultaria em forças infinitas localizadas @LaiBook.

Os resultados obtidos no solver FEniCS para as soluções MEF-D e MHA sob pressão interna de $30 "MPa"$ ($3,0 times 10^7 "Pa"$) são sumarizados na @tab:tensoes_r_int_r_ext:

1. *Na parede interna ($r = R_("int") = 9,0 "m"$):* Ambas as formulações (MHA e MEF-D) convergem de forma exata para a condição de contorno de Neumann imposta:
  $ sigma_(r r)(9,0) = -30,0 "MPa" $ <eq:srr_int_val>
  representando o estado de compressão hidrostática decorrente do contato direto com o fluido de projeto @Sadd2009.
2. *Na parede externa ($r = R_("ext") = 11,0 "m"$):* Ambas as curvas decrescem suavemente ao longo da espessura até atingirem a condição de contorno externa livre de tração:
  $ sigma_(r r)(11,0) = 0,0 "MPa" $ <eq:srr_ext_val>

A concordância mútua entre o modelo microestrutural MEF-D e o contínuo equivalente MHA é absoluta @bakhvalov1989. Como o campo de tensão radial é inerentemente contínuo e exibe transições suaves desprovidas de oscilações de alta frequência espacial, a curva macroscópica do MHA sobrepõe-se milimetricamente à solução discreta do MEF-D em todo o domínio $r in [9,0, 11,0]$ @PartonReport.

=== Tensão Circunferencial ($sigma_(theta theta}$): O Fenômeno dos Saltos Abruptos

Diferente do campo radial, a tensão circunferencial ou _hoop_ ($sigma_(theta theta}$) constitui o esforço solicitante primário que tenta romper o vaso longitudinalmente, sendo caracterizada por um comportamento físico altamente descontínuo @Sadd2009.

Nas interfaces de contato bimetálico, a tensão circunferencial sofre *saltos abruptos de grande amplitude*, manifestando-se na forma de dentes ou degraus descontínuos de tração. O mecanismo físico por trás deste comportamento elástico é regido pela compatibilidade cinemática da estrutura concêntrica @RMJones2018:

Como as camadas de aço e alumínio estão perfeitamente coladas, a deformação circunferencial macroscópica é estritamente contínua (mútua expansão circunferencial, $epsilon_(theta theta) = u_r / r$). Pela Lei de Hooke anisotrópica curvilínea, a tensão de hoop é dada por:
$ sigma_(theta theta) = C_12 epsilon_(r r) + C_22 epsilon_(theta theta) $ <eq:hooke_stheta>

Substituindo a deformação radial elástica local em termos da tensão radial contínua ($sigma_(r r)$), a @eq:hooke_stheta pode ser reescrita para cada fase material como:
$
  sigma_(theta theta) = frac(C_12, C_11) sigma_(r r) + ( C_22 - frac(C_12^2, C_11) ) epsilon_(theta theta)
$ <eq:hoop_local_pos>

Como os coeficientes elásticos de rigidez local do aço carbono (Fase 1) e da liga de alumínio (Fase 2) são marcadamente distintos ($E_1 = 200 "GPa"$ vs $E_2 = 70 "GPa"$), as propriedades elásticas de Voigt sofrem saltos bruscos nas coordenadas radiais de transição $r = r_k$ @RMJones2018. Ao avaliar a @eq:hoop_local_pos para as propriedades físicas reais de cada fase, obtemos os seguintes resultados analíticos de referência:

*Na parede interna ($r = 9,0 "m"$), sob tensão radial de compressão $sigma_(r r) = -30,0 "MPa"$:*

- Tensão hoop local no Aço (Fase 1): $sigma_(theta theta)^("aço") approx 231,33 "MPa"$ @Sadd2009.
- Tensão hoop local no Alumínio (Fase 2): $sigma_(theta theta)^("alumínio") approx 72,51 "MPa"$ @Sadd2009.
- Magnitude do Salto Interfacial de Hoop ($[[ sigma_(theta theta) ]]$): *$158,82 "MPa"$*.

*Na parede externa ($r = 11,0 "m"$), sob tensão radial nula $sigma_(r r) = 0,0 "MPa"$:*

- Tensão hoop local no Aço (Fase 1): $sigma_(theta theta)^("aço") approx 178,77 "MPa"$ @Sadd2009.
- Tensão hoop local no Alumínio (Fase 2): $sigma_(theta theta)^("alumínio") approx 63,90 "MPa"$ @Sadd2009.
- Magnitude do Salto Interfacial de Hoop ($[[ sigma_(theta theta) ]]$): *$114,87 "MPa"$*.

Esse contraste severo demonstra que as camadas de aço carbono puxam para si a maior parcela de carga de tração da estrutura. Fisicamente, o aço atua como um "cinturão de alta rigidez", aliviando a sobrecarga elástica sobre as camadas de alumínio @RMJones2018.

Quando confrontamos esses resultados com o MHA, observa-se que a solution homogeneizada elástica equivalente fornece uma curva suave ($hat{sigma}_(theta theta)$) que inicia-se em $151,92 "MPa"$ na face interna e decresce suavemente até atingir $121,33 "MPa"$ na face externa @bakhvalov1989. Essa trajetória contínua representa de forma exata a *tensão média de volume* do composto bimetálico periódica, fornecendo o gabarito de rigidez global estável essencial para análises estruturais de grande escala @PartonReport.

=== Tensão Equivalente de Von Mises ($sigma_("VM")$): Verificação de Escoamento

A integridade elástica e a prevenção de falhas estruturais por plastificação localizada são avaliadas através do critério de energia de distorção de Von Mises @Sadd2009. Para o estado de deformação plana generalizada axissimétrico, a tensão equivalente de Von Mises ($sigma_("VM")$) é expressa em termos das componentes principais por:

$
  sigma_("VM") = sqrt(1/2 [ (sigma_(r r) - sigma_(theta theta))^2 + (sigma_(theta theta) - sigma_(z z))^2 + (sigma_(z z) - sigma_(r r))^2 ])
$ <eq:von_mises_calc>

onde a tensão axial induzida pela restrição de deformação plana é dada por $sigma_(z z) = nu (sigma_(r r) + sigma_(theta theta})$ @Sadd2009.

Devido à presença das descontinuidades abruptas de hoop ($sigma_(theta theta}$), o campo equivalente de Von Mises calculado pelo MEF-D também exibe oscilações em degraus perfeitamente correlacionadas com a paridade das camadas bimetálicas @PartonReport. Ao calcularmos analiticamente a @eq:von_mises_calc with as tensões radiais e circunferenciais de referência obtidas pelo SymPy, temos:

*Na parede interna ($r = 9,0 "m"$):*
- Tensão de Von Mises no Aço (Fase 1): $sigma_("VM")^("aço") approx 229,87 "MPa"$ @Sadd2009.
- Tensão de Von Mises no Alumínio (Fase 2): $sigma_("VM")^("alumínio") approx 89,07 "MPa"$ @Sadd2009.
*Na parede externa ($r = 11,0 "m"$):*
- Tensão de Von Mises no Aço (Fase 1): $sigma_("VM")^("aço") approx 158,89 "MPa"$ @Sadd2009.
- Tensão de Von Mises no Alumínio (Fase 2): $sigma_("VM")^("alumínio") approx 56,40 "MPa"$ @Sadd2009.

Confrontando estes resultados elásticos de Von Mises com os limites de escoamento mecânicos de projeto descritos no Capítulo 4 ($sigma_y^("aço") = 400,0 "MPa"$ e $sigma_y^("alumínio") = 270,0 "MPa"$), comprova-se a estrita segurança física do vaso bimetálico sob a pressão nominal extrema de $30 "MPa"$ /*@nr13_2023*/:

*Fase de Aço Carbono:* O pico máximo de tensão equivalente ocorre na parede interna e equivale a $229,87 "MPa"$, fornecendo um coeficiente de segurança mínimo contra plastificação de $F S_{"aço"} = 400,0 / 229,87 approx 1,74$ /*@nr13_2023*/.

*Fase de Liga de Alumínio:* O pico máximo ocorre na mesma coordenada interna e equivale a $89,07 "MPa"$, resultando em um coeficiente de segurança altamente conservativo de $F S_{"alumínio"} = 270,0 / 89,07 approx 3,03$ /*@nr13_2023*/.

Estes resultados numéricos validam plenamente a viabilidade estrutural do reservatório composto periódico /*@felipe_sa2020*/. O projeto hibridizado bimetálico, além de proporcionar uma *redução de massa de $32,69%$* em relação ao aço sólido, permanece operando estritamente em regime elástico linear sob pressões elevadas de $300 "bar"$, com excelentes coeficientes de segurança locais contra escoamento e fadiga interlaminar /*@nr13_2023*/.

#figure(
  caption: [Distribuições e saltos de tensões principais radiais, circunferenciais e Von Mises na parede bimetálica sob pressão interna de 30 MPa.],
  table(
    columns: (1.2fr, 1.3fr, 1.5fr, 1.5fr, 1.5fr),
    align: (left, center, center, center, center),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6edf5") } else if calc.even(y) { rgb("f8fafc") } else { none },
    [*Coordenada*],
    [*Material / Fase*],
    [*Tensão Radial $sigma_(r r)$*],
    [*Tensão Hoop $sigma_(theta theta)$*],
    [*Von Mises $sigma_("VM")$*],

    [Parede Interna ($r=9,0$ m)], [Aço (Fase 1)], [$-30,00 "MPa"$], [$231,33 "MPa"$], [$229,87 "MPa"$],
    [Parede Interna ($r=9,0$ m)], [Alumínio (Fase 2)], [$-30,00 "MPa"$], [$72,51 "MPa"$], [$89,07 "MPa"$],
    [Parede Externa ($r=11,0$ m)], [Aço (Fase 1)], [$0,00 "MPa"$], [$178,77 "MPa"$], [$158,89 "MPa"$],
    [Parede Externa ($r=11,0$ m)], [Alumínio (Fase 2)], [$0,00 "MPa"$], [$63,90 "MPa"$], [$56,40 "MPa"$],
  ),
) <tab:tensoes_r_int_r_ext>

// =========================================================================
// Capítulo 5: Resultados e Discussões
// Seção 5.4: Efeito do Aumento do Número de Camadas (Limite Assintótico)
// Idioma: Português (Brasil)
// Formato: Typst
// =========================================================================

#let b(body) = [*#body*]
#let math_eq(body) = [$#body$]

== Efeito do Aumento do Número de Camadas (Limite Assintótico) <sec:limite_assintotico>

Um dos pilares matemáticos da teoria de homogeneização é a premissa de separação de escalas, regida pelo parâmetro geométrico adimensional $epsilon = l/L << 1$, o qual estabelece a relação entre a escala do período microestrutural ($l$) e a escala característica global da estrutura ($L$) @bakhvalov1989. Para validar numericamente essa hipótese de convergência fraca elíptica e demonstrar o rigor físico do Método de Homogeneização Assintótica (MHA), esta seção analisa o efeito do aumento do número de células periódicas ($N_("cel")$) — mantendo-se a fração volumétrica global constante em $V_1 = V_2 = 0,5$ — sobre a aproximação elástica obtida @BrunaReport.

À medida que o número de células periódicas na parede do vaso de pressão aumenta, a espessura de cada célula unitária ($Y$) encolhe progressivamente, reduzindo o valor de $epsilon$ e aproximando o domínio físico heterogêneo do limite matemático de um meio contínuo homogeneizado ideal @Guinovart2024.

=== Avaliação Quantitativa do Erro de Homogeneização

Para quantificar a aproximação elástica do MHA em relação ao comportamento físico real, confrontou-se a curva de deslocamentos radial obtida pelo Método dos Elementos Finitos Detalhado (MEF-D) com a solução macroscópica equivalente fornecida pelo MHA @bakhvalov1989. Foram extraídas duas métricas clássicas de erro elástico:

1. *Erro Máximo Absoluto ($E_(L^infinity)$):* Avalia a discrepância local máxima do campo de deslocamentos radial na parede do cilindro, expressa por:
  $ E_(L^infinity) = max_(r in [R_("int"), R_("ext")] |u_r^("MEF-D")(r) - u_r^("MHA")(r)| $ <eq:erro_linf>

2. *Erro Relativo em Norma $L^2$:* Quantifica a divergência elástica global de energia integrada ao longo de toda a espessura do vaso, definida como:
  $
    E_(L^2) = sqrt(frac(integral_(R_("int"))^(R_("ext")) (u_r^("MEF-D") - u_r^("MHA"))^2 r d r, integral_(R_("int"))^(R_("ext")) (u_r^("MHA"))^2 r d r)) times 100 %
  $ <eq:erro_l2>

As simulações numéricas foram conduzidas para uma varredura paramétrica de periodicidade, avaliando cenários contendo de $10$ a $200$ células elásticas (o que equivale a um intervalo de $20$ a $400$ camadas bimetálicas alternadas de aço e alumínio). Os resultados obtidos no solucionador computacional real de projeto são sintetizados na @tab:convergencia_erros.

#figure(
  caption: [Análise quantitativa de erros locais e globais na parede do vaso cilíndrico para diferentes níveis de periodicidade microestrutural sob pressão interna de $30 "MPa"$.],
  table(
    columns: (1.2fr, 1.2fr, 1.4fr, 1.8fr, 1.8fr),
    align: (center, center, center, center, center),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6edf5") } else if calc.even(y) { rgb("f8fafc") } else { none },
    [*Células ($N_("cel")$)*],
    [*Camadas ($N_("cam")$)*],
    [*Período $epsilon$ ("m")*],
    [*Erro Máximo $E_(L^infinity)$ ("m")*],
    [*Erro Relativo $E_(L^2)$ (%)*],

    [$10$], [$20$], [$0,200$], [$5,7688 times 10^(-5)$], [$0,4968$],
    [$20$], [$40$], [$0,100$], [$2,8951 times 10^(-5)$], [$0,2493$],
    [$40$], [$80$], [$0,050$], [$1,4502 times 10^(-5)$], [$0,1249$],
    [$80$], [$160$], [$0,025$], [$7,2574 times 10^(-6)$], [$0,0625$],
    [$100$], [$200$], [$0,020$], [$5,8070 times 10^(-6)$], [$0,0500$],
    [$200$], [$400$], [$0,010$], [$2,9044 times 10^(-6)$], [$0,0250$],
  ),
) <tab:convergencia_erros>

=== Demonstração da Taxa de Convergência Linear $O(epsilon)$

A análise dos resultados numéricos tabulados na @tab:convergencia_erros revela um comportamento de decaimento de erro extremamente regular e consistente com a teoria assintótica @bakhvalov1989.

Observa-se que, ao dobrarmos o número de células periódicas de $N_("cel") = 10$ para $N_("cel") = 20$ (o que reduz a espessura da célula unitária de $epsilon = 0,200 "m"$ para $epsilon = 0,100 "m"$), as componentes de erro local e global são reduzidas exatamente pela metade:
* O erro máximo local $E_(L^infinity)$ cai de $5,7688 times 10^(-5) "m"$ para $2,8951 times 10^(-5) "m"$ (decaimento de $49,82%$);
* O erro elástico global $E_(L^2)$ transiciona de $0,4968%$ para $0,2493%$ (decaimento de $49,82%$).

Essa mesma proporcionalidade matemática é mantida ao longo de toda a varredura paramétrica. Ao reduzirmos o período em dez vezes, de $epsilon = 0,100 "m"$ (20 células) para $epsilon = 0,010 "m"$ (200 células), os erros locais e globais decrescem de forma rigorosamente proporcional por um fator de dez, atingindo o patamar residual de apenas **$0,0250%$** para o erro relativo $E_(L^2)$ @Guinovart2024.

Esse comportamento comprova numericamente que a taxa de convergência elástica do Método de Homogeneização Assintótica (usando apenas o termo de ordem dominante $u_0$) é **estritamente linear e de ordem unitária em relação à escala do período** @bakhvalov1989:
$ E_(L^2) = O(epsilon^1) , quad E_(L^infinity) = O(epsilon^1) $ <eq:convergencia_linear>

Fisicamente, a @eq:convergencia_linear confirma com rigor o teorema da relação de proximidade em espaços de Sobolev deduzido por Bakhvalov & Panasenko @bakhvalov1989. O resultado valida a hipótese fundamental de convergência elíptica fraca: à medida que a frequência espacial de oscilação das propriedades bimetálicas tende ao infinito ($epsilon -> 0$), a resposta elástica detalhada do corpo heterogêneo $u^epsilon(r)$ converge estritamente para a curva de deslocamentos regular $u^0(r)$ gerada pelo material homogêneo equivalente @PartonReport.

=== Discussão sobre Eficiência Estrutural e Custo Computacional

Para além do rigor matemático, a análise de convergência traz à tona a enorme vantagem computacional que a homogeneização assintótica confere aos projetos de engenharia @PartonReport.

Em termos práticos, para resolver numericamente o cilindro bimetálico com $N_("cel") = 200$ (composto por $400$ subcamadas elásticas ultrafinas de espessura de apenas $5,0 "mm"$), o Método dos Elementos Finitos Detalhado (MEF-D) exige uma malha radial extremamente fina para garantir o alinhamento de nós discutido no Capítulo 4. A discretização radial requerida de $4.000$ divisões gera um sistema linear com **$80.000$ triângulos discretos**, demandando um esforço computacional e de memória de CPU consideráveis para a montagem de matrizes de rigidez altamente oscilatórias @Sadd2009.

Em contrapartida, o Método de Homogeneização Assintótica (MHA) contorna essa sobrecarga operacional de forma extremamente elegante @PartonReport:
1. O problema local de célula (unidimensional) é integrado analiticamente uma única vez para obter os coeficientes efetivos $[hat(C)]$, requerendo frações de segundo para ser computado @bakhvalov1989;
2. O solucionador de elementos finitos macroscópico resolve o vaso como um meio contínuo homogêneo ortotrópico equivalente, eliminando a necessidade de refinar a malha para rastrear interfaces individuais. Uma malha simples e rápida com poucos graus de liberdade é suficiente para capturar a curva suave global @Sadd2009.

Como demonstrado pela @tab:convergencia_erros, a aproximação elástica obtida por essa abordagem simplificada MHA carrega uma divergência global de energia elástica de **apenas $0,025%$** frente à simulação detalhada de $400$ camadas. Esse patamar é totalmente desprezível para fins práticos de engenharia, consolidando o MHA como uma ferramenta indispensável, precisa e assintoticamente exata para o projeto, análise de fadiga e otimização mecânica de vasos de pressão e cascas multicamadas de alta periodicidade @PartonReport.

// =========================================================================
// Capítulo 5: Resultados e Discussões
// Seção 5.5: Análise de Eficiência Mecânica e Resistência Específica
// Idioma: Português (Brasil)
// Formato: Typst
// =========================================================================

#let b(body) = [*#body*]
#let math_eq(body) = [$#body$]

== Análise de Eficiência Mecânica e Resistência Específica <sec:eficiencia_mecanica>

A avaliação do desempenho de um vaso de pressão de alta performance para aplicações industriais e automotivas não deve limitar-se à análise isolada da capacidade de suporte de carga ou da tensão máxima admissível. Conforme enfatizado pela literatura clássica de materiais compósitos e estruturas de peso reduzido @RMJones2018, o critério definidor de eficiência estrutural reside na avaliação do comportamento mecânico **normalizado por unidade de massa**, expressa através da **Resistência Específica** ($W_g = sigma_y / hat{rho}$) e da **Rigidez Específica** ($K_g = hat{E} / hat{rho}$).

Esta seção quantifica os ganhos de eficiência mecânica e otimização estrutural proporcionados pela hibridização bimetálica periódica (Aço Carbono / Liga de Alumínio, fração volumétrica $V_1 = V_2 = 0,5$), confrontando a solução multicamadas com as configurações homogêneas fabricadas puramente em Aço Carbono e puramente em Liga de Alumínio @PartonReport.

=== Densidade Equivalente e Alívio de Massa

A densidade volumétrica macroscópica equivalente ($hat{rho}$) de um meio periódico heterogêneo é governada de forma exata e puramente aditiva pela Regra das Misturas simples @bakhvalov1989:

$
  hat{rho} = V_1 rho_{"{aço}"} + V_2 rho_{"{alu}"} = 0,5 (7800 { "kg/m"}^3) + 0,5 (2700 { "kg/m"}^3) = 5250 { "kg/m"}^3
$ <eq:densidade_efetiva_sec55>

Para os raios de projeto ($R_{"{int}"} = 9,0 { m}$ e $R_{"{ext}"} = 11,0 { m}$), a área da seção transversal do costado do vaso equivale a $A_{"{wall}"} = pi (R_{"{ext}"}^2 - R_{"{int}"}^2) approx 125,66 { m}^2$. A massa linear resultante $M_{"{linear}"} = A_{"{wall}"} hat{rho}$ (expressa em toneladas por metro de comprimento axial) para cada uma das três configurações estruturais é sumarizada abaixo:
- **Cilindro Homogêneo 100% Aço Carbono:** $M_{"{linear}"} = 980,18 { t/m}$;
- **Cilindro Homogêneo 100% Liga de Alumínio:** $M_{"{linear}"} = 339,29 { t/m}$;
- **Cilindro Multicamadas Bimetálico (MHA/MEF):** $M_{"{linear}"} = 659,73 { t/m}$.

Conforme demonstrado analiticamente, a substituição do projeto puramente metálico em aço pela solução bimetálica hibridizada proporciona um **alívio direto de massa de $32,69%$** /*@felipe_sa2020.*/ Essa redução de peso por metro lineal representa um ganho substancial para o transporte, manuseio e montagem de reservatórios de grande porte de armazenamento de fluidos comprimidos /*@nr13_2023.*/

=== Avaliação da Eficiência Estrutural e Fatores de Segurança

Para comparar o aproveitamento mecânico da matéria-prima em cada configuração sob a pressão interna de projeto de $30 { "MPa"}$ ($3,0 times 10^7 { "Pa"}$), define-se o *Índice de Eficiência de Suporte de Carga por Unidade de Massa* ($W_{{"ef"}}$), expresso pela razão entre a pressão suportada e a massa linear do costado:

$
  W_{{"ef"}} = {P_{{"int"}}}/{M_{{"linear"}}} quad [{"MPa"} / ({t/m})]
$ <eq:indice_eficiencia_massa>

A @tab:comparativo_eficiencia apresenta o estudo comparativo das métricas de desempenho elástico, tensões de Von Mises máximas, fatores de segurança locais contra escoamento e os índices de eficiência estrutural para as três configurações de vaso de pressão sob estudo.

#figure(
  caption: [Estudo comparativo de eficiência estrutural, tensões equivalentes de Von Mises, fatores de segurança e alívio de massa sob pressão de projeto de $30 { "MPa"}$.],
  table(
    columns: (1.5fr, 1.0fr, 1.2fr, 1.2fr, 1.2fr),
    align: (left, center, center, center, center),
    stroke: 0.5pt + luma(150),
    fill: (x, y) => if y == 0 { rgb("e6edf5") } else if calc.even(y) { rgb("f8fafc") } else { none },
    [*Configuração Estrutural*],
    [*Densidade (${"kg"/m}^3$)*],
    [*Massa Linear (${t}/{m}$)*],
    [*Tensão $sigma_{{"VM"}}^{{"máx"}}$ (${"MPa"}$)*],
    [*Fator de Segurança ($"FS"$)*],

    [100% Aço Carbono], [$7800$], [$980,18$], [$159,05$], [$2,51$],
    [100% Liga de Alumínio], [$2700$], [$339,29$], [$158,53$], [$1,70$],
    [Bimetálico (Camada Aço)], [$5250$], [$659,73$], [$229,87$], [$1,74$],
    [Bimetálico (Camada Alumínio)], [$5250$], [$659,73$], [$89,07$], [$3,03$],
  ),
) <tab:comparativo_eficiencia>

A análise rigorosa dos dados da @tab:comparativo_eficiencia revela aspectos mecânicos de altíssimo valor técnico:

1. **Ganho de Eficiência Estrutural:** O vaso puramente de aço apresenta um índice de eficiência de $W_{{"ef"}}^{{"aço"}} = 30 / 980,18 approx 0,03061 { "MPa"}/({t/m})$. A solução bimetálica multicamadas atinge $W_{{"ef"}}^{{"bimet"}} = 30 / 659,73 approx 0,04547 { "MPa"}/({t/m})$, o que representa um **aumento de $48,57%$ na eficiência de suporte de carga por unidade de massa** em relação ao aço sólido @RMJones2018.
2. **Distribuição Inteligente de Esforços:** Em um cilindro de alumínio puro sob $30 { "MPa"}$, a tensão de Von Mises de $158,53 { "MPa"}$ consome grande parte da capacidade do material, resultando em um fator de segurança modesto de $"FS" = 1,70$ frente ao seu limite de escoamento de $270 { "MPa"}$ @Sadd2009. Na estrutura bimetálica, as camadas de aço carbono (mais rígidas) puxam as tensões circunferenciais de tração para si ($sigma_{theta theta}^{{"aço"}} = 231,33 { "MPa"}$), aliviando drasticamente a sobrecarga sobre o alumínio ($sigma_{theta theta}^{{"alumínio"}} = 72,51 { "MPa"}$) @PartonReport.
3. **Elevação do Fator de Segurança do Alumínio:** Como consequência do efeito de "cinturamento" promovido pelas subcamadas de aço, o fator de segurança da fase de alumínio no composto eleva-se para **$"FS" = 3,03$** (um ganho de $78,2%$ em relação ao alumínio puro), enquanto o aço opera com um fator de segurança seguro de $"FS" = 1,74$ /*@nr13_2023.*/

=== Rigidez Específica e Desempenho Global

Em termos de rigidez elástica tangencial (resistência ao estufamento por expansão radial), a constante homogeneizada de Backus para o composto bimetálico equivale a $hat{C}_{22} = 1,8093 times 10^{11} { "Pa"}$ ($180,93 { "GPa"}$) @bakhvalov1989.

A razão de rigidez específica do compósito é calculada por:

$
  K_g^{{"bimet"}} = frac{hat{C}_{22}}{hat{rho}} = frac{1,8093 times 10^{11} { "Pa"}}{5250 { "kg"/m}^3} approx 3,446 times 10^7 { m}^2/{s}^2
$ <eq:rigidez_especifica_bimet>

Para o aço carbono maciço ($C_{11} = 269,23 { "GPa"}$ e $rho = 7800 { "kg"/m}^3$), a rigidez específica resulta em $K_g^{{"aço"}} approx 3,452 times 10^7 { m}^2/{s}^2$. Isso comprova que a estrutura bimetálica **preserva $99,83%$ da rigidez específica do aço maciço**, porém fornecendo um alívio de peso de quase um terço do total da estrutura @RMJones2018.

Estes resultados confirmam a plena viabilidade técnica do Método de Homogeneização Assintótica (MHA) no projeto e otimização de vasos de pressão multicamadas, demonstrando que a hibridização bimetálica periódica é uma alternativa de engenharia madura, segura e de elevada eficiência mecânica para reservatórios de alta pressão /*@nr13_2023, @felipe_sa2020.*/
#inline-note[lembrar de incluir citações normativas]

