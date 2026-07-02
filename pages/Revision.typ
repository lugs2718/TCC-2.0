#import "../imports.typ": *

//A simple #pin(1)highlighted text#pin(2).

//#pinit-highlight(1, 2)

// #pinit-point-from(1)[It is simple.]


== Meios com Estrutura Periódica e Células Recorrentes
Um meio com estrutura periódica é definido matematicamente como aquele composto por elementos ou células unitárias que se repetem ao longo de sua estrutura [Bak89]. Na engenharia de materiais, essa repetição geométrica é a característica definidora de diversos compósitos, como os reforçados por fibras unidirecionais ou sistemas granulados tridimensionais [Bak89]. 

#image("/images/composito_periodico_bakhvalov.png")

A análise desses meios fundamenta-se na eystência de dois comprimentos característicos: a dimensão da célula periódica ($l$) e a dimensão global do espécime ($L$). A premissa básica da homogeneização eyge que as dimensões da microestrutura sejam muito menores que as da macroestrutura, estabelecendo o parâmetro adimensional pequeno (como já dito na Introdução):

$ epsilon = l / L << 1 $

De acordo com [Bak89], essa separação de escalas permite que as propriedades físicas, que oscilam rapidamente na microescala, sejam investigadas assintoticamente quando $epsilon -> 0$. 

== Evolução Histórica da Homogeneização
O problema de determinar propriedades efetivas para meios heterogêneos remonta a trabalhos clássicos de Poisson, Maxwell, Rayleigh, Voigt e Reuss [Bak89]. Historicamente, duas abordagens limitantes tornaram-se fundamentais:
- *Abordagem de Voigt:* Sugere que as constantes elásticas sejam calculadas pela média dos valores sobre o volume, fornecendo o limite superior para os parâmetros efetivos [Bak89].
- *Abordagem de Reuss:* Utiliza a média dos componentes do tensor inverso (compliância), estabelecendo o limite inferior [Bak89].

A discrepância entre esses limites, conhecida como "Garfo de Hill" (_Hill's fork_), pode ser significativamente larga em compósitos com fases de propriedades muito distintas, o que justifica a aplicação de métodos mais rigorosos, como o MHA, para prever as características do material de forma assintoticamente exata [Bak89].

== Fundamentos do Método de Homogeneização Assintótica (MHA)
O MHA trata processos em meios periódicos descritos por equações diferenciais parciais com coeficientes rapidamente oscilantes [Bak89]. O método busca soluções na forma de séries de potências de $epsilon$, onde os coeficientes dependem tanto de variáveis lentas ou macroscópicas ($x$) quanto de variáveis rápidas ou microscópicas ($y = x/epsilon$):

$ u^(infinity) (x, epsilon) = sum_(i=0)^(infinity) epsilon^i u_i (x, y) $

Nesta formulação, as variáveis lentas descrevem a estrutura global do campo, enquanto as variáveis rápidas capturam a estrutura local [Bak89]. A substituição desta série nas equações governantes permite a determinação dos chamados "problemas locais" na célula unitária, cuja solução é essencial para o cálculo dos coeficientes efetivos do material homogêneo equivalente [Bak89].




=== Método dos elementos finitos: Formulação fraca

//=====================================================

Para a aplicação do método dos elementos finitos, deve-se antes encontrar a forma fraca da @eq:OriginalPDE. Priomeiro multiplica-se ambos os lados da equação por uma função vetorial de teste $bold(v)$, com o mesmo formato que o campo de deslocamentos.

$
  -(nabla dot sigma)^T bold(v) = bold(f)^T bold(v).
$

Então, integra-se ambos os lados,

$
  -integral_Omega (nabla dot sigma)^T bold(v) d Omega = integral_Omega bold(f)^T bold(v) d Omega.
$ <eq:IntegralBase>

O próximo passo é aplicar a integração por partes do lado esquerdo. Para isso, devemos considerar o seguinte,

$
  nabla dot (sigma bold(v)) = (nabla dot sigma)^T bold(v) + sigma : nabla bold(v), \
  -(nabla dot sigma)^T bold(v) = sigma : nabla bold(v) - nabla dot (sigma bold(v)),
$

onde $sigma : nabla bold(v)$ indica a operação de contração dupla do tensor de tensões pelo gradiente da função teste. Retornando à integral,

$
  integral_Omega sigma : nabla bold(v) d Omega - integral_Omega nabla dot (sigma bold(v)) d Omega = integral_Omega bold(f)^T bold(v) d Omega.
$

Pelo teorema da divergência de Gauss, é possível reduzir a ordem do termo $integral_Omega nabla dot (sigma bold(v)) d Omega$,

$
  integral_Omega nabla dot (sigma bold(v)) d Omega = integral_(partial Omega) (sigma bold(v))^T bold(n) d S
$

Considerando que o tensor $sigma$ é simétrico, o produto $(sigma bold(v))^T bold(n)$ pode ser desenvolvido da seguinte forma,

$
  (sigma bold(v))^T bold(n) = sigma^T bold(v)^T bold(n) = bold(v)^T sigma bold(n) = bold(v)^T bold(t)
$

onde $bold(t)$ é o vetor de tração, produto da aplicação de uma tensão a uma determinada área. Outro ponto a ser considerado é a contração dupla $sigma : nabla bold(v)$, onde $nabla bold(v)$ pode ser separado em sua parte simétrica e anti-simétrica, ou seja,

$
  sigma : nabla bold(v) &= sigma : "sym"(nabla bold(v)) + sigma : "antisym"(nabla bold(v)) \
  &= sigma : [1/2 (nabla bold(v) + nabla bold(v)^T)] + sigma : [1/2 (nabla bold(v) - nabla bold(v)^T)],
$

Mas, sabe-se da álgebra linear #margin-note[Citação aqui] que a contração dupla de um tensor simétrico por um anti-simétrico é nula. Logo, apenas a parte simétrica de $bold(v)$ prevalece. Volta-se então ao problema original,

$
  integral_Omega sigma(bold(u)) : epsilon(bold(v)) d Omega = integral_Omega bold(f)^T bold(v) d Omega + integral_(partial Omega) bold(t)^T bold(v) d S,
$

com $epsilon(bold(v))$ indicando a parte simétrica do gradiente do campo $bold(v)$.

*Fonte*: #link("https://www.youtube.com/watch?v=Z-FnP2myvKw")[Vídeo: Elasticidade e Forma Fraca]

#task[
  - Chegar até as matrizes de rigidez. 
    - *Pegar no gemini*
]

Para transpor o problema da forma fraca contínua para um sistema algébrico discreto solúvel computacionalmente, aplica-se o Método de Galerkin. O domínio $Omega$ é discretizado em elementos finitos, e os campos contínuos de deslocamento $bold(u)$ e da função teste (ou variação virtual) $bold(v)$ são aproximados por uma combinação linear de funções de forma $bold(N)$ e seus respectivos valores nodais:

$ bold(u) (bold(x)) approx bold(N)(bold(x)) bold(d) $
$ bold(v) (bold(x)) approx bold(N)(bold(x)) bold(c) $

onde $bold(d)$ é o vetor de deslocamentos nodais incógnitos e $bold(c)$ é um vetor de deslocamentos virtuais nodais arbitrário.

Aplicando o operador diferencial (gradiente simétrico) às funções de forma, obtém-se a matriz de deformação $bold(B)$, que relaciona as deformações aos deslocamentos nodais:

$ bold(epsilon.alt) (bold(u)) = bold(B)(bold(x)) bold(d) $
$ bold(epsilon.alt) (bold(v)) = bold(B)(bold(x)) bold(c) $

Utilizando a Lei de Hooke generalizada, o tensor de tensões é expresso em função dos deslocamentos nodais pela matriz de elasticidade constitutiva $bold(cal(C))$:

$ bold(sigma) (bold(u)) = bold(cal(C)) bold(epsilon.alt) (bold(u)) = bold(cal(C)) bold(B) bold(d) $

Substituindo as aproximações de tensão e deformação na integral do lado esquerdo da forma fraca, e utilizando a notação matricial para o produto interno duplo ($bold(sigma) : bold(epsilon.alt) = bold(epsilon.alt)^T bold(sigma)$), o trabalho virtual interno torna-se:

$ integral_Omega bold(sigma)(bold(u)) : bold(epsilon.alt)(bold(v)) d Omega = integral_Omega (bold(B) bold(c))^T (bold(cal(C)) bold(B) bold(d)) d Omega $

Pelas propriedades de transposição matricial, $(bold(B) bold(c))^T = bold(c)^T bold(B)^T$. Como os vetores nodais $bold(c)$ e $bold(d)$ independem das coordenadas espaciais de integração, eles podem ser isolados fora da integral:

$ integral_Omega bold(sigma)(bold(u)) : bold(epsilon.alt)(bold(v)) d Omega = bold(c)^T [ integral_Omega bold(B)^T bold(cal(C)) bold(B) d Omega ] bold(d) $

O termo entre colchetes representa a contribuição puramente geométrica e constitutiva do domínio à resistência contra deformações. A este termo dá-se o nome de matriz de rigidez global do sistema, denotada por $bold(K)$:

$ bold(K) = integral_Omega bold(B)^T bold(cal(C)) bold(B) d Omega $

De modo análogo, o lado direito da forma fraca é discretizado para formar o vetor de forças globais $bold(F)$, englobando as forças de corpo e as trações de contorno:

$ integral_Omega bold(f)^T (bold(N) bold(c)) d Omega + integral_(partial Omega) bold(t)^T (bold(N) bold(c)) d S = bold(c)^T [ integral_Omega bold(N)^T bold(f) d Omega + integral_(partial Omega) bold(N)^T bold(t) d S ] $
$ L(bold(v)) = bold(c)^T bold(F) $

Igualando o trabalho interno ao externo ($bold(c)^T bold(K) bold(d) = bold(c)^T bold(F)$) e considerando que o vetor virtual $bold(c)$ é arbitrário e não nulo, chega-se ao sistema de equações algébricas lineares fundamental do Método dos Elementos Finitos:

$ bold(K) bold(d) = bold(F) $

//=====================================================




