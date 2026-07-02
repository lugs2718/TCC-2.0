#import "../../imports.typ": *

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
#let Chat11 = $hat(C)_11$
#let Chat12 = $hat(C)_12$

#let deformacao-simplificada = $
     vec(
            partial_r (u_r^0 + epsilon u_r^1),
            (u_r^0 + epsilon u_r^1) / r,
            (partial_z (u_r^0 + epsilon u_r^1) + partial_r u_z) / 2
         )
           $

== Homogeneização

O método de homogeneização assintótica emprega uma #text(blue)[solução assintótica formal (SAF)] para o problema de valor de contorno (PVC) com oscilações rápidas, expressa como:

#idea[
  É recomendável definir a expansão assintótica na introdução e referenciá-la aqui.
]

#let deformation = $epsilon.alt$

$
  // SAF para deslocamento
  bold(u)^((infinity))(r, epsilon) &= 
  bold(u)^(0)(r) + 
  epsilon bold(u)^(1) (r, y) + 
  epsilon^2 bold(u)^(2)(r, y) + dots, \

  // SAF para deformações
  bold(deformation)^((infinity))(r, epsilon) &= bold(deformation)^(0)(r, y) + 
  epsilon bold(deformation)^(1)(r, y) + 
  epsilon^2 bold(deformation)^(2)(r, y) + dots, \

  // SAF para tensões
  bold(sigma)^((infinity))(r, epsilon) &=
  bold(sigma)^(0)(r, y) +
  epsilon bold(sigma)^(1)(r, y) +
  epsilon^2 bold(sigma)^(2)(r, y) + dots
$ <eq:asymptotic_expansions>

Truncando a expansão de tensões após o termo de primeira ordem ($cal(O)(epsilon)$) em @eq:asymptotic_expansions e substituindo na lei constitutiva @eq:HookesLawCoeffs, obtém-se a seguinte equação matricial:



$
  mat(sigma_r^(0) + epsilon sigma_r^(1); 
  sigma_theta^(0) + epsilon sigma_theta^(1);
  tau^0_(r z) + epsilon tau^1_(r z)) &= 
  
  mat(cal(C)_11 (y), cal(C)_12 (y), cal(C)_13 (y);
  cal(C)_21 (y), cal(C)_22 (y), cal(C)_23 (y);
  cal(C)_31 (y), cal(C)_32 (y), cal(C)_33 (y))

  #deformacao-simplificada.
  
  // mat((d) / (d r) (u0 + epsilon u1); 1/r (u0 + epsilon u1)).
  
$ <eq:HookesLawWithSAF_MatrixForm>

#warning[Note a presença do tensor de elasticidade reduzido.]

Aplicando a regra da cadeia à @eq:HookesLawWithSAF_MatrixForm e separando os termos por potências de $epsilon$, as seguintes condições devem ser satisfeitas: #margin-note[Explicar como a regra da cadeia funciona nesse contexto.]

$
  epsilon^(-1)&: partial(u0, y) = 0, \
  epsilon^0&: sigma_r^(0) = cal(C)_11 (y) partial(u0, r) + cal(C)_11 (y) partial(u1, y) + cal(C)_12 (y) u0 / r.
$ <eq:HookesLawWithSAFRdirection>

Para o equilíbrio mecânico (@eq:EquilibriumCylindricalForm), a coleta de termos de ordem $epsilon^(-1)$ e $epsilon^0$ resulta em:

$
  epsilon^(-1)&: partial(sigma_r^(0), y) = 0, \
  epsilon^0&: partial(sigma_r^(0), r) + partial(sigma_r^(1), y) + 1/r (sigma_r^(0) - sigma_theta^(0)) = 0.
$ <eq:EquilibriumWithStressSAFs>

Assume-se que a função de deslocamento de primeira ordem possui a forma separável $u_r^(1) = chi^("(1)") (y) partial(u0, r) + chi^("(2)") (y) u0 / r$. A substituição desta forma na equação de equilíbrio de ordem $epsilon^(-1)$ define os *problemas locais*:

$
  partial / (partial y) (cal(C)_11 pd(chi^("(1)") (y), y) + cal(C)_11) = 0, \
  partial / (partial y) (cal(C)_11 pd(chi^("(2)") (y), y) + cal(C)_12) = 0.
$ <eq:LocalProblems>

Para garantir a existência e unicidade dessas soluções, impõe-se a condição de #text(blue)[contato perfeito] na interface entre as camadas:

$
  [[chi(y)]] = 0, quad [[cal(C)_11(y) partial(chi(y), y) + cal(C)_i j (y) ]] = 0,
$

além da condição de normalização da média na célula unitária $Y$:

$
  avg(chi^("(1)") (y)) = avg(chi^("(2)") (y)) = 0.
$

Finalmente, aplicando o operador de média $avg(dots)$ a @eq:EquilibriumWithStressSAFs, obtemos a #text(blue)[Equação Homogeneizada]:

$
  Chat11 partial( ""^2 u0, r^2) + Chat11 1/r partial(u0, r) - Chat11 u0 / r^2 = 0.
$ <eq:HomogenizedEquation>


// === Coeficientes Efetivos

A partir do MHA axissimétrico, os coeficientes efetivos são expressos em termos das médias das propriedades locais:

$
  Chat11 = avg(cal(C)_11 (y)^(-1))^(-1), quad
  Chat12 = avg(cal(C)_11 (y)^(-1))^(-1) avg( (cal(C)_12 (y)) /( cal(C)_11 (y)) ).
$

Sendo $avg(dot) = 1/(|Y|) integral_Y (dot) d Y$. Para um compósito bilaminado onde as propriedades são constantes em cada fase, a integral simplifica-se para uma soma ponderada pelas #text(blue)[frações volumétricas] ($v_i$):

$
  avg(f) = v_1 f_1 + v_2 f_2, quad text("onde ") v_i = V_i / V.
$

Assim, o coeficiente $Chat11$ (rigidez radial efetiva) torna-se a média harmônica:

$
  Chat11 = 1 / (v_1 / cal(C)_11^("(1)") + v_2 / cal(C)_11^("(2)")) = (cal(C)_11^("(1)") cal(C)_11^("(2)")) / (v_1 cal(C)_11^("(2)") + v_2 cal(C)_11^("(1)")).
$

Analogamente, para o coeficiente de acoplamento efetivo $Chat12$:

$
  Chat12 = Chat11 ( v_1 cal(C)_12^("(1)") / cal(C)_11^("(1)") + v_2 cal(C)_12^("(2)") / cal(C)_11^("(2)") ).
$