#import "../imports.typ": *

#task[
  - Objetivo B.1: Vasos de Pressão e Critérios Normativos (ASME e NR-13):
    * O que abordar:* Apresentar a definição de vasos de pressão, seu papel na indústria e a importância do projeto seguro.
    * Rigor técnico:* Discutir os limites de parede fina vs. parede grossa (solução de Lamé). Apresentar os critérios de projeto mecânico conforme o Código ASME Seção VIII Divisão 1 (como o cálculo de espessura admissível) e as diretrizes de classificação e segurança operacional exigidas pela Norma Regulamentadora Brasileira NR-13.
    * Fontes-chave:* Felipe Zacharias (2018), Vasos de Pressão (UFJF), Manual Simplificado ASME Sec VIII Div 1, e NR-13.
]

// Seção 2.1: Vasos de Pressão e Critérios Normativos (ASME e NR-13)

== Vasos de Pressão e Critérios Normativos

=== Definição e Classificação Geométrica: Paredes Finas vs. Paredes Grossas

Vasos de pressão são conceitualmente definidos como quaisquer recipientes estanques, independentemente de sua geometria, dimensões ou finalidade, capazes de conter um fluido sob pressão positiva ou negativa (vácuo) significativamente diferente da pressão atmosférica [24, 37, 48]. Na engenharia de processos e segurança do trabalho, adota-se um divisor clássico para diferenciar esses equipamentos de simples reservatórios de armazenamento: quando a diferença de pressão interna e externa é superior a $0,1$ MPa (ou aproximadamente $15$ psig ou $1,0$ bar), o equipamento é enquadrado e projetado como um vaso de pressão; para diferenciais de pressão inferiores a esse patamar, a estrutura é classificada como um tanque de armazenamento [18, 24].

Fisicamente, as duas geometrias primárias mais difundidas na indústria para a contenção de fluidos pressurizados são os cilindros (verticais ou horizontais) e as esferas [18]. Sob o ponto de vista da mecânica do contínuo e da resistência dos materiais, o dimensionamento elástico e a distribuição de tensões ao longo da parede do vaso são intrinsecamente dependentes da relação geométrica entre o raio interno ($r$) e a espessura da parede ($t$). A literatura clássica estabelece o seguinte critério de classificação estrutural @Sadd2009:

*Vasos de Parede Fina:* Ocorrem quando a relação geométrica satisfaz a desigualdade:
$ r/t >= 10 $ <eq-limite-parede-fina>
Nesta condição, assume-se que as tensões normais de tração atuantes na parede do vaso são uniformes ao longo de toda a espessura, sendo chamadas de tensões de membrana [24]. Estudos teóricos e experimentais demonstram que, ao adotar a hipótese de parede fina em vasos que respeitam a @eq-limite-parede-fina, as equações simplificadas de membrana fornecem um erro analítico menor que 4% em relação aos valores de tensão máxima real obtidos por teorias elásticas exatas tridimensionais [42].

*Vasos de Parede Grossa:* Ocorrem quando a espessura do vaso é expressiva ($r/t < 10$), fazendo com que a distribuição de tensões varie radialmente de forma não linear ao longo da espessura, exigindo o emprego de soluções completas de elasticidade (como as clássicas soluções de Lamé) devido ao alto gradiente de tensões e efeitos de cisalhamento interlaminar [18, 42].

Para reservatórios cilíndricos de parede fina sujeitos a uma pressão manométrica interna ($p$), o estado plano de tensões é governado por tensões principais normais sem componentes de cisalhamento, devido à simetria axial (axissimetria) do cilindro e do carregamento [42]. A tensão circunferencial (ou tangencial/hoop), denotada por $sigma_1$, atua no sentido tangencial ao longo do costado cilíndrico e é deduzida como [18, 42]:
$ sigma_1 = (p r) / t $ <eq-tensao-circunferencial>

Simultaneamente, a tensão longitudinal (ou axial), denotada por $sigma_2$, atua paralelamente ao eixo do cilindro e é gerada pelas forças de pressão que empurram os tampões de extremidade, sendo descrita por [42]:
$ sigma_2 = (p r) / (2 t) $ <eq-tensao-longitudinal>

Comparando-se as equações @eq-tensao-circunferencial e @eq-tensao-longitudinal, observa-se que a tensão circunferencial é exatamente o dobro da tensão longitudinal ($sigma_1 = 2 sigma_2$) [42]. Essa relação física possui uma implicação mecânica fundamental de falha: ao pressurizar excessivamente um tubo ou cilindro metálico homogêneo, a parede falhará primeiro por tração ao longo das juntas longitudinais, gerando uma fissura linear paralela ao eixo de comprimento do cilindro [42]. Por essa razão, juntas de solda longitudinais em cascos cilíndricos calandrados devem ser dimensionadas e inspecionadas para suportar o dobro do carregamento em relação às juntas circunferenciais [42].

Em contrapartida, para reservatórios esféricos de parede fina, a perfeita simetria esférica do domínio faz com que as tensões circunferenciais e longitudinais sejam idênticas ($sigma_1 = sigma_2$), resultando em [42]:
$ sigma_1 = sigma_2 = (p r) / (2 t) $ <eq-tensao-esferica>

No estado de tensões na parede de uma esfera, as tensões principais normais são iguais, o que faz com que o círculo de Mohr correspondente ao plano tangencial se reduza a um único ponto, zerando a tensão cisalhante máxima no plano ($tau_("no plano") = 0$) [42]. No entanto, a tensão cisalhante máxima absoluta (fora do plano) para cilindros e esferas é dada, respectivamente, por [42]:
$ tau_("max, cilindro") = sigma_1 / 2 = (p r) / (2 t) $
$ tau_("max, esfera") = sigma_1 / 2 = (p r) / (4 t) $

Essa distribuição de tensões prova que, embora os vasos esféricos apresentem uma fabricação muito mais complexa e cara devido à necessidade de conformação tridimensional de gomos soldados, eles são mecanicamente muito mais eficientes, sendo capazes de suportar o dobro de pressão interna em relação a um vaso cilíndrico de mesmo diâmetro e espessura [42].

=== Critérios de Projeto Conforme o Código ASME Seção VIII (Divisões 1 e 2)

Para garantir a segurança operacional e mitigar os riscos de falhas explosivas catastróficas, o projeto e a fabricação de vasos de pressão industriais são rigorosamente regidos por códigos normativos internacionais, dos quais o mais amplamente utilizado globalmente e no Brasil é o Código ASME Seção VIII (*Boiler and Pressure Vessel Code*, BPVC), desenvolvido pela Associação Americana de Engenheiros Mecânicos (*American Society of Mechanical Engineers*) [18, 37].

O Código ASME Seção VIII divide-se em três divisões com filosofias de projeto, fatores de segurança e limites de pressão distintos [18, 24, 37]:

#table(
  columns: (1fr, 2fr, 2fr),
  align: left + horizon,
  stroke: 0.5pt + luma(150),
  fill: (x, y) => if y == 0 { rgb("e6edf5") } else { none },
  [*Critério Comparativo*], [*ASME Seção VIII - Divisão 1*], [*ASME Seção VIII - Divisão 2*],
  [*Filosofia de Projeto*],
  [Projeto por Regras Práticas (*Design-by-Rules*) [18, 24].],
  [Projeto por Análise Detalhada (*Design-by-Analysis*) [18, 24].],

  [*Análise de Tensões*],
  [Não exige modelagem analítica ou numérica detalhada de todas as tensões locais; foca no controle de tensões globais de membrana via equações práticas simplificadas [24, 37].],
  [Exige a análise rigorosa de todas as categorias de tensões combinadas (primárias, secundárias e locais de descontinuidade) [24].],

  [*Fator de Segurança*],
  [Fator de segurança elevado. As tensões admissíveis do material ($S$) são conservadoras (menores) [18, 24].],
  [Fator de segurança reduzido. Permite tensões admissíveis superiores devido ao rigor das análises de engenharia [24, 37].],

  [*Espessura de Parede*],
  [Paredes mais espessas e pesadas para resistir à mesma pressão interna de projeto [24, 37].],
  [Paredes mais finas e vasos consideravelmente mais leves [24].],

  [*Exigências de Fabricação*],
  [Padrão convencional de inspeção, exames não destrutivos e ensaios [24].],
  [Altas exigências de qualificação de materiais, exames não destrutivos severos, tratamentos térmicos e testes detalhados de impacto [24].],

  [*Limites de Pressão*],
  [Aplicável a pressões de projeto acima de $15$ psi ($0,1$ MPa) até $3.000$ psi ($20$ MPa) [24, 27].],
  [Aplicável a pressões elásticas de projeto de até $10.000$ psi ($70$ MPa) [24].],
) #margin-note[Coloar legenda (Quadro) e refenciá-lo no texto]

