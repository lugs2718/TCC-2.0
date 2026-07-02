// Configurações de documento e pacotes equivalentes


#set page(margin: (left: 3cm, top: 3cm, right: 2cm, bottom: 2cm), numbering: "1")
#set text(lang: "pt", region: "BR", size: 12pt)
#set par(justify: true, first-line-indent: 1.25cm)
#set math.equation(numbering: "(1)")

// Regra de exibição para referências às equações: Eq. (1)
#show ref: it => {
  let el = it.element
  if el != none and el.func() == math.equation {
    let num = numbering(el.numbering, ..counter(math.equation).at(el.location()))
    link(el.location(), [Eq. (#num)])
  } else {
    it
  }
}

// Título e Autor
#align(center)[
  #block(text(weight: "bold", 1.5em)[Desenvolvimento das equações de elasticidade])
  #v(1em)
]

Inicia-se com a versão forte da equação de equilíbrio mecânico para o caso de uma viga engastada em uma extremidade:

#figure(
  image("/images/image.png", width: 50%),
  caption: [Viga engastada],
) <Viga>

Temos então o PVC:

$
  cases(
    -nabla dot sigma = bold(f) quad &bold(x) in Omega, sigma = lambda "tr"(epsilon) I + 2 mu epsilon, 
    epsilon = 1/2 (nabla bold(u) + nabla bold(u)^T), 
    bold(u) = 0 quad &bold(x) in Gamma_u, 
    sigma bold(n) = 0 quad &bold(x) in Gamma_t
  )
$ <eq:PVC>

onde $Gamma_u$ é a superfície onde são aplicadas as condições de contorno de Dirichlet e $Gamma_t$ aquela onde são aplicadas as condições de contorno de Neumann. Para encontrar a forma fraca da equação de equilíbrio, iniciamos multiplicando ambos os lados da equação por uma função vetorial de teste $bold(v)$, com o mesmo formato que o campo de deslocamentos.

$
  -(nabla dot sigma)^T bold(v) = bold(f)^T bold(v).
$

Integra-se ambos os lados,

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

Mas, sabe-se da álgebra linear que a contração dupla de um tensor simétrico por um anti-simétrico é nula. Logo, apenas a parte simétrica de $bold(v)$ prevalece. Volta-se então ao problema original,

$
  integral_Omega sigma(bold(u)) : epsilon(bold(v)) d Omega = integral_Omega bold(f)^T bold(v) d Omega + integral_(partial Omega) bold(t)^T bold(v) d S,
$

com $epsilon(bold(v))$ indicando a parte simétrica do gradiente do campo $bold(v)$.

= Fonte

#link("https://www.youtube.com/watch?v=Z-FnP2myvKw")[Vídeo: Elasticidade e Forma Fraca]