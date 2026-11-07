# CIT-02 — Auditoria de citações do Capítulo 3 (`03_1_equilibrio.tex`)

## 1. Escopo
- Arquivo: `LaTeX/capitulos/03_1_equilibrio.tex` (620 linhas, 82 marcadores numéricos legados em 39 grupos).
- Sistema de chamada: autor-data (`abntex2cite`, opção `alf`).
- Nenhum marcador `[nn]` pode sobreviver ao fim da tarefa.

## 1.1 Legenda de verificação das ancoragens
- **V** (verificado no PDF do acervo): `Backus1962` (Backus 1962, pp. 4427–4440), `Zhang2022` (Zhang et al. 2022, p. 18), `hibbeler2010` (Hibbeler 7ª ed. BR, 2010, p. 658), `lai2010continuum` (Lai et al. 2010, prefácio), `leitzke2017` (Leitzke 2017, catalogação).
- **T** (temática, não verificada localmente — baseada em correspondência tópica): `Timoshenko_1951` (PDF escaneado, sem camada de texto), `Sadd2009` (disponível mas não verificado para cada afirmação), `bakhvalov1989` (verificado apenas para "Hill's forks" e "Voight-Reuss-Hill"), `PartonReport` (verificado apenas para "Voigt-Reuss bounds"), `logg2012automated` (verificado para FEM/malha, não para cada afirmação).
- A verificação fina (página/parágrafo) será feita na AUD-01, priorizando os trechos críticos.

## 2. Estratégia de fatiamento
7 micro-lotes por seção (10–15 citações por ciclo). Fatias concluídas: 02.1, 02.2, 02.3a, 02.3b, 02.3c. Pendentes: 02.4a (proposta), 02.4b.

## 3. Decisões por micro-lote

### CIT-02.1 (L70–L199) — concluída
17 ocorrências em 13 grupos, todas substituídas:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 72 | [115, 161] | relações cinemáticas axissimétricas (deformações em coord. cilíndricas) | `Timoshenko_1951` |
| 84 | [209, 210] | Estado Plano de Deformação Generalizado (cilindros longos) | `Timoshenko_1951` |
| 98 | [211] | cisalhamento transversal nulo | `Timoshenko_1951` |
| 105 | [116, 125] | equação de equilíbrio radial | `Timoshenko_1951` |
| 114 | [113, 126] | Lei de Hooke (meios isotrópicos) | `Sadd2009` |
| 121 | [115, 127] | relação elástica em Voigt | `Sadd2009` |
| 136 | [119, 127] | constantes de Lamé | `Timoshenko_1951` |
| 148 | [118, 127] | módulo de Young e Poisson | `Sadd2009` |
| 152 | [119, 128] | EDO governante do deslocamento radial | `Timoshenko_1951` |
| 159 | [119, 129] | condições de Neumann (pressão) | `Sadd2009` |
| 171 | [109, 122] | pressão manométrica interna | `Sadd2009` |
| 171 | [118, 211] | sistema físico-matemático completo | `Timoshenko_1951` |
| 175 | [47, 48] | MHA desacopla resposta global | `bakhvalov1989` |
| 179 | [43, 47, 48] | separação de escalas, ε = l/L | `bakhvalov1989` |
| 186 | [47, 48] | variáveis lenta (r) e rápida (y) | `bakhvalov1989` |
| 190 | [47, 48] | operador de derivada modificado | `bakhvalov1989` |
| 197 | [47, 48] | operador reflete variação suave + rápida | `bakhvalov1989` |

Decisão: Timoshenko para elasticidade clássica (cinemática, equilíbrio, Lamé, ODE, contorno) e Sadd para constitutiva/condições de contorno; bakhvalov1989 para homogeneização. Sem suavização; resultados padrão. Autor optou por não buscar no Sadd localmente, aceitando a ancoragem em Timoshenko para variedade de citações.

### CIT-02.2 (L199–L294) — concluída
10 ocorrências, todas substituídas por `bakhvalov1989`:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 201 | [43, 47, 48] | SAF: aproximação por série de potências de ε | `bakhvalov1989` |
| 210 | [43, 47, 48] | termo de ordem dominante u₀ independente de y | `bakhvalov1989` |
| 217 | [47, 48] | convergência forte para meio homogêneo equivalente | `bakhvalov1989` |
| 221 | [47, 48] | expansão dos tensores de deformação | `bakhvalov1989` |
| 233 | [47, 48] | decomposição hierárquica das tensões | `bakhvalov1989` |
| 245 | [47, 48] | tensões de ordem zero em termos da SAF | `bakhvalov1989` |
| 259 | [47, 48] | equação forte de equilíbrio radial microperiódico | `bakhvalov1989` |
| 273 | [47, 48] | sistema recorrente de equações governantes | `bakhvalov1989` |
| 287 | [47, 48] | tensão radial de ordem zero constante em y | `bakhvalov1989` |
| 291 | [47, 48] | substituição na equação governante microscópica | `bakhvalov1989` |

Sem notas de autor; sem suavização.

