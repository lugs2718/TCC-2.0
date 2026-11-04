# Estratégia de Citação do TCC — CIT-00

**Projeto:** Análise de um tubo cilíndrico multicamadas por meio da homogeneização assintótica numérica e método dos elementos finitos
**Autor:** Luiz Gustavo da Silva Pereira (UFF — EEIMVR)
**Data:** 03 de novembro de 2026
**Status:** aprovada em 03/11/2026 com as decisões A–D registradas na Seção 8; estratégia em vigor.

---

## 1. Objetivo da tarefa

Definir como o trabalho será citado, dada a ausência da lista numerada que daria sentido aos marcadores `[nn]` herdados da versão anterior. A tarefa não reescreve texto: fixa critérios, ordem de execução e registro de evidências.

---

## 2. Diagnóstico

### 2.1 Marcadores órfãos

Contagem refeita desconsiderando colchetes em modo matemático (intervalos como `$r \in [9,0,\,11,0]$` não são citações):

| Arquivo | Grupos | Números | Situação |
|---|---|---|---|
| `02_revisao_bibliografica.tex` | 167 | 313 | não compila (capítulo comentado em `main.tex`) |
| `03_1_equilibrio.tex` | 78 | 136 | ativo no PDF |
| `04_mef.tex` | 59 | 87 | ativo no PDF |
| `01_introducao.tex`, `03_2_homogeneizacao.tex`, `05_resultados.tex`, `06_conclusao.tex` | 0 | 0 | já sem marcadores |
| **Total** | **304** | **536** | |

> Correção de registro: a contagem anterior (574) incluía colchetes dentro de matemática. O número correto é **536**.

Concentração por subseção (as dez maiores):

| Subseção | Marcadores |
|---|---|
| NR-13 e integridade estrutural (Cap. 2) | 38 |
| ASME Seção VIII, Div. 1 e 2 (Cap. 2) | 37 |
| Lei de Hooke generalizada e tensor de 4ª ordem (Cap. 2) | 27 |
| Notação de Voigt e redução 6×6 (Cap. 2) | 21 |
| Formulação variacional fraca e métrica axissimétrica (Cap. 2) | 19 |
| Justificativa do MHA frente a ESL/layerwise (Cap. 2) | 17 |
| Dedução do problema local e funções corretoras (Cap. 3) | 14 |
| Alinhamento de nós com as interfaces (Cap. 4) | 15 |
| Substituição e recorrência de problemas (Cap. 2) | 13 |
| Backus / meios estratificados (Cap. 2) | 13 |

Grupos com 8–15 números no fim do mesmo parágrafo são o padrão dominante. Isso não é citação: é carimbo decorativo. Nenhuma fonte sustenta 12 afirmações distintas de um parágrafo; a recitação vai reduzir a maioria a 1–2 chamadas.

### 2.2 Tentativas de recuperação da lista legada (todas negativas)

| Via | Resultado |
|---|---|
| Fontes `.typ` (`Typst/clean_tcc.typ`, `Páginas/*.typ`) | Os `[nn]` são **texto literal** no arquivo, não numeração gerada por `#cite`. Não há o que recalcular. |
| `Typst/main.typ` linha 98 | Usa `#referencias(read("bibliografia.bib"))`; o `.bib` nunca teve mais de 41 entradas (36 no commit `343645c`, 41 no `1ab2514`). Uma numeração que chega a 1249 não pode ter origem nele. |
| `articles_scraping.py` (removido no commit `1ab2514`) | Arquivo **vazio** (0 bytes): nenhuma lista de DOIs preservada. |
| `TCC - última versão.pdf` (68 p.) | Contém marcadores, mas **não contém seção de referências**; e sua numeração é outra (1 a 18, com faixas como `[11-13]`), incompatível com a do `.tex`. |

**Conclusão:** a lista legada é irrecuperável. A numeração não é reconstruível nem por inferência de contexto, porque um mesmo número aparece associado a temas distintos em capítulos diferentes. A citação será **recitada do zero**.

### 2.3 Estado das citações válidas

Hoje existem 30 chamadas `\cite` funcionais (Cap. 1: 9; §2.1: 10; Cap. 3: 9; §3.2: 3), além de 3 chaves inválidas e 1 quebrada em linha comentada:

