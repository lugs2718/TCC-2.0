#import "imports.typ": *
#show strong: set text(rgb("#1a73d0")) // Use a specific hex color

//#set-margin-note-defaults(rect: default-rect, stroke: none, side: right)


//==========================
//Configurações do documento
//==========================
#set document(
  title: "Análise de um tubo cilíndrico multicamadas por meio da homogêneização assintótica numérica e método dos elementos finitos",
)

#set heading(numbering: "1.")
#set text(size: 12pt)
#set par(justify: true)

//==========================
//Configurações matemáticas
//==========================
//Colocar as referências das fórmulas entre parênteses

#set math.equation(numbering: "(1)", supplement: [Eq.])
#show ref: it => {
  let el = it.element
  if el != none and el.func() == math.equation {
    // Acessa o número da equação e aplica o formato de parênteses
    let num = numbering(el.numbering, ..counter(math.equation).at(el.location()))
    link(el.location(), [Eq. #num])
  } else {
    it
  }
}
#outline(
  title: "Sumário",
)

#pagebreak()

// Lista de figuras
// Lista de tabelas

= Resumo

#include "pages/Summary.typ"
//#note-outline()

= Introdução
#include "pages/Introduction.typ"

= Revisão bibliográfica
#include "pages/Revision.typ"

= Materiais e métodos

//#margin-note[Incluir fluxograma do que foi feito no TCC.]

#warning[
  Essa seção não está casando muito bem com a de baixo.
  - Nas 2 foram definidas matrizes de elasticidade, mas com parâmetros diferentes, uma com $lambda$ e $mu$ e na outra apenas com $C_(i j)$.
  - Preciso unificar essas definições.
]

#include "pages/materials&methods/Equilibrum.typ"

#include "pages/materials&methods/Homogenization.typ"

#include "pages/materials&methods/FEM.typ"

= Resultados e discussões

#image("images/MHA vs MEF 20 camadas.png")

#image("images/MHA vs MEF 40 camadas.png")

#image("images/MHA vs MEF 100 camadas.png")

= Conclusão

= Referências bibliográficas

