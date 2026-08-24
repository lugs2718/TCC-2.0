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

Assim como feito por @PartonReport e @DavidDissertacao, será utilizada uma expansão assintótica de primeira ordem para tensões, deformações e deslocamentos. As expansões são expressas como:

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

Truncando a expansão de tensões após o termo de primeira ordem ($cal(O)(epsilon)$) em @eq:asymptotic_expansions e substituindo na lei constitutiva @eq:HookesLawCoeffs, obtém-se a seguinte equação matricial:



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
      #deformacao-simplificada.
  // mat((d) / (d r) (u0 + epsilon u1); 1/r (u0 + epsilon u1)).
$ <eq:HookesLawWithSAF_MatrixForm>

#warning[Note a presença do tensor de elasticidade reduzido.]

Aplicando a regra da cadeia à @eq:HookesLawWithSAF_MatrixForm e separando os termos por potências de $epsilon$, as seguintes condições devem ser satisfeitas: #margin-note[Explicar como a regra da cadeia funciona nesse contexto.]

$
  epsilon^(-1) & : partial(u0, y) = 0, \
     epsilon^0 & : sigma_r^(0) = cal(C)_11 (y) partial(u0, r) + cal(C)_11 (y) partial(u1, y) + cal(C)_12 (y) u0 / r.
$ <eq:HookesLawWithSAFRdirection>

Para o equilíbrio mecânico (@eq:EquilibriumCylindricalForm), a coleta de termos de ordem $epsilon^(-1)$ e $epsilon^0$ resulta em:

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