Conforme a Subseção A, Parte UG do ASME Seção VIII Divisão 1, as fórmulas utilizadas para o cálculo da espessura mínima requerida ($t$) e da Pressão Máxima de Trabalho Admissível (PMTA, ou $P$) de cascos cilíndricos sob pressão interna são baseadas na tensão circunferencial solicitando as juntas soldadas longitudinais [18, 24]. Quando a espessura do costado não excede a metade do raio interno, ou quando a pressão interna não ultrapassa o limite elástico $0,385 S E$, aplicam-se as seguintes expressões de projeto (UG-27) [24, 27]:
$ t = (P R) / (S E - 0,6 P) quad text("ou") quad P = (S E t) / (R + 0,6 t) $ <eq-asme-circunferencial>

Onde:

- $t$ é a espessura mínima de parede requerida (excluindo sobrespessuras de corrosão), em milímetros ($"mm"$) [24, 27];

- $P$ é a pressão interna de projeto ou a PMTA, em megapascais ($"MPa"$) [24, 27];

- $R$ é o raio interno do casco cilíndrico na condição corroída, em milímetros ($"mm"$) [24, 27];

- $S$ é o valor máximo da tensão de tração admissível do material na temperatura de projeto, obtido nas tabelas da Seção II Parte D do Código ASME, em megapascais ($"MPa"$) [24, 27];

- $E$ é a eficiência de junta soldada circunferencial ou longitudinal, que varia de $0,70$ a $1,00$ em função da extensão dos exames radiográficos realizados na junta (conforme parágrafos UW-11 e UW-12) [24, 27].

Para as juntas circunferenciais solicitadas pela tensão longitudinal, sob as mesmas condições geométricas de parede fina (espessura menor que metade do raio interno e $P <= 1,25 S E$), as equações do parágrafo UG-27 do ASME Seção VIII Div. 1 resultam em [24, 27]:
$ t = (P R) / (2 S E + 0,4 P) quad text("ou") quad P = (2 S E t) / (R - 0,4 t) $ <eq-asme-longitudinal>

O código estabelece de forma rigorosa que a espessura mínima nominal a ser adotada para a fabricação de cascos e tampos de aço carbono e baixa liga, independentemente do cálculo por pressão, é o maior valor entre $4,8$ mm ou a relação baseada no diâmetro interno com tolerância à corrosão (UG-16), visando garantir estabilidade dimensional e facilidade de fabricação na caldeiraria [24].

=== Gestão de Segurança e Integridade Estrutural Conforme a NR-13

No Brasil, a operação e integridade física de todos os vasos de pressão industriais são regulamentadas de forma obrigatória pela Norma Regulamentadora nº 13 (NR-13) do Ministério do Trabalho e Emprego, intitulada "Caldeiras, Vasos de Pressão, Tubulações e Tanques Metálicos de Armazenamento" [37, 48]. A NR-13 estabelece requisitos mínimos legais para a gestão da integridade estrutural desses equipamentos nos aspectos relacionados à instalação, inspeção de segurança, operação e manutenção, visando prioritariamente prevenir acidentes severos e resguardar a vida dos trabalhadores [150, 151, 159].

A norma possui critérios bem delineados de abrangência de fiscalização para enquadramento de recipientes sob suas regras. Conforme o subitem 13.2.1, estão inclusos no escopo da NR-13 [48]:
1. Vasos de pressão cujo produto entre a pressão máxima de operação ($P$, em kPa) e seu volume interno ($V$, em m³) seja superior a 8 ($P.V > 8$) [196];
2. Vasos de pressão que contenham fluidos de Classe A (fluidos altamente tóxicos, inflamáveis ou hidrogênio), independentemente do valor do produto $P.V$ [196].

Por outro lado, recipientes com diâmetro interno inferior a $150$ mm estão formalmente dispensados da aplicação da norma, independentemente do fluido ou pressão de operação [198].

A NR-13 organiza os vasos de pressão em categorias de risco (de I a V, onde a Categoria I representa a classe de risco mais elevado e a Categoria V o menor risco), as quais regulam diretamente a periodicidade máxima permitida para as inspeções de segurança internas e externas e testes de integridade [164, 207]. Essa categorização é definida em função de dois parâmetros principais: a **Classe de Fluido** e o **Grupo de Potencial de Risco** [164, 203].

*Classes de Fluido (Subitem 13.5.1.1.1):*Os fluidos de processo contidos nos vasos de pressão são classificados em quatro classes distintas com base em sua inflamabilidade, toxicidade e reatividade [48, 202]:

- *Classe A:* Fluidos inflamáveis; combustíveis com temperatura de operação igual ou superior a $200$ ºC; fluidos tóxicos com limite de tolerância igual ou inferior a $20$ ppm; hidrogênio e acetileno [5, 202].
- *Classe B:* Fluidos combustíveis com temperatura de operação inferior a $200$ ºC; fluidos tóxicos com limite de tolerância superior a $20$ ppm [5, 202].
- *Classe C:* Vapor de água; gases asfixiantes simples; ar comprimido [5, 203].
- *Classe D:* Outros fluidos não enquadrados nas classes anteriores (como água potável ou fluidos inertes) [5, 203].

*Grupo de Potencial de Risco (Subitem 13.5.1.1.3):* Estabelecido a partir do produto matemático $P.V$, onde $P$ é o módulo da pressão máxima de operação em megapascais ($"MPa"$) e $V$ é o volume interno do vaso em metros cúbicos ($"m"^3$), divididos nos seguintes cinco grupos [203, 204]:
- *Grupo 1:* $P.V >= 100$ [204];
- *Grupo 2:* $100 > P.V >= 30$ [204];
- *Grupo 3:* $30 > P.V >= 2,5$ [204];
- *Grupo 4:* $2,5 > P.V >= 1$ [204];
- *Grupo 5:* $P.V < 1$ [204].

Cruzando-se as matrizes de Classe de Fluido com o Grupo de Potencial de Risco, a Tabela 1 da NR-13 define formalmente a Categoria do Vaso de Pressão [204]:

#table(
  columns: (1.5fr, 1.1fr, 1.1fr, 1.1fr, 1.1fr, 1.1fr),
  align: center + horizon,
  stroke: 0.5pt + luma(150),
  fill: (x, y) => if y == 0 { rgb("e6edf5") } else if x == 0 { rgb("f8fafc") } else { none },
  [*Classe do Fluido*],
  [**Grupo 1** \ _P.V >= 100_],
  [**Grupo 2** \ _30 <= P.V < 100_],
  [**Grupo 3** \ _2,5 <= P.V < 30_],
  [**Grupo 4** \ _1 <= P.V < 2,5_],
  [**Grupo 5** \ _P.V < 1_],

  [*Classe A* \ _(Tóxicos, Inflamáveis, H₂)_], [**I**], [**I**], [**II**], [**III**], [**III**],
  [*Classe B* \ _(Combustíveis < 200 ºC), Tóxicos >20 ppm)_], [**I**], [**II**], [**III**], [**IV**], [**IV**],
  [*Classe C* \ _(Vapor, Ar Comprimido)_], [**I**], [**II**], [**III**], [**IV**], [**V**],
  [*Classe D* \ _(Outros Fluidos)_], [**II**], [**III**], [**IV**], [**V**], [**V**],
)

Mecanicamente, para que um vaso de pressão seja operado legalmente em território nacional, a NR-13 exige que o estabelecimento industrial mantenha um conjunto de documentações técnicas atualizadas e prontamente acessíveis para a auditoria de fiscais do trabalho e do Ministério Público [167, 206]. Essa pasta de integridade inclui obrigatoriamente [167, 206]:
1. *Prontuário do Vaso de Pressão:* Emitido e assinado pelo fabricante, contendo o código de construção (como o ASME), especificação dos materiais de retenção de pressão, procedimentos de fabricação, qualificação de soldagem e relatórios de exames e inspeção final [206];
2. *Registro de Segurança:* Livro de ocorrências físicas onde são registradas as inspeções de segurança, calibrações de instrumentos e anomalias operacionais [167];
3. *Projeto de Instalação:* Desenho de arranjo físico detalhando as condições de ventilação, distâncias de segurança e o livre acesso para rotas de fuga dos operadores [167, 172];
4. *Relatórios de Inspeção de Segurança:* Documentos gerados periodicamente por um Profissional Habilitado (PH) atestando que os exames internos, externos e testes não destrutivos comprovam a integridade estrutural do costado, tampos e bocais [167].

Adicionalmente, cada vaso de pressão deve possuir afixado em seu corpo, em local de fácil acesso e amplamente visível, uma placa de identificação indelével com informações fundamentais gravadas (fabricante, número de série, ano de fabricação, código de construção, PMTA, eficiência de junta soldada) e, pintada em destaque no costado, a identificação visível de sua categoria (por exemplo, "CAT I" ou "CAT III") para fins de fiscalização operacional rápida [35, 205, 206].

#task[
  - Objetivo B.2: Mecânica dos Materiais Compósitos e Simetrias Elásticas:
    * O que abordar:* Introduzir os conceitos de materiais compostos (matriz, reforço e fases constitutivas) e os diferentes níveis de comportamento elástico.
    * Rigor técnico:* Explicar a Lei de Hooke generalizada e a transição das propriedades constitutivas partindo do caso anisotrópico mais geral (21 constantes) até a redução para materiais ortotrópicos (9 constantes) e transversalmente isotrópicos (5 constantes) na Notação de Voigt, justificando como o layout de múltiplas camadas cilíndricas induz a ortotropia curvilínea.
    * Fontes-chave:* Robert M. Jones (1999), Parton & Kudryavtsev (1993), e Review on laminated composites (Liew, 2019).
]

