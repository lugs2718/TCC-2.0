# Auditoria de Citações do Capítulo 4 — CIT-01

**Projeto:** Análise de um tubo cilíndrico multicamadas por meio da homogeneização assintótica numérica e método dos elementos finitos
**Autor:** Luiz Gustavo da Silva Pereira (UFF — EEIMVR)
**Data:** 03 de novembro de 2026
**Arquivo auditado:** `LaTeX/capitulos/04_mef.tex`
**Estratégia aplicada:** [`citacao_estrategia_CIT-00.md`](citacao_estrategia_CIT-00.md), decisões A–D
**Status:** marcadores removidos; **6 afirmações bloqueadas** aguardando fonte (decisão C)

---

## 1. Escopo e critério

A tarefa cobriu as referências numéricas legadas do Capítulo 4: **85 referências** distribuídas em **57 grupos** `[...]`, ao longo de **43 linhas** do arquivo em `HEAD`. O critério de decisão foi:

1. **Descrição do próprio código, fórmula ou cálculo:** o marcador é removido, porque a fonte é o script `Códigos/main.py` e o próprio desenvolvimento do capítulo, não uma obra externa.
2. **Fato de método, ferramenta ou teoria:** o marcador é substituído por chamada autor-data a uma entrada do `.bib`, com preferência pelo pool já existente.
3. **Afirmação factual forte sem fonte localizável:** o texto é preservado, o marcador é removido e o ponto é registrado como **bloqueio** (decisão C). Não houve suavização automática nem invenção de referência.

> A verificação foi estática. Não há `pdflatex`, `latexmk` nem `bibtex` instalados no ambiente; portanto, **não se declara compilação**.

---

## 2. Resultado quantitativo

| Item | Antes (HEAD) | Depois |
|---|---:|---:|
| Referências numéricas `[nn]` de citação | 85 | **0** |
| Grupos `[...]` de citação | 57 | **0** |
| Linhas com marcadores | 43 | **0** |
| Chamadas `\cite` no Capítulo 4 | 0 | **11** |
| Bloqueios registrados | — | **6** |

> **Recontagem documentada.** O inventário inicial registrava 87 marcadores em 59 grupos. A contagem por script sobre o arquivo em `HEAD` encontrou 88 ocorrências numéricas entre colchetes, das quais 3 são índices de código/matemática (`x[0]` duas vezes e `values[0]` uma), restando **85 referências em 57 grupos**. A diferença de 2 em relação ao inventário inicial não foi explicada; adota-se aqui o valor medido, não o valor herdado.

Os únicos colchetes numéricos remanescentes no arquivo são `x[0]` — na expressão matemática `r = x[0]` e no código Python — e `values[0]` no código. Nenhum deles é citação.

---

## 3. Fontes efetivamente usadas

| Chave | Obra | Onde foi usada | Chamadas |
|---|---|---|---|
| `logg2012automated` | Logg, Mardal & Wells (2012), *Automated Solution of Differential Equations by the Finite Element Method: The FEniCS Book* | discretização estruturada, elementos `CG1`, quadratura, `UserExpression`, formas variacionais e integração no FEniCS | 7 |
| `Sadd2009` | Sadd (2009), *Elasticity: Theory, Applications, and Numerics* | refinamento de malha em problemas elásticos; interpolação linear e tensão constante por elemento | 2 |
| `Timoshenko_1951` | Timoshenko & Goodier (1951), *Theory of Elasticity* | redução axissimétrica do cilindro ao plano `r-z` | 1 |
| `bakhvalov1989` | Bakhvalov & Panasenko (1989), *Homogenization: Averaging Processes in Periodic Media* | conceito de célula periódica unitária (RVE) | 1 |

Nenhuma chave nova foi criada. Todas as quatro já existiam em `LaTeX/bibliografia.bib`.

---

## 4. Decisões por bloco

> Os locais referem-se à numeração de linhas do arquivo em `HEAD`, antes das edições. No arquivo atual, os comentários `% [CIT]` deslocaram as linhas seguintes.

TODO (Autor): Verificar se essas decisões fazem sentido.

| Local (HEAD) | Referências | Decisão | Justificativa |
|---|---:|---|---|
| L34 | 1 | `Sadd2009` | refinamento de malha governa a precisão em elasticidade |
| L38 | 1 | `Timoshenko_1951` | redução axissimétrica ao plano `r-z` |
| L59 | 2 | `logg2012automated` (2 → 1 chamada) | elementos `CG1` e espaço de Galerkin no FEniCS |
| L61 | 1 | removido | razões metodológicas do autor, sem obra externa ancorada |
| L63 | 2 | `Sadd2009` em 1; 1 removido | tensão constante por elemento; a segunda chamada era continuação da inferência |
| L69 | 3 | `logg2012automated` em 1 grupo; 2 removidos | malha triangular do FEniCS; o refinamento é escolha do autor |
| L71–L82 | 5 | removidos | descrição literal de variáveis e do gerador `RectangleMesh` no script |
| L107 | 4 | removidos | `N_r = 4.000` e `80.000` elementos são resultados do próprio cálculo |
| L111 | 1 | `logg2012automated` | integração nos pontos de Gauss |
| L113–L115 | 7 | **bloqueio B1** | média interfacial e exigência de nós coincidentes com interfaces |
| L117 | 5 | **bloqueio B2** | “fenômeno de Gibbs elástico” e convergência estrita ao limite homogeneizado |
| L119 | 1 | **bloqueio B3** | impossibilidade de automatizar CAD e particionamento de malha |
| L121 | 1 | `logg2012automated` | mapeamento implícito de propriedades implementado no FEniCS |
| L125 | 1 | `bakhvalov1989` | células periódicas unitárias (RVEs) |
| L127–L159 | 7 | removidos | fórmulas e algoritmo do próprio trabalho |
| L179–L223 | 19 | `logg2012automated` em L179 e L218 (6 → 2 chamadas); demais removidos | implementação e formas variacionais no FEniCS; o restante descreve a arquitetura local |
| L227–L249 | 11 | **B4** em L231 (3) e **B5** em L247 (2); L227 e L249 removidos (6) | propriedades dos materiais e “Garfo de Hill”; os demais são parâmetros e cálculos do autor |
| L256–L266 | 11 | **B6** em L262 (3); L256, L260, L265 e L266 removidos (8) | cenário de carga e resultados numéricos do autor |
| L268 | 2 | `logg2012automated` (2 → 1 chamada) | forma linear de trabalho virtual no FEniCS |
| **Total** | **85** | | |

