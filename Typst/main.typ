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

//#set document(title: "Guia Rápido - ABNTyp")
#set page(paper: "a4", margin: 2cm)
#set text(font: "Times New Roman", size: 11pt, lang: "pt")


// Configurações de espaçamento, justificação e indentação
// ABNT 2023: 1,5 de espaçamento entre linhas e 1,25 cm de indentação
#set par(
  justify: true,
  leading: 1.5em,
  spacing: 1.5em,
  first-line-indent: (amount: 1.25cm, all: true),
)

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

#show regex("\d+\.\d+"): it => {
  show ".": ","
  it
}

//==========================
//Configuração do sumário
//==========================

#outline(
  title: "Sumário",
)

#pagebreak()

// Lista de figuras
// Lista de tabelas

#note-outline()

= Resumo

// #include "pages/Summary.typ"

= Introdução
#include "pages/Introduction.typ"

#pagebreak()

= Revisão bibliográfica
#include "pages/Revision.typ"

= Formulação matemática

#include "pages/materials&methods/Equilibrum.typ"

#include "pages/materials&methods/Homogenization.typ"

= Materiais e métodos

#include "pages/materials&methods/FEM.typ"

= Resultados e discussões

#include "pages/Results.typ"

// = Conclusão

#pagebreak()

#referencias(read("bibliografia.bib"))