| Local | Código atual | Problema | Correção |
|---|---|---|---|
| `02_revisao_bibliografica.tex:23` | `\cite{beer1989resistencia:}` | dois-pontos na chave | `\cite{beer1989resistencia}` |
| `02_revisao_bibliografica.tex:27` | `\cite{eq-tensao-circunferencial}` e `\cite{eq-tensao-longitudinal}` | rótulo de equação usado como citação | `\eqref{eq:...}`, após converter as equações Typst (`REV-02.1`, sub-bloco D.2) |
| `02_revisao_bibliografica.tex:50` | `\cite[p.~2]{asme\textit{sec8}div1_2019}` | comando dentro da chave (linha comentada) | `asme_sec8_div1_2019` |

### 2.4 Pool disponível: 28 entradas nunca citadas

Das 41 entradas do `.bib`, 28 nunca foram chamadas — e cobrem exatamente os temas órfãos. É o primeiro lugar onde a recitação deve procurar fonte, antes de buscar material novo:

| Tema | Entradas candidatas |
|---|---|
| Homogeneização / SAF | `Cioranescu2010`, `Milton2016`, `HomogenisationReportBakhvalov`, `bakhvalov1989`, `PartonReport`, `BrunaReport` |
| Cilindros e cascas multicamadas | `Choi1995`, `Choi1995_dup`, `Heyliger2003`, `Berger2003`, `Tsalis2012`, `Tsalis2013`, `Tsalis2017`, `Adali1993` |
| MEF / FEniCS | `logg2012automated`, `bleyer2018numericaltours` |
| Elasticidade e tensores | `Itskov2007` |
| Normas e vasos de pressão | `asme_sec8_div1_2019`, `brasil_nr13_2022` |
| Trabalhos recentes / aplicações | `Soyarslan2024`, `Alao2024`, `Jarrett2023`, `Yang2023`, `Zhang2022`, `Ruan2024`, `Hu2015`, `Haynes2016`, `DcioJr2022`, `DONG1962`, `agne2024impact`, `deMenezes2025`, `Pereira2025` |

Ressalvas que passam a `REF-01`: `Choi1995_dup` é duplicata; `RMJones2018` tem `year={1999}`; cinco entradas estão incompletas.

---

## 3. Sistema de chamada

**Decisão técnica já suportada pelo projeto:** `abntex2cite` com opção `alf` (`main.tex`, linha 72) — sistema **autor-data**. Consequências:

1. A lista numerada não existe e não é necessária; `[nn]` não é compilável como citação.
2. Toda chamada deve usar `\cite` ou `\citeonline`, com página quando a afirmação for específica (`\cite[p.~415]{...}`), como já ocorre em §2.1.
3. A ordem alfabética da lista é gerada pelo `bibtex`: não é preciso gerenciar posição de referência.

---

## 4. Regras de recitação

- **R1 — Uma chamada, uma afirmação.** A citação ancora a frase que ela sustenta; não se coloca no fim do parágrafo "para o parágrafo todo".
- **R2 — Duas fontes é o teto.** Exceção: quando duas obras divergem e o texto compara as duas.
- **R3 — não citar o que não se leu.** Obra inacessível entra como limitação declarada, nunca como confirmação.
- **R4 — página obrigatória** em citação direta, dado numérico e prescrição normativa; autor-ano basta em conceito geral.
- **R5 — `\citeonline`** quando o autor é sujeito da oração ("Segundo Beer et al. (1989), ...").
- **R6 — equação não é referência.** Rótulos `eq:*` vão para `\eqref`, nunca para `\cite`.
- **R7 — nenhum `[nn]` sobrevive** ao fim da tarefa do capítulo correspondente.
- **R8 — sem fonte, a tarefa para.** A afirmação é preservada e a busca por fonte é feita caso a caso (decisão C). Se a fonte não for localizada, a tarefa é registrada como `bloqueada` naquele ponto e o caso é levado ao autor; não se suaviza o texto por conta própria e não se inventa referência, ano, página ou DOI.

> Decisão C implica custo: cada afirmação sem fonte localizável interrompe a seção. O registro de bloqueios passa a ser parte do entregável de cada `CIT-0x`.

Estados de verificação por afirmação (herdados da skill): `confirmada`, `parcialmente sustentada`, `não sustentada`, `sem fonte`, `não verificável`.

---

## 5. Fluxo operacional por seção

1. **Inventariar** as afirmações com pretensão factual da seção.
2. **Classificar** cada uma: dado próprio / literatura / norma / método / opinião do autor.
3. **Buscar evidência** no pool do `.bib`; não havendo, procurar fonte nova; não havendo, registrar `bloqueada` e levar o caso ao autor (decisão C) — sem suavizar o texto.
4. **Redigir a chamada** conforme R1–R8.
5. **Registrar** na matriz do `AUD-01` e remover os marcadores daquela seção.

Cada seção termina com `[x]` apenas quando os marcadores foram substituídos **e** as fontes declaradas como `confirmada` ou `não verificável`.

---

## 6. Ordem de execução proposta

| Tarefa | Alvo | Marcadores | Justificativa |
|---|---|---|---|
| **CIT-01** | Cap. 4 (`04_mef.tex`) | 87 | Texto ativo no PDF e base das afirmações do Cap. 5; menor esforço. |
| **CIT-02** | Cap. 3 (`03_1_equilibrio.tex`) | 136 | Formulação; depende de Lai/Sadd/Timoshenko/Bakhvalov/Parton/Guinovart, já no `.bib`. |
| **CIT-03** | Cap. 2 — §2.1 e §2.2 | ~125 | NR-13/ASME/Hooke/Voigt/simetrias. Executar **após** `REV-02.1` (sub-bloco D.2), pois as mesmas linhas têm equações Typst quebradas. |
| **CIT-04** | Cap. 2 — §2.3 | ~32 | Zig-zag, ESL, layerwise, justificativa do MHA. |
| **CIT-05** | Cap. 2 — §2.4 | ~56 | Homogeneização, Backus, SAF, h-convergência. |
| **CIT-06** | Cap. 2 — §2.5 | ~48 | MEF, Galerkin, FEniCS. |
| **CIT-07** | Varredura final | — | Chaves órfãs, `bibtex` sem `Warning--`, coerência entre chamada e lista. |

O Cap. 2 vem por último de propósito: está comentado em `main.tex` e não compila, então sua citação não chega ao PDF até que `REV-02.1`/`REV-02.2` o restaurem.

---

## 7. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Apagar marcador e perder a pista de que ali havia intenção de citar | Substituir por `% [CIT] afirmação X sem fonte` antes de remover; remoção só na conferência final da seção. |
| Reduzir 12 referências a 2 parecer "menos embasado" ao orientador | A matriz do `AUD-01` documenta a decisão e a fonte principal que passou a sustentar o trecho. |
| Norma paga/inacessível (ASME, NR-13) | Registrar `não verificável` com a edição consultada; não transcrever página não confirmada. |
| Retrabalho entre `REV-02.x` e `CIT-0x` no Cap. 2 | Executar a tarefa de revisão imediatamente antes da de citação, na mesma seção. |
| Citação trocada (fonte que não diz aquilo) | Toda fonte nova entra com página e trecho de apoio na matriz; sem trecho, não entra. |

---

## 8. Decisões registradas (03/11/2026)

| ID | Questão | Decisão do autor | Efeito |
|---|---|---|---|
| **A** | Sistema de chamada | **Autor-data** (`abntex2cite alf`) | A numeração legada é abandonada em definitivo; toda chamada usa `\cite`/`\citeonline`. |
| **B** | Base normativa | **NR-13 + ASME Seção VIII, Div. 1 e 2** | As 75 chamadas de §2.1 ancoram-se nesses dois documentos; normas de compósitos não entram sem indicação posterior do autor. |
| **C** | Afirmação sem fonte localizável | **Buscar fonte caso a caso** | A afirmação é preservada; a tarefa para no ponto e volta ao autor se a fonte não for encontrada. Não há suavização automática. |
| **D** | Ordem de execução | **Cap. 4 → Cap. 3 → Cap. 2** | `CIT-01` (Cap. 4), `CIT-02` (Cap. 3), `CIT-03` a `CIT-06` (Cap. 2), `CIT-07` (varredura). |

---

## 9. Critério de conclusão da CIT-00

Satisfeito em 03/11/2026: documento aprovado e decisões A–D registradas no artefato de estado. Nenhuma alteração em `.tex` fez parte desta tarefa.
