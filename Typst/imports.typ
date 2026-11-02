//#import "@preview/pinit:0.2.2": *
#import "@preview/gentle-clues:1.2.0": *
#import "@preview/drafting:0.2.2": inline-note, margin-note, note-outline, set-margin-note-defaults//,note-outline
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz:0.3.4"

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.0": *
#import "@preview/abntyp:0.1.5": *

#show: normas-abnt.with(
  // Opções: "Times New Roman" (padrão) ou "Arial"
  fonte: "Times New Roman",

  // Bibliografia automática (opcional):
  // Se você tiver um arquivo .bib com suas referências:
  // arquivo-bibliografia: "referencias.bib",
)
// Inicialização obrigatória do codly no documento
#show: codly-init.with()

// Configuração visual para o TCC
// Configuração visual para o TCC corrigida
#codly(
  languages: (
    py: (name: "Python", color: rgb("#2b5b84"), icon: "🐍"),
  ),
  //zebra-fill: luma(245),
  fill: none, // <-- Adicione isso!
  stroke: 0.5pt + luma(200),
  radius: 2pt,
)