== Mecânica dos Materiais Compósitos e Simetrias Elásticas (Objetivo B.2)

O estudo do comportamento mecânico de estruturas cilíndricas multicamadas e vasos de pressão avançados requer uma base conceitual sólida da mecânica dos meios anisotrópicos. Ao contrário dos materiais convencionais, cuja isotropia simplifica as relações constitutivas, os compósitos exibem propriedades físicas que dependem da direção analisada. Esta seção apresenta o formalismo matemático da Lei de Hooke Generalizada, o método de redução de constantes elásticas através das simetrias elásticas e a Notação de Voigt, culminando na justificativa física de como cilindros formados por camadas isotrópicas apresentam um comportamento macroscopicamente ortotrópico curvilíneo [25, 49].

=== Lei de Hooke Generalizada e o Tensor de Rigidez de Quarta Ordem

No âmbito da elasticidade linear tridimensional, a relação entre o tensor de tensões de segunda ordem $bold(sigma)$ e o tensor de deformações infinitesimais de segunda ordem $bold(epsilon)$ é regida pela Lei de Hooke Generalizada, expressa em notação de índices como [25, 49, 82]:

$ sigma_(i j) = C_{i j k l} epsilon_(k l) , quad (i, j, k, l = 1, 2, 3) $ <eq:hooke_tensor>

onde $C_{i j k l}$ representa o tensor de elasticidade (ou rigidez elástica) de quarta ordem. De acordo com a análise dimensional e a álgebra tensorial, o tensor $C_{i j k l}$ possui $3^4 = 81$ componentes independentes na ausência de simetrias [67, 68].

Contudo, a física dos meios contínuos impõe restrições severas a essas componentes devido às simetrias físicas dos tensores de tensão e deformação, bem como a princípios termodinâmicos [11, 26, 68]:

1. *Simetria do Tensor de Tensões:* Em virtude da conservação do momento angular (e na ausência de momentos de corpo distribuídos), o tensor de tensões de Cauchy é simétrico ($sigma_(i j) = sigma_(j i)$). Isto resulta na simetria menor esquerda do tensor de rigidez [4, 11, 68]:
  $ C_{i j k l} = C_{j i k l} $ <eq:sym_left>

2. *Simetria do Tensor de Deformações:* Por definição cinemática, o tensor de pequenas deformações é a parte simétrica do gradiente do vetor deslocamento ($epsilon_(k l) = 1/2 (u_(k,l) + u_(l,k))$)#margin-note[Definir o conceito de gradiente de um campo vetorial]. Isto implica na simetria menor direita [1, 4, 11, 68]:
  $ C_{i j k l} = C_{i j l k} $ <eq:sym_right>

A aplicação conjunta das simetrias menores dadas pelas @eq:sym_left e @eq:sym_right reduz o número de componentes elásticas independentes de 81 para 36 componentes [11, 68].

3. *Existência de um Potencial Elástico (Termodinâmica):* Para um material elástico hiperelástico, assume-se a existência de uma função de densidade de energia de deformação (ou potencial elástico $W$) por unidade de volume, de modo que as tensões sejam derivadas de $W$ por [11, 12, 178]:
  $ sigma_(i j) = frac(partial W, partial epsilon_(i j)) $ <eq:potential_w>

Diferenciando novamente a expressão anterior em relação às deformações, obtêm-se as componentes de rigidez [11, 68]:
$ C_{i j k l} = frac(partial^2 W, partial epsilon_(i j) partial epsilon_(k l)) $ <eq:stiff_deriv>

Como a ordem de diferenciação parcial de uma função contínua de classe $C^2$ é imaterial (teorema de Clairaut-Schwarz), conclui-se que o tensor de rigidez possui simetria maior [11, 68]:
$ C_{i j k l} = C_{k l i j} $ <eq:sym_major>

A introdução da simetria maior dada pela @eq:sym_major impõe que a matriz elástica resultante seja simétrica, reduzindo o número máximo de constantes elásticas independentes para o caso de um material elástico anisotrópico tridimensional geral (triclínico) para exatamente *21 componentes* [11, 13, 184].

=== Notação de Voigt e a Redução Matricial 6x6

Com o intuito de simplificar a manipulação algébrica e a implementação computacional, utiliza-se a Notação de Voigt para contrair os tensores de segunda e quarta ordens em arranjos matriciais de menor dimensão [10, 68, 82]. A contração de índices segue o algoritmo padrão de mapeamento para os índices de tensão e deformação normais e cisalhantes [10, 69, 184]:

#align(center)[
  #table(
    columns: (2cm, 2cm, 2cm, 2cm),
    align: center,
    stroke: 0.5pt,
    [*Índice Tensorial $(i j)$*],
    [*Índice de Voigt $(alpha)$*],
    [*Tensão Voigt ($sigma_alpha$)*],
    [*Deformação Voigt ($epsilon_alpha$)*],

    [11], [1], [$sigma_1 = sigma_11$], [$epsilon_1 = epsilon_11$],
    [22], [2], [$sigma_2 = sigma_22$], [$epsilon_2 = epsilon_22$],
    [33], [3], [$sigma_3 = sigma_33$], [$epsilon_3 = epsilon_33$],
    [23 ou 32], [4], [$sigma_4 = tau_23$], [$epsilon_4 = gamma_23 = 2 epsilon_23$],
    [13 ou 31], [5], [$sigma_5 = tau_13$], [$epsilon_5 = gamma_13 = 2 epsilon_13$],
    [12 ou 21], [6], [$sigma_6 = tau_12$], [$epsilon_6 = gamma_12 = 2 epsilon_12$],
  )
]

É de extrema importância frisar que, ao contrair o tensor de deformações, introduz-se um fator multiplicador de 2 nas componentes cisalhantes ($gamma_alpha = 2 epsilon_(i j)$ para $i != j$), de modo a preservar o trabalho interno virtual $d W = sigma_(i j) d epsilon_(i j) = sigma_alpha d epsilon_alpha$ [10, 11, 20].

Aplicando a notação de Voigt, a Lei de Hooke tridimensional assume a forma matricial [13]:

$
  vec(sigma_1, sigma_2, sigma_3, tau_23, tau_13, tau_12) = mat(
    C_11, C_12, C_13, C_14, C_15, C_16;
    C_12, C_22, C_23, C_24, C_25, C_26;
    C_13, C_23, C_33, C_34, C_35, C_36;
    C_14, C_24, C_34, C_44, C_45, C_46;
    C_15, C_25, C_35, C_45, C_55, C_56;
    C_16, C_26, C_36, C_46, C_56, C_66
  ) vec(epsilon_1, epsilon_2, epsilon_3, gamma_23, gamma_13, gamma_12)
$ <eq:voigt_matrix_anisotropic>

A equação @eq:voigt_matrix_anisotropic representa a relação constitutiva de um material triclínico genérico, caracterizado por 21 componentes de rigidez elástica independentes e acoplamento total entre deformações normais e tensões cisalhantes (e vice-versa) [13, 20].

=== Classes de Simetria Elástica e Redução de Constantes

À medida que o material exibe planos de simetria física ou estrutural em sua microestrutura, o número de constantes elásticas independentes é reduzido de forma sistemática através de leis de transformação de coordenadas tensoriais [13, 67, 188]. Três simetrias elásticas são fundamentais para o entendimento do comportamento dos compósitos estruturais:

==== Material Monoclínico (1 Plano de Simetria)
Se o material possui um único plano de simetria elástica (por exemplo, o plano $x_1 - x_2$), as propriedades elásticas devem permanecer invariantes sob uma transformação de reflexão em relação a este plano ($x_3' = -x_3$). Isso anula as constantes de acoplamento cisalhante fora do plano, reduzindo o número total de constantes para *13 componentes* [14, 18, 184]:

$
  [C] = mat(
    C_11, C_12, C_13, 0, 0, C_16;
    C_12, C_22, C_23, 0, 0, C_26;
    C_13, C_23, C_33, 0, 0, C_36;
    0, 0, 0, C_44, C_45, 0;
    0, 0, 0, C_45, C_55, 0;
    C_16, C_26, C_36, 0, 0, C_66
  )
$ <eq:monoclinic_stiffness>

==== Material Ortotrópico (3 Planos Ortogonais de Simetria)
Se o material possui três planos ortogonais de simetria mecânica (como é o caso de fibras orientadas em eixos cartesianos ortogonais), as propriedades constitutivas são simétricas em relação a esses três planos de simetria mutuamente perpendiculares [14, 15, 184]. Nesse caso, todos os acoplamentos entre esforços normais e distorções angulares desaparecem na base de coordenadas principais do material (PMC), resultando em apenas *9 constantes independentes* [15, 23, 184]:

$
  [C] = mat(
    C_11, C_12, C_13, 0, 0, 0;
    C_12, C_22, C_23, 0, 0, 0;
    C_13, C_23, C_33, 0, 0, 0;
    0, 0, 0, C_44, 0, 0;
    0, 0, 0, 0, C_55, 0;
    0, 0, 0, 0, 0, C_66
  )
$ <eq:orthotropic_stiffness>

A relação de deformação-tensão (Lei de Hooke invertida) para materiais ortotrópicos em coordenadas principais é tradicionalmente expressa através de propriedades de engenharia com significado físico direto (Módulos de Young ($E_1, E_2, E_3$), Módulos de Cisalhamento ($G_{12}, G_{13}, G_{23}$) e Coeficientes de Poisson ($nu_{12}, nu_{13}, nu_{23}$)) [21, 22, 220]:

$
  vec(epsilon_1, epsilon_2, epsilon_3, gamma_23, gamma_13, gamma_12) = mat(
    1/E_1, -nu_21/E_2, -nu_31/E_3, 0, 0, 0;
    -nu_12/E_1, 1/E_2, -nu_32/E_3, 0, 0, 0;
    -nu_13/E_1, -nu_23/E_2, 1/E_3, 0, 0, 0;
    0, 0, 0, 1/G_23, 0, 0;
    0, 0, 0, 0, 1/G_13, 0;
    0, 0, 0, 0, 0, 1/G_12
  ) vec(sigma_1, sigma_2, sigma_3, tau_23, tau_13, tau_12)
$ <eq:orthotropic_compliance>

Como a matriz de flexibilidade $[S] = [C]^(-1)$ é necessariamente simétrica ($S_(alpha beta) = S_(beta alpha)$), as seguintes equações de reciprocidade (uma generalização da Lei de Betti) devem ser rigorosamente atendidas pelas propriedades elásticas de engenharia [23, 24, 220]:

$ frac(nu_(i j), E_i) = frac(nu_(j i), E_j) , quad text("para") i, j = 1, 2, 3 $ <eq:betti_reciprocity>

==== Material Transversalmente Isotrópico (1 Plano de Isotropia)
Se, em qualquer ponto do meio elástico, existe um plano físico no qual as propriedades elásticas são idênticas em todas as direções de forma rotacional, o material é classificado como transversalmente isotrópico [16, 19, 185]. Tomando o plano $2-3$ como o plano de isotropia elástica (no qual as propriedades são invariantes sob qualquer rotação ao longo do eixo $1$), as componentes de rigidez são reduzidas a apenas *5 constantes elásticas independentes* [16, 17, 185]:

$
  [C] = mat(
    C_11, C_12, C_12, 0, 0, 0;
    C_12, C_22, C_23, 0, 0, 0;
    C_12, C_23, C_22, 0, 0, 0;
    0, 0, 0, frac(C_22 - C_23, 2), 0, 0;
    0, 0, 0, 0, C_55, 0;
    0, 0, 0, 0, 0, C_55
  )
$ <eq:transverse_isotropic_stiffness>

onde o termo de cisalhamento no plano de isotropia é definido pela relação clássica $C_44 = 1/2 (C_22 - C_23)$, análoga à relação elástica linear de materiais puramente isotrópicos [17, 185].

=== Origem Física do Comportamento Ortotrópico Cilíndrico Macroscópico

A modelagem de vasos de pressão multicamadas, como cilindros bimetálicos compostos por lâminas delgadas e alternadas de aço carbono e ligas de alumínio, introduz um fenômeno físico-matemático de enorme importância: a *transição de simetria induzida por homogeneização* [5, 39, 193].

Embora cada camada individual que constitui a parede do cilindro exiba um comportamento puramente isotrópico (caracterizado localmente por apenas 2 parâmetros elásticos livres, $E$ e $nu$) [100, 120, 193], o processo de empilhamento periódico ao longo do raio $r$ do vaso e a subsequente homogeneização matemática via Método de Homogeneização Assintótica (MHA) quebram a isotropia global da estrutura [39, 43, 193].

==== O Princípio de Homogeneização de Backus
Do ponto de vista físico, um cilindro composto por camadas ultrafinas de propriedades mecânicas alternadas comporta-se de forma idêntica a um meio elástico estratificado periódico de Backus [5]. Sob a ação de um carregamento mecânico macroscópico, a estrutura apresenta rigidez assimétrica:
- Na *direção radial* (perpendicular às interfaces de camadas), a deformação do conjunto é governada por uma associação de "molas em série" (regida pela média harmônica das propriedades elásticas locais), resultando em um comportamento elástico significativamente mais flexível [5].
- Nas *direções circunferencial e axial* (paralelas às interfaces), as camadas deformam juntas sob o mesmo campo macroscópico, caracterizando uma associação de "molas em paralelo" (regida pela média aritmética das propriedades), o que induz uma rigidez mecânica consideravelmente maior [5].

Este desacoplamento de rigidez induz um comportamento macroscópico equivalente de **ortotropia cilíndrica** (ou isotropia transversal curvilínea), no qual a direção radial $r$ comporta-se como o eixo normal à simetria elástica, enquanto as direções axial $z$ e tangencial $theta$ formam o plano macroscópico de isotropia elástica curvilínea [5, 39, 193].

Como consequência direta do MHA de camadas isotrópicas coaxiais periódicas, o cilindro homogêneo equivalente macroscópico passa a ser regido por um tensor de elasticidade efetivo $[hat(C)]$ contendo exatamente *5 coeficientes independentes* ($hat(C)_{11}, hat(C)_{22}, hat(C)_{12}, hat(C)_{23}$ e $hat(C)_{55}$), em substituição às propriedades locais rapidamente oscilantes do modelo original [5, 39, 193]. O alinhamento natural dessas constantes com as coordenadas cilíndricas do costado do vaso ($r, theta, z$) elimina a necessidade de transformações de coordenadas complexas e simplifica drasticamente o equilíbrio axissimétrico final estudado no TCC [5, 39].

#task[
  - Objetivo B.3: Teorias de Deformação de Placas/Cascas e o Efeito Zig-Zag:
    * O que abordar:* Apresentar a evolução da modelagem mecânica de laminados ao longo da espessura.
    * Rigor técnico:* Diferenciar as teorias clássicas de laminação (CLT) e de primeira ordem (FSDT), que assumem seções planas, das Teorias Zig-Zag (ZZT) e modelos camada a camada (layerwise). Explicar fisicamente a necessidade dessas teorias avançadas para capturar as descontinuidades de derivadas (os famosos "kinks" ou cotovelos) nos deslocamentos interlaminares de materiais com alto contraste de rigidez.
    * Fontes-chave:* Review on laminated composites (Garg et al., 2020) e Robert M. Jones (1999).
]

== Teorias de Deformação de Placas/Cascas e o Efeito Zig-Zag (Objetivo B.3)

O projeto de vasos de pressão e cascas de parede espessa fabricados em materiais compósitos ou arranjos multicamadas exige teorias cinemáticas capazes de descrever com fidelidade a distribuição de deslocamentos e tensões ao longo da espessura. Esta seção aborda a evolução das formulações cinemáticas clássicas de camada única equivalente, as limitações intrínsecas que as tornam inadequadas para cilindros de parede grossa e o mecanismo físico-matemático que rege o efeito zigue-zague (*kinks*) nas interfaces das camadas com alto contraste de rigidez elástica [25, 34].

=== Teorias de Camada Única Equivalente (Equivalent Single Layer - ESL)

As teorias de Camada Única Equivalente (ESL) reduzem o problema tridimensional (3D) de elasticidade para uma formulação bidimensional (2D) aproximada, tratando o laminado heterogêneo como uma placa ou casca homogênea equivalente com propriedades integradas ao longo da espessura $h$ [34]. As duas principais teorias deste grupo são a Teoria Clássica de Laminação de Placas (CLT) e a Teoria de Deformação por Cisalhamento de Primeira Ordem (FSDT) [25, 34].

==== Teoria Clássica de Laminação de Placas (CLT)

A Teoria Clássica de Laminação (CLT — *Classical Lamination Theory*), fundamentada nas hipóteses de Kirchhoff-Love para cascas delgadas, assume que qualquer linha reta originalmente normal à superfície neutra do cilindro permanece [25]:
1. Reta após a deformação;
2. Normal à superfície deformada;
3. Inalterada em seu comprimento (extensão vertical nula, $epsilon_z = 0$).

Sob estas premissas cinemáticas, o campo de deslocamentos axial $u_z$ e circunferencial $u_theta$ a uma coordenada radial $r$ (adotando a superfície média como referência de espessura $z$) é escrito como [25]:

$ u_z (r, theta, z) = u_z^0 (r, theta) - z frac(partial w, partial z) $ <eq:clt_disp1>
$ u_theta (r, theta, z) = u_theta^0 (r, theta) - z frac(partial w, r partial theta) $ <eq:clt_disp2>
$ u_r (r, theta, z) = w(r, theta) $ <eq:clt_disp3>

onde $u_z^0$ e $u_theta^0$ são os deslocamentos no plano médio e $w$ é o deslocamento radial. A principal implicação física da @eq:clt_disp1 e @eq:clt_disp2 é a anulação das deformações por cisalhamento transversal elástico [25, 34]:

$ gamma_(r z) = 2 epsilon_(r z) = 0, quad gamma_(r theta) = 2 epsilon_(r theta) = 0 $ <eq:clt_shear>

A ausência de deformação de cisalhamento transversal restringe a aplicabilidade da CLT estritamente a cascas muito finas ($R_"int"/t >= 10$), uma vez que o erro introduzido ao ignorar a flexibilidade ao cisalhamento se propaga rapidamente para o cálculo de deflexões e frequências naturais à medida que a espessura aumenta [25, 34].

==== Teoria de Deformação por Cisalhamento de Primeira Ordem (FSDT)

Para contornar a rigidez excessiva da CLT, a Teoria de Deformação por Cisalhamento de Primeira Ordem (FSDT — *First-Order Shear Deformation Theory*), baseada no modelo de Mindlin-Reissner, relaxa a hipótese de normalidade. As seções retas e normais permanecem retas, mas não necessariamente perpendiculares à superfície média após a deformação [25, 34]. O campo de deslocamentos é expandido linearmente com a coordenada de espessura $z$ [25]:

$ u_z (r, theta, z) = u_z^0 (r, theta) + z phi_z (r, theta) $ <eq:fsdt_disp1>
$ u_theta (r, theta, z) = u_theta^0 (r, theta) + z phi_theta (r, theta) $ <eq:fsdt_disp2>

onde $phi_z$ e $phi_theta$ representam as rotações das seções transversais em torno dos eixos circunferenciais e axiais. Sob esta formulação, as deformações de cisalhamento transversal são constantes ao longo da espessura [34]:

$ gamma_(r z) (z) = phi_z + frac(partial w, partial z) = "constante" $ <eq:fsdt_shear>

Embora a FSDT capture a flexibilidade global ao cisalhamento, a premissa de deformação cisalhante constante ao longo da espessura viola a condição física de contorno de tensão nula nas superfícies livres superior e inferior do cilindro ($tau_(r z)|_(z = p m h/2) = 0$) [25]. Na realidade mecânica de um meio homogêneo, a distribuição de tensão de cisalhamento transversal assume um perfil parabólico. Para corrigir essa discrepância energética, a FSDT necessita da introdução de um fator de correção de cisalhamento ($kappa$), tipicamente adotado como $kappa = 5/6$ para seções retangulares homogêneas, o qual se torna altamente complexo e impreciso quando aplicado a laminados compostos heterogêneos [25, 34].

=== Limitações de Aplicação em Cilindros de Parede Grossa e Meios de Alto Contraste

No estudo mecânico de vasos de pressão como o analisado neste trabalho — que apresenta uma espessura de parede $t = 2" mm"$ e raio interno $R_"int" = 9" mm"$, resultando em uma relação geométrica de parede grossa $R_"int"/t = 4,5$ — as teorias de ESL clássicas (CLT e FSDT) tornam-se completamente inadequadas devido a três fatores impeditivos [25, 34, 42]:

1. *Inadmissibilidade de Tensão Radial Nula ($sigma_(r r) = 0$):* Ambas as teorias clássicas de placa assumem um estado plano de tensões, impondo $sigma_(r r) = 0$. Em vasos de parede grossa sob pressão interna $P_i = 10" MPa"$, a tensão radial $sigma_(r r)$ varia fortemente de $-10" MPa"$ na parede interna até atingir $0$ na face externa, atuando diretamente no escoamento plástico local e nas condições de contorno de equilíbrio [42].
2. *Ausência do Efeito de Compressibilidade:* As teorias ESL desprezam a deformação normal radial ($epsilon_(r r) = 0$). Em cilindros espessos bimetálicos, o contraste de coeficiente de Poisson induz efeitos de expansão diferencial localizados ao longo do raio que não podem ser negligenciados.
3. *Omissão das Deformações Interlaminares:* O salto de propriedades mecânicas entre o aço carbono e a liga de alumínio gera altas taxas de cisalhamento interlaminar concentradas junto às interfaces de colagem, fenômeno invisível às abordagens que suavizam as propriedades ao longo da espessura [34].

=== O Efeito Zigue-Zague (*Kinks*) nas Interfaces

Quando um cilindro ou casca multicamadas é composto por materiais com propriedades elásticas distintas (como o par aço/alumínio), as variáveis elásticas no plano e fora do plano comportam-se de forma descontínua nas interfaces. Esse fenômeno é governado de forma estrita pela mecânica do contato perfeito [34, 39].

Considere a interface perfeitamente aderida entre a camada $k$ e a camada $k+1$ localizada em uma coordenada radial $r = r_k$. As condições físicas de compatibilidade de deslocamento e continuidade de tração (ação e reação) exigem que [39]:

$ [[ u_i ]] = u_i^((k+1)) (r_k) - u_i^((k)) (r_k) = 0 $ <eq:cont_disp>
$ [[ sigma_(r i) ]] = sigma_(r i)^((k+1)) (r_k) - sigma_(r i)^((k)) (r_k) = 0, quad (i = r, theta, z) $ <eq:cont_stress>

A @eq:cont_disp impõe que o vetor de deslocamento seja contínuo ao longo de toda a espessura para evitar a abertura de vazios ou o escorregamento entre as fases. Da mesma forma, a @eq:cont_stress exige que a tensão normal radial ($sigma_(r r)$) e as tensões de cisalhamento transversal ($tau_(r z), tau_(r theta)$) sejam estritamente contínuas na interface para satisfazer o equilíbrio infinitesimal [39].

Contudo, os módulos de elasticidade e cisalhamento das fases sofrem saltos bruscos na transição das camadas (por exemplo, o módulo de cisalhamento do aço é cerca de três vezes superior ao do alumínio, $G_"aço" approx 77" GPa"$ vs $G_"alu" approx 26" GPa"$). Aplicando-se a Lei de Hooke para o cisalhamento transversal, temos [25]:

$ tau_(r z) = G(r) gamma_(r z) (r) $ <eq:hooke_shear>

Para garantir a continuidade da tensão de cisalhamento ($tau_(r z)^((k)) = tau_(r z)^((k+1))$) sob a descontinuidade abrupta do módulo de cisalhamento ($G^((k)) != G^((k+1))$), a deformação por cisalhamento transversal ($gamma_(r z)$) obrigatoriamente sofre um salto abrupto na interface [34]:

$ [[ gamma_(r z) ]] = tau_(r z) (r_k) ( frac(1, G^((k+1))) - frac(1, G^((k))) ) != 0 $ <eq:jump_shear>

Como a deformação por cisalhamento transversal $gamma_(r z)$ é diretamente proporcional à derivada do deslocamento longitudinal em relação ao raio ($partial_r u_z$), o salto na deformação manifesta-se matematicamente como uma *descontinuidade na primeira derivada do campo de deslocamentos* ($partial_r u_i$) [34].

Graficamente, esse fenômeno traduz-se em mudanças súbitas e localizadas de inclinação nas curvas de deslocamento radial ou axial exatamente nos pontos das interfaces elásticas, gerando o formato geométrico de "cotovelos" ou *"kinks"* conhecido na literatura científica de compósitos laminados como *comportamento em zigue-zague* (*zig-zag effect*) [34, 39]. As teorias ESL, por assumirem aproximações polinomiais contínuas (C¹-contínuas) de deslocamento ao longo de toda a espessura, são matematicamente incapazes de reproduzir esses kinks elásticos locais, resultando em subestimação severa das deformações interlaminares de cisalhamento [34].

=== Teorias Camada a Camada (*Layerwise*) e Teorias Zigue-Zague (ZZT)

Para representar com precisão física o efeito zigue-zague sem recorrer a simulações elásticas tridimensionais (3D) completas de altíssimo custo computacional, foram desenvolvidas formulações cinemáticas avançadas: as Teorias Camada a Camada (*Layerwise Theories*) e as Teorias Zigue-Zague (ZZT) [34].

1. *Teorias Camada a Camada (Layerwise):* Nesta abordagem, as equações de deslocamento 2D são formuladas de forma independente para cada uma das $N$ camadas do laminado, conectando as variáveis nas interfaces por equações de restrição de continuidade [34]. Embora extremamente precisas para capturar os "kinks" e as tensões interlaminares de borda livre, as teorias *layerwise* possuem a severa desvantagem de que o número total de variáveis de deslocamento (graus de liberdade) da estrutura cresce linearmente com o número de camadas ($N$), tornando o método proibitivo para cilindros de múltiplos períodos ou COPVs de dezenas de lâminas.
2. *Teorias Zigue-Zague (ZZT — Zig-Zag Theories):* As ZZT superam essa limitação ao enriquecer as teorias de camada única equivalente (como a FSDT) através da superposição de uma função em zigue-zague contínua por partes ($zeta_i (z)$) de amplitude variável, de modo a induzir de forma analítica a descontinuidade de derivada desejada nas interfaces [34]:
  $
    u_z (r, theta, z) = u_z^0 (r, theta) + z phi_z (r, theta) + sum_(k=1)^(N-1) zeta_k (z) hat(phi)_z^k (r, theta)
  $ <eq:zzt_disp>

As funções de enriquecimento $zeta_k (z)$ são pré-calculadas analiticamente de forma a satisfazer a priori as condições de continuidade de tensões interlaminares na interface (@eq:cont_stress). Como resultado prático, as Teorias Zigue-Zague conseguem capturar com precisão cirúrgica os "kinks" nos deslocamentos e prever o início de falhas por delaminação interlaminares mantendo o número total de graus de liberdade do modelo matemático independente do número de camadas do compósito, oferecendo uma excelente alternativa computacional para análises mecânicas locais [34]. #margin-note[Essa seção mostra outros métodos, como o zig-zag, que talvez seriam melhores para essa aplicação. Talvez eu deva retirar algumas.]

#task[
  - Objetivo B.4: Métodos de Homogeneização e a Transição Micro-Macro:
    * O que abordar:* Apresentar o conceito de representação homogênea equivalente para meios heterogêneos periódicos.
    * Rigor técnico:* Contrastar as abordagens clássicas de limites elásticos (médias de Voigt e Reuss) e a formulação de Backus para meios estratificados com o formalismo matemático do Método de Homogeneização Assintótica (MHA). Explicar os conceitos de célula unitária periódica (Y), parâmetro de escala espacial ($epsilon$) e a hipótese de convergência fraca quando $epsilon -> 0$.
    * Fontes-chave:* Bakhvalov & Panasenko (1989), Bruna Homogeneização (2017), David Guinovart (2015), e Parton & Kudryavtsev (1993).
]

=== Métodos de Homogeneização e a Transição Micro-Macro (Objetivo B.4)

A modelagem de materiais heterogêneos com microestrutura complexa impõe desafios severos à análise mecânica clássica. A presença de fases distintas com propriedades mecânicas discrepantes resulta em coeficientes elétricos ou elásticos que oscilam de forma extremamente rápida na escala microscópica. Resolver as equações de equilíbrio elástico em domínios dessa natureza por meio de técnicas discretas diretas, como o Método dos Elementos Finitos (MEF), exige um refinamento de malha tão severo que o custo computacional torna-se proibitivo para estruturas de escala industrial [7, 47]. Esta seção aborda a transição conceitual e matemática entre as escalas micro e macro, apresentando os limites elásticos clássicos, o modelo de médias de Backus para estratificados e o formalismo rigoroso do Método de Homogeneização Assintótica (MHA).

=== Abordagens Clássicas de Homogeneização e Limites Elásticos

Historicamente, o problema de determinar propriedades físicas efetivas para meios heterogêneos remonta a trabalhos fundamentais de Poisson, Maxwell, Rayleigh, Voigt e Reuss [39, 47]. No campo da mecânica dos sólidos, duas formulações fundamentais baseadas em médias volumétricas simples consolidaram-se como balizas analíticas:

1. *Abordagem de Voigt (Média Aritmética):* Assume que o campo de deformações é perfeitamente uniforme em todo o composto (hipótese de isodeformação ou _isostrain_). A rigidez efetiva equivalente $C_(i j)^V$ é calculada diretamente como a média aritmética ponderada pelas frações volumétricas das fases constituintes:
  $ C_(i j)^V = chevron.l C_(i j) (y) chevron.r = sum_(k=1)^(N) V_k C_(i j)^((k)) $ <eq:voigt_mean>
  onde $V_k$ representa a fração volumétrica da fase $k$ e $C_(i j)^((k))$ seu respectivo coeficiente elástico. Termodinamicamente, o modelo de Voigt estabelece o limite superior absoluto para a rigidez do composto [7, 47].

2. *Abordagem de Reuss (Média Harmônica):* Assume que o campo de tensões é uniforme ao longo de todo o domínio (hipótese de isotensão ou _isostress_). A compliância efetiva equivalente $S_(i j)^R$ (inverso da rigidez) é expressa como a média ponderada das compliâncias locais:
  $
    S_(i j)^R = chevron.l S_(i j) (y) chevron.r = sum_(k=1)^(N) V_k S_(i j)^((k)) quad arrow.r.double quad C_(i j)^R = chevron.l C_(i j)^(-1)(y) chevron.r^(-1)
  $ <eq:reuss_mean>
  A média de Reuss representa o limite inferior elástico da estrutura heterogênea [7, 47].