---

## 5. Bloqueios abertos (decisão C)

| ID | Local | Afirmação preservada | Por que está bloqueada | Fonte necessária |
|---|---|---|---|---|
| **B1** | §4.1.3, após L115 | elemento que cruza a interface produz média artificial das propriedades; nós devem coincidir com as interfaces | não há fonte localizada no `.bib` para a prescrição de malha conformada à interface | livro/texto de MEF para meios heterogêneos, com página e trecho de apoio |
| **B2** | §4.1.3, após L117 | “fenômeno de Gibbs elástico” e convergência estrita ao limite homogeneizado | o termo não é sustentado por nenhuma entrada do `.bib`; a garantia de convergência é uma afirmação forte | referência sobre oscilações numéricas em interfaces ou sobre convergência do MHA |
| **B3** | §4.1.3, após L119 | reconstrução CAD e `mesh partitioning` seriam impossíveis de automatizar parametricamente | afirmação categórica sem fonte; a automação CAD é possível em princípio | fonte sobre geração automatizada de malha ou reformulação pelo autor |
| **B4** | §4.2.1, após L231 | `E`, `ν`, `ρ` e `σ_y` do aço e do alumínio da Tabela 1 | o texto não identifica os graus específicos; os valores são genéricos e não têm fonte no `.bib` | norma, handbook ou datasheet com composição/grau e página |
| **B5** | §4.2.1, após L247 | “Garfo de Hill elástico” | conceito nomeado sem referência localizada | Hill (1952) ou obra equivalente sobre limites elásticos |
| **B6** | §4.2.2, após L262 | 30–35 MPa como pressão nominal de reservatórios Tipo III para `H₂` | a base normativa aprovada (NR-13 + ASME VIII) não cobre reservatórios Tipo III; não há fonte no `.bib` | norma técnica de reservatórios de gás ou literatura de aplicação, com página |

**Consequência:** a tarefa não pode ser declarada integralmente concluída. Os marcadores foram eliminados, mas seis afirmações continuam sem lastro documental. O texto não foi suavizado.

> **Suspeita adicional em B4 (não confirmada):** o estado do projeto registra ASTM A516 Gr. 70 e AA 6061-T6, mas a Tabela 1 não nomeia os graus. O valor de `σ_y = 400 MPa` para o aço precisa ser conferido contra a especificação do grau adotado; a substituição do valor não foi feita por falta de fonte confirmada.

---

## 6. Correção técnica incidental

Em L107, a espessura de cada subcamada estava grafada como `5,0 mm`. O cálculo é:

- `L_c = (R_ext − R_int) / N_cel = 2,0 / 200 = 0,01 mm = 10 µm`;
- com `V_1 = V_2 = 0,5`, cada subcamada tem `h = 5,0 µm`.

O valor foi corrigido para `5,0 \, \mu\text{m}` nas duas ocorrências. A afirmação de “10 elementos lineares internos” permanece coerente: `resolucao_malha = 20` por célula, `nel1 = nel2 = 10`.

---

## 7. Verificação estática

| Verificação | Resultado |
|---|---|
| Marcadores `[nn]` fora de código/matemática | **0** |
| Colchetes restantes | `x[0]` (matemática e código) e `values[0]` (código) |
| Ambientes `\begin` / `\end` | 22 / 22, balanceados |
| Chaves citadas | todas existentes no `.bib` |
| Compilação LaTeX | **não executada** — ferramentas ausentes |
| Execução do solver | **não executada** — FEniCS ausente |

---

## 8. Pendências e próximo passo

1. **Decidir sobre B1–B6:** fornecer as fontes, autorizar a busca externa ou aceitar a reformulação do trecho. Sem isso, a CIT-01 fica `bloqueada` nesses pontos.
2. **AUD-01:** consolidar a matriz de afirmações com os registros desta auditoria.
3. **CIT-02:** só iniciar após decisão sobre os bloqueios, para não acumular pendências no Capítulo 3.
4. **REF-01:** a entrada `bakhvalov1989` tem o campo `author` fora do padrão (`Panasenko, NSBG and Bakhvalov, NS`) e `Guinovart2024` termina com `}*/`; ambas precisam de saneamento antes da compilação final.
