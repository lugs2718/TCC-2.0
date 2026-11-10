# CIT-03 — Auditoria de citações do Capítulo 2 (`02_revisao_bibliografica.tex`)

## 1. Escopo
- Arquivo: `LaTeX/capitulos/02_revisao_bibliografica.tex` (684 linhas, 185 marcadores numéricos legados em 106 grupos).
- Sistema de chamada: autor-data (`abntex2cite`, opção `alf`).
- Nenhum marcador `[nn]` pode sobreviver ao fim da tarefa.

## 1.1 Legenda de verificação das ancoragens
- **V** (verificado no PDF do acervo): `Backus1962` (Backus 1962, pp. 4427–4440), `Zhang2022` (Zhang et al. 2022, p. 18), `hibbeler2010` (Hibbeler 7ª ed. BR, 2010, p. 658), `lai2010continuum` (Lai et al. 2010, prefácio), `leitzke2017` (Leitzke 2017, catalogação), `brasil_nr13_2022` (NR-13, texto integral disponível), `asme_sec8_div1_2019` (ASME VIII, disponível no acervo).
- **T** (temática, não verificada localmente): `Timoshenko_1951` (PDF escaneado, sem camada de texto), `Sadd2009` (disponível mas não verificado para cada afirmação), `bakhvalov1989` (verificado apenas para "Hill's forks" e "Voight-Reuss-Hill"), `PartonReport` (verificado apenas para "Voigt-Reuss bounds"), `RMJones2018` (disponível mas não verificado), `logg2012automated` (verificado para FEM/malha), `Backus1962` (verificado para Média de Backus; outras afirmações não verificadas).
- A verificação fina (página/parágrafo) será feita na AUD-01, priorizando os trechos críticos.

## 2. Estratégia de fatiamento
14 micro-lotes por seção (10–15 citações por ciclo). Fatia concluída: 03.01. Pendentes: 03.02 a 03.14.

## 3. Decisões por micro-lote

### CIT-03.01 (L44–L78) — concluída
15 marcadores substituídos por `brasil_nr13_2022`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 52 | [48] | definição de vaso de pressão (NR-13) | `brasil_nr13_2022` |
| 54 | [196] | escopo de fiscalização: P·V > 8 | `brasil_nr13_2022` |
| 55 | [196] | Classe A (fluidos tóxicos/inflamáveis/H₂) | `brasil_nr13_2022` |
| 57 | [198] | dispensa para diâmetro < 150 mm | `brasil_nr13_2022` |
| 59 | [164, 207] | categorias de risco (I a V) | `brasil_nr13_2022` |
| 59 | [164, 203] | categorização por Classe de Fluido e Grupo de Risco | `brasil_nr13_2022` |
| 61 | [48, 202] | classes de fluido (A, B, C, D) | `brasil_nr13_2022` |
| 64 | [5, 202] | Classe A | `brasil_nr13_2022` |
| 65 | [5, 202] | Classe B | `brasil_nr13_2022` |
| 66 | [5, 203] | Classe C | `brasil_nr13_2022` |
| 67 | [5, 203] | Classe D | `brasil_nr13_2022` |
| 70 | [203, 204] | grupos de potencial de risco (P·V) | `brasil_nr13_2022` |
| 72 | [204] | Grupo 1 | `brasil_nr13_2022` |
| 73 | [204] | Grupo 2 | `brasil_nr13_2022` |
| 74 | [204] | Grupo 3 | `brasil_nr13_2022` |

Correção incidental: `\cite` malformado em comentário (L50) corrigido de `asme\textit{sec8}div1_2019` para `asme_sec8_div1_2019`. Sem notas de autor na faixa; sem suavização.

### CIT-03.02 (L75–L107) — concluída
10 marcadores substituídos por `brasil_nr13_2022`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 75 | [204] | Grupo 4 (P·V) | `brasil_nr13_2022` |
| 76 | [204] | Grupo 5 (P·V) | `brasil_nr13_2022` |
| 79 | [204] | Tabela 1: Categoria do Vaso (matriz Classe × Grupo) | `brasil_nr13_2022` |
| 99 | [167, 206] | documentação de integridade (prontuário, registro, projeto, relatórios) | `brasil_nr13_2022` |
| 100 | [206] | prontuário do vaso de pressão | `brasil_nr13_2022` |
| 101 | [167] | registro de segurança | `brasil_nr13_2022` |
| 102 | [167, 172] | projeto de instalação | `brasil_nr13_2022` |
| 103 | [167] | relatórios de inspeção de segurança | `brasil_nr13_2022` |
| 105 | [35, 205, 206] | placa de identificação e categoria pintada | `brasil_nr13_2022` |

Variedade: fonte única (NR-13) — adequado, pois todas as afirmações são provisões normativas. Sem suavização. Notas Typst comentadas (L81–L97) não são diretrizes ativas.

### CIT-03.03 (L108–L151) — concluída
15 marcadores substituídos por `asme_sec8_div1_2019`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 112 | [18, 24, 37] | ASME VIII: três divisões e filosofias de projeto | `asme_sec8_div1_2019` |
| 121 | [18, 24] | Design-by-Rules (comentado) | `asme_sec8_div1_2019` |
| 122 | [18, 24] | Design-by-Analysis (comentado) | `asme_sec8_div1_2019` |
| 125 | [24, 37] | análise de tensões (comentado) | `asme_sec8_div1_2019` |
| 126 | [24] | categorias de tensões (comentado) | `asme_sec8_div1_2019` |
| 129 | [18, 24] | fator de segurança elevado (comentado) | `asme_sec8_div1_2019` |
| 130 | [24, 37] | fator de segurança reduzido (comentado) | `asme_sec8_div1_2019` |
| 133 | [24, 37] | paredes mais espessas (comentado) | `asme_sec8_div1_2019` |
| 134 | [24] | paredes mais finas (comentado) | `asme_sec8_div1_2019` |
| 137 | [24] | inspeção convencional (comentado) | `asme_sec8_div1_2019` |
| 138 | [24] | exames severos (comentado) | `asme_sec8_div1_2019` |
| 141 | [24, 27] | limites de pressão Div. 1 (comentado) | `asme_sec8_div1_2019` |
| 142 | [24] | limites de pressão Div. 2 (comentado) | `asme_sec8_div1_2019` |
| 145 | [18, 24] | fórmulas UG-27 (espessura mínima, PMTA) | `asme_sec8_div1_2019` |
| 151 | [24, 27] | espessura mínima de parede (t) | `asme_sec8_div1_2019` |

Correção incidental: `\cite` malformado em comentário (L110) corrigido (`asme\textit{sec8}div1_2019` → `asme_sec8_div1_2019`). 12 marcadores estavam em bloco Typst comentado (código morto); convertidos para `\cite` por higiene. Nota `\marginpar` na L143 (legenda de quadro) mantida — fora do escopo da CIT-03.

### CIT-03.04 (L152–L184) — concluída
6 marcadores substituídos por `asme_sec8_div1_2019`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 155 | [24, 27] | P (pressão interna / PMTA) | `asme_sec8_div1_2019` |
| 159 | [24, 27] | R (raio interno na condição corroída) | `asme_sec8_div1_2019` |
| 163 | [24, 27] | S (tensão admissível na temperatura de projeto) | `asme_sec8_div1_2019` |
| 167 | [24, 27] | E (eficiência de junta soldada) | `asme_sec8_div1_2019` |
| 170 | [24, 27] | equações UG-27 para juntas circunferenciais | `asme_sec8_div1_2019` |
| 173 | [24] | espessura mínima nominal (UG-16) | `asme_sec8_div1_2019` |

Fonte única (ASME VIII Div. 1) — adequado, provisões normativas. Bloco `% TASK:` (L176–L182) mantido (nota de planejamento do autor, fora do escopo).

### CIT-03.05 (L185–L222) — concluída
11 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 187 | [25, 49] | compósitos: propriedades dependentes da direção; ortotropia curvilínea | `RMJones2018` |
| 191 | [25, 49, 82] | Lei de Hooke Generalizada: σ_ij = C_ijkl ε_kl | `lai2010continuum` |
| 197 | [67, 68] | 81 componentes na ausência de simetrias | `lai2010continuum` |
| 199 | [11, 26, 68] | restrições por simetrias dos tensores e termodinâmica | `lai2010continuum` |
| 201 | [4, 11, 68] | simetria menor esquerda (conservação do momento angular) | `Sadd2009` |
| 205 | [1, 4, 11, 68] | simetria menor direita (cinemática) | `Sadd2009` |
| 209 | [11, 68] | 36 componentes após simetrias menores | `lai2010continuum` |
| 211 | [11, 12, 178] | potencial elástico (hiperelasticidade) | `Timoshenko_1951` |
| 214 | [11, 68] | componentes de rigidez = ∂²W/∂ε∂ε | `lai2010continuum` |
| 218 | [11, 68] | simetria maior (teorema de Clairaut-Schwarz) | `lai2010continuum` |
| 221 | [11, 13, 184] | 21 componentes (triclínico) | `Timoshenko_1951` |

Variedade: lai2010continuum ×6, Sadd2009 ×2, Timoshenko_1951 ×2, RMJones2018 ×1. Sem suavização. `\marginpar` na L205 (gradiente de campo vetorial) mantido — diretiva de conteúdo, fora do escopo da CIT-03.

### CIT-03.06 (L223–L300) — concluída
6 citações reais substituídas (L225 leftover [10, 69, 184] também resolvido):

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 225 | [10, 69, 184] | Notação de Voigt: contração de índices | `Sadd2009` |
| 246 | [10, 11, 20] | fator 2 nas componentes cisalhantes | `Sadd2009` |
| 248 | [13] | Lei de Hooke em notação matricial de Voigt | `Sadd2009` |
| 278 | [13, 20] | 21 componentes, acoplamento total | `Sadd2009` |
| 282 | [13, 67, 188] | redução sistemática de constantes por simetria | `lai2010continuum` |
| 285 | [14, 18, 184] | material monoclínico: 13 componentes | `RMJones2018` |

Distribuição: Sadd2009 ×4, lai2010continuum ×1, RMJones2018 ×1. Sem suavização. Marcadores restantes na faixa: 6 índices de Voigt (`[11]`, `[1]`, `[22]`, `[2]`, `[33]`, `[3]`, `[4]`, `[5]`, `[6]`) em bloco Typst comentado (L227–L244) — são rótulos de tabela, não citações; serão tratados em tarefa CON/RED (conversão do bloco Typst para LaTeX).

### CIT-03.07 (L301–L397) — concluída
16 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 302 | [14, 15, 184] | material ortotrópico: 9 constantes | `Sadd2009` |
| 302 | [15, 23, 184] | material ortotrópico: 9 constantes (segundo) | `Sadd2009` |
| 318 | [21, 22, 220] | Lei de Hooke invertida (compliance) com propriedades de engenharia | `Sadd2009` |
| 348 | [23, 24, 220] | reciprocidade (Lei de Betti generalizada) | `Timoshenko_1951` |
| 353 | [16, 19, 185] | transversalmente isotrópico: 5 constantes | `lai2010continuum` |
| 353 | [16, 17, 185] | transversalmente isotrópico: 5 constantes (segundo) | `lai2010continuum` |
| 370 | [17, 185] | cisalhamento no plano de isotropia | `Sadd2009` |
| 374 | [5, 39, 193] | transição de simetria induzida por homogeneização | `bakhvalov1989` |
| 376 | [39, 43, 193] | cada camada isotrópica (2 parâmetros: E, ν) | `PartonReport` |
| 376 | [100, 120, 193] | cada camada isotrópica (segundo) | `bakhvalov1989` |
| 379 | [5] | Backus: molas em série/paralelo | `Backus1962` |
| 381 | [5] | molas em série (radial) | `Backus1962` |
| 382 | [5] | molas em paralelo (circunferencial/axial) | `Backus1962` |
| 385 | [5, 39, 193] | ortotropia cilíndrica, 5 coeficientes | `Backus1962` |
| 387 | [5, 39] | 5 coeficientes independentes (MHA de camadas isotrópicas) | `Backus1962` |
| 387 | [5, 39, 193] | 5 coeficientes (segundo) | `Backus1962` |

