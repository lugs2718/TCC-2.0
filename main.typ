#import "imports.typ": *
#show strong: set text(rgb("#1a73d0")) // Use a specific hex color


// Importar a bibliografia
// A bibliografia será incluída no final do documento
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

= Formulação matemática

#include "pages/materials&methods/Equilibrum.typ"

#include "pages/materials&methods/Homogenization.typ"

= Materiais e métodos

#include "pages/materials&methods/FEM.typ"

= Resultados e discussões

#include "pages/Results.typ"

= Conclusão

#bibliography("bibliografia.bib")
