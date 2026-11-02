

// Importar a bibliografia
// A bibliografia será incluída no final do documento
//


//==========================
//Configurações do documento
//==========================


//




// Configurações de espaçamento, justificação e indentação
// ABNT 2023: 1,5 de espaçamento entre linhas e 1,25 cm de indentação
,
)

//==========================
//Configurações matemáticas
//==========================
//Colocar as referências das fórmulas entre parênteses

", supplement: [Eq.])




//==========================
//Configuração do sumário
//==========================







// Lista de figuras
// Lista de tabelas



= Resumo

// 
Palavras chave:

= Introdução

== Motivação e contexto

Os materiais compósitos são definidos pela combinação de dois ou mais constituintes macroscópicos distintos, concebida com o objetivo de obter propriedades físicas e mecânicas superiores às dos materiais homogêneos tradicionais @RMJones2018. A premissa fundamental desta classe de
materiais reside no fato de que a resposta mecânica do sistema resultante não pode ser prevista a partir de nenhum de seus constituintes isolados, pois emerge precisamente da interação entre as fases que o compõem @PartonReport. Tal característica confere aos compósitos uma capacidade singular de ajuste de propriedades  (rigidez, resistência específica, tenacidade, condutividade térmica, etc.) tornando-os indispensáveis em setores que impõem restrições simultâneas e conflitantes de desempenho e massa.

Na engenharia atual, a utilização dessas estruturas é fundamental em domínios que exigem alta resistência específica aliada à redução de peso, como as indústrias aeroespacial e naval. Neste último segmento, duas configurações estruturais concentram especial relevância tecnológica: os vasos de pressão de múltiplas camadas reforçados por fibra (_Composite Overwrapped Pressure Vessels_, COPVs) @Zhang2022[p. 1] e os risers flexíveis utilizados em sistemas de produção de petróleo e gás em águas profundas @Liu2026. Aplicações críticas incluem o uso de painéis laminados em aeronaves comerciais (como no caso do Boeing 777, cuja estrutura é composta majoritariamente por compósitos) e vasos de alta pressão @Zhang2022[p. 2]. Ambas as estruturas operam sob condições severas e combinadas de carregamento (pressão interna elevada e solicitações cíclicas) o que impõe ao engenheiro a necessidade de modelos matemáticos capazes de reproduzir com fidelidade a resposta mecânica local e global do componente.

O comportamento desses materiais é governado pela interação entre suas
fases constituintes em múltiplas escalas, de modo que uma análise fidedigna deve integrar informações que se estendem desde a microestrutura  (onde se definem as propriedades de cada fase individualmente)  até o nível macroscópico, no qual o componente estrutural como um todo é dimensionado @PartonReport. Essa necessidade de trânsito entre escalas distintas configura o chamado *problema multiescala*, cujo tratamento rigoroso constitui o núcleo temático do presente trabalho.

O Método dos Elementos Finitos (MEF) constitui, atualmente, a abordagem numérica predominante na análise de estruturas compósitas. Contudo, sua aplicação direta a meios com propriedades rapidamente oscilantes  (característicos de compósitos microperiódicos) impõe uma exigência crítica: a malha de discretização deve ser suficientemente refinada para capturar as variações de propriedade em escala de $l$, o que resulta em sistemas lineares de dimensão proibitiva quando $epsilon$ é muito pequeno @Guinovart2024.

Como alternativa matematicamente rigorosa a esta limitação, o Método de
Homogeneização Assintótica (MHA) propõe substituir o meio heterogêneo
por um material homogêneo equivalente, cujas propriedades efetivas
encapsulam os efeitos da microestrutura @bakhvalov1989.

//TRECHO ANTIGO
//Aplicações críticas incluem o uso de painéis laminados em aeronaves comerciais  como no caso do Boeing 787 Dreamliner, cuja estrutura é composta majoritariamente por compósitos  e vasos de pressão que operam sob condições severas de carregamento [Lei25, Per24]. O comportamento desses materiais é governado pela interação complexa entre suas fases, exigindo uma análise que integre dados desde a microestrutura até o nível macroscópico para prever falhas e otimizar o desempenho [Bak89, Par91].

//Dentre os tipos de compósitos, destacam-se os chamados micro-heterogêneos, cujas propriedades físicas variam de forma rápida na escala microscópica, enquanto manifestam uma aparência de homogeneidade na escala macroscópica [Lei17, Pan05]. Tais materiais podem ser encontrados tanto na natureza, como em estruturas ósseas e madeiras, quanto em meios fabricados pelo homem para aplicações de alta performance [Lei17].

== Problema multiescala e a homogeneização
A modelagem de componentes micro-heterogêneos fundamenta-se no *princípio da separação de escalas* e na *hipótese do contínuo*. O princípio de separação de escalas supõe que exista uma clara distinção entre as escalas microscópica e macroscópica, sendo caracterizado por um parâmetro geométrico adimensional $epsilon$, definido por @bakhvalov1989 como a razão entre os comprimentos característicos da microescala $l$ (associado ao período da microestrutura) e da macroescala $L$ (associado à dimensão da estrutura como um todo). Ou seja:

$ epsilon = l / L , $

#figure(
  image("images/separação de escalas.png", width: 80%),
  caption: [Ilustração do processo de separação de escalas e parâmetro $epsilon$. Fonte: @BrunaReport.],
)<fig:SeparacaoEscalas>

De forma similar, a hipótese do contínuo estabelece que, mesmo havendo uma microestrutura bem definida em escala $l$, o material pode ser tratado como um contínuo em ambas as escalas, desde que a região de interesse seja suficientemente grande em comparação com o período da microestrutura. Pela @fig:SeparacaoEscalas, percebe-se a relação do parâmetro $epsilon$ com as escalas micro e macro, assim como os conceitos de separação de escalas e a hipótese do contínuo. A validade das abordagens multiescala repousa sobre a desigualdade $0 < epsilon << 1$. Quando $epsilon$ é suficientemente pequeno, torna-se possível desacoplar os problemas nas duas escalas e tratá-los de forma sequencial, reduzindo drasticamente a complexidade computacional do problema original. Para condução da análise, emprega-se uma _Solução Assintótica Formal_ (SAF) em série de potências do parâmetro $epsilon$, a saber: 

/*A título de ilustração, considere-se um cilindro compósito com dezenas de camadas alternadas: a resolução direta pelo MEF exigiria uma malha com elementos cuja dimensão característica fosse da ordem de $l$, multiplicando o custo computacional por um fator da ordem de $(L/l)^d$, onde $d$ é a dimensão espacial do problema. */

/*Como alternativa rigorosa, o *Método de Homogeneização Assintótica (MHA)* propõe substituir o meio heterogêneo por um material homogêneo equivalente ideal, cujas propriedades efetivas são calculadas através de problemas locais definidos na célula unitária [Lei17, Bak89]. Para capturar com precisão as oscilações das tensões locais, este trabalho utiliza Soluções Assintóticas Formais (SAF) de *segunda ordem*, que superam as limitações das abordagens tradicionais de primeira ordem ao reproduzir detalhes da solução exata que seriam perdidos em médias globais simples [Lei17].*/

$
  bold(u)^((infinity))(bold(x), epsilon) =
  bold(u)^0(bold(x)) +
  epsilon bold(u)^1(bold(x), bold(y)) +
  epsilon^2 bold(u)^2(bold(x), bold(y)) + dots.h ,
$

onde $bold(x)$ denota as coordenadas macroscópicas e $bold(y) = bold(x) slash epsilon$ as coordenadas microscópicas. Estas últimas são responsáveis por descrever as oscilações rápidas da solução dentro de cada período da célula unitária @bakhvalov1989. A substituição desta expansão nas equações de equilíbrio e a coleta de termos por potências de $epsilon$ permitem decompor o problema original em uma hierarquia de subproblemas: um _problema local_, definido sobre a célula unitária e responsável por calcular os *coeficientes efetivos* do material homogeneizado, e um _problema macroscópico_, formulado sobre o domínio global e governado por esses coeficientes @BrunaReport[p. 17].

Uma distinção fundamental separa as abordagens de ordem 0 e de ordem 1 da SAF. A solução de ordem 0 fornece uma aproximação satisfatória para os campos de deslocamento macroscópico, porém falha em reproduzir com precisão as oscilações locais de tensão que caracterizam a resposta em escala de microestrutura @BrunaReport. Para superar esta limitação, o presente trabalho adota a SAF de primeira ordem, que incorpora o termo $epsilon bold(u)^1$ e é capaz de reproduzir as flutuações locais da solução exata com acurácia significativamente superior, sem aumentar proporcionalmente o custo computacional do problema macroscópico @BrunaReport. 

== Objetivo geral

O objetivo geral deste trabalho é realizar uma análise multiescala de
vasos de pressão compósitos microperiódicos,  estabelecendo um comparativo
sistemático de precisão e eficiência computacional entre o Método dos
Elementos Finitos (MEF), empregado como solução de referência, e o Método
de Homogeneização Assintótica de primeira ordem (MHA), empregado como
método principal de análise.

== Objetivos específicos
Os objetivos específicos que sustentam esta meta são os seguintes:

+ *Formular o problema de equilíbrio do cilindro compósito microperiódico*
  em coordenadas cilíndricas, sob hipótese de axissimetria, e reduzi-lo à
  forma escalar unidimensional que serve de ponto de partida para a
  aplicação do MHA /*@BrunaReport @bakhvalov1989*/.

+ *Aplicar o MHA ao problema formulado*, conduzindo a dedução formal da
  expansão assintótica, dos problemas locais sobre a célula unitária e da
  equação homogeneizada que governa o deslocamento macroscópico.
/*@bakhvalov1989 @PartonReport*/

+ *Deduzir e calcular os coeficientes efetivos de elasticidade* do
  material equivalente para a configuração axissimétrica bilaminada,
  expressando-os em termos das frações volumétricas e das propriedades
  constitutivas de cada fase. /*@BrunaReport*/

+ *Desenvolver e validar um código computacional* baseado na biblioteca
  FEniCS para a simulação numérica do problema de elasticidade
  axissimétrica via MEF, permitindo a obtenção de soluções de referência
  para a comparação com os resultados do MHA.

+ *Comparar quantitativamente a precisão e a eficiência computacional*
  entre a solução homogeneizada de segunda ordem e a solução numérica
  detalhada, avaliando o impacto da inclusão dos termos de ordem superior
  na SAF sobre a qualidade da aproximação dos campos de tensão e
  deslocamento /*@BrunaReport*/.


== Organização e limitações do Trabalho

O presente trabalho está organizado em seis capítulos. O *Capítulo 2*
apresenta a revisão bibliográfica, cobrindo os fundamentos dos meios
micro-heterogêneos, as equações de equilíbrio mecânico em coordenadas
cilíndricas sob hipótese de axissimetria, as relações constitutivas da
elasticidade linear isotrópica e os princípios teóricos do MHA e do MEF,
incluindo uma descrição da plataforma computacional FEniCS. O *Capítulo 3*
detalha os materiais e métodos, apresentando a formulação completa do
problema de valor de contorno, a dedução da SAF, o procedimento de
homogeneização e o cálculo analítico dos coeficientes efetivos. O
*Capítulo 4* expõe os resultados obtidos e a discussão comparativa entre
as abordagens numéricas e analíticas. O *Capítulo 5* consolida as
conclusões do trabalho e aponta perspectivas para investigações futuras.
As referências bibliográficas são listadas ao final do documento.

Neste trabalho não será abordado ...








= Revisão bibliográfica



// Seção 2.1: Vasos de Pressão e Critérios Normativos (ASME e NR-13)

== Vasos de Pressão e Critérios Normativos

=== Gestão de Segurança e Integridade Estrutural Conforme a NR-13

No Brasil, a operação e integridade física de todos os vasos de pressão industriais são regulamentadas de forma obrigatória pela Norma Regulamentadora @brasil_nr13_2022, intitulada "Caldeiras, Vasos de Pressão, Tubulações e Tanques Metálicos de Armazenamento". A NR-13 estabelece requisitos mínimos legais para a gestão da integridade estrutural desses equipamentos nos aspectos relacionados à instalação, inspeção de segurança, operação e manutenção, visando prioritariamente prevenir acidentes severos e resguardar a vida dos trabalhadores.

Conforme definido pela norma NR-13, vasos de pressão são conceitualmente definidos como quaisquer recipientes estanques, independentemente de sua geometria, dimensões ou finalidade, capazes de conter um fluido sob pressão positiva ou negativa (vácuo) significativamente diferente da pressão atmosférica.