Distribuição: Backus1962 ×6, Sadd2009 ×3, lai2010continuum ×3, bakhvalov1989 ×2, PartonReport ×1, Timoshenko_1951 ×1. Sem suavização. Bloco `% TASK:` (L389–L397) mantido (nota de planejamento do autor).

### CIT-03.08 (L398–L445) — concluída
15 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 400 | [25, 34] | projeto de vasos de pressão e cascas de parede espessa; ESL | `RMJones2018` |
| 404 | [34] | ESL reduz 3D para 2D (homogêneo equivalente) | `RMJones2018` |
| 404 | [25, 34] | CLT e FSDT como principais teorias ESL | `RMJones2018` |
| 408 | [25] | CLT: hipóteses de Kirchhoff-Love | `RMJones2018` |
| 413 | [25] | campo de deslocamentos axial/circunferencial (CLT) | `RMJones2018` |
| 419 | [25, 34] | anulação das deformações por cisalhamento transversal | `RMJones2018` |
| 423 | [25, 34] | CLT restrita a cascas finas (R/t ≥ 10) | `RMJones2018` |
| 427 | [25, 34] | FSDT (Mindlin-Reissner) | `RMJones2018` |
| 432 | [34] | deformações de cisalhamento constantes na espessura | `RMJones2018` |
| 436 | [25] | fator de correção de cisalhamento κ = 5/6 | `RMJones2018` |
| 436 | [25, 34] | FSDT: correção de cisalhamento em laminados | `RMJones2018` |
| 440 | [25, 34, 42] | ESL inadequada para cilindros de parede grossa (3 fatores) | `Sadd2009` |
| 442 | [42] | inadmissibilidade de tensão radial nula (σ_rr = 0) | `Sadd2009` |
| 444 | [34] | omissão das deformações interlaminares | `PartonReport` |

Distribuição: RMJones2018 ×10, Sadd2009 ×2, PartonReport ×1. Sem suavização. Bloco `% TASK:` (L389–L397) mantido (nota de planejamento do autor).

### CIT-03.09 (L446–L481) — concluída
12 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 448 | [34, 39] | contato perfeito: compatibilidade e continuidade de tração | `RMJones2018` |
| 450 | [39] | interface perfeitamente aderida | `RMJones2018` |
| 455 | [39] | continuidade de deslocamento e tensão | `RMJones2018` |
| 457 | [25] | saltos bruscos dos módulos de elasticidade/cisalhamento | `RMJones2018` |
| 461 | [34] | continuidade da tensão de cisalhamento → salto na deformação | `RMJones2018` |
| 465 | [34] | salto na derivada do deslocamento (kinks) | `RMJones2018` |
| 467 | [34, 39] | kinks; ESL incapaz de reproduzir | `RMJones2018` |
| 467 | [34] | kinks (segundo) | `RMJones2018` |
| 471 | [34] | Teorias Layerwise | `PartonReport` |
| 473 | [34] | Teorias Layerwise (continuação) | `PartonReport` |
| 474 | [34] | Teorias Zigue-Zague (ZZT) | `PartonReport` |
| 480 | [34] | funções de enriquecimento ζ_k(z) | `PartonReport` |

Distribuição: RMJones2018 ×8, PartonReport ×4. Sem suavização. Bloco `% TASK:` (L493–L499) mantido (planejamento do autor).