A diferença entre os limites de Voigt e Reuss é conhecida na literatura micromecânica como o *Garfo de Hill* (_Hill's fork_) [47]. Em materiais compósitos com alto contraste de rigidez entre as fases (como o par aço-alumínio ou fibra de carbono e resina epóxi), a distância entre os limites elásticos superior e inferior torna-se demasiadamente larga, de forma que as estimativas médias clássicas perdem a utilidade prática para o projeto estrutural de precisão. Isto justifica a necessidade de métodos matemáticos mais rigorosos, capazes de resolver as equações de célula local de forma exata.

=== Homogeneização de Meios Estratificados e a Média de Backus

Para estruturas compostas por camadas paralelas alternadas de materiais isotrópicos, George Backus (1962) deduziu uma formulação analítica exata que descreve o comportamento macroscópico equivalente de ondas elásticas de longo comprimento [14, 15, 39]. O modelo de Backus prova matematicamente que o empilhamento periódico de duas fases isotrópicas resulta em um meio macroscópico equivalente com comportamento *Transversalmente Isotrópico* [15, 39].

As equações de Backus misturam médias harmônicas (Reuss) para a direção perpendicular às interfaces e médias aritméticas com correções do efeito de Poisson (Voigt modificado) para as direções paralelas ao plano das camadas [15, 39]:
*Direção Transversal (Radial $r$):* O comportamento mecânico é dominado por tensões que atravessam as interfaces, assemelhando-se a molas em série. Portanto, a rigidez efetiva radial transversal é ditada pelo limite de Reuss:
$ C_(11) = chevron.l C_(11)^(-1)(y) chevron.r^(-1) $ <eq:backus_c11>
*Direções Paralelas (Circunferencial $theta$ e Axial $z$):* Como as camadas estão confinadas e ligadas rigidamente, elas deformam-se conjuntamente sob tração paralela (molas em paralelo). A rigidez efetiva circunferencial $C_(22)$ é expressa como uma média aritmética corrigida pelo acoplamento de Poisson das fases [15, 39]:
$
  C_(22) = chevron.l C_(22) (y) chevron.r - chevron.l nu(y) chevron.r^2 chevron.l C_(11)^(-1)(y) chevron.r^(-1)
$ <eq:backus_c22>

Sob a ótica do Método de Homogeneização Assintótica (MHA), quando o número de camadas concêntricas periódicas de um vaso de pressão cilíndrico aumenta substancialmente, a espessura de cada lâmina torna-se minúscula frente ao raio global ($epsilon arrow.r 0$). Nesse limite assintótico, a curvatura local do cilindro desaparece, de modo que a célula unitária anular microscópica comporta-se localmente como um laminado plano infinitesimal [15, 39]. Consequentemente, as formulações cartesianas de Backus e as teorias de meios estratificados de Bakhvalov são matematicamente válidas e rigorosas para caracterizar a ortotropia cilíndrica equivalente do vaso de pressão de parede grossa [15, 39].

=== Formalismo Matemático do Método de Homogeneização Assintótica (MHA)

O Método de Homogeneização Assintótica baseia-se no princípio da *separação de escalas* em meios microperiódicos [7, 39]. Define-se o parâmetro geométrico pequeno $epsilon$, que representa a razão adimensional entre as dimensões características da microescala (comprimento da célula unitária, $l$) e da macroescala (tamanho global do domínio elástico, $L$) [7, 39, 47]:
$ epsilon = l/L << 1 $ <eq:epsilon_param>

=== Variáveis Independentes e o Operador de Derivação
Em função do parâmetro $epsilon$, introduz-se uma nova variável espacial microscópica, denominada variável rápida ou local ($y$), em contraposição à variável macroscópica lenta ou global ($x$) [1, 7, 39]:
$ y = x/epsilon $ <eq:fast_var>

Pela regra da cadeia, qualquer derivada espacial de uma variável dependente elástica que oscile rapidamente com respeito à microestrutura periódica deve ser expressa em termos de ambas as escalas por [1, 7, 39, 47]:
$ d/(d x) = partial/(partial x) + 1/epsilon partial/(partial y) $ <eq:der_rule>

=== Proposta da Solução Assintótica Formal (SAF)
O MHA propõe que o campo de deslocamentos $u^epsilon(r)$ do cilindro heterogêneo original seja aproximado por uma série de potências do parâmetro adimensional pequeno $epsilon$, conhecida como Solução Assintótica Formal (SAF) [1, 7, 39, 47]:
$ u^(oo)(r, epsilon) = u_0(x) + epsilon u_1(x, y) + epsilon^2 u_2(x, y) + dots $ <eq:saf_disp>
onde os termos de perturbação $u_i (x, y)$ são funções $Y$-periódicas na variável rápida $y$ na escala da célula básica unitária $Y = [0, 1]$ [7, 39]. Na teoria clássica do MHA, prova-se que o termo principal $u_0$ não depende de $y$, representando o deslocamento macroscópico puro e regular do meio homogêneo equivalente [1, 7, 39].

=== Substituição e Recorrência de Problemas
#margin-note[Aqui já apresentamos parte da metodologia, mas não seria melhor deixar tirar essa parte e deixar para a própria metodologia?]
Substituindo a SAF dada pela @eq:saf_disp na equação governante do equilíbrio elástico radial e separando os coeficientes associados a cada potência de $epsilon$, obtém-se uma sequência recorrente de equações diferenciais elípticas [1, 7, 39]:

1. *Termos de Ordem $O(epsilon^(-2))$:*
  $ partial/(partial y) ( C_(11)(y) partial/(partial y) u_0(x) ) = 0 $ <eq:order_minus2>
  Como $u_0 = u_0(x)$, esta equação é identicamente nula, confirmando a independência de $u_0$ com respeito à variável rápida.

2. *Termos de Ordem $O(epsilon^(-1))$ (Problema Local):*
  $
    partial/(partial y) [ C_(11)(y) ( partial/(partial x) u_0(x) + partial/(partial y) u_1(x, y) ) ] = 0
  $ <eq:order_minus1>
  Utilizando a técnica de separação de variáveis de homogeneização, postula-se que a perturbação de primeira ordem $u_1$ é expressa pelo produto da derivada do deslocamento macroscópico por uma função auxiliar local $N_1(y)$, denominada função de perturbação da célula unitária [1, 7, 39]:
  $ u_1(x, y) = N_1(y) (d u_0(x))/(d x) $ <eq:u1_sep>
  Substituindo a @eq:u1_sep na @eq:order_minus1, isola-se a equação governante do *Problema Local* sobre a célula básica $Y$:
  $ d/(d y) ( C_(11)(y) (d N_1(y))/(d y) + C_(11)(y) ) = 0 $ <eq:local_problem_n1>
  Esta EDO deve ser resolvida sob as condições de $1$-periodicidade de $N_1(y)$ e normalização de média nula para garantir a unicidade de solução ($chevron.l N_1(y) chevron.r = 0$) [7, 39].

3. *Termos de Ordem $O(epsilon^0)$ (Problema Homogeneizado):*
  Coletando os termos de ordem neutra e aplicando o operador valor médio volumétrico $chevron.l dot chevron.r$ na célula unitária, as oscilações microscópicas rápidas se anulam por periodicidade, gerando a *Equação Homogeneizada Macroscópica* [1, 7, 39]:
  $ C_(11) (d^2 u_0(r))/(d r^2) + C_(11)/r (d u_0(r))/(d r) - C_(11)/r^2 u_0(r) = 0 $ <eq:homog_eq>
  onde os coeficientes efetivos homogeneizados equivalentes $C_(11)$ e $C_(12)$ do vaso de parede grossa são determinados analiticamente em termos das propriedades elásticas locais através de [7, 39]: #margin-note[Vou colocar o problema da Bruna no lugar do meu na revisão]
  $
    C_(11) = chevron.l C_(11)^(-1)(y) chevron.r^(-1) , quad C_(12) = chevron.l C_(11)^(-1)(y) chevron.r^(-1) chevron.l C_(12)(y) C_(11)^(-1)(y) chevron.r
  $ <eq:effective_coeffs>

== Rigor Matemático: H-Convergência e Relação de Proximidade

A validade científica do Método de Homogeneização Assintótica não se limita à obtenção de equações médias simplificadas, mas repousa sobre provas matemáticas rigorosas de convergência elíptica, no âmbito da chamada *H-Convergência* [39].

De acordo com Bakhvalov & Panasenko (1989) e Cioranescu & Donato (1999), prova-se que à medida que o parâmetro de escala espacial tende a zero ($epsilon arrow.r 0^+$), a solution exata heterogênea $u^epsilon$ do vaso de pressão original de $N$ camadas concêntricas converge fraca e continuamente em espaços de Sobolev (como $H^1(Omega)$) para a solução suave $u_0$ do problema macroscópico equivalente [7, 39]:
$ u^epsilon arrow.r u_0 \ quad \ "quando" \ \ epsilon arrow.r 0^+ $ <eq:weak_conv>

=== Estimativa de Erro e Relação de Proximidade
Para quantificar o erro cometido pela simplificação macroscópica homogeneizada, as dissertações de Bruna Leitzke (2017) e David Guinovart (2015) deduzem o teorema da relação de proximidade [7, 39]. A norma da diferença espacial entre a solução exata $u^epsilon$ e a SAF de primeira ordem $u^((1)) = u_0 + epsilon u_1$ é limitada superiormente por uma constante real positiva $C_k$ multiplicada pela escala do período $epsilon$ [7, 39]:
$
  norm(u^epsilon - u^((1)))_(C(Omega)) <= C_k epsilon quad arrow.r.double quad norm(u^epsilon - u^((1))) = O(epsilon)
$ <eq:closeness_error>

A @eq:closeness_error fornece o rigor matemático definitivo do método: ela garante que o erro de modelagem decresce de forma puramente linear e monótona com a redução da espessura das camadas elásticas (aumento de periodicidade), provando que o MHA é uma ferramenta assintoticamente exata para o projeto e otimização mecânica de cascas concêntricas e vasos multicamadas.

#task[
  - Objetivo B.5: O Método dos Elementos Finitos (MEF) e Simulação Computacional:
    * O que abordar:* Fundamentar o método numérico utilizado para resolver as equações governantes do cilindro heterogêneo e homogeneizado.
    * Rigor técnico:* Apresentar os conceitos de discretização de domínio, funções de forma de Lagrange e o processo de projeção variacional (Formulação Fraca). Justificar a adoção de elementos axissimétricos bidimensionais em softwares de código aberto (FEniCS) para a otimização de tempo e custo de simulação de vasos de pressão bimetálicos ou compósitos.
    * Fontes-chave:* Revisão Bibliográfica: MEF, e Elasticidade Axissimétrica com FEniCS.
]

== O Método dos Elementos Finitos e Simulação Computacional (Objetivo B.5)

Para problemas elásticos lineares em geometrias complexas ou com heterogeneidades de alta frequência espacial (como cascas bimetálicas de muitos períodos), as soluções analíticas fechadas tornam-se intratáveis ou exigem simplificações excessivamente restritivas. Nesses cenários, o Método dos Elementos Finitos (MEF) consolida-se como a ferramenta de modelagem numérica mais robusta para a análise de tensões e deformações [35, 235]. Esta seção apresenta os fundamentos matemáticos e algorítmicos do MEF aplicados à mecânica dos sólidos, detalhando a discretização do domínio, as funções de interpolação Lagrangeanas, a formulação variacional fraca com integração axissimétrica e a justificativa técnica para o uso do ambiente computacional FEniCS como solucionador de pesquisa [35, 312].

=== Discretização do Domínio e Funções de Interpolação Lagrangeanas

O princípio fundamental do MEF consiste em aproximar a solução de um problema contínuo infinito por meio da partição do domínio contínuo $Omega$ em um conjunto finito de subdomínios menores disjuntos denominados elementos finitos ($Omega_e$), de modo que [238]:

$ Omega approx union.sq_e Omega_e $

A conexão entre elementos adjuntos ocorre em pontos discretos chamados nós. Dentro de cada elemento $Omega_e$, os campos contínuos de deslocamento real $bold(u)(bold(x))$ e virtual $bold(v)(bold(x))$ são aproximados a partir de seus valores nodais discretos ($bold(d)^e$ e $bold(c)^e$, respectively) através de uma matriz de funções de forma (ou funções de interpolação) $bold(N)(bold(x))$ [238]:

$ bold(u)(bold(x)) approx bold(N)(bold(x)) bold(d)^e , quad bold(v)(bold(x)) approx bold(N)(bold(x)) bold(c)^e $

No desenvolvimento deste trabalho, adota-se os elementos elásticos de *Lagrange de grau 2* (elementos quadráticos) [300]. Ao contrário dos elementos de grau 1 (lineares), onde as derivadas primeiras do deslocamento (deformações) são constantes dentro do elemento, os polinômios quadráticos inserem nós adicionais nas arestas dos elementos. Isto confere as seguintes vantagens físicas [230, 242]:

1. *Captura de Gradientes Suaves:* Permite que o campo de deslocamentos assuma perfis parabólicos locais, o que melhora significativamente a estimativa de gradientes e picos de deformação em cascas delgadas e interfaces bimetálicas.
2. *Minimização do Cisalhamento Parasita (Shear Locking):* Evita a rigidez artificial excessiva que afeta elementos lineares sob estados de flexão ou cisalhamento transversal intenso.
3. *Acurácia nas Tensões:* Como a deformação $bold(epsilon)$ depende de derivadas espaciais do deslocamento ($bold(epsilon) = bold(S) bold(u)$), o uso de polinômios quadráticos para $bold(u)$ garante que o campo de tensões $bold(sigma)$ varie linearmente ao longo do elemento, fornecendo excelente precisão na interface de descontinuidade elástica [230, 243].

=== Formulação Variacional Fraca e a Métrica Axissimétrica

A equação governante do equilíbrio elástico tridimensional (equação de momento de Cauchy) na ausência de forças de corpo é expressa na forma forte como [277]:

$ - bold(nabla) dot bold(sigma) = bold(0) , quad bold(x) in Omega $

Para transpor o problema do espaço diferencial de Sobolev para uma formulação integral solúvel numericamente, aplica-se o Princípio dos Trabalhos Virtuais (PTV) ou o Método de Galerkin [242, 280]. Multiplica-se a equação de equilíbrio por um campo arbitrário de deslocamentos virtuais (função teste) $bold(v)$ pertencente ao espaço admissível $bold(V)_0$ (onde $bold(v) = bold(0)$ sobre a fronteira de Dirichlet $Gamma_u$), integrando-se sobre todo o volume do corpo [280, 306]:

$ - integral_Omega (bold(nabla) dot bold(sigma)) dot bold(v) d Omega = 0 $

Aplicando o teorema da divergência de Gauss e a integração por partes no termo de maior ordem (para reduzir a exigência de diferenciabilidade da solução de $C^2$ para $C^1$), obtém-se a *Formulação Fraca Clássica* da elasticidade linear [243, 280]:

$ integral_Omega bold(sigma)(bold(u)) : bold(epsilon)(bold(v)) d Omega = integral_(Gamma_t) bold(t)^T bold(v) d S $

onde $bold(sigma)(bold(u)) = bold(cal(C)) : bold(epsilon)(bold(u))$ é a relação constitutiva governada pela Lei de Hooke e $bold(epsilon)(bold(v)) = 1/2 (bold(nabla) bold(v) + bold(nabla) bold(v)^T)$ é o tensor de deformações virtuais simétrico [280, 289].

No caso específico de vasos de pressão cilíndricos longos sob carregamento puramente radial, a simetria de revolução em torno do eixo de rotação $z$ estabelece um estado de *elasticidade axissimétrica* [189]. Sob esta hipótese física, os campos de deslocamento e tensão tornam-se independentes da coordenada angular $theta$ ($partial_theta (\cdot) = 0$), e a componente circunferencial do deslocamento é nula ($u_theta = 0$), reduzindo o problema elástico tridimensional (3D) para um domínio de seção transversal bidimensional (2D) no plano radial-axial $r-z$ [190, 287].

Esta redução simplifica drasticamente o custo computacional, mas exige um tratamento matemático rigoroso na integração de volume [190]. O elemento de volume infinitesimal em coordenadas cilíndricas é definido como $d Omega = r d r d theta d z$. Como nenhum termo depende da variável angular $theta$, a integração direta ao longo da circunferência ($0$ a $2 pi$) resulta em uma constante multiplicadora de $2 pi$. Assim, a integral tridimensional é convertida em uma integral bidimensional ponderada pelo raio $r$ [190]:

$ integral_Omega (dot) d Omega = 2 pi integral_(Omega_(r z)) (dot) r d r d z $

Omitindo-se o fator constante $2 pi$ presente em ambos os lados da equação fraca, a forma bilinear $a(bold(u), bold(v))$ e o funcional linear de carga $L(bold(v))$ em coordenadas de revolução axissimétricas são redefinidos como [306, 307]:

$ a(bold(u), bold(v)) = integral_(Omega_(r z)) bold(sigma)(bold(u)) : bold(epsilon)(bold(v)) r d r d z $
$ L(bold(v)) = integral_(Gamma_(i n t)) bold(t)^T bold(v) r d S $

Nesta formulação, o tensor de deformações $bold(epsilon)$ em coordenadas axissimétricas deve incluir obrigatoriamente a *deformação circunferencial* (ou de expansão radial, _hoop strain_), expressa como $epsilon_(theta theta) = u_r / r$ [190, 293]:

$
  bold(epsilon)(bold(u)) = mat(
    partial_r u_r, 0, (partial_z u_r + partial_r u_z) / 2;
    0, u_r / r, 0;
    (partial_z u_r + partial_r u_z) / 2, 0, partial_z u_z
  )
$

Note que o termo de expansão $u_r/r$ introduz uma singularidade matemática intrínseca quando o raio $r \to 0$ [190]. No entanto, para o caso de vasos de pressão ocos com raio interno positivo ($R_{"int"} > 0$), a formulação permanece perfeitamente regular, suave e elíptica.

=== Discretização de Galerkin e a Matriz de Rigidez

Substituindo a aproximação discreta dos deslocamentos e deformações locais em nível de elemento finito ($Omega_e$), e adotando a notação matricial de Voigt para o produto interno duplo de tensores ($bold(sigma) : bold(epsilon) = bold(epsilon)^T bold(sigma)$), a integral bilinear interna do elemento resulta em [237, 281]:

$
  integral_(Omega_e) bold(sigma)(bold(u)) : bold(epsilon)(bold(v)) r d r d z = bold(c)^e^T [ integral_(Omega_e) bold(B)^T bold(cal(C)) bold(B) r d r d z ] bold(d)^e
$

onde $bold(B)$ representa a matriz cinemática (que relaciona as deformações com os deslocamentos nodais, contendo as derivadas das funções de forma e os termos de divisão $N_i/r$) e $bold(cal(C))$ é a matriz de elasticidade constitutiva do material [239, 281].

Como as variações virtuais nodais $bold(c)^e$ são arbitrárias, o termo entre colchetes define a *Matriz de Rigidez Local do Elemento* $bold(K)^e$ [282]:

$ bold(K)^e = integral_(Omega_e) bold(B)^T bold(cal(C)) bold(B) r d r d z $

O sistema linear global é construído por meio do processo de montagem (_assembly_), em que as matrizes de rigidez locais e os vetores de força nodais locais ($bold(F)^e$) de todos os elementos são agregados nos respectivos graus de liberdade globais por meio do operador clássico de superposição [236, 283]:

$ bold(K) = bold(A)_(e=1)^(N_{"el"}) bold(K)^e , quad bold(F) = bold(A)_(e=1)^(N_{"el"}) bold(F)^e $

O equilíbrio final do sistema discreto resulta no sistema algébrico global [284]:

$ bold(K) bold(D) = bold(F) $

Uma vez resolvido o sistema para o vetor de deslocamentos globais $bold(D)$, as deformações e tensões locais de Von Mises em cada ponto de integração Gaussiana são calculadas diretamente a partir das derivadas locais das funções de interpolação [242, 243].

=== Justificativa de Uso da Plataforma Computacional FEniCS

A simulação computacional de materiais compósitos microperiódicos com alta densidade de camadas (elevado número de períodos $N$) impõe severos desafios no uso de softwares de elementos finitos comerciais como Abaqus ou Ansys [124, 267]. Embora tais softwares sejam consolidados na engenharia para análises macroscópicas, eles operam amplamente como os chamados sistemas "caixa-preta", onde as equações constitutivas e os elementos finitos axissimétricos são pré-compilados rigidamente [124, 126].

A modificação de leis elásticas para incorporar o tensor homogeneizado complexo do MHA ou para testar geometrias exóticas (como cilindros elípticos heterogêneos) em softwares comerciais exige o desenvolvimento de sub-rotinas complexas em Fortran ou C++ (como a UMAT ou UEL no Abaqus), que demandam alto custo de desenvolvimento e geram dificuldades de estabilização numérica [126].

Em contrapartida, a escolha da plataforma de código aberto *FEniCS* blinda o presente estudo sob uma perspectiva científica e operacional pelas seguintes razões [127, 312]:

1. *Programação Direta em Linguagem de Formas Unificadas (UFL):* O FEniCS permite escrever a forma bilinear $a(bold(u), bold(v))$ e o funcional elástico $L(bold(v))$ diretamente em sintaxe matemática de alto nível (Python/C++). O compilador de formas do FEniCS (FFC) encarrega-se de realizar a diferenciação automática e a integração numérica de forma transparente e otimizada [127].
2. *Controle Absoluto da Microestrutura:* A criação de centenas de camadas periódicas concêntricas de materiais alternados (como aço e alumínio) é automatizada diretamente por meio do desenvolvimento de expressões de propriedades elásticas espaciais em Python (classe `PeriodicProperty`), eliminando a necessidade de modelagem e costura manual de centenas de retângulos concêntricos na interface gráfica (CAD) [126, 302].
3. *Integração Natural MHA-MEF:* Como o FEniCS possui total flexibilidade para redefinir as componentes da matriz constitutiva ponto a ponto, é possível calcular os coeficientes efetivos do MHA analiticamente e, na linha de instrução subsequente, alimentar diretamente o solver macroscópico com o tensor elástico homogeneizado equivalente, garantindo um fluxo de processamento de frações de segundo contra minutos ou horas exigidos pela modelagem detalhada tradicional [126, 308].