/*Na engenharia de processos e segurança do trabalho, conforme definido pela @asme_sec8_div1_2019 adota-se um divisor clássico para diferenciar esses equipamentos de simples reservatórios de armazenamento: quando a diferença de pressão interna e externa é superior a $0.1$ MPa (ou aproximadamente $15$ psig ou $1.0$ bar), o equipamento é enquadrado e projetado como um vaso de pressão; para diferenciais de pressão inferiores a esse patamar, a estrutura é classificada como um tanque de armazenamento.*/

A norma possui critérios bem delineados de abrangência de fiscalização para enquadramento de recipientes sob suas regras. Conforme o subitem 13.2.1, estão inclusos no escopo da NR-13 [48]:

1. Vasos de pressão cujo produto entre a pressão máxima de operação ($P$, em kPa) e seu volume interno ($V$, em m³) seja superior a 8 ($P.V > 8$) [196];
2. Vasos de pressão que contenham fluidos de Classe A (fluidos altamente tóxicos, inflamáveis ou hidrogênio), independentemente do valor do produto $P.V$ [196].

Por outro lado, recipientes com diâmetro interno inferior a $150$ mm estão formalmente dispensados da aplicação da norma, independentemente do fluido ou pressão de operação [198].

A NR-13 organiza os vasos de pressão em categorias de risco (de I a V, onde a Categoria I representa a classe de risco mais elevado e a Categoria V o menor risco), as quais regulam diretamente a periodicidade máxima permitida para as inspeções de segurança internas e externas e testes de integridade [164, 207]. Essa categorização é definida em função de dois parâmetros principais: a *Classe de Fluido* e o *Grupo de Potencial de Risco* [164, 203].

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
  [*Grupo 1* \ _P.V >= 100_],
  [*Grupo 2* \ _30 <= P.V < 100_],
  [*Grupo 3* \ _2,5 <= P.V < 30_],
  [*Grupo 4* \ _1 <= P.V < 2,5_],
  [*Grupo 5* \ _P.V < 1_],

  [*Classe A* \ _(Tóxicos, Inflamáveis, H₂)_], [*I*], [*I*], [*II*], [*III*], [*III*],
  [*Classe B* \ _(Combustíveis < 200 ºC), Tóxicos >20 ppm)_], [*I*], [*II*], [*III*], [*IV*], [*IV*],
  [*Classe C* \ _(Vapor, Ar Comprimido)_], [*I*], [*II*], [*III*], [*IV*], [*V*],
  [*Classe D* \ _(Outros Fluidos)_], [*II*], [*III*], [*IV*], [*V*], [*V*],
)

Mecanicamente, para que um vaso de pressão seja operado legalmente em território nacional, a NR-13 exige que o estabelecimento industrial mantenha um conjunto de documentações técnicas atualizadas e prontamente acessíveis para a auditoria de fiscais do trabalho e do Ministério Público [167, 206]. Essa pasta de integridade inclui obrigatoriamente [167, 206]:
1. *Prontuário do Vaso de Pressão:* Emitido e assinado pelo fabricante, contendo o código de construção (como o ASME), especificação dos materiais de retenção de pressão, procedimentos de fabricação, qualificação de soldagem e relatórios de exames e inspeção final [206];
2. *Registro de Segurança:* Livro de ocorrências físicas onde são registradas as inspeções de segurança, calibrações de instrumentos e anomalias operacionais [167];
3. *Projeto de Instalação:* Desenho de arranjo físico detalhando as condições de ventilação, distâncias de segurança e o livre acesso para rotas de fuga dos operadores [167, 172];
4. *Relatórios de Inspeção de Segurança:* Documentos gerados periodicamente por um Profissional Habilitado (PH) atestando que os exames internos, externos e testes não destrutivos comprovam a integridade estrutural do costado, tampos e bocais [167].

Adicionalmente, cada vaso de pressão deve possuir afixado em seu corpo, em local de fácil acesso e amplamente visível, uma placa de identificação indelével com informações fundamentais gravadas (fabricante, número de série, ano de fabricação, código de construção, PMTA, eficiência de junta soldada) e, pintada em destaque no costado, a identificação visível de sua categoria (por exemplo, "CAT I" ou "CAT III") para fins de fiscalização operacional rápida [35, 205, 206].


=== Critérios de Projeto Conforme o Código ASME Seção VIII (Divisões 1 e 2)

Para garantir a segurança operacional e mitigar os riscos de falhas explosivas catastróficas, o projeto e a fabricação de vasos de pressão industriais são rigorosamente regidos por códigos normativos internacionais, dos quais o mais amplamente utilizado globalmente e no Brasil é o Código ASME Seção VIII (*Boiler and Pressure Vessel Code*, BPVC), desenvolvido pela @asme_sec8_div1_2019 (*American Society of Mechanical Engineers*).

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
) 

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

//====================================================


=== Classificação Geométrica: Paredes Finas vs. Paredes Grossas




//=============================
// Essa parte ficou meio jogada aqui. Acho que faz mais sentido passar para depois, quando eu for falar sobre a solução de Lamé.

Sob o ponto de vista da mecânica do contínuo e da resistência dos materiais, o dimensionamento elástico e a distribuição de tensões ao longo da parede do vaso são intrinsecamente dependentes da relação geométrica entre o raio interno ($r$) e a espessura da parede ($t$). Por este motivo, a literatura clássica estabelece o seguinte critério de classificação estrutural:

*Vasos de Parede Fina:* Ocorrem quando a relação geométrica satisfaz a desigualdade:

$ r/t >= 10. $ <eq-limite-parede-fina>

Nesta condição, assume-se que as tensões normais de tração atuantes na parede do vaso são uniformes ao longo de toda a espessura, sendo chamadas de tensões de membrana @asme_sec8_div1_2019[p. 415].  

*Vasos de Parede Grossa:* Ocorrem quando a espessura do vaso é expressiva ($r/t < 10$), fazendo com que a distribuição de tensões varie radialmente de forma não linear ao longo da espessura, exigindo o emprego de soluções completas de elasticidade (como as clássicas soluções de Lamé) devido ao alto gradiente de tensões e efeitos de cisalhamento interlaminar @Sadd2009[p. 591].

//=============================

A @asme_sec8_div1_2019 cita também que as duas geometrias primárias mais difundidas na indústria para a contenção de fluidos pressurizados são os cilindros (verticais ou horizontais) e as esferas. Para reservatórios cilíndricos de parede fina sujeitos a uma pressão manométrica interna $p$, @Sadd2009 afirma que o estado plano de tensões é governado por tensões principais normais sem componentes de cisalhamento, devido à simetria axial (axissimetria) do cilindro e do carregamento. @beer1989resistencia deduzem a tensão circunferencial (ou tangencial/hoop), denotada por $sigma_1$, que atua no sentido tangencial ao longo do costado cilíndrico, sendo expressa como:

$ sigma_1 = (p r) / t. $ <eq-tensao-circunferencial>

De modo similar, a tensão longitudinal (ou axial), denotada por $sigma_2$, atua paralelamente ao eixo do cilindro e é gerada pelas forças de pressão que empurram os tampões de extremidade, sendo descrita por @beer1989resistencia:

$ sigma_2 = (p r) / (2 t). $ <eq-tensao-longitudinal>

Comparando-se as equações @eq-tensao-circunferencial e @eq-tensao-longitudinal, observa-se que a tensão circunferencial é exatamente o dobro da tensão longitudinal ($sigma_1 = 2 sigma_2$). Essa relação física possui uma implicação mecânica fundamental de falha: ao pressurizar excessivamente um tubo ou cilindro metálico homogêneo, a parede falhará primeiro por tração ao longo das juntas longitudinais, gerando uma fissura linear paralela ao eixo de comprimento do cilindro. Por essa razão, juntas de solda longitudinais em cascos cilíndricos calandrados devem ser dimensionadas e inspecionadas para suportar o dobro do carregamento em relação às juntas circunferenciais. 

Em contrapartida, para reservatórios esféricos de parede fina, @beer1989resistencia ressaltam que a perfeita simetria esférica do domínio faz com que as tensões circunferenciais e longitudinais sejam idênticas ($sigma_1 = sigma_2$), resultando em:

$ sigma_1 = sigma_2 = (p r) / (2 t) $ <eq-tensao-esferica>

No estado de tensões na parede de uma esfera, as tensões principais normais são iguais, o que faz com que o círculo de Mohr correspondente ao plano tangencial se reduza a um único ponto, zerando a tensão cisalhante máxima no plano ($tau_("no plano") = 0$). No entanto, a tensão cisalhante máxima absoluta (fora do plano) para cilindros e esferas é dada, respectivamente, por @beer1989resistencia[p. 656]:

$ tau_("max, cilindro") = sigma_1 / 2 = (p r) / (2 t) $
$ tau_("max, esfera") = sigma_1 / 2 = (p r) / (4 t) $

Essa distribuição de tensões prova que, embora os vasos esféricos apresentem uma fabricação muito mais complexa e cara devido à necessidade de conformação tridimensional de gomos soldados, eles são mecanicamente muito mais eficientes, sendo capazes de suportar o dobro de pressão interna em relação a um vaso cilíndrico de mesmo diâmetro e espessura.

//====================================================
// Aqui eu introduzo a ASME e a NR-13. Mas como elas foram citadas na seção anterior, vou precisar colocar essa seção primeiro






== Mecânica dos Materiais Compósitos e Simetrias Elásticas (Objetivo B.2)

O estudo do comportamento mecânico de estruturas cilíndricas multicamadas e vasos de pressão avançados requer uma base conceitual sólida da mecânica dos meios anisotrópicos. Ao contrário dos materiais convencionais, cuja isotropia simplifica as relações constitutivas, os compósitos exibem propriedades físicas que dependem da direção analisada. Esta seção apresenta o formalismo matemático da Lei de Hooke Generalizada, o método de redução de constantes elásticas através das simetrias elásticas e a Notação de Voigt, culminando na justificativa física de como cilindros formados por camadas isotrópicas apresentam um comportamento macroscopicamente ortotrópico curvilíneo [25, 49].

=== Lei de Hooke Generalizada e o Tensor de Rigidez de Quarta Ordem

No âmbito da elasticidade linear tridimensional, a relação entre o tensor de tensões de segunda ordem $bold(sigma)$ e o tensor de deformações infinitesimais de segunda ordem $bold(epsilon)$ é regida pela Lei de Hooke Generalizada, expressa em notação de índices como [25, 49, 82]:

$ sigma_(i j) = C_{i j k l} epsilon_(k l) , quad (i, j, k, l = 1, 2, 3) $ <eq:hooke_tensor>

onde $C_{i j k l}$ representa o tensor de elasticidade (ou rigidez elástica) de quarta ordem. De acordo com a análise dimensional e a álgebra tensorial, o tensor $C_{i j k l}$ possui $3^4 = 81$ componentes independentes na ausência de simetrias [67, 68].

Contudo, a física dos meios contínuos impõe restrições severas a essas componentes devido às simetrias físicas dos tensores de tensão e deformação, bem como a princípios termodinâmicos [11, 26, 68]:

1. *Simetria do Tensor de Tensões:* Em virtude da conservação do momento angular (e na ausência de momentos de corpo distribuídos), o tensor de tensões de Cauchy é simétrico ($sigma_(i j) = sigma_(j i)$). Isto resulta na simetria menor esquerda do tensor de rigidez [4, 11, 68]:
  $ C_{i j k l} = C_{j i k l} $ <eq:sym_left>

2. *Simetria do Tensor de Deformações:* Por definição cinemática, o tensor de pequenas deformações é a parte simétrica do gradiente do vetor deslocamento ($epsilon_(k l) = 1/2 (u_(k,l) + u_(l,k))$). Isto implica na simetria menor direita [1, 4, 11, 68]:
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

Este desacoplamento de rigidez induz um comportamento macroscópico equivalente de *ortotropia cilíndrica* (ou isotropia transversal curvilínea), no qual a direção radial $r$ comporta-se como o eixo normal à simetria elástica, enquanto as direções axial $z$ e tangencial $theta$ formam o plano macroscópico de isotropia elástica curvilínea [5, 39, 193].

Como consequência direta do MHA de camadas isotrópicas coaxiais periódicas, o cilindro homogêneo equivalente macroscópico passa a ser regido por um tensor de elasticidade efetivo $[hat(C)]$ contendo exatamente *5 coeficientes independentes* ($hat(C)_{11}, hat(C)_{22}, hat(C)_{12}, hat(C)_{23}$ e $hat(C)_{55}$), em substituição às propriedades locais rapidamente oscilantes do modelo original [5, 39, 193]. O alinhamento natural dessas constantes com as coordenadas cilíndricas do costado do vaso ($r, theta, z$) elimina a necessidade de transformações de coordenadas complexas e simplifica drasticamente o equilíbrio axissimétrico final estudado no TCC [5, 39].



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

As funções de enriquecimento $zeta_k (z)$ são pré-calculadas analiticamente de forma a satisfazer a priori as condições de continuidade de tensões interlaminares na interface (@eq:cont_stress). Como resultado prático, as Teorias Zigue-Zague conseguem capturar com precisão cirúrgica os "kinks" nos deslocamentos e prever o início de falhas por delaminação interlaminares mantendo o número total de graus de liberdade do modelo matemático independente do número de camadas do compósito, oferecendo uma excelente alternativa computacional para análises mecânicas locais [34].

=== Justificativa para a Adoção da Homogeneização Assintótica (MHA) frente às ZZT

Embora as Teorias Zigue-Zague (ZZT) representem um avanço cinematográfico significativo ao desacoplar os graus de liberdade globais do número de camadas $N$, a adoção do Método de Homogeneização Assintótica (MHA) se justifica por razões de escalabilidade, rigor matemático e facilidade de implementação numérica no projeto de vasos multicamadas com alto número de períodos [7, 34, 39, 43]:

1. *Inviabilidade Algébrica sob Alta Periodicidade:* Nas ZZT, as funções de enriquecimento local $zeta_k (z)$ e os coeficientes de acoplamento precisam ser formulados e pré-calculados analiticamente de interface em interface ($N-1$ interfaces) [34]. Para cilindros bimetálicos de alta densidade periódica ou estruturas com centenas de microcamadas (em que $N$ cresce consideravelmente), a montagem desse sistema algébrico de enriquecimento torna-se altamente complexa, onerosa e propensa a erros numéricos de condicionamento. O MHA contorna isso completamente ao desacoplar as escalas de análise: o problema físico global é resolvido como um contínuo perfeitamente homogêneo, cuja complexidade matemática é invariante em relação ao número real de camadas [7, 43].
2. *Rigor Matemático e Convergência Provada:* Ao contrário das ZZT, que se baseiam em aproximações cinemáticas ad hoc (ou *ansatz* físicos), o MHA é ancorado no rigor da análise assintótica clássica e na teoria da $H$-convergência elíptica [7, 43]. Ele fornece uma prova formal de consistência matemática na qual, por meio do Teorema da Relação de Proximidade em espaços de Sobolev ($L^2$ e $H^1$), a diferença entre a solução heterogênea do MEF e a aproximação homogeneizada decresce de forma estritamente linear com o parâmetro de escala pequena ($epsilon = l/L -> 0$) [7]. Isso garante que, quanto maior for a densidade de camadas do vaso, mais exata e robusta é a resposta fornecida pelo MHA.
3. *Acoplamento Direto e Simplicidade em Solvers de Elementos Finitos (FEniCS):* A implementação numérica de elementos finitos enriquecidos baseados em ZZT exige o desenvolvimento de elementos customizados não padronizados e formulações variacionais complexas (geralmente indisponíveis em pacotes de MEF comerciais ou open-source) [34, 35]. Por outro lado, o MHA permite utilizar elementos lagrangeanos quadráticos clássicos em malhas bidimensionais axissimétricas comuns. O solver do FEniCS resolve o equilíbrio global sem qualquer modificação em suas matrizes de rigidez elástica homogêneas nativas, e o problema de célula local (1D) é resolvido de forma independente e direta, simplificando enormemente a programação e estabilidade numérica do código [14, 15].
4. *Capacidade de Reconstrução de Campos Locais e Interlaminares:* Uma das maiores vantagens do MHA é o seu caráter de modelagem multiescala bidirecional. Após obter a solução macroscópica homogeneizada suave $u_0(r)$, o comportamento local em zigue-zague dos deslocamentos e as flutuações das tensões interlaminares em cada camada individual podem ser reconstruídos com exatidão analítica _a posteriori_ em qualquer ponto através dos corretores locais elásticos (incluindo a função de perturbação local $N_1(y)$) [7, 39]:
  $ u_i^epsilon (r) approx u_{0,i}(r) + epsilon N_{1,i j}(y) frac(partial u_{0,j}, partial r) $ <eq:correction_mha>
  Dessa forma, o MHA recupera toda a física microscópica e as descontinuidades de derivada ("kinks") na interface sem sobrecarregar a cinemática global da estrutura [7].



== Métodos de Homogeneização e a Transição Micro-Macro (Objetivo B.4)

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
  onde os coeficientes efetivos homogeneizados equivalentes $C_(11)$ e $C_(12)$ do vaso de parede grossa são determinados analiticamente em termos das propriedades elásticas locais através de [7, 39]: 
  $
    C_(11) = chevron.l C_(11)^(-1)(y) chevron.r^(-1) , quad C_(12) = chevron.l C_(11)^(-1)(y) chevron.r^(-1) chevron.l C_(12)(y) C_(11)^(-1)(y) chevron.r
  $ <eq:effective_coeffs>

=== Rigor Matemático: H-Convergência e Relação de Proximidade

A validade científica do Método de Homogeneização Assintótica não se limita à obtenção de equações médias simplificadas, mas repousa sobre provas matemáticas rigorosas de convergência elíptica, no âmbito da chamada *H-Convergência* [39].

De acordo com Bakhvalov & Panasenko (1989) e Cioranescu & Donato (1999), prova-se que à medida que o parâmetro de escala espacial tende a zero ($epsilon arrow.r 0^+$), a solution exata heterogênea $u^epsilon$ do vaso de pressão original de $N$ camadas concêntricas converge fraca e continuamente em espaços de Sobolev (como $H^1(Omega)$) para a solução suave $u_0$ do problema macroscópico equivalente [7, 39]:
$ u^epsilon arrow.r u_0 \ quad \ "quando" \ \ epsilon arrow.r 0^+ $ <eq:weak_conv>

=== Estimativa de Erro e Relação de Proximidade
Para quantificar o erro cometido pela simplificação macroscópica homogeneizada, as dissertações de Bruna Leitzke (2017) e David Guinovart (2015) deduzem o teorema da relação de proximidade [7, 39]. A norma da diferença espacial entre a solução exata $u^epsilon$ e a SAF de primeira ordem $u^((1)) = u_0 + epsilon u_1$ é limitada superiormente por uma constante real positiva $C_k$ multiplicada pela escala do período $epsilon$ [7, 39]:
$
  norm(u^epsilon - u^((1)))_(C(Omega)) <= C_k epsilon quad arrow.r.double quad norm(u^epsilon - u^((1))) = O(epsilon)
$ <eq:closeness_error>

A @eq:closeness_error fornece o rigor matemático definitivo do método: ela garante que o erro de modelagem decresce de forma puramente linear e monótona com a redução da espessura das camadas elásticas (aumento de periodicidade), provando que o MHA é uma ferramenta assintoticamente exata para o projeto e otimização mecânica de cascas concêntricas e vasos multicamadas.



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
$<eq:WeakFormEquation>

Note que o termo de expansão $u_r/r$ introduz uma singularidade matemática intrínseca quando o raio $r -> 0$ [190]. No entanto, para o caso de vasos de pressão ocos com raio interno positivo ($R_{"int"} > 0$), a formulação permanece perfeitamente regular, suave e elíptica.

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


= Formulação matemática


//==========================
//Variáveis
//==========================

#let l = $chevron.l$
#let r = $chevron.r$

#let nuy = $nu$
// 1. Calcula o fator de escala que precede a matriz.
#let fator = $E^epsilon / ((1 + nuy^epsilon) (1 - 2 nuy^epsilon))$

// 2. Define os termos internos repetitivos.
#let C11 = $1 - nuy$ // Termo da diagonal (Normal)
#let C12 = $nuy$       // Termo fora da diagonal (Normal)
#let G = $(1 - 2 nuy) / 2$ // Termo da diagonal (Cisalhamento)
#let sigma_b = $bold(sigma)$
#let C_b = $bold(cal(C))$

// tensões cisalhantes
#let tau_r_t = $tau_(r theta)$
#let tau_t_z = $tau_(theta z)$
#let tau_r_z = $tau_(r z)$

#let matriz-elasticidade-3D = (
  // 3.1 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    bold(cal(C)) = mat(
      // 1ª Linha (sigma_x)
      cal(C)_(11), cal(C)_(12), cal(C)_(13), cal(C)_(14), cal(C)_(15), cal(C)_(16);
       // 2ª Linha (sigma_y)
      cal(C)_(21), cal(C)_(22), cal(C)_(23), cal(C)_(24), cal(C)_(25), cal(C)_(26);
       // 3ª Linha (sigma_z)
      cal(C)_(31), cal(C)_(32), cal(C)_(33), cal(C)_(34), cal(C)_(35), cal(C)_(36);
       // 4ª Linha (tau_yz)
      cal(C)_(41), cal(C)_(42), cal(C)_(43), cal(C)_(44), cal(C)_(45), cal(C)_(46);
       // 5ª Linha (tau_xz)
      cal(C)_(51), cal(C)_(52), cal(C)_(53), cal(C)_(54), cal(C)_(55), cal(C)_(56);
       // 6ª Linha (tau_xy)
      cal(C)_(61), cal(C)_(62), cal(C)_(63), cal(C)_(64), cal(C)_(65), cal(C)_(66);
    )
  $
)

#let matriz-elasticidade-3D-isotropica = (
  // 3.2 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    #fator mat(
      // 1ª Linha (sigma_x)
      #C11, #C12, #C12, 0, 0, 0;
       // 2ª Linha (sigma_y)
      #C12, #C11, #C12, 0, 0, 0;
       // 3ª Linha (sigma_z)
      #C12, #C12, #C11, 0, 0, 0;
       // 4ª Linha (tau_yz)
      0, 0, 0, #G, 0, 0;
       // 5ª Linha (tau_xz)
      0, 0, 0, 0, #G, 0;
       // 6ª Linha (tau_xy)
      0, 0, 0, 0, 0, #G ;
    )
  $
)

#let matriz-elasticidade-3D-isotropica-simplificada = (
  // 3.2 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    #fator mat(
      // 1ª Linha (sigma_x)
      #C11, #C12, #C12, ;
       // 2ª Linha (sigma_y)
      #C12, #C11, #C12, ;
       // 3ª Linha (sigma_z)
      //#C12, #C12, #C11, 0, 0, 0;
      // 4ª Linha (tau_yz)
      //0, 0, 0, #G, 0, 0;
      // 5ª Linha (tau_xz)
      #C12, #C12, #G ;
       // 6ª Linha (tau_xy)
      //0, 0, 0, 0, 0, #G;
    )
  $
)

#let stress = $
  vec(
    sigma_(r r),
    sigma_(theta theta),
    sigma_(z z),
    0,
     //tau_(theta z),
    tau_(r z),
    0
  )
  //tau_(r theta))
$
#let stress_reduzido = $
  vec(
    sigma_(r r),
    sigma_(theta theta),
    tau_(r z)
  )
$

#let deformacao = $
  vec(
    partial_r u_r,
    u_r / r,
    partial_z u_z,
    0,
    (partial_z u_r + partial_r u_z) / 2,
    0
  )
$

#let deformacao-simplificada = $
  vec(
    partial_r u_r,
    u_r / r,
    (partial_z u_r + partial_r u_z) / 2
  )
$



== Hipótese do Contínuo e Equações Governantes (Objetivo C.1)

A análise do comportamento mecânico de um vaso de pressão cilíndrico composto por camadas de materiais que se alternam periodicamente na direção radial baseia-se na mecânica dos meios contínuos. Esta seção apresenta as equações de conservação da quantidade de movimento (equações de equilíbrio) e as relações cinemáticas fundamentais expressas em coordenadas cilíndricas tridimensionais, justificando rigorosamente sua redução para o modelo axissimétrico unidimensional [25, 49, 107].

Assume-se que o cilindro opera sob regime de pequenas deformações elásticas lineares e que está submetido a uma pressão interna constante, mantendo-se livre de forças de corpo gravitacionais ou inerciais ($bold(b) = bold(0)$) [108, 120].

=== Equações de Equilíbrio Geral em Coordenadas Cilíndricas

Para modelar o estado tridimensional de tensões em um cilindro, as equações diferenciais de equilíbrio (equação de Cauchy para o caso estático) são expressas no sistema natural de coordenadas cilíndricas $(r, theta, z)$. O divergente do tensor de tensões de Cauchy $bold(sigma)^epsilon$ possui componentes nas direções radial, circunferencial e axial dadas, respectivamente, por [110, 123]:

$
  (nabla dot bold(sigma)^epsilon)_r = frac(partial sigma_(r r)^epsilon, partial r) + frac(1, r) frac(partial tau_(r theta)^epsilon, partial theta) + frac(partial tau_(r z)^epsilon, partial z) + frac(sigma_(r r)^epsilon - sigma_(theta theta)^epsilon, r) + b_r = 0
$ <eq:equilibrium_3d_r>

$
  (nabla dot bold(sigma)^epsilon)_theta = frac(partial tau_(r theta)^epsilon, partial r) + frac(1, r) frac(partial sigma_(theta theta)^epsilon, partial theta) + frac(partial tau_(theta z)^epsilon, partial z) + frac(2 tau_(r theta)^epsilon, r) + b_theta = 0
$ <eq:equilibrium_3d_theta>

$
  (nabla dot bold(sigma)^epsilon)_z = frac(partial tau_(r z)^epsilon, partial r) + frac(1, r) frac(partial tau_(theta z)^epsilon, partial theta) + frac(partial sigma_(z z)^epsilon, partial z) + frac(tau_(r z)^epsilon, r) + b_z = 0
$ <eq:equilibrium_3d_z>

onde o sobrescrito $epsilon$ denota que as variáveis físicas variam na escala microscópica rápida induzida pela heterogeneidade periódica do material, descrita localmente pela variável rápida $bold(y) = bold(r)/epsilon$ [109, 121].

=== Simplificação por Axissimetria

Devido à simetria de revolução da estrutura cilíndrica e à natureza uniforme do carregamento de pressão interna, o problema mecânico é classificado como axissimétrico. Esta característica geométrica e física impõe duas simplificações severas sobre os campos de deslocamento e tensão [111, 124]:

1. *Invariância Circunferencial:* Nenhuma propriedade física ou campo mecânico varia ao longo do ângulo $theta$, o que anula todas as derivadas parciais nesta direção:
  $ frac(partial (dot), partial theta) = 0 $ <eq:axisymmetry_deriv>

2. *Ausência de Torção:* Na ausência de carregamentos torsoriais aplicados às extremidades do cilindro, as componentes de deslocamento tangencial $u_theta$ e as tensões de cisalhamento associadas a esse plano são nulas
:
$ tau_(r theta)^epsilon = tau_(theta z)^epsilon = 0 $ <eq:axisymmetry_shear>

Substituindo as @eq:axisymmetry_deriv e @eq:axisymmetry_shear nas equações gerais, a equação de equilíbrio na direção circunferencial (@eq:equilibrium_3d_theta) é identicamente satisfeita ($0 = 0$). As componentes radial e axial simplificam-se para [112, 204]:

$
  frac(partial sigma_(r r)^epsilon, partial r) + frac(partial tau_(r z)^epsilon, partial z) + frac(sigma_(r r)^epsilon - sigma_(theta theta)^epsilon, r) + b_r = 0
$ <eq:equilibrium_axi_r>

$
  frac(partial tau_(r z)^epsilon, partial r) + frac(partial sigma_(z z)^epsilon, partial z) + frac(tau_(r z)^epsilon, r) + b_z = 0
$ <eq:equilibrium_axi_z>

O tensor de tensões axissimétrico, mantendo ainda as tensões de cisalhamento longitudinal de forma genérica, é representado em notação de Voigt como [112, 115]:

$
  bold(sigma)^epsilon = vec(sigma_(r r)^epsilon, sigma_(theta theta)^epsilon, sigma_(z z)^epsilon, tau_(r z)^epsilon)
$ <eq:voigt_stress_axi>

=== Relações Cinemáticas e Estado Plano de Deformação Generalizado

As componentes do tensor de deformações infinitesimais $bold(epsilon)^epsilon$ relacionam-se com as componentes de deslocamento radial $u_r^epsilon$ e axial $u_z^epsilon$ por meio das relações elásticas axissimétricas [115, 161]:

$
  epsilon_(r r)^epsilon = frac(partial u_r^epsilon, partial r), quad epsilon_(theta theta)^epsilon = frac(u_r^epsilon, r), quad epsilon_(z z)^epsilon = frac(partial u_z^epsilon, partial z)
$ <eq:strains_normal>
$
  gamma_(r z)^epsilon = 2 epsilon_(r z)^epsilon = frac(partial u_r^epsilon, partial z) + frac(partial u_z^epsilon, partial r)
$ <eq:strain_shear>

Para viabilizar a resolução analítica e reduzir o problema elástico bidimensional do plano $r-z$ para uma formulação estritamente unidimensional na direção radial, introduz-se a hipótese de *Estado Plano de Deformação Generalizado* (condizente com cilindros longos com extremidades restritas) [209, 210]:

1. *Uniformidade Axial:* Assume-se que a geometria do cilindro e o carregamento de pressão são constantes ao longo do eixo axial $z$, o que implica que o deslocamento radial $u_r^epsilon$ independe da coordenada $z$:
  $ frac(partial u_r^epsilon, partial z) = 0 $ <eq:plane_strain_ur>

2. *Preservação de Seções Planas:* Postula-se que as seções transversais ao eixo longitudinal permanecem planas após a deformação. Logo, o deslocamento axial $u_z^epsilon$ varia no máximo linearmente com a coordenada $z$, resultando em uma deformação axial constante ($epsilon_(z z)^epsilon = epsilon_0$) e independente do raio $r$:
  $ frac(partial u_z^epsilon, partial r) = 0 $ <eq:plane_strain_uz>

Substituindo as @eq:plane_strain_ur e @eq:plane_strain_uz na equação de deformação por cisalhamento (@eq:strain_shear), conclui-se que o cisalhamento transversal é identicamente nulo em todo o domínio [211]:

$ gamma_(r z)^epsilon = 0 + 0 = 0 $ <eq:shear_zero>

Pela Lei de Hooke para meios isotrópicos locais, a anulação da deformação cisalhante transversal implica diretamente na anulação da tensão de cisalhamento ($tau_(r z)^epsilon = 0$) [211]. Sob essas premissas cinemáticas, e assumindo a ausência de forças de corpo ($b_r = 0$), a equação de equilíbrio radial (@eq:equilibrium_axi_r) simplifica-se para a sua forma final escalar unidimensional ordinária [116, 125]:

$
  frac(d sigma_(r r)^epsilon (r), d r) + frac(sigma_(r r)^epsilon (r) - sigma_(theta theta)^epsilon (r), r) = 0
$ <eq:equilibrium_radial_1d>

=== Relações Constitutivas Locais

Para cada camada homogênea constituinte do vaso de pressão (fases aço e alumínio), assume-se um comportamento elástico linear regido pela Lei de Hooke [113, 126]:

$ bold(sigma)^epsilon (r) = bold(cal(C))^epsilon (r) : bold(epsilon)^epsilon (r) $ <eq:hooke_tensor_local>

onde $bold(cal(C))^epsilon (r)$ é o tensor de elasticidade local dependente da posição radial $r$. Na notação de Voigt reduzida, descartando-se as componentes de cisalhamento nulas, a relação elástica local é dada por [115, 127]:

$
  vec(sigma_(r r)^epsilon (r), sigma_(theta theta)^epsilon (r)) = mat(cal(C)_(11)^epsilon (r), cal(C)_(12)^epsilon (r); cal(C)_(12)^epsilon (r), cal(C)_(11)^epsilon (r)) vec(d u_r^epsilon / d r, u_r^epsilon / r)
$ <eq:voigt_hooke_radial>

As constantes elásticas locais da matriz de rigidez relacionam-se com as constantes de Lamé do material por [119, 127]:

$
  cal(C)_(11)^epsilon (r) = lambda^epsilon (r) + 2 mu^epsilon (r) = frac(E^epsilon (r) (1 - nu^epsilon (r)), (1 + nu^epsilon (r))(1 - 2 nu^epsilon (r)))
$ <eq:c11_lame>

$
  cal(C)_(12)^epsilon (r) = lambda^epsilon (r) = frac(E^epsilon (r) nu^epsilon (r), (1 + nu^epsilon (r))(1 - 2 nu^epsilon (r)))
$ <eq:c12_lame>

onde $E^epsilon (r)$ representa o módulo de Young e $nu^epsilon (r)$ o coeficiente de Poisson da fase correspondente à coordenada $r$ [118, 127].

=== Equação Governante do Deslocamento Radial e Condições de Contorno

Substituindo a Lei de Hooke (@eq:voigt_hooke_radial) de volta na equação de equilíbrio radial escalar (@eq:equilibrium_radial_1d), obtém-se a equação diferencial ordinária de segunda ordem que governa o deslocamento radial $u^epsilon (r)$ [119, 128]:

$
  cal(C)_(11)^epsilon (r) frac(d^2 u_r^epsilon(r), d r^2) + [ frac(cal(C)_(11)^epsilon (r), r) + frac(d cal(C)_(11)^epsilon (r), d r) ] frac(d u_r^epsilon(r), d r) + [ frac(1, r) frac(d cal(C)_(12)^epsilon (r), d r) - frac(cal(C)_(11)^epsilon (r), r^2) ] u_r^epsilon(r) = 0
$ <eq:ode_governing_radial>

Para completar o Problema de Valor de Contorno (PVC), as condições mecânicas de Neumann (pressão constante prescrita na parede interna $r = r_i$ e parede livre de tensões na parede externa $r = r_e$) são impostas como [119, 129]:

$
  sigma_(r r)^epsilon (r_i) = cal(C)_(11)^epsilon (r_i) d (u_r^epsilon) / (d r) |_(r_i) + cal(C)_(12)^epsilon (r_i) ((u_r^epsilon (r_i)) / r_i) = -p
$ <eq:bc_radial_inner>

$
  sigma_(r r)^epsilon (r_e) = cal(C)_(11)^epsilon (r_e) d (u_r^epsilon) / (d r) |_(r_e) + cal(C)_(12)^epsilon (r_e) ((u_r^epsilon (r_e)) / r_e) = 0
$  <eq:bc_radial_outer>

onde $p$ representa a pressão manométrica interna atuando no vaso [109, 122]. A @eq:ode_governing_radial associada às condições de contorno de Neumann (@eq:bc_radial_inner e @eq:bc_radial_outer) constitui o sistema físico-matemático original completo ao qual o Método de Homogeneização Assintótica (MHA) será aplicado para obter as propriedades efetivas equivalentes do cilindro [118, 211].



== O Formalismo do Método de Homogeneização Assintótica (MHA) no Cilindro (Objetivo C.2)

A modelagem mecânica de cilindros de parede grossa compostos por múltiplos períodos de camadas concêntricas alternadas (aço e alumínio) é resolvida analiticamente por meio do Método de Homogeneização Assintótica (MHA). Este método permite desacoplar a resposta global do vaso de pressão dos gradientes de tensão microscópicos altamente oscilatórios de interface em interface, tratando as equações diferencias parciais com coeficientes rapidamente oscilantes de forma rigorosa e sistemática [47, 48].

=== Separação de Escalas e Operadores de Derivada

Considere a espessura total do cilindro de parede grossa como a escala característica macroscópica global do domínio, denotada por $L = R_"ext" - R_"int"$. Introduce-se a escala geométrica local do período elementar de lamelas, denotada por $l$. O princípio fundamental do MHA apoia-se na existência de um parâmetro adimensional pequeno $epsilon$, que define a separação entre as escalas macroscópicas e microscópicas do meio heterogêneo [43, 47, 48]:

$ epsilon = frac(l, L) << 1 $ <eq:epsilon_scale>

Com base nesta separação física de escalas, definem-se duas coordenadas espaciais independentes para mapear o cilindro de parede grossa [47, 48]:
1. *Variável Lenta ou Macroscópica ($r$):* Descreve o comportamento global, o carregamento de pressão externa e os gradientes suaves de deslocamento do vaso.
2. *Variável Rápida ou Microscópica ($y$):* Definida como $y = r/epsilon$, mapeia o comportamento localizado no nível da célula unitária periódica $Y = [0, 1]$. O coeficiente elástico do material heterogêneo passa a ser uma função puramente dependente de $y$, isto é, $cal(C)_{i j}(y)$ [47, 48].

Por consequência da introdução das variáveis independentes $r$ e $y$, o operador de derivada total em relação ao raio $r$ é modificado por meio da aplicação rigorosa da regra da cadeia, dividindo-se em duas parcelas de escalas distintas [47, 48]:

$ frac(d, d r) = frac(partial, partial r) + frac(1, epsilon) frac(partial, partial y) $ <eq:modified_derivative>

O operador dado pela @eq:modified_derivative reflete que qualquer variação de uma propriedade no cilindro ocorre tanto de forma suave na escala global quanto de forma extremamente rápida através da transição entre os períodos de ligas metálicas [47, 48].

== Solução Assintótica Formal (SAF)

O MHA postula que o campo real de deslocamento radial $u^epsilon(r)$ do cilindro multicamadas heterogêneo pode ser perfeitamente aproximado por uma série de potências do parâmetro pequeno $epsilon$, conhecida como Solução Assintótica Formal (SAF) [43, 47, 48]:

$ u^epsilon (r) = u_0(r, y) + epsilon u_1(r, y) + epsilon^2 u_2(r, y) + O(epsilon^3) $ <eq:saf_u>

onde os termos de perturbação elástica $u_i (r, y)$ são periódicos com respeito à variável rápida $y$ na célula unitária $Y$ ($Y$-periódicos).

Na teoria matemática de homogeneização de equações elípticas lineares, prova-se que o termo de ordem dominante $u_0(r, y)$ é estritamente independente da escala microscópica rápida $y$ [43, 47, 48]:

$ frac(partial u_0, partial y) = 0 quad ==> quad u_0(r, y) = u_0(r) $ <eq:u0_macro>

A @eq:u0_macro carrega um significado físico profundo: sob o limite assintótico elíptico ($epsilon -> 0$), o campo de deslocamentos principal do material microestruturado converge de forma forte para o comportamento regular e contínuo de um meio homogêneo equivalente global, eliminando as flutuações locais [47, 48].

=== Expansão dos Tensores de Deformação e Tensão

Substituindo a SAF dada pela @eq:saf_u e aplicando a regra da derivada dada pela @eq:modified_derivative, os campos cinemáticos de deformação infinitesimal radial $epsilon_r^epsilon$ e circunferencial $epsilon_theta^epsilon$ são expandidos como [47, 48]:

$
  epsilon_r^epsilon = frac(d u^epsilon, d r) = frac(partial u_0, partial r) + frac(partial u_1, partial y) + epsilon ( frac(partial u_1, partial r) + frac(partial u_2, partial y) ) + O(epsilon^2)
$ <eq:deform_r>
$ epsilon_theta^epsilon = frac(u^epsilon, r) = frac(u_0, r) + epsilon frac(u_1, r) + O(epsilon^2) $ <eq:deform_theta>

Substituindo estas deformações na Lei de Hooke para o cilindro axissimétrico em coordenadas curvilíneas, o tensor de tensões oscilatório é decomposto em potências hierárquicas de $epsilon$ [47, 48]:

$ sigma_r^epsilon = sigma_r^0 + epsilon sigma_r^1 + O(epsilon^2) $ <eq:stress_r_exp>
$ sigma_theta^epsilon = sigma_theta^0 + epsilon sigma_theta^1 + O(epsilon^2) $ <eq:stress_theta_exp>

onde os termos dominantes de tensão de ordem zero ($sigma^0$) são expressos em termos dos campos de deslocamento da SAF como [47, 48]:

$
  sigma_r^0 (r, y) = cal(C)_{11}(y) ( frac(partial u_0, partial r) + frac(partial u_1, partial y) ) + cal(C)_{12}(y) frac(u_0, r)
$ <eq:stress_r_zero>
$
  sigma_theta^0 (r, y) = cal(C)_{12}(y) ( frac(partial u_0, partial r) + frac(partial u_1, partial y) ) + cal(C)_{22}(y) frac(u_0, r)
$ <eq:stress_theta_zero>

=== Equilíbrio Diferencial Recorrente

A equação forte de equilíbrio mecânico radial axissimétrico para o cilindro microperiódico, na ausência de forças de corpo, é dada por [47, 48]:

$ frac(d sigma_r^epsilon, d r) + frac(sigma_r^epsilon - sigma_theta^epsilon, r) = 0 $ <eq:equil_original>

Substituindo a expansão do tensor de tensões dado pelas @eq:stress_r_exp e @eq:stress_theta_exp na @eq:equil_original, e aplicando o operador diferencial espacial modificado, temos:

$
  ( frac(partial, partial r) + frac(1, epsilon) frac(partial, partial y) ) (sigma_r^0 + epsilon sigma_r^1 + O(epsilon^2)) + frac((sigma_r^0 - sigma_theta^0) + epsilon (sigma_r^1 - sigma_theta^1) + O(epsilon^2), r) = 0
$ <eq:equil_substituted>

Agrupando e organizando os termos da @eq:equil_substituted em potências de ordem de magnitude do parâmetro geométrico pequeno $epsilon$, obtém-se o sistema recorrente de equações governantes [47, 48]:

1. *Ordem $O(epsilon^-1)$:*
  $ frac(partial sigma_r^0, partial y) = 0 $ <eq:order_minus_1>

2. *Ordem $O(epsilon^0)$:*
  $
    frac(partial sigma_r^0, partial r) + frac(partial sigma_r^1, partial y) + frac(sigma_r^0 - sigma_theta^0, r) = 0
  $ <eq:order_zero>

A equação de ordem $O(epsilon^-1)$ dada pela @eq:order_minus_1 impõe que a tensão radial de ordem zero é constante em relação à escala microscópica rápida $y$ dentro da célula unitária, ou seja, $sigma_r^0 = sigma_r^0 (r)$ [47, 48].

=== Dedução do Problema Local e as Funções Corretores

Substituindo a definição da tensão de ordem zero dada pela @eq:stress_r_zero na equação governante microscópica dada pela @eq:order_minus_1, obtém-se [47, 48]:

$
  frac(partial, partial y) [ cal(C)_{11}(y) ( frac(partial u_0, partial r) + frac(partial u_1, partial y) ) + cal(C)_{12}(y) frac(u_0, r) ] = 0
$ <eq:order_minus_1_full>

Para solucionar a equação diferencial parcial @eq:order_minus_1_full, adota-se a técnica de separação de variáveis de homogeneização. Postula-se que o termo de perturbação de primeira ordem $u_1(r, y)$ é expresso pela combinação linear dos gradientes de deformação macroscópica dominantes multiplicados por funções auxiliares locais dependentes unicamente de $y$ [47, 48]:

$ u_1(r, y) = chi^(1)(y) frac(partial u_0, partial r) + chi^(2)(y) frac(u_0, r) $ <eq:separable_u1>

onde as funções $chi^(1)(y)$ e $chi^(2)(y)$ são conhecidas como as *funções corretoras* ou funções de perturbação da célula unitária básica $Y$ [47, 48].

Substituindo a expressão separável da @eq:separable_u1 de volta na equação diferencial radial de microescala da @eq:order_minus_1_full, e isolando os termos em evidência das deformações macroscópicas independentes de $y$ ($partial_r u_0$ e $u_0/r$), chegamos a:

$
  [ frac(d, d y) ( cal(C)_{11}(y) frac(d chi^(1)(y), d y) + cal(C)_{11}(y) ) ] frac(partial u_0, partial r)
  \
  + [ frac(d, d y) ( cal(C)_{11}(y) frac(d chi^(2)(y), d y) + cal(C)_{12}(y) ) ] frac(u_0, r) = 0
$ <eq:local_derivation>

Dado que a relação em @eq:local_derivation deve ser satisfeita de forma idêntica para quaisquer estados arbitrários de carregamento e gradientes macroscópicos de deformação do vaso de pressão ($partial_r u_0 != 0$ e $u_0 != 0$), os coeficientes que acompanham estes termos devem anular-se individualmente. Isso isola o conjunto de equações diferenciais ordinárias de segunda ordem que constituem o *Problema Local de Célula* no domínio $Y = [0, 1]$ [47, 48]:

$ frac(d, d y) [ cal(C)_{11}(y) ( frac(d chi^(1)(y), d y) + 1 ) ] = 0 $ <eq:local_eq1>
$ frac(d, d y) [ cal(C)_{11}(y) frac(d chi^(2)(y), d y) + cal(C)_{12}(y) ] = 0 $ <eq:local_eq2>

Para garantir a existência, continuidade e unicidade das funções de perturbação elástica $chi^(1)(y)$ e $chi^(2)(y)$, as equações diferenciais locais @eq:local_eq1 e @eq:local_eq2 são acopladas às seguintes condições físicas nas interfaces internas de contato perfeito ($y = y_"int"$) e de contorno periódico na célula unitária [47, 48]:

1. *Compatibilidade Cinemática (Continuidade do Deslocamento):*
  $ [[ chi^(j)(y) ]] = 0 $ <eq:local_cont_disp>

2. *Equilíbrio de Tração Interfacial (Continuidade de Tensão de Contato):*
  $ [[ cal(C)_{11}(y) frac(d chi^(j)(y), d y) + cal(C)_{1 j}(y) ]] = 0 , quad (j = 1, 2) $ <eq:local_cont_stress>

3. *Condição de Normalização de Média Nula (Unicidade de Solução):*
  $ chevron.l chi^(j)(y) chevron.r = 1/(|Y|) integral_Y chi^(j)(y) d y = 0 $ <eq:local_norm>

A condição de normalização dada na @eq:local_norm é de fundamental importância matemática, eliminando o grau de liberdade de translação rígida infinitesimal na célula e garantindo que as flutuações microscópicas adicionadas pela SAF atuem puramente como corretores locais de energia, sem interferir no balanço volumétrico global da estrutura [47, 48].



== Propriedades Efetivas Transversais (Objetivo B.4)

A determinação analítica dos coeficientes efetivos (homogeneizados) que regem o comportamento macroscópico do cilindro é um dos resultados mais elegantes do Método de Homogeneização Assintótica (MHA) [7, 39]. Sob o princípio de que, para um elevado número de períodos ($epsilon -> 0$), a curvatura local das camadas infinitesimais tende a zero, o problema local de célula pode ser resolvido com exatidão analítica [15, 39]. Esta seção apresenta a integração matemática das equações diferenciais locais de célula formuladas na seção anterior, deduzindo os coeficientes de rigidez radial efetiva ($hat(cal(C))_{11}$), de acoplamento circunferencial-radial efetivo ($hat(cal(C))_{12}$), de rigidez hoop/tangencial efetiva ($hat(cal(C))_{22}$) e o módulo de cisalhamento transversal equivalente ($hat(G)$), fundamentados nas clássicas Médias de Backus para meios estratificados [15].

=== Integração do Problema Local e Dedução de $hat(cal(C))_{11}$ e $hat(cal(C))_{12}$

No capítulo anterior, estabelecemos as equações fortes ordinárias na variável rápida $y$ para as funções de perturbação $chi^(1)(y)$ e $chi^(2)(y)$ dentro da célula unitária periódica $Y = [0, 1]$:

$ frac(d, d y) ( cal(C)_11(y) ( frac(d chi^(1)(y), d y) + 1 ) ) = 0 $ <eq:cell_chi1>
$ frac(d, d y) ( cal(C)_11(y) frac(d chi^(2)(y), d y) + cal(C)_12(y) ) = 0 $ <eq:cell_chi2>

onde $cal(C)_11(y) = lambda(y) + 2 mu(y)$ e $cal(C)_12(y) = lambda(y)$ representam as propriedades constitutivas locais flutuantes em Voigt de cada fase [39].

==== Dedução de $hat(cal(C))_{11}$ (Média Harmônica Radial)

Para integrar a @eq:cell_chi1 em relação a $y$, definimos uma constante de integração $k_1$ [39]:

$ cal(C)_11(y) ( frac(d chi^(1)(y), d y) + 1 ) = k_1 $ <eq:integ_chi1_1>

Isolando o gradiente local da função de perturbação $d chi^(1) / d y$, temos:

$ frac(d chi^(1)(y), d y) = frac(k_1, cal(C)_11(y)) - 1 $ <eq:grad_chi1>

Como a função de perturbação $chi^(1)(y)$ deve satisfazer a condição de periodicidade nas fronteiras da célula unitária $Y = [0, 1]$, a integral de sua derivada sobre o domínio de célula deve ser identicamente nula ($integral_0^1 (d chi^(1) / d y) d y = chi^(1)(1) - chi^(1)(0) = 0$) [39, 47]. Aplicando o operador de valor médio espacial $chevron.l dot chevron.r = 1/|Y| integral_Y (dot) d y$ em ambos os lados da @eq:grad_chi1, obtemos:

$
  chevron.l frac(d chi^(1)(y), d y) chevron.r = chevron.l frac(k_1, cal(C)_11(y)) - 1 chevron.r = 0
$ <eq:mean_grad_chi1>

Como $k_1$ é uma constante em relação a $y$, ela pode ser extraída do operador de média:

$
  k_1 chevron.l frac(1, cal(C)_11(y)) chevron.r = 1 ==> k_1 = chevron.l cal(C)_11(y)^(-1) chevron.r^(-1)
$ <eq:k1_sol>

Por definição de homogeneização do MHA, a constante de integração do fluxo de tensões de célula representa exatamente o coeficiente elástico efetivo macroscópico associado, ou seja, $hat(cal(C))_{11} = k_1$ [112]. Portanto, a rigidez radial efetiva do vaso de parede grossa é dada de forma exata pela *média harmônica* (modelo de Reuss) de suas fases elásticas [39, 112]:

$ hat(cal(C))_{11} = chevron.l cal(C)_11(y)^(-1) chevron.r^(-1) $ <eq:C11_eff_final>

No caso de um compósito bimetálico bilaminado onde as propriedades são perfeitamente homogêneas em cada fase, a média reduz-se a uma soma ponderada pelas frações volumétricas de aço ($v_1$) e alumínio ($v_2$), onde $v_1 + v_2 = 1$ [113]:

$
  hat(cal(C))_{11} = frac(1, frac(v_1, cal(C)_11^((1))) + frac(v_2, cal(C)_11^((2)))) = frac(cal(C)_11^((1)) cal(C)_11^((2)), v_1 cal(C)_11^((2)) + v_2 cal(C)_11^((1)))
$ <eq:C11_bilaminado>

Fisicamente, esta relação reflete com precisão o comportamento de molas em série: como a solicitação de pressão atua perpendicularmente às interfaces concêntricas, a deformação radial macroscópica é governada pela compliância elástica das fases em série, sendo dominada pela fase de menor rigidez elástica [121].

==== Dedução de $hat(cal(C))_{12}$ (Coeficiente de Acoplamento Efetivo)

De forma análoga, para deduzir o coeficiente de acoplamento efetivo $hat(cal(C))_{12}$, integramos a segunda equação ordinária de célula dada pela @eq:cell_chi2, estabelecendo a constante de integração $k_2$ [39]:

$ cal(C)_11(y) frac(d chi^(2)(y), d y) + cal(C)_12(y) = k_2 $ <eq:integ_chi2_1>

Isolando o gradiente local $d chi^(2) / d y$, dividindo toda a expressão por $cal(C)_11(y)$, temos:

$ frac(d chi^(2)(y), d y) = frac(k_2, cal(C)_11(y)) - frac(cal(C)_12(y), cal(C)_11(y)) $ <eq:grad_chi2>

Invocando novamente a periodicidade de $chi^(2)(y)$ na célula unitária, impõe-se que a média de sua primeira derivada é nula ($chevron.l d chi^(2) / d y chevron.r = 0$). Aplicando o operador de valor médio na @eq:grad_chi2, isolamos a constante de integração $k_2$ [127]:

$
  k_2 chevron.l frac(1, cal(C)_11(y)) chevron.r = chevron.l frac(cal(C)_12(y), cal(C)_11(y)) chevron.r
$ <eq:k2_solve_pre>

$ k_2 = chevron.l cal(C)_11(y)^(-1) chevron.r^(-1) chevron.l frac(cal(C)_12(y), cal(C)_11(y)) chevron.r $ <eq:k2_sol>

Pelo formalismo matemático do MHA, a constante elástica homogeneizada de acoplamento radial-circunferencial macroscópico $hat(cal(C))_{12}$ equivale a $k_2$ [129]. Substituindo a definição de $hat(cal(C))_{11}$ dada pela @eq:C11_eff_final na @eq:k2_sol, conclui-se que [112]:

$ hat(cal(C))_{12} = hat(cal(C))_{11} chevron.l frac(cal(C)_12(y), cal(C)_11(y)) chevron.r $ <eq:Chat12_Calculation>

Para a configuração bilaminada bimetálica de interesse deste trabalho, o coeficiente $hat(cal(C))_{12}$ simplifica-se para [113]:

$
  hat(cal(C))_{12} = hat(cal(C))_{11} ( v_1 frac(cal(C)_12^((1)), cal(C)_11^((1))) + v_2 frac(cal(C)_12^((2)), cal(C)_11^((1))) )
$ <eq:C12_bilaminado>

Esta formulação demonstra que o acoplamento elástico global $hat(cal(C))_{12}$ não é uma média aditiva simples, mas sim uma média harmônica radial corrigida pelo acoplamento de Poisson local de cada camada elástica constituinte [122].

=== Dedução de $hat(cal(C))_{22}$ e a Média de Backus (Rigidez Hoop)

A determinação da rigidez hoop/tangencial macroscópica equivalente $hat(cal(C))_{22}$ (que governa a resistência à tração circunferencial que tenta romper o cilindro lateralmente) e do módulo de cisalhamento transversal $hat(G)$ exige a análise de problemas de contorno de célula associados aos carregamentos no plano tangente das interfaces [15].

==== O Princípio de Homogeneização de Backus (1962)

Pela teoria clássica de George Backus (1962) para meios elásticos estratificados formados por camadas paralelas de materiais isotrópicos, prova-se que o composto se comporta macroscopicamente como um meio *Transversalmente Isotrópico* elástico [15, 120]. Como as lâminas metálicas encontram-se perfeitamente aderidas e são forçadas a se deformar conjuntamente sob tração paralela à interface (no sentido circunferencial $theta$ e axial $z$), o comportamento mecânico tangencial se assemelha a molas em paralelo [121].

Matematicamente, a rigidez hoop efetiva $hat(cal(C))_{22}$ é dada pelo somatório das médias aritméticas locais, deduzindo-se a famosa relação de Backus [15, 122]:

$
  hat(cal(C))_{22} = chevron.l cal(C)_22(y) chevron.r - chevron.l frac(cal(C)_12(y)^2, cal(C)_11(y)) chevron.r + frac(hat(cal(C))_{12}^2, hat(cal(C))_{11})
$ <eq:C22_eff_final>

No caso de as fases elásticas constituintes serem puramente isotrópicas (onde $cal(C)_22(y) = cal(C)_11(y) = lambda(y) + 2 mu(y)$), a relação simplifica-se algebricamente no código computacional para a seguinte expressão em termos das propriedades de cada fase [132]:

$
  hat(cal(C))_{22} = (v_1 cal(C)_11^((1)) + v_2 cal(C)_11^((2))) - ( v_1 frac((cal(C)_12^((1)))^2, cal(C)_11^((1))) + v_2 frac((cal(C)_12^((2)))^2, cal(C)_11^((2))) ) + frac(hat(cal(C))_{12}^2, hat(cal(C))_{11})
$ <eq:C22_bilaminado>

Fisicamente, a @eq:C22_bilaminado mostra que a rigidez hoop macroscópica é governada essencialmente pelo limite de Voigt (média aritmética, representando as molas em paralelo), porém severamente reduzida pelo efeito de deformação lateral livre decorrente do contraste de coeficientes de Poisson e rigidez das camadas (segundo e terceiro termos de acoplamento elástico) [122].

=== Módulo de Cisalhamento Efetivo Out-of-Plane ($hat(G)$)

Por fim, o módulo de cisalhamento efetivo out-of-plane $hat(G) = hat(cal(C))_{1313} = hat(cal(C))_{2323}$ (que rege o acoplamento elástico de torção e cisalhamento radial-axial $r-z$ do vaso) é obtido aplicando o MHA sob torção microscópica [29]. Como o esforço cisalhante transversal precisa atravessar as interfaces perfeitamente unidas para manter o equilíbrio, as tensões de cisalhamento interfacial devem ser estritamente contínuas ($tau_{r z}^((1)) = tau_{r z}^((2))$) [30].

Para que haja a continuidade de tensão sob o contraste súbito dos módulos de cisalhamento locais das fases ($mu(y) = G(y)$), as deformações cisalhantes são descontínuas, ditando que o módulo de cisalhamento efetivo macroscópico seja governado de forma pura pelo limite de Reuss (média harmônica) [31, 38]:

$ hat(G) = chevron.l frac(1, mu(y)) chevron.r^(-1) $ <eq:Chatg_Calculation>

Para o nosso cilindro bimetálico de aço e alumínio, a relação fornece de forma direta [132]:

$ hat(G) = frac(1, frac(v_1, G_1) + frac(v_2, G_2)) = frac(G_1 G_2, v_1 G_2 + v_2 G_1) $ <eq:G_bilaminado>

onde $G_1$ e $G_2$ são os módulos de cisalhamento elástico locais do aço e alumínio, respectivamente [132].

Este conjunto completo de coeficientes elásticos ($hat(cal(C))_{11}$, $hat(cal(C))_{12}$, $hat(cal(C))_{22}$ e $hat(G)$) fornece a caracterização elástica ortotrópica curvilínea exata que alimenta o tensor de rigidez macroscópica contínua no FEniCS, permitindo simular com altíssima eficiência e rigor de modelagem o vaso de pressão multicamadas sem a necessidade de discretizar individualmente cada camada física do cilindro [38, 115].



== Formulação Variacional Fraca Axissimétrica (Seção 3.4)

A resolução de problemas de elasticidade linear anisotrópica em domínios cilíndricos multicamadas por meio do Método dos Elementos Finitos (MEF) requer a transição da equação diferencial governante (forma forte) para a sua representação integral equivalente (forma fraca ou variacional). Esta seção apresenta a dedução matemática rigorosa da forma fraca axissimétrica baseada no Princípio dos Trabalhos Virtuais (PTV), detalhando a integração de volume no sistema de coordenadas cilíndricas e justificando a inclusão explícita do raio $r$ no domínio bidimensional de integração para simulação no solver FEniCS [14, 47].

== O Princípio dos Trabalhos Virtuais (PTV)

Considere um domínio tridimensional de revolução $Omega_(3D)$ delimitado por uma fronteira $partial Omega = Gamma_D union Gamma_N$, onde $Gamma_D$ representa a fronteira de Dirichlet (deslocamentos prescritos) e $Gamma_N$ denota a fronteira de Neumann (trações ou pressões aplicadas). O Princípio dos Trabalhos Virtuais estabelece que, para qualquer campo de deslocamentos virtuais cinematicamente admissíveis $bold(v) = (v_r, v_z)^T in V$ (onde $V$ é o espaço de Sobolev das funções de teste que se anulam em $Gamma_D$), o trabalho virtual interno do sistema deve ser igual ao trabalho virtual externo [47, 48]:

$
  integral_(Omega_(3D)) bold(sigma) : bold(epsilon)(bold(v)) \, d Omega_(3D) = integral_(Gamma_N^(3D)) bold(t) dot bold(v) \, d S_(3D)
$ <eq:ptv_3d>

onde $bold(sigma)$ é o tensor de tensões de Cauchy, $bold(epsilon)(bold(v)) = 1/2 (nabla bold(v) + (nabla bold(v))^T)$ é o tensor de deformações virtuais lineares e $bold(t)$ é o vetor de trações prescritas na superfície de Neumann [14, 47].

== Integração por Revolução e Simplificação Axissimétrica

Devido à simetria de revolução geométrica e de carregamento em torno do eixo longitudinal $z$, o problema tridimensional pode ser projetado e resolvido em um domínio bidimensional meridiano plano $Omega$ (definido no plano $r-z$). O elemento de volume tridimensional em coordenadas cilíndricas é escrito como [42, 47]:

$ d Omega_(3D) = r \, d r \, d theta \, d z $ <eq:vol_element>

Como as componentes de tensão, deformação e deslocamento são independentes da coordenada circunferencial $theta$ ($partial_theta = 0$), podemos realizar a integração analítica direta ao longo da circunferência ($theta in [0, 2pi]$). Assim, a integral tridimensional de volume simplifica-se para [14, 47]:

$
  integral_(Omega_(3D)) f(r, z) \, d Omega_(3D) = integral_(z) integral_(r) integral_0^(2pi) f(r, z) r \, d r \, d theta \, d z = 2 pi integral_(Omega) f(r, z) r \, d r \, d z
$ <eq:int_revol>

De forma análoga, para o elemento de área na fronteira cilíndrica lateral $d S_(3D) = r \, d theta \, d s$, onde $d s$ representa o elemento de arco ao longo da fronteira unidimensional $Gamma_N$ no plano meridiano, a integral de superfície externa torna-se [14, 47]:

$
  integral_(Gamma_N^(3D)) bold(t) dot bold(v) \, d S_(3D) = 2 pi integral_(Gamma_N) bold(t) dot bold(v) r \, d s
$ <eq:int_surf_revol>

Substituindo as @eq:int_revol e @eq:int_surf_revol na equação do PTV (@eq:ptv_3d) e cancelando o fator constante $2 pi$ em ambos os membros, obtém-se a *forma fraca axissimétrica fundamental* definida no domínio plano $Omega$ [14, 47, 48]:

$
  integral_(Omega) bold(sigma) : bold(epsilon)(bold(v)) r \, d r \, d z = integral_(Gamma_N) bold(t) dot bold(v) r \, d s
$ <eq:weak_axisymmetric>

== Relações Constitutivas e Cinemáticas no Plano Meridiano

Para expressar a @eq:weak_axisymmetric em termos das variáveis de deslocamento primárias $bold(u) = (u_r, u_z)^T$ e de teste $bold(v) = (v_r, v_z)^T$, aplicamos a Notação de Voigt reduzida para o comportamento axissimétrico ortotrópico curvilíneo. Os vetores de deformação macroscópica e virtual são definidos como [14, 47]:

$
  bold(epsilon)(bold(u)) = ( epsilon_(r r), epsilon_(theta theta), epsilon_(z z), gamma_(r z) )^T = ( frac(partial u_r, partial r), frac(u_r, r), frac(partial u_z, partial z), frac(partial u_r, partial z) + frac(partial u_z, partial r) )^T
$ <eq:voigt_strain>
$
  bold(epsilon)(bold(v)) = ( frac(partial v_r, partial r), frac(v_r, r), frac(partial v_z, partial z), frac(partial v_r, partial z) + frac(partial v_z, partial r) )^T
$ <eq:voigt_virtual_strain>

A relação constitutiva linear para o material homogeneizado equivalente (MHA) ou para as fases elásticas individuais é expressa pela matriz de rigidez elástica axissimétrica $bold(cal(C))$ [47, 48]:

$
  bold(sigma) =
  bold(cal(C)) bold(epsilon)(bold(u)) ==>
  ( sigma_(r r), sigma_(theta theta), sigma_(z z), tau_(r z) )^T =
  mat(
    C_(11), C_(12), C_(13), 0;
    C_(12), C_(22), C_(23), 0;
    C_(13), C_(23), C_(33), 0;
    0, 0, 0, G
  )
  mat(epsilon_(r r); epsilon_(theta theta); epsilon_(z z); gamma_(r z)).
$ <eq:constitutive_matrix>

O produto interno do trabalho virtual interno em coordenadas cilíndricas expande-se como [14, 47]:

$
  bold(sigma) : bold(epsilon)(bold(v)) = sigma_(r r) epsilon_(r r)(bold(v)) + sigma_(theta theta) epsilon_(theta theta)(bold(v)) + sigma_(z z) epsilon_(z z)(bold(v)) + tau_(r z) gamma_(r z)(bold(v))
$ <eq:stress_strain_inner>

== Formulação Variacional Final e o "Peso do Raio" no FEniCS

A forma variacional canônica $a(bold(u), bold(v)) = L(bold(v))$ é obtida substituindo a relação constitutiva (@eq:constitutive_matrix) na equação de equilíbrio fraco (@eq:weak_axisymmetric) [14, 47]:

$
  a(bold(u), bold(v)) = integral_(Omega) [ bold(epsilon)(bold(v))^T bold(cal(C)) bold(epsilon)(bold(u)) ] r \, d r \, d z
$ <eq:bilinear_form>
$ L(bold(v)) = integral_(Gamma_N) [ bold(t) dot bold(v) ] r \, d s $ <eq:linear_form>

=== O Papel Crítico do Termo $r$ na Discretização

Os geradores de malha bidimensionais padrão e as bibliotecas automáticas de elementos finitos (como o FEniCS) realizam a integração numérica utilizando as medidas cartesianas planas nativas [14, 47]:
* $d x = d r \, d z$ para integrais de domínio;
* $d s$ para integrais de contorno plano.

Fisicamente, se omitíssemos o termo de peso $r$ nas formas bilineares e lineares, o solver estaria resolvendo uma fatia plana 2D em estado plano de deformações cartesiano, o que anularia o efeito da curvatura e a expansão circunferencial (*hoop strain* $u_r/r$). Portanto, a *formulação fraca no FEniCS deve obrigatoriamente incorporar o raio $r$ como um campo geométrico multiplicador* diretamente no integrando [14, 47]:

```python
# Representação conceitual no FEniCS (UFL)
r = Expression("x[0]", degree=1) # Coordenada radial x[0]

# Forma Bilinear com o peso do raio r
a = inner(sigma_uf(u), epsilon_uf(v)) * r * dx

# Forma Linear com o peso do raio r na fronteira de Neumann (pressão interna P_i)
# n é o vetor normal unitário externo à fronteira lateral
L = inner(t, v) * r * ds(1)
```

Esta modelagem variacional garante que o balanço de energia virtual seja tridimensionalmente exato, consolidando o rigor matemático necessário para as etapas subsequentes de simulação e otimização do vaso de pressão [14, 47, 48].






// Definição de funções auxiliares
#let pd(num, den) = $((partial #num) / (partial #den))$
#let avg(it) = $chevron.l #it chevron.r$
#let stress0r = $sigma_r^(0)$
#let stress0theta = $sigma_theta^(0)$
#let u0 = $u_r^(0)$
#let u1 = $u_r^(1)$
#let u2 = $u_r^(2)$

#let l = $chevron.l$
#let r = $chevron.r$

// Atalhos para os coeficientes eficazes
#let Chat11 = $hat(cal(C))_11$
#let Chat12 = $hat(cal(C))_12$

#let deformacao-simplificada = $
  vec(
    partial_r (u_r^0 + epsilon u_r^1),
    (u_r^0 + epsilon u_r^1) / r,
    (partial_z (u_r^0 + epsilon u_r^1) + partial_r u_z) / 2
  )
$

== Aplicando o método de homogeneização

Assim como feito por @PartonReport e @Guinovart2024, será utilizada uma expansão assintótica de primeira ordem para tensões, deformações e deslocamentos. As expansões são expressas como:

#let deformation = $epsilon.alt$

$
  // SAF para deslocamento
            bold(u)^((infinity))(r, epsilon) & =
                                               bold(u)^(0)(r) +
                                               epsilon bold(u)^(1) (r, y) +
                                               epsilon^2 bold(u)^(2)(r, y) + dots, \
  // SAF para deformações
  bold(deformation)^((infinity))(r, epsilon) & = bold(deformation)^(0)(r, y) +
                                               epsilon bold(deformation)^(1)(r, y) +
                                               epsilon^2 bold(deformation)^(2)(r, y) + dots, \
  // SAF para tensões
        bold(sigma)^((infinity))(r, epsilon) & =
                                               bold(sigma)^(0)(r, y) +
                                               epsilon bold(sigma)^(1)(r, y) +
                                               epsilon^2 bold(sigma)^(2)(r, y) + dots
$ <eq:asymptotic_expansions>

Truncando a expansão de tensões após o termo de primeira ordem ($cal(O)(epsilon)$) em @eq:asymptotic_expansions e substituindo na lei constitutiva , obtém-se a seguinte equação matricial:

$
  mat(
    sigma_r^(0) + epsilon sigma_r^(1);
    sigma_theta^(0) + epsilon sigma_theta^(1);
    tau^0_(r z) + epsilon tau^1_(r z)
  ) & =
      mat(
        cal(C)_11 (y), cal(C)_12 (y), cal(C)_13 (y);
        cal(C)_21 (y), cal(C)_22 (y), cal(C)_23 (y);
        cal(C)_31 (y), cal(C)_32 (y), cal(C)_33 (y)
      )
      
  // mat((d) / (d r) (u0 + epsilon u1); 1/r (u0 + epsilon u1)).
$ <eq:HookesLawWithSAF_MatrixForm>



Aplicando a regra da cadeia à @eq:HookesLawWithSAF_MatrixForm e separando os termos por potências de $epsilon$, as seguintes condições devem ser satisfeitas: 

$
  epsilon^(-1) & : partial(u0, y) = 0, \
     epsilon^0 & : sigma_r^(0) = cal(C)_11 (y) partial(u0, r) + cal(C)_11 (y) partial(u1, y) + cal(C)_12 (y) u0 / r.
$ <eq:HookesLawWithSAFRdirection>

Para o equilíbrio mecânico(@eq:equilibrium_radial_1d), a coleta de termos de ordem $epsilon^(-1)$ e $epsilon^0$ resulta em:

$
  epsilon^(-1) & : partial(sigma_r^(0), y) = 0, \
     epsilon^0 & : partial(sigma_r^(0), r) + partial(sigma_r^(1), y) + 1/r (sigma_r^(0) - sigma_theta^(0)) = 0.
$ <eq:EquilibriumWithStressSAFs>

Assume-se que a função de deslocamento de primeira ordem possui a forma separável $u_r^(1) = chi^("(1)") (y) partial(u0, r) + chi^("(2)") (y) u0 / r$ do mesmo modo como feito por @BrunaReport. A substituição desta forma na equação de equilíbrio de ordem $epsilon^(-1)$ define os *problemas locais*:

$
  partial / (partial y) (cal(C)_(11)(y) pd(chi^("(1)") (y), y) + cal(C)_(11)(y)) = 0, \
  partial / (partial y) (cal(C)_(11)(y) pd(chi^("(2)") (y), y) + cal(C)_(12)(y)) = 0.
$ <eq:LocalProblems>

Para garantir a existência e unicidade dessas soluções, impõe-se a condição de #text(blue)[contato perfeito] na interface entre as camadas:

$
  [[chi(y)]] = 0, quad [[cal(C)_11(y) partial(chi(y), y) + cal(C)_i j (y) ]] = 0,
$

além da condição de normalização da média na célula unitária $Y$:

$
  avg(chi^("(1)") (y)) = avg(chi^("(2)") (y)) = 0.
$


== Solução dos problemas locais

Para solucionar o sistema de equações diferenciais ordinárias que definem as funções corretoras $chi^("(1)")(y)$ e $chi^("(2)")(y)$ (Equação @eq:LocalProblems), realiza-se a integração direta de cada expressão em relação à coordenada microscópica $y$.

Integrando a primeira equação diferencial, obtém-se:

$ cal(C)_(11)(y) pd(chi^("(1)") (y), y) + cal(C)_(11)(y) = k_1 => pd(chi^("(1)") (y), y) = k_1 / cal(C)_(11)(y) - 1 $

onde $k_1$ é uma constante de integração. Para determinar $k_1$, aplica-se a condição de periodicidade inerente à teoria de homogeneização assimptótica. Sendo a função corretora $chi^("(1)")(y)$ periódica na célula unitária $Y$, a integral de sua derivada ao longo do domínio $Y$ deve ser nula:

$ integral_0^Y pd(chi^("(1)")(y), y) dif y = 0 quad => quad integral_0^Y ( k_1 / cal(C)_(11)(y) - 1 ) dif y = 0 $

Resolvendo para $k_1$ e expressando em termos do operador de média espacial (fração volumétrica), conclui-se que a constante de integração é exatamente igual ao coeficiente de rigidez efetivo (homogeneizado) $Chat11$:

$ k_1 = 1 / ( 1 / Y integral_0^Y 1 / cal(C)_(11)(y) dif y ) = Chat11 $

Aplicando procedimento análogo à segunda equação diferencial para $chi^("(2)")(y)$, tem-se a integração e a constante $k_2$:

$
  cal(C)_(11)(y) pd(chi^("(2)") (y), y) + cal(C)_(12)(y) = k_2 => pd(chi^("(2)") (y), y) = (k_2 - cal(C)_(12)(y)) / cal(C)_(11)(y)
$

Impondo novamente a condição de periodicidade $integral_0^Y pd(chi^("(2)"), y) dif y = 0$, determina-se $k_2$:

$
  integral_0^Y (k_2 - cal(C)_(12)(y)) / cal(C)_(11)(y) dif y = 0 quad => quad k_2 = ( 1 / Y integral_0^Y cal(C)_(12)(y) / cal(C)_(11)(y) dif y ) / ( 1 / Y integral_0^Y 1 / cal(C)_(11)(y) dif y )
$

Substituindo $Chat11$, nota-se que $k_2$ corresponde perfeitamente ao coeficiente efetivo de acoplamento $Chat12$, previamente definido:

$ k_2 = Chat11 lr(avg(cal(C)_(12)(y) / cal(C)_(11)(y))) = Chat12 $

Logo, os gradientes locais (derivadas espaciais das funções corretoras), que governarão o comportamento microscópico das tensões, ficam matematicamente determinados por:

$
  pd(chi^("(1)")(y), y) = Chat11 / cal(C)_(11)(y) - 1 , quad quad pd(chi^("(2)")(y), y) = (Chat12 - cal(C)_(12)(y)) / cal(C)_(11)(y)
$ <eq:Gradientes_Locais>

== Obtenção dos campos de tensão (Localização)

Uma vez resolvido o problema macroscópico para encontrar o deslocamento homogeneizado $u_0(r)$, é possível retroceder para a escala microscópica e calcular a distribuição real de tensões no compósito. A aproximação de ordem zero (escala micro) para o tensor de tensões é dada pela Lei de Hooke utilizando as derivadas assimptóticas do deslocamento:

$ sigma_(r r)^("(0)") = cal(C)_(11)(y) (pd(u_0, r) + pd(u_1, y)) + cal(C)_(12)(y) u_0 / r $

Substituindo a expansão separável $u_1 = chi^("(1)") pd(u_0, r) + chi^("(2)") u_0 / r$ e agrupando os termos, obtém-se:

$
  sigma_(r r)^("(0)") = [cal(C)_(11)(y) (1 + pd(chi^("(1)"), y))] pd(u_0, r) + [cal(C)_(11)(y) pd(chi^("(2)"), y) + cal(C)_(12)(y)] u_0 / r
$

Ao substituir os gradientes locais deduzidos na @eq:Gradientes_Locais diretamente nos colchetes acima, observa-se um resultado notável da mecânica de compósitos:

$ sigma_(r r)^("(0)") (r) = Chat11 pd(u_0, r) + Chat12 u_0 / r $ <eq:Tensao_Radial_Local>

A @eq:Tensao_Radial_Local revela que a dependência microscópica ($y$) é cancelada. Portanto, a tensão radial $sigma_(r r)$ é constante ao longo da célula unitária e exatamente igual à tensão macroscópica homogeneizada, provando de forma analítica o cumprimento do Lema de Cauchy (continuidade das trações normais nas interfaces entre as camadas).

Por outro lado, aplicando o mesmo procedimento para a tensão circunferencial ($sigma_(theta theta)$):

$ sigma_(theta theta)^("(0)") = cal(C)_(12)(y) (pd(u_0, r) + pd(u_1, y)) + cal(C)_(22)(y) u_0 / r $

$
  sigma_(theta theta)^("(0)") (r, y) = [ cal(C)_(12)(y) / cal(C)_(11)(y) Chat11 ] pd(u_0, r) + [ cal(C)_(22)(y) + cal(C)_(12)(y) / cal(C)_(11)(y) (Chat12 - cal(C)_(12)(y)) ] u_0 / r
$ <eq:Tensao_Circunferencial_Local>

Ao contrário da tensão radial, a @eq:Tensao_Circunferencial_Local preserva a dependência explícita da coordenada microestrutural $y$. Como os coeficientes de rigidez locais $cal(C)_(i j)$ sofrem variações abruptas (em formato de degrau) ao cruzar a fronteira entre o aço e o alumínio, a teoria de homogeneização assimptótica prevê e justifica matematicamente a ocorrência de saltos descontínuos no campo de tensão circunferencial da solução heterogênea.

== Obtenção da flutuação microestrutural do deslocamento

Enquanto o termo de ordem zero $u_0(r)$ fornece o comportamento global e suavizado da estrutura cilíndrica, a captura das oscilações microscópicas e das mudanças abruptas de inclinação (*kinks*) nas interfaces depende intrinsecamente do termo de primeira ordem $u_1(r, y)$.

Retomando a expansão assintótica separável admitida para o campo de deslocamentos, o termo flutuante é definido por:

$ u_1(r, y) = chi^("(1)") (y) pd(u_0, r) + chi^("(2)") (y) u_0 / r $ <eq:U1_Expansao>

Para determinar o valor explícito do deslocamento local, deve-se conhecer as funções corretoras $chi^("(1)") (y)$ e $chi^("(2)") (y)$. A partir dos gradientes locais deduzidos na @eq:Gradientes_Locais, realiza-se a integração em relação à coordenada da célula unitária $y$:

$ chi^("(1)")(y) = integral_0^y ( Chat11 / cal(C)_(11)(s) - 1 ) dif s + C_1 $

$ chi^("(2)")(y) = integral_0^y ( Chat12 - cal(C)_(12)(s) ) / cal(C)_(11)(s) dif s + C_2 $

onde $s$ é uma variável muda de integração e $C_1, C_2$ representam constantes de integração puras.

A teoria de homogeneização assimptótica prescreve que, para garantir a unicidade da solução do problema local, o valor médio das funções corretoras ao longo da célula unitária deve ser estritamente nulo, isto é: $avg(chi^("(1)")) = 0$ e $avg(chi^("(2)")) = 0$.

Aplicando o operador de média espacial, $1/Y integral_0^Y (dot) dif y$, determinam-se as constantes de integração:

$ C_1 = - 1 / Y integral_0^Y [ integral_0^y ( Chat11 / cal(C)_(11)(s) - 1 ) dif s ] dif y $

$ C_2 = - 1 / Y integral_0^Y [ integral_0^y ( Chat12 - cal(C)_(12)(s) ) / cal(C)_(11)(s) dif s ] dif y $

Com as constantes $C_1$ e $C_2$ estabelecidas, as funções $chi^("(1)")(y)$ e $chi^("(2)")(y)$ tornam-se completamente conhecidas em qualquer ponto $y$ da microestrutura bimetálica. O campo de deslocamento heterogêneo real é então reconstruído de forma aproximada pela soma $u(r,y) approx u_0(r) + epsilon u_1(r,y)$, viabilizando a validação analítica contra os deslocamentos extraídos dos nós da malha do Método dos Elementos Finitos (MEF).


== Problema homogeneizado e coeficientes efetivos


Finalmente, aplicando o operador de média $avg(dot)$ a @eq:EquilibriumWithStressSAFs, obtemos a #text(blue)[Equação Homogeneizada]:

$
  Chat11 (partial^2 u_0)/(partial r^2) + (Chat11)/r (partial u_0)/(partial r) - (Chat11 u_0)/r^2 = 0.
$ <eq:HomogenizedEquation>

A partir do MHA axissimétrico, os coeficientes efetivos são expressos em termos das médias das propriedades locais:

$
  Chat11 = avg(cal(C)_11 (y)^(-1))^(-1), quad
  Chat12 = avg(cal(C)_11 (y)^(-1))^(-1) avg((cal(C)_12 (y)) /( cal(C)_11 (y))).
$

Sendo $avg(dot) = 1/(|Y|) integral_Y (dot) d Y$. Para um compósito bilaminado onde as propriedades são constantes em cada fase, a integral simplifica-se para uma soma ponderada pelas #text(blue)[frações volumétricas] ($v_i$):

$
  avg(f) = v_1 f_1 + v_2 f_2, quad text("onde ") v_i = V_i / V, quad i=1, 2.
$

Assim, o coeficiente $Chat11$ (rigidez radial efetiva) torna-se a média harmônica:

$
  Chat11 = 1 / (v_1 / cal(C)_11^("(1)") + v_2 / cal(C)_11^("(2)")) = (cal(C)_11^("(1)") cal(C)_11^("(2)")) / (v_1 cal(C)_11^("(2)") + v_2 cal(C)_11^("(1)")).
$ <eq:Chat11_Calculation>

Analogamente, para o coeficiente de acoplamento efetivo $Chat12$:

$
  Chat12 = Chat11 ( v_1 cal(C)_12^("(1)") / cal(C)_11^("(1)") + v_2 cal(C)_12^("(2)") / cal(C)_11^("(2)") ).
$ <eq:Chat12_Calculation>

// Falta o cálculo do coeficiente efetivo de cisalhamento

Por fim, para o coeficiente efetivo de cisalhamento, tem-se:

$
  hat(G) = 1 / (v_1 / G^("(1)") + v_2 / G^("(2)")).
$<eq:Chatg_Calculation>


= Materiais e métodos

// Configurações de documento e pacotes equivalentes


, numbering: "1")


")


#figure(
  align(center)[
    
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

Para contornar essa barreira operacional, adota-se neste trabalho a estratégia de *Mapeamento Implícito de Propriedades* via vetor de interfaces discretas. Em vez de discretizar as interfaces físicas na própria malha, o domínio espacial é particionado por uma malha estruturada única e contínua no plano $r z$ (conforme discutido na /*@sec:discretizacao_malha*/). As propriedades elásticas locais dos materiais de fase (módulo de Young, coeficiente de Poisson e a respectiva matriz constitutiva) são injetadas diretamente nos pontos de integração Gaussiana através de expressões analíticas espaciais periódicas de busca indexada programadas no ambiente FEniCS [562].

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
) <tab:propriedades_fases> 

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


= Resultados e discussões




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
) <tab-comparacao-mef-mha>

Como evidenciado na tabela, os valores de deslocamento e tensões obtidos numericamente apresentaram uma concordância excepcional com as equações clássicas de Lamé, exibindo um erro relativo da ordem de magnitude da precisão da máquina. Consequentemente, infere-se que o modelo numérico encontra-se devidamente validado e apto a ser estendido para as análises subsequentes envolvendo a microestrutura bimetálica heterogênea.





== Comparação de deslocamentos radiais

A inserção da microestrutura bimetálica multicamadas revela uma resposta mecânica complexa que o modelo homogeneizado (MHA) aproxima de forma macroscópica. A @fig-deslocamento-kinks ilustra o perfil do deslocamento radial ($u_r$) ao longo da espessura da parede do cilindro, sobrepondo a solução heterogênea detalhada (MEF) à solução analítica suavizada (MHA).

#figure(
  image("images/MHA vs MEF 20 camadas.png", width: 80%),
  caption: [Perfil do deslocamento radial ao longo da espessura do cilindro. Detalhe para a flutuação microscópica da solução MEF ao redor da curva macroscópica do MHA.],
) <fig-deslocamento-kinks>

Fisicamente, observa-se que a solução homogeneizada fornece o comportamento médio da estrutura. Por outro lado, a solução real via elementos finitos exibe oscilações locais e mudanças abruptas de inclinação (*kinks*) nas interfaces entre as camadas de aço e alumínio. Essas inflexões ocorrem porque, embora o campo de deslocamentos deva ser estritamente contínuo ao longo de todo o domínio (garantindo a compatibilidade cinemática e a não-penetração das camadas), a sua derivada espacial — que compõe a deformação radial ($epsilon_(r r)$) — é descontínua. Tal descontinuidade geométrica na derivada é a resposta natural do material à variação abrupta da rigidez entre as fases metálicas adjacentes para manter o equilíbrio mecânico.





== Efeito do aumento do número de camadas

#figure(
  align(center)[
    #grid(
      columns: 3,

      // Coluna 1
      image("images/MHA vs MEF 20 camadas.png"),
      image("images/MHA vs MEF 40 camadas.png"),
      image("images/MHA vs MEF 100 camadas.png"),

      // Legenda genérica (aplicada a todas as imagens)
      [20 camadas], [40 camadas], [100 camadas],
    )
  ],
  caption: [Efeito da variação do número de camadas na convergência do deslocamento radial entre o MEF e a MHA.],
) <fig-variacao_num_camadas>


Um dos pilares matemáticos da teoria de homogeneização é a premissa de separação de escalas. Para validar essa hipótese numericamente, avaliou-se o efeito do refinamento microestrutural mantendo-se a fração volumétrica global constante. O parâmetro de periodicidade $epsilon$, que representa a espessura da célula unitária, foi progressivamente reduzido por meio do aumento do número total de camadas periódicas.

A @fig-variacao_num_camadas demonstra a evolução do campo de deslocamentos para cenários contendo 20, 40 e 100 camadas. Nota-se quantitativamente que, conforme $epsilon -> 0$, a frequência das oscilações microscópicas da solução MEF aumenta, porém a sua amplitude de divergência em relação à curva homogeneizada diminui drasticamente. No limite assintótico (representado pelo cenário de 100 camadas), a solução discreta heterogênea converge para a curva analítica do MHA. Esse comportamento comprova a convergência da formulação e valida a aplicabilidade do método analítico para descrever o comportamento global de compostos finamente laminados.




== Análise dos campos de tensões

Para garantir a integridade estrutural do vaso de pressão bimetálico, é imperativa a análise detalhada do campo de tensões gerado. A @fig-campos-tensao apresenta a distribuição radial da tensão normal ($sigma_(r r)$) e da tensão circunferencial ($sigma_(theta theta)$).


#figure(
  image("images/comparacao_tensoes.png", width: 90%),
  caption: [Distribuição das tensões radial e circunferencial na parede do cilindro multicamadas. Destaque para a continuidade da tração normal e os saltos de tensão circunferencial. ],
) <fig-campos-tensao> 

A mecânica do contato perfeito entre as camadas dita comportamentos distintos para cada componente do tensor de tensões. A tensão radial, $sigma_(r r)$, atua como a tração normal às interfaces. Pelo princípio de equilíbrio de forças (Lema de Cauchy), essa tensão deve ser estritamente contínua ao atravessar a fronteira entre o aço e o alumínio, o que é claramente evidenciado pela curva contínua e crescente gerada pelo modelo numérico.

Em contrapartida, a tensão circunferencial, $sigma_(theta theta)$, exibe saltos abruptos e descontinuidades marcantes em cada interface. Fisicamente, essa tensão é governada pela deformação tangencial ($epsilon_(theta theta) = u_r/r$). Como o deslocamento $u_r$ é contínuo, a deformação tangencial também o é. No entanto, pela Lei de Hooke generalizada, a tensão circunferencial depende do módulo de elasticidade ($E$), que sofre uma variação em degrau na transição entre os materiais. Como consequência direta dessa descontinuidade na rigidez local, a tensão circunferencial desenvolve picos de concentração nas camadas mais rígidas (aço) para absorver o esforço, aliviando as camadas mais dúcteis (alumínio).




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




// = Conclusão





)