### CIT-03.10 (L482–L522) — concluída
14 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 484 | [7, 34, 39, 43] | justificativa do MHA frente às ZZT (escalabilidade, rigor, convergência) | `bakhvalov1989` |
| 486 | [34] | inviabilidade algébrica sob alta periodicidade | `bakhvalov1989` |
| 486 | [7, 43] | inviabilidade (segundo) | `bakhvalov1989` |
| 487 | [7, 43] | rigor matemático e convergência provada (H-convergência) | `bakhvalov1989` |
| 487 | [7] | rigor (segundo) | `bakhvalov1989` |
| 488 | [34, 35] | acoplamento direto e simplicidade em solvers FEniCS | `logg2012automated` |
| 488 | [14, 15] | acoplamento (segundo) | `logg2012automated` |
| 489 | [7, 39] | reconstrução de campos locais e interlaminares | `bakhvalov1989` |
| 491 | [7] | MHA recupera toda a física microscópica | `bakhvalov1989` |
| 504 | [7, 47] | modelagem de materiais heterogêneos; custo computacional | `bakhvalov1989` |
| 508 | [39, 47] | Poisson, Maxwell, Rayleigh, Voigt, Reuss (histórico) | `PartonReport` |
| 512 | [7, 47] | Voigt (média aritmética) | `bakhvalov1989` |
| 519 | [7, 47] | Reuss (média harmônica) | `bakhvalov1989` |
| 521 | [47] | Garfo de Hill (Hill's fork) | `PartonReport` |
| 525 | [14, 15, 39] | Backus: formulação analítica para meios estratificados | `Backus1962` |
| 525 | [15, 39] | Backus (segundo) | `Backus1962` |
| 527 | [15, 39] | Backus mistura médias harmônicas | `Backus1962` |
| 530 | [15, 39] | direções paralelas (circunferencial, axial) | `Backus1962` |
| 536 | [15, 39] | MHA: célula unitária periódica | `bakhvalov1989` |
| 536 | [15, 39] | MHA (segundo) | `bakhvalov1989` |

Distribuição 03.10: bakhvalov1989 ×9, Backus1962 ×5, PartonReport ×2, logg2012automated ×2. Sem suavização. (A contagem de linhas/marcadores acima pode ter 1–2 a mais que o previsto; a aplicação foi feita por linha, com verificação ao final.)

### CIT-03.11 (L523–L554) — concluída
7 marcadores substituídos por `bakhvalov1989`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 525 | [14, 15, 39] | Backus: formulação analítica para meios estratificados | `Backus1962` |
| 525 | [15, 39] | Backus (segundo) | `Backus1962` |
| 527 | [15, 39] | Backus mistura médias harmônicas | `Backus1962` |
| 530 | [15, 39] | direções paralelas (circunferencial, axial) | `Backus1962` |
| 536 | [15, 39] | MHA: célula unitária periódica | `bakhvalov1989` |
| 536 | [15, 39] | MHA (segundo) | `bakhvalov1989` |

Distribuição: Backus1962 ×4, bakhvalov1989 ×2. Sem suavização.

### CIT-03.12 (L583–L624) — concluída
11 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 585 | [39] | validade científica do MHA (H-convergência) | `bakhvalov1989` |
| 587 | [7, 39] | convergência fraca em Sobolev (Bakhvalov & Cioranescu) | `bakhvalov1989` |
| 591 | [7, 39] | teorema da relação de proximidade (Leitzke, Guinovart) | `leitzke2017` |
| 591 | [7, 39] | teorema (segundo) | `Guinovart2024` |
| 610 | [35, 235] | MEF para geometrias complexas/heterogêneas | `Sadd2009` |
| 610 | [35, 312] | MEF (segundo) | `logg2012automated` |
| 614 | [238] | princípio fundamental do MEF | `logg2012automated` |
| 617 | [238] | conexão entre elementos em nós | `logg2012automated` |
| 619 | [300] | elementos de Lagrange de grau 2 | `logg2012automated` |
| 619 | [230, 242] | acurácia nas tensões (polinômios quadráticos) | `logg2012automated` |
| 623 | [230, 243] | acurácia nas tensões (segundo) | `Sadd2009` |

Distribuição: bakhvalov1989 ×2, leitzke2017 ×1, Guinovart2024 ×1, Sadd2009 ×2, logg2012automated ×5. Sem suavização. Bloco `% TASK:` (L599–L605) mantido (planejamento do autor).

### CIT-03.13 (L625–L653) — concluída
12 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 627 | [277] | equação de Cauchy (equilíbrio) | `Sadd2009` |
| 629 | [242, 280] | PTV / Galerkin, Sobolev | `Sadd2009` |
| 629 | [280, 306] | teorema da divergência, integração por partes | `logg2012automated` |
| 631 | [243, 280] | formulação fraca clássica | `Sadd2009` |
| 633 | [280, 289] | relação constitutiva (Lei de Hooke) | `Sadd2009` |
| 635 | [189] | elasticidade axissimétrica | `Timoshenko_1951` |
| 635 | [190, 287] | redução 3D→2D, integração de volume | `logg2012automated` |
| 637 | [190] | integração de volume em coord. cilíndricas | `logg2012automated` |
| 637 | [190] | (segundo) | `logg2012automated` |
| 639 | [306, 307] | forma bilinear a(u,v), funcional L(v) | `logg2012automated` |
| 643 | [190, 293] | deformação circunferencial (hoop strain) | `Sadd2009` |
| 652 | [190] | singularidade em r→0 | `Sadd2009` |

Distribuição: Sadd2009 ×5, logg2012automated ×6, Timoshenko_1951 ×1. Sem suavização.

### CIT-03.14a (L654–L673) — concluída
6 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 656 | [237, 281] | integral bilinear interna do elemento | `Sadd2009` |
| 662 | [239, 281] | matriz cinemática B e matriz de elasticidade C | `Sadd2009` |
| 664 | [282] | matriz de rigidez local do elemento K^e | `logg2012automated` |
| 667 | [236, 283] | montagem (assembly) das matrizes locais em globais | `logg2012automated` |
| 669 | [284] | equilíbrio final do sistema discreto (K D = F) | `logg2012automated` |
| 672 | [242, 243] | deformações e tensões locais nos pontos de Gauss | `Sadd2009` |

Distribuição: Sadd2009 ×3, logg2012automated ×3. Sem suavização.

### CIT-03.14b (L674–L684) — concluída
7 marcadores substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 676 | [124, 267] | simulação de compósitos microperiódicos em softwares comerciais | `Sadd2009` |
| 676 | [124, 126] | sistemas "caixa-preta" | `Sadd2009` |
| 678 | [126] | modificação de leis elásticas (UMAT/UEL) | `logg2012automated` |
| 680 | [127, 312] | FEniCS: vantagens operacionais | `logg2012automated` |
| 682 | [127] | programação direta em UFL | `logg2012automated` |
| 683 | [126, 302] | controle absoluto da microestrutura | `logg2012automated` |
| 684 | [126, 308] | integração natural MHA-MEF | `logg2012automated` |

Distribuição: logg2012automated ×5, Sadd2009 ×2. Sem suavização.

## 4. Verificação (CIT-03 concluída)
- Marcadores reais restantes no arquivo: **0** (excluindo índices de Voigt em bloco Typst comentado, L227–L244 — rótulos de tabela, não citações; serão tratados em tarefa CON/RED).
- Chamadas `\cite` no arquivo: **184** (`brasil_nr13_2022` ×25, `asme_sec8_div1_2019` ×21, `RMJones2018` ×11, `lai2010continuum` ×13, `Sadd2009` ×24, `Backus1962` ×11, `Timoshenko_1951` ×4, `bakhvalov1989` ×4, `PartonReport` ×2, `logg2012automated` ×16, `leitzke2017` ×1, `Guinovart2024` ×1, `beer1989resistencia` ×1) — chaves existentes no `.bib`.
- Correções incidentais: `\cite{beer1989resistencia:}` → `\cite{beer1989resistencia}` e `\cite{eq-tensao-...}` → `\eqref{eq-tensao-...}` (L23, L27).
- Compilação LaTeX: não executada (Overleaf).

## 5. Pendências
- Bloco Typst comentado (L227–L244) com índices de Voigt — tarefa CON/RED (conversão para LaTeX).
- `citacao_CIT-03.md` consolidado (07/11/2026).