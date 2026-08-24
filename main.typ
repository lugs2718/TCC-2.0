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

= Materiais e métodos

#figure(
  align(center)[
    #diagram(
      node-stroke: 1pt + rgb("#1a73d0"),
      node-fill: rgb("#f5f9fd"),
      edge-stroke: 1.2pt + rgb("#666666"),
      node-corner-radius: 5pt,

      node(
        (0, 0),
        [*1. Definição do Problema* \

          - Vaso de pressão multicamadas
        ],
        width: 6cm,
      ),

      node(
        (0, 1),
        [*2. Parâmetros Iniciais* \
          - Geometria
          - Fração volumétrica
          - Condições de contorno
        ],
        width: 5cm,
      ),

      node((-1, 2), [*3a. Modelo Analítico* \ Homogeneização Assintótica (MHA)], width: 4.5cm),
      node((1, 2), [*3b. Modelo Numérico* \ Elementos Finitos (MEF - FEniCS)], width: 4.5cm),

      node((0, 3), [*4. Verificação* \ Comparação (Tensões e Deslocamentos)], width: 5cm),

      node((0, 4), [*5. Análise de Viabilidade* \ Resistência ($W_g$) e Rigidez ($K_g$)], width: 6cm),

      // Conexões diretas
      edge((0, 0), (0, 1), "-|>"),

      // Bifurcação para os modelos
      edge((0, 1), (-1, 2), "-|>"),
      edge((0, 1), (1, 2), "-|>"),

      // Junção dos modelos para comparação
      edge((-1, 2), (0, 3), "-|>"),
      edge((1, 2), (0, 3), "-|>"),

      // Conclusão
      edge((0, 3), (0, 4), "-|>"),
    )
  ],
  caption: [Fluxograma geral da metodologia adotada.],
) <fig-fluxograma>

#include "pages/materials&methods/Equilibrum.typ"

#include "pages/materials&methods/Homogenization.typ"

#include "pages/materials&methods/FEM.typ"

= Resultados e discussões

#include "pages/Results.typ"

= Conclusão

= Referências bibliográficas

#bibliography("bibliografia.bib")