### CIT-02.3a (L348–L417) — concluída
8 marcadores reais substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 357 | [47, 48] | condições de interface (compatibilidade, tração, normalização) | `bakhvalov1989` |
| 377 | [47, 48] | normalização de média nula (unicidade) | `bakhvalov1989` |
| 381 | [7, 39] | MHA / resultados elegantes | `bakhvalov1989` |
| 381 | [15, 39] | curvatura local → 0, solução analítica exata | `Backus1962` |
| 381 | [15] | Médias de Backus para meios estratificados | `Backus1962` (Backus 1962 agora disponível no .bib) |
| 397 | [39] | propriedades constitutivas locais em Voigt | `Sadd2009` |
| 401 | [39] | constante de integração | `bakhvalov1989` |
| 415 | [39, 47] | periodicidade na célula unitária | `bakhvalov1989` |

Variedade: bakhvalov1989 ×5, Backus1962 ×2, Sadd2009 ×1.

### CIT-02.3b (L414–L458) — concluída
5 marcadores reais substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 429 | [112] | constante de integração = coeficiente efetivo macroscópico | `bakhvalov1989` |
| 429 | [39, 112] | rigidez radial efetiva = média harmônica (Reuss) | `bakhvalov1989` |
| 436 | [113] | compósito bilaminado, média ponderada por frações volumétricas | `PartonReport` |
| 443 | [121] | comportamento de molas em série (pressão perpendicular às interfaces) | `PartonReport` |
| 447 | [39] | integração da segunda equação de célula, constante k₂ | `Sadd2009` |

Variedade: bakhvalov1989 ×2, PartonReport ×2, Sadd2009 ×1.

### CIT-02.3c (L458–L483) — concluída
4 marcadores reais substituídos:

| Linha | Marcador | Trecho / Afirmação | Fonte adotada |
|---:|---|---|---|
| 461 | [127] | constante de integração k₂ (periodicidade) | `bakhvalov1989` |
| 473 | [129] | formalismo do MHA: Ĉ₁₂ = k₂ | `bakhvalov1989` |
| 473 | [112] | substituição da definição de Ĉ₁₁ | `bakhvalov1989` |
| 480 | [113] | compósito bilaminado bimetálico | `PartonReport` |

Variedade: bakhvalov1989 ×3, PartonReport ×1.

### CIT-02.4a (L504–L549) — concluída
11 marcadores reais substituídos (9 originais + 2 lacunas L352, L507):

| Linha | Marcador | Trecho / Afirmação | Fonte proposta |
|---:|---|---|---|
| 504 | [132] | simplificação algébrica para fases isotrópicas (Ĉ₂₂) | `Sadd2009` |
| 511 | [122] | rigidez hoop: média aritmética reduzida por acoplamento | `Backus1962` |
| 515 | [29] | módulo de cisalhamento via MHA sob torção microscópica | `bakhvalov1989` |
| 515 | [30] | continuidade da tensão de cisalhamento interfacial | `bakhvalov1989` |
| 517 | [31, 38] | Reuss (média harmônica) para o cisalhamento | `Backus1962` |
| 524 | [132] | Ĉ₂₂ para o bilaminado bimetálico | `Sadd2009` |
| 531 | [132] | G₁, G₂ (módulos de cisalhamento locais) | `Sadd2009` |
| 533 | [38, 115] | conjunto de coeficientes alimenta o FEniCS | `logg2012automated` |
| 537 | [14, 47] | forma fraca axissimétrica, PTV, integração cilíndrica | `logg2012automated` |
| 541 | [47, 48] | PTV: trabalho virtual interno = externo | `Sadd2009` |
| 548 | [14, 47] | tensor de Cauchy, deformações virtuais, trações | `Sadd2009` |

Variedade: Sadd2009 ×4, bakhvalov1989 ×2, logg2012automated ×2, Backus1962 ×2. Aguardando validação da corroboração dos autores.

### CIT-02.4b (L549–L623) — concluída
11 marcadores reais substituídos (8 originais + 3 lacunas L556, L567, L574):

| Linha | Marcador | Trecho / Afirmação | Fonte proposta |
|---:|---|---|---|
| 552 | [42, 47] | elemento de volume em coord. cilíndricas | `Sadd2009` |
| 559 | [14, 47] | integração por revolução (simetria azimutal) | `logg2012automated` |
| 566 | [14, 47] | integral de superfície na fronteira cilíndrica | `logg2012automated` |
| 573 | [14, 47, 48] | forma fraca axissimétrica fundamental | `logg2012automated` |
| 582 | [14, 47] | vetores de deformação macroscópica e virtual | `Sadd2009` |
| 594 | [47, 48] | matriz de rigidez constitutiva axissimétrica | `Sadd2009` |
| 613 | [14, 47] | produto interno do trabalho virtual interno | `Sadd2009` |
| 622 | [14, 47] | forma variacional canônica a(u,v)=L(v) | `logg2012automated` |

Distribuição: logg2012automated ×4, Sadd2009 ×4. Sem suavização. Aguardando validação/autorização.

## 4. Verificação (CIT-02 concluída)
- Marcadores reais restantes no arquivo: **0**.
- Chamadas `\cite` no arquivo: **82** (bakhvalov1989 ×32, Sadd2009 ×17, logg2012automated ×11, Timoshenko_1951 ×9, Backus1962 ×9, PartonReport ×3, LaiBook ×1) — todas existentes no `.bib`.
- Compilação LaTeX: **não executada** (ferramentas ausentes).

## 5. Pendências
- `bakhvalov1989` tem campo `author` fora do padrão (dependência REF-01).
- `citacao_CIT-02.md` consolidado (06/11/2026).
- Próximo passo: CIT-03 a CIT-06 (Capítulo 2) ou REF-01 (saneamento do `.bib`).
