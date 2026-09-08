#import "../../imports.typ": *

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

#task[3.1. Hipótese do Contínuo e Equações Governantes (O Cilindro): Apresentação das equações diferenciais parciais de equilíbrio mecânico (Navier-Cauchy) em coordenadas cilíndricas tridimensionais, reduzindo-as para o caso axissimétrico sob hipótese de estado plano de deformações ou restrições longitudinais, além de definir as condições de contorno de Dirichlet e Neumann (pressão interna $P_i$).]

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
#margin-note([citação aqui]):
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

#task[3.2. Dedução do MHA e do Problema Local: Desenvolvimento matemático detalhado da separação de escalas via parâmetro de perturbação pequeno $epsilon = l/L$, expandindo o deslocamento na SAF e isolando o problema local sobre a célula unitária $Y$ para deduzir as funções de perturbação $N_1(y)$ e $N_2(y)$.]

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

#task[3.3. Propriedades Efetivas Transversais: Equacionamento analítico fechado das propriedades elásticas homogeneizadas equivalentes ($hat{C}_{11}$, $hat{C}_{12}$, $hat{C}_{22}$ e módulo de cisalhamento $hat{G}$) correlacionando-as com a teoria de Backus e a regra das misturas (médias aritméticas e harmônicas radiais).]

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

Pela teoria clássica de George Backus (1962)#margin-note([mudar para uma citação bibliográfica]) para meios elásticos estratificados formados por camadas paralelas de materiais isotrópicos, prova-se que o composto se comporta macroscopicamente como um meio *Transversalmente Isotrópico* elástico [15, 120]. Como as lâminas metálicas encontram-se perfeitamente aderidas e são forçadas a se deformar conjuntamente sob tração paralela à interface (no sentido circunferencial $theta$ e axial $z$), o comportamento mecânico tangencial se assemelha a molas em paralelo [121].

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

#task[3.4. Formulação Variacional Fraca Axissimétrica: Demonstração matemática de como as equações fortes são convertidas em integrais através do Princípio dos Trabalhos Virtuais, detalhando o "truque" geométrico de multiplicar as integrais pelo raio $r$ para que o FEniCS consiga realizar a integração volumétrica correta no domínio 2D plano.]

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



