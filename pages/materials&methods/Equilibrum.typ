#import "../../imports.typ": *

//==========================
//Variáveis
//==========================


#let l = $chevron.l$
#let r = $chevron.r$

#let nuy = $nu$
// 1. Calcula o fator de escala que precede a matriz.
#let fator = $E^epsilon / ((1 + nuy^epsilon)  (1 - 2  nuy^epsilon))$

// 2. Define os termos internos repetitivos.
#let C11 = $1 - nuy$ // Termo da diagonal (Normal)
#let C12 = $nuy$       // Termo fora da diagonal (Normal)
#let G = $(1 - 2  nuy) / 2$ // Termo da diagonal (Cisalhamento)
#let sigma_b = $bold(sigma)$
#let C_b = $bold(cal(C))$

// tensões cisalhantes
#let tau_r_t = $tau_(r theta)$
#let tau_t_z = $tau_(theta z)$
#let tau_r_z = $tau_(r z)$

#let matriz-elasticidade-3D = (
  // 3.1 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
  bold(cal(C)) =  mat(
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
)

#let matriz-elasticidade-3D-isotropica-simplificada = (
  // 3.2 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    #fator  mat(
      // 1ª Linha (sigma_x)
      #C11, #C12, #C12, ;
      // 2ª Linha (sigma_y)
      #C12, #C11, #C12, ;
      // 3ª Linha (sigma_z)
      //#C12, #C12, #C11, 0, 0, 0;
      // 4ª Linha (tau_yz)
      //0, 0, 0, #G, 0, 0;
      // 5ª Linha (tau_xz)
      #C12, #C12, #G;
      // 6ª Linha (tau_xy)
      //0, 0, 0, 0, 0, #G;
    )
  $
)

#let stress = $
      vec(sigma_(r r),
          sigma_(theta theta),
          sigma_(z z),
          0,
          //tau_(theta z),
          tau_(r z),
          0)
          //tau_(r theta))
$
#let stress_reduzido = $
      vec(sigma_(r r),
          sigma_(theta theta),
          tau_(r z))
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


== Hipótese do contínuo

=== Equações de equilíbrio em coordenadas cilíndricas

//Considere o tensor de tensões de Cauchy $sigma$ expresso no sistema de coordenadas cilíndricas $(r, theta, z)$ (em notação de Voigt),
Nesta seção, a forma geral da #text(blue)[equação de momento de Cauchy homogênea] #margin-note[Lembrete: Ajustar a bibliografia] (Sadd, 2009) é tomada como ponto de partida para analisar o comportamento mecânico de um vaso de pressão cilíndrico composto por camadas de materiais que se alternam periodicamente na direção radial, como ilustrado na fig:Composito. O tubo é submetido a uma pressão interna constante. Assume-se que todos os materiais constituintes exibem um regime elástico linear bem definido, permanecendo neste regime durante todo o processo. As equações governantes são descritas pela @eq:OriginalPDE, conforme descrito na #margin-note[Lembrete: Traduzir essas referências] /*@sec:Equilibrium*/, 

#let sigma_bx = $bold(sigma)^epsilon (bold(r))$
#let sigma_by = $bold(sigma) (bold(y))$

$
cases(-nabla dot #sigma_bx + bold(b) = 0 \, quad bold(epsilon.alt)^epsilon = 1/2 [nabla bold(u)^epsilon (bold(r)) + nabla bold(u)^epsilon (bold(r))^T] \,
quad bold(x) in Omega,
#sigma_bx dot bold(n) = -bold(p)\, quad bold(x) in Gamma_u\, quad
#sigma_bx dot bold(n) = bold(0)\, quad bold(x) in Gamma_t)
$ <eq:OriginalPDE>
#margin-note[A pressão $p$ deveria ter $epsilon$?]

onde $#sigma_bx = bold(sigma)^epsilon (bold(r/epsilon)) = #sigma_by$ é o tensor de tensões que varia na microestrutura, descrita pela variável $bold(y)$. $bold(b)$ denota o campo de forças de corpo, $bold(u)^epsilon$ é o vetor de deslocamento (a principal incógnita), $bold(n)$ é a normal unitária externa à fronteira $partial Omega = Gamma_u union Gamma_t$, e $bold(p)$ é a 
//#strong[pressão manométrica] 
#strong[pressão absoluta]#margin-note[Explicar sobre o papel da pressão na introdução] aplicada na superfície interna do cilindro. O conjunto $Gamma_u$ representa a superfície interna onde as condições de contorno de Neumann de pressão constante são impostas, enquanto $Gamma_t$ denota a superfície externa livre de tração (veja fig:Composito). 

O divergente do tensor de tensões em coordenadas cilíndricas
possui componentes na direção radial 

$
  (nabla dot #sigma_b)_r =
  partial_r sigma_(r r)
  + 1/r partial_theta #tau_r_t
  + partial_z #tau_r_z
  + (sigma_(r r) - sigma_(theta theta)) / r ,
$

na direção circunferencial 

$
  (nabla dot #sigma_b)_theta =
  partial_r #tau_r_t
  + 1/r partial_theta sigma_(theta theta)
  + partial_z #tau_t_z
  + (#tau_r_t + #tau_r_t) / r ,
$

e na direção axial

$
  (nabla dot #sigma_b)_z =
  partial_r #tau_r_z
  + 1/r partial_theta #tau_t_z
  + partial_z sigma_(z z)
  + #tau_r_z / r .
$

Entretanto, assumindo #strong[axisimetria], não há variação das propriedades na direção circunferencial, isto é, 

$ partial_theta (dot) = 0. $

Além disso, no caso clássico sem torção, as tensões de cisalhamento
circunferenciais são nulas,

$
  #tau_r_t = #tau_r_t = 0,
$

$
  #tau_t_z = #tau_t_z = 0.
$

Assim, o tensor de tensões pode ser escrito como

$
sigma =
mat(
sigma_(r r), 0, tau_(r z);
0, sigma_(theta theta), 0;
tau_(z r), 0, sigma_(z z) #margin-note[Por que as tensões de cisalhamento na direção $r z$ não são nulas?]
).
$

Ou, usando a notação de Voigt

$
  sigma = #stress.
$

// As equações locais de equilíbrio são dadas por
// $ nabla dot sigma + b = 0. $

Aplicando o operador divergente e somando as forças de corpo, tem-se as componentes da equação de equilíbrio na direção radial

$

partial_r sigma_(r r)
+ partial_z #tau_r_z
+ (sigma_(r r) - sigma_(theta theta)) / r
+ b_r = 0
$ <eq:equilibrium_r_direction>

#margin-note[
  Explicar o por que a direção circunferencial foi omitida.
]
e na direção axial

$
  partial_r #tau_r_z
  + partial_z sigma_(z z)
  + #tau_r_z / r
  + b_z = 0.
$

=== Relações contitutivas - Lei de Hooke

A relação tensão-deformação segue a lei de Hooke,

$
  bold(sigma)^epsilon = bold(cal(C))^epsilon : bold(epsilon)^epsilon,
$

onde $bold(cal(C))$ é o tensor de elasticidade contendo o módulo de Young ($E$)  e o coeficiente de Poisson ($nu$)
//coeficientes de Lamé $lambda$ e $mu$,
e $bold(epsilon.alt)$ é o tensor de deformações.
#margin-note[
  Encontrar bibliografia para descrever melhor o produto interno duplo.
]
e ":" o produto interno duplo. Em sua forma mais geral, o tensor possui 3^4 componentes. Entretanto, considerando o material isotrópico, o tensor se reduz para

// Forma "geral" do tensor de elasticidade
//$
//  #matriz-elasticidade-3D.
//$<eq:LeiDeHookeGeral>

$
  #C_b^epsilon = #matriz-elasticidade-3D-isotropica.
$<eq:LeiDeHookeGeral>

=== Formulação do problema <sec:fundamental-equations> 

// #figure(
//   image("images/Modelo_do_compósito.png", width: 50%),
//   caption: [Representação do vaso de pressão composto microperiódico completo, consistindo de duas fases de constituintes individualmente homogêneos e raio $r_i$ ($i = 1, 2, dots, N$).],
// ) <fig:Composito>

//==========================
//Variáveis
//==========================


#let l = $chevron.l$
#let r = $chevron.r$

#let nuy = $nu^epsilon (r)$
// 1. Calcula o fator de escala que precede a matriz.
#let fator = $(E^epsilon (r)) / ((1 + nuy)  (1 - 2  nuy))$

// 2. Define os termos internos repetitivos.
#let C11 = $1 - nuy$ // Termo da diagonal (Normal)
#let C12 = $nuy$       // Termo fora da diagonal (Normal)
#let G = $(1 - 2  nuy) / 2$ // Termo da diagonal (Cisalhamento)
#let sigma_b = $bold(sigma)$
#let C_b = $bold(C)$

// tensões cisalhantes
#let tau_r_t = $tau_(r theta)$
#let tau_t_z = $tau_(theta z)$
#let tau_r_z = $tau_(r z)$

#let matriz-elasticidade-3D = {
  // 3.1 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
  bold(C) =  mat(
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
}

#let matriz-elasticidade-3D-isotropica = {
  // 3.2 Constrói a matriz 6x6 e a retorna no modo matemático.
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

#let matriz-elasticidade-3D-isotropica-simplificada = {
  // 3.2 Constrói a matriz 6x6 e a retorna no modo matemático.
  $
    #fator  mat(
      // 1ª Linha (sigma_x)
      #C11, #C12, #C12, ;
      // 2ª Linha (sigma_y)
      #C12, #C11, #C12, ;
      // 3ª Linha (sigma_z)
      //#C12, #C12, #C11, 0, 0, 0;
      // 4ª Linha (tau_yz)
      //0, 0, 0, #G, 0, 0;
      // 5ª Linha (tau_xz)
      #C12, #C12, #G;
      // 6ª Linha (tau_xy)
      //0, 0, 0, 0, 0, #G;
    )
  $
}

#let stress = $
      vec(sigma^epsilon_(r r),
          sigma^epsilon_(theta theta),
          sigma^epsilon_(z z),
          0,
          //tau_(theta z),
          tau_(r z),
          0)
          //tau_(r theta))
$
#let stress_reduzido = $
      vec(sigma^epsilon_(r r),
          sigma^epsilon_(theta theta),
          tau^epsilon_(r z)) // Foram desconsideradas as tensões cisalhantes. (Por que mesmo?).
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
            partial_r u_r^epsilon,
            u_r^epsilon / r,
            (partial_z u_r^epsilon + partial_r u_z^epsilon) / 2,
         )
           $
      


#margin-note[Lembrete: Explicar o motivo dessa simplificação] Desconsiderando as tensões cisalhantes e as forças de corpo e considerando que não há variação das propriedades em $z$, a @eq:equilibrium_r_direction pode ser simplificada,

$
  (d sigma_r^epsilon (r)) / (d r) + 1/r [sigma_r^epsilon (r) - sigma_theta^epsilon (r)] = 0,
$ <eq:EquilibriumCylindricalForm>

onde $sigma_r^epsilon$ e $sigma_theta^epsilon$ são as componentes de tensão radial e circunferencial (tangencial), respectivamente. Dado que apenas um dos termos de cisalhamento é não nulo e a tensão axial é constante, o tensor de tensões pode ser simplificado para 

#warning[
  - Verificar essa afirmação da tensão axial ser constante;
  - Coloquei a descrição do tensor reduzido aqui, preciso ajustar
]

$
  #sigma_b^epsilon = #stress_reduzido.
$

#question[
  Seria melhor definir outra variável para o tensor reduzido?
  
]

#margin-note[
    Aqui, preciso decidir se vou usar os coeficientes de Lamé ($lambda$ e $mu$) ou os coefficientes padrão ($E$ e $nu$).
  ]

#let sigmari = $sigma_r^epsilon (r_i) = 
  cal(C)_11^epsilon (r_i) (d u_r) / (d r) + cal(C)_12^epsilon (r_i) u_r / r_i$
#let sigmare = $sigma_r^epsilon (r_e) = 
  cal(C)_11^epsilon (r_e) (d u_r) / (d r) + cal(C)_12^epsilon (r_e) u_r / r_e$
#let Ceff = $cal(C)_11^epsilon (r)$
#let duh = $(d u^epsilon (r)) / (d r)$
#let duhr = $(d^2 u^epsilon (r)) / (d r^2)$

Logo, podemos simplificar a @eq:LeiDeHookeGeral para o formato

$
  #stress_reduzido = #matriz-elasticidade-3D-isotropica-simplificada #deformacao-simplificada.
$<eq:HookesLawCoeffs>

Aqui, $E^epsilon (r)$ é o módulo de elasticidade e $nu^epsilon (r)$ é o coeficiente de Poisson (Sadd, 2008). O sobrescrito $epsilon$ denota a separação de escalas na descrição do material. 

Para reduzir o problema tridimensional a um caso estritamente unidimensional na direção radial, invoca-se a hipótese do #strong[Estado Plano de Deformação Generalizado] (ou Estado Plano de Deformação para cilindros longos com extremidades restritas). 

Fisicamente, assume-se que a geometria do cilindro e o carregamento de pressão interna são uniformes ao longo de seu eixo longitudinal $z$. Consequentemente, o campo de deslocamento radial independe da cota axial, de modo que:
$ (diff u_r) / (diff z) = 0 $

Adicionalmente, postula-se que as seções transversais perpendiculares ao eixo $z$ permanecem planas após a deformação. Isso implica que o deslocamento axial $u_z$ varia no máximo linearmente com $z$ ($u_z = epsilon_0 z$, onde $epsilon_0$ é a deformação axial constante), o que anula sua variação na direção radial:
$ (diff u_z) / (diff r) = 0 $

Com essas considerações cinemáticas, a componente de deformação por cisalhamento $gamma_(r z)$ no plano radial-axial é identicamente nula:
$ gamma_(r z) = (diff u_r) / (diff z) + (diff u_z) / (diff r) = 0 + 0 = 0 $

Pela relação constitutiva isotrópica, conclui-se que a tensão de cisalhamento transversal também se anula ($tau_(r z) = 0$). Esse resultado justifica a redução do tensor de deformações e de tensões àqueles que dependem exclusivamente das variáveis normais $r$ e $theta$, viabilizando a aplicação unidimensional do Método de Homogeneização Assintótica (MHA)


Combinando a equação de equilíbrio @eq:EquilibriumCylindricalForm com a lei de Hooke @eq:HookesLawCoeffs, obtemos a equação diferencial à qual o método de homogeneização será aplicado:

$
  Ceff duhr + (1/r Ceff + (d Ceff) / (d r)) duh + \
  (1/r (d cal(C)_12^epsilon (r)) / (d r) - (cal(C)_11^epsilon (r)) / r^2) u^epsilon (r) - f^epsilon (r) = 0, \
  sigmari = -p, \
  sigmare = 0.
$ <eq:EquililbriumFinalVersion>

Os coeficientes $cal(C)_11^epsilon (r) = lambda^epsilon (r) + 2 mu^epsilon (r)$ e $cal(C)_12^epsilon (r) = lambda^epsilon (r)$, expressos na notação de Voigt (Sadd, 2009), são as componentes do tensor de elasticidade isotrópico usadas para simplificar a @eq:HookesLawCoeffs. Além disso, a @eq:EquililbriumFinalVersion está sujeita às mesmas condições de contorno da @eq:OriginalPDE.

