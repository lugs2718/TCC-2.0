#outline(title: "Sumário")
#set heading(numbering: "1.")

#show raw.where(block: true): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#set math.equation(
  numbering: "(1)"  
)

#pagebreak()

//==========================
//Variáveis
//==========================

#let nuy = $nu(y)$
#let l = $chevron.l$
#let r = $chevron.r$

// 1. Calcula o fator de escala que precede a matriz.
#let fator = $E(y) / ((1 + nuy)  (1 - 2  nuy))$

// 2. Define os termos internos repetitivos.
#let C11 = $1 - nuy$ // Termo da diagonal (Normal)
#let C12 = $nuy$       // Termo fora da diagonal (Normal)
#let G = $(1 - 2  nuy) / 2$ // Termo da diagonal (Cisalhamento)

#let matriz-elasticidade-3D = {
  // 3. Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    #fator  mat(
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
      0, 0, 0, 0, 0, #G;
    )
  $
}

#let stress = $
      vec(sigma_1,
          sigma_2,
          sigma_3,
          tau_(1 2),
          tau_(2 3),
          tau_(1 3))  
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

= Introdução

Este trabalho tem como objetico resolver as equações de equilíbrio de um material compósito cilíndrico usando uma abordagem matemática chamada *Homogeneização Assintótica*. 

A Homogeneização assintótica se baseia em simplificar a análise de compósitos, analise essa que pode ser custosa, visto que os compósitos, por definição, são produzidos a partir de múltiplos materiais, originando propriedades
físicas melhoradas em comparação com aquelas dos meios homogêneos (BRUNA, 2017). Tal simplificação é feita ao tornar a atenção apenas o comportamento *efetivo* do compósito, separando esta dos efeitos micro-estruturais. Para ilustrar, é similar ao que é feito com sistemas de resistores ou molas, onde subtitui-se a grande quantidade de componentes por um único elemento com propriedades equilaventes ao sistema inicial.

//#image("Artigos Gerais • Rev. Bras. Ensino Fís. 42 • 2020.png")

Entretanto, para que essa metodologia funcione, são necessárias algumas condições:

- Hipótese do contínuo;
- Separação de escalas.

O compósito estudado é um vaso de pressão de múltiplas camadas isotrópicas e periódicas, conforme figura abaixo.

[figura ilustrando o compósito]

= Meios micro-heterogêneos

- Possuem propriedades físicas que variam de forma rápida (BRUNA, 2017);

- Muito utilizados em projetos onde se deseja obter propriedades físicas melhoradas em comparação com aquelas dos meios homogêneos (PANASENKO, 2005). 

//#image("Materiais micro-periódicos - Bruna Leitzke.png")

- Exemplos na natureza (Figura 1): 
  - estrutura óssea;
  - madeira.
  
- Exemplos sintéticos (Figura 2): 
  - compósito bifásico;
  - cerâmica.

//#image("Exemplos de compósitos.png")

//== Aplicações na engenharia mecânica

= Lei de Hooke 

Na mecânica dos sólidos, a Lei de Hooke relaciona é essencial, pois da uma relação entre as tensões e as deformações. Ela é escrita da seguinte forma:
$
  #stress = #matriz-elasticidade-3D #deformacao.
$





== Equações de equilíbrio em coordenadas cilíndricas

Considere o tensor de tensões de Cauchy $sigma$ expresso no sistema
de coordenadas cilíndricas $(r, theta, z)$,

$
sigma =
mat(
sigma_(r r), sigma_(r theta), sigma_(r z);
sigma_(theta r), sigma_(theta theta), sigma_(theta z);
sigma_(z r), sigma_(z theta), sigma_(z z)
).
$

As equações locais de equilíbrio são dadas por

$
nabla dot sigma + b = 0,
$

onde $b$ representa o vetor de forças de corpo.

O divergente do tensor de tensões em coordenadas cilíndricas
resulta nas seguintes componentes.

=== Direção radial

$
(nabla dot sigma)_r =
partial_r sigma_(r r)
+ 1/r partial_theta sigma_(r theta)
+ partial_z sigma_(r z)
+ (sigma_(r r) - sigma_(theta theta)) / r .
$

=== Direção circunferencial

$
(nabla dot sigma)_theta =
partial_r sigma_(theta r)
+ 1/r partial_theta sigma_(theta theta)
+ partial_z sigma_(theta z)
+ (sigma_(theta r) + sigma_(r theta)) / r .
$

=== Direção axial

$
(nabla dot sigma)_z =
partial_r sigma_(z r)
+ 1/r partial_theta sigma_(z theta)
+ partial_z sigma_(z z)
+ sigma_(z r) / r .
$

== Simplificação axissimétrica

Assumindo axisimetria, não há variação na direção circunferencial,
isto é,

$ partial_theta () = 0. $

Além disso, no caso clássico sem torção, as tensões de cisalhamento
circunferenciais são nulas,

$
sigma_(r theta) = sigma_(theta r) = 0,
$

$
sigma_(theta z) = sigma_(z theta) = 0.
$

Assim, o tensor de tensões pode ser escrito como

$
sigma =
mat(
sigma_(r r), 0, sigma_(r z);
0, sigma_(theta theta), 0;
sigma_(z r), 0, sigma_(z z)
).
$

As equações locais de equilíbrio são dadas por

$ nabla dot sigma + b = 0. $

=== Equilíbrio radial

$
partial_r sigma_(r r)
+ partial_z sigma_(r z)
+ (sigma_(r r) - sigma_(theta theta)) / r
+ b_r = 0.
$

=== Equilíbrio axial

$
partial_r sigma_(z r)
+ partial_z sigma_(z z)
+ sigma_(z r) / r
+ b_z = 0.
$


= Metodo da Homogeneização Assintotica

== Expansão assintótica formal


$
  u_r^((infinity)) = u_r^((0)) + epsilon u_r^((1)) + epsilon^2 u_r^((2)) + ...
$

== Definição do problema local

O problema local é a tradução do problema de equilíbrio para o domínio da célula unitária. Ele será essencial para se obter os coeficientes efetivos.

$
  partial_y (C_11(y) partial_y chi(y) + C_11(y) )= 0. \
$  

=== Condições de interface - contato perfeito

$
[[chi(y)]] = 0, [[C_11(y) partial_y + C_11(y) ]] = 0.
$

=== Condições de unicidade

$

  #l chi^"(1)" (y)#r _(Y_1) = #l chi^"(2)" (y)#r _(Y_2) = 0.\ 

$

//=== Diferencial de volume em coordenadas cilíndricas
//
//$
//  V = pi R^2 L, 
//  #h(3mm) 
//  d V = 2 pi R L d V.  \
//  
//  1/V integral "(.)" d V = (2 pi  L) / (pi R^2 L) integral "(.)" r d r = 2 / R^2 integral "(.)" r d r .
//$

== Coeficientes efetivos


A partir do MHA axissimétrico, foram obtidos os seguintes coeficientes efetivos: 

$
  hat(C)_11 = #l C_11 (y)^(-1)#r^(-1), 
  #h(3mm) 
$

$
  hat(C)_12 = 
  #l C_11 (y)^(-1)#r^(-1) #l (C_12 (y))/(C_11 (y)) #r.  // CORRIGIDO: Invertido para C12/C11
  
  //hat(C)_11 ( C_12^"(1)"/C_11^"(1)"v_1 + 
  //           C_12^"(2)"/C_11^"(2)"v_2).
$

tendo em vista a definição da média, $#l dot #r = 1/(|Y|) integral_Y (dot) d Y$, sendo Y o domínio da célula unitária. Por se tratar de uma integral (um operador linear), podem ser reescritas como a soma das integrais calculadas nas 2 regiões. Ao explorar este fato fórmulas mais simples para o cálculo da média nessas regiões podem ser encontradas, explorando simultaneamente a condição de propriedades homogêneas em cada região da célula unitária. 

Para isso, voltamos às considerações de tensão e deformação plana (nota para mim: avaliar se isso é verdade), as funções são constantes em relação à coordenada $z$, ou seja,

$
  1/V integral_V (dot) d V = L/V  integral_A (dot) d A,
$

que pode então ser reescrita como

$
  L/V  integral_A (dot) d A =
  L/V (integral_A_1 (dot)_1 d A_1 + integral_A_2 (dot)_2 d A_2),
$

e, como as propriedades avaliadas são constantes em cada região, temos então

$
  L/V ((dot)_1 integral_A_1 d A_1 + (dot)_2 integral_A_2 d A_2)=
  L/V (dot)_1 A_1 + L/V (dot)_2 A_2=
  V_1/V (dot)_1  + V_2 /V (dot)_2\

$

$
  (1/V integral_V (dot) d V = v_1 (dot)_1  + v_2  (dot)_2,)
$

sendo $v_i$ a *fração volumétrica* da região em questão. 

Segue-se então para a simplificação das expressões dos coeficientes efetivos da seguinte forma:

$
  hat(C)_11 = #l C_11 (y)^(-1)#r^(-1) =
  1 / (#l 1/(C_11(y)) #r) =
  1 / (v_1 / C_11^"(1)" + v_2 / C_11^"(2)") =
  (C_11^"(1)"C_11^"(2)") / (C_11^"(2)"v_1 + C_11^"(1)"v_2).
$

Da mesma forma para $hat(C)_12$,

$
  hat(C)_12 = 
  #l C_11 (y)^(-1)#r^(-1)#l C_11 (y)#r #l (C_11 (y))/(C_12 (y)) #r =
  
  hat(C)_11 ( C_11^"(1)"/C_12^"(1)"v_1 + 
             C_11^"(2)"/C_12^"(2)"v_2).
$


Os coeficientes efetivos obtidos pelo MHA axissimétrico foram os seguintes:

$
  hat(C)_11 = <C_11(y)^(-1)>^(-1)
$

= Metodo dos Elementos Finitos

== Forma fraca do problema

== FEniCS

//#image("Composito 10 camadas.png")

//#image("Composito 20 camadas.png")

= Resultados

//#image("Resultados FEM.png")



== Problemas encontrados

=== Divergência entre as soluções MHA e FEM.

//#image("Comparação entre MHA e FEM.png")

  
= Possíveis tratativas


