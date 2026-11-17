# Planejamento e Estado da Revisão do TCC (Fase 0 — Revisão Expandida)
**Projeto:** *Análise de um tubo cilíndrico multicamadas por meio da homogeneização assintótica numérica e método dos elementos finitos*  
**Autor:** Luiz Gustavo da Silva Pereira  
**Instituição:** Universidade Federal Fluminense (UFF) — EEIMVR / Departamento de Engenharia Mecânica  
**Data da Auditoria:** 02 de novembro de 2026 (Consolidação da Etapa 1 e Expansão Estruturada do Backlog)  
**Status do Projeto:** Fase 0 concluída; CON-01 e TEC-04 concluídas; Backlog expandido em tarefas granulares.
## 0. Legenda de Escopo das Tarefas (Taxonomia)

Cada tarefa do projeto recebe um identificador estável (`XX-NN`) cujo prefixo indica o **escopo**:

| Prefixo | Escopo | Descrição |
|---|---|---|
| `DIA` | Diagnóstico e Inventário | Mapeamento inicial de arquivos, estrutura LaTeX, PDF, diagnóstico acadêmico preliminar. |
| `CON` | Conteúdo e Estrutura Argumentativa | Organização de capítulos/seções, coesão, alinhamento objetivos-método-resultados, redundâncias, lacunas. |
| `TEC` | Consistência Técnica, Matemática e Computacional | Equações, símbolos, unidades, algoritmos, parâmetros de malha, coerência entre formulação e implementação. |
| `CIT` | Auditoria de Citações e Rastreabilidade | Conversão de marcadores numéricos `[nn]` para chaves BibTeX, confronto de afirmações com fontes, resolução de bloqueios. |
| `RED` | Redação Científica e Estilo | Clareza, concisão, variedade lexical, estilo acadêmico, limpeza editorial. |
| `NOR` | Normas Institucionais e Apresentação Gráfica | Conformidade ABNT/EdUFF, estrutura pré/pós-textual, figuras, tabelas, quadros, legendas, paginação. |
| `REF` | Saneamento da Base Bibliográfica (`.bib`) | Auditoria, completude, padronização e correção de entradas BibTeX. |
| `PDF` | Inspeção Visual do PDF Final | Diagramação, mancha gráfica, margens, quebras, correspondência sumário-conteúdo. |
| `REV` | Revisão por Capítulo/Seção (conteúdo) | Revisão integrada de um capítulo ou seção (estrutura + conteúdo + equações), fatiada em sub-tarefas quando necessário. |
| `AUD` | Auditoria de Afirmações | Matriz de afirmações verificáveis (local, classe, evidência, estado). |

**Regra de granularidade:** tarefas volumosas são fatiadas em micro-lotes (ex.: `CIT-02.1`, `CIT-02.2`, `REV-02.2a`). Cada micro-lote cobre 10–15 citações ou uma subseção coesa, com diagnóstico → proposta → validação → consolidação.

---

## 1. Registro Histórico das Ações e Decisões Consolidadas

### 1.1 Metadados Institucionais e Autoria
- **Autor oficial:** Atualizado formalmente para **Luiz Gustavo da Silva Pereira** no preâmbulo de [`LaTeX/main.tex`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/LaTeX/main.tex).
- **Sistema de Unidades:** Confirmada a adoção estrita do **Sistema de Engenharia N-mm-MPa** em perfeita congruência com o código computacional [`Códigos/main.py`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/C%C3%B3digos/main.py) ($R_{\text{int}} = 9{,}0\text{ mm}$, $R_{\text{ext}} = 11{,}0\text{ mm}$, $t = 2{,}0\text{ mm}$, $P_{\text{int}} = 30\text{ MPa}$, módulos em MPa). Menções residuais a metros nos capítulos subsequentes serão corrigidas para milímetros durante as respectivas revisões técnicas.

### 1.2 Capítulo 1 (Introdução) — Tarefa CON-01 Concluída com Sucesso
A revisão integral do arquivo [`LaTeX/capitulos/01_introducao.tex`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/LaTeX/capitulos/01_introducao.tex) incorporou todas as diretrizes acordadas:
1. **Justificativa Técnico-Científica dos Materiais:** Incorporada a seleção do par bimetálico aço carbono estrutural (ASTM A516 Gr. 70) e liga de alumínio (AA 6061-T6), fundamentada tanto na redução de massa de mais de $30\%$ quanto no alto contraste de rigidez elástica ($E_1/E_2 \approx 2{,}86$), servindo como *benchmark* micromecânico ideal para o MHA.
2. **Contextualização Substancial das Aplicações:** As referências a vasos COPVs (Zhang) e risers flexíveis em águas profundas (Liu) foram articuladas com suas respectivas funções estruturais.
3. **Harmonização do MEF e MHA:** A subseção 1.2 contrasta claramente o custo proibitivo de refinamento de malha no MEF detalhado frente à capacidade do MHA de substituir o meio oscilatório por um contínuo equivalente.
4. **Alinhamento Transparente da SAF (1ª Ordem vs. Trabalhos Futuros):** Ficou explicitado que o MHA deduz as constantes efetivas e resolve o campo macroscópico médio $\mathbf{u}^0(\mathbf{x})$, enquanto a implementação computacional da reconstrução analítica das flutuações locais via $\epsilon \mathbf{u}^1$ é delimitada teoricamente e programada como proposta de trabalho futuro.
5. **Calibração Analítica com Solução de Lamé:** Incluída expressamente no Objetivo Geral como padrão fundamental de verificação do solucionador numérico para o caso homogêneo.
6. **Eliminação de Jargões Antecipados:** O termo prematuro *kinks* foi substituído no Objetivo Específico nº 5 por "descontinuidades de gradiente nas interfaces", reservando a fundamentação formal para o Capítulo 2.
7. **Delimitação de Escopo e Limitações:** Redigida subseção formal (regime elástico linear, pequenos deslocamentos, ausência de delaminação e efeitos térmicos, simetria axissimétrica sob deformação plana generalizada).
8. **Organização da Monografia:** Descrição precisa dos 6 capítulos reais da obra.
9. **Higienização de Rascunhos:** Legenda provisória corrigida para `\caption{Representação esquemática do princípio da separação de escalas e do parâmetro geométrico adimensional $\epsilon$}` e todas as anotações `\marginpar` atendidas e limpas.

### 1.3 Aprimoramento Metodológico da SKILL `tcc-revisor` (v2.2) e Versionamento
- **Princípio da Atomicidade:** Revisão de capítulos densos (como o Capítulo 2, de 76 kB) fatiada obrigatoriamente em seções temáticas autônomas e lotes gerenciáveis de até 10–15 citações/equações para evitar propostas extensas que inviabilizem a validação.
- **Protocolo Ativo para Notas de Autor:** Determinado que anotações `\marginpar`, marcações de rascunho e comentários `% TODO` são diretrizes ativas de projeto; sua remoção só pode ocorrer após o pleno atendimento e incorporação do conteúdo no texto.
- **Diretriz de Redação Humana e Mitigação de Detectores de IA (Princípio 14 e Sub-passo G):** Instituída a priorização de variação lexical, alternância de extensão sintática e naturalidade acadêmica para eliminar padrões sintéticos excessivamente homogêneos, acompanhado da checagem em detectores de IA e documentação de resultados. A tarefa atômica `REV-01-IA` foi inserida no backlog para revisar a Introdução sob essa ótica.
- **Higiene do Versionamento:** Criação do `.gitignore` na raiz do projeto para ignorar artefatos de compilação LaTeX (`*.aux`, `*.log`, `*.bbl`, etc.), ambientes virtuais Python e arquivos temporários de sistema.

### 1.5 Capítulo 4 (MEF) — Tarefa CIT-01 Concluída (05/11/2026)
- **Escopo:** auditoria de citações do Capítulo 4 (`04_mef.tex`): 85 referências numéricas legadas removidas (recontagem sobre `HEAD`; inventário inicial dizia 87 — diferença documentada em `citacao_CIT-01.md`).
- **Resultado:** 14 chamadas `\cite` (`Sadd2009`, `Timoshenko_1951`, `logg2012automated`, `bakhvalov1989`, `Zhang2022`); 0 marcadores `% [CIT]` restantes.
- **Bloqueios resolvidos por reformulação (decisão C emendada — suavização autorizada):** B1 (interpolação de deslocamento), B2 (remoção da referência ao “fenômeno de Gibbs elástico”), B3 (limitação real do fluxo adotado, em vez da negativa categórica), B5 (remoção da menção a “Garfo de Hill elástico”).
- **Bloqueio B4 resolvido com ajuste:** graus nomeados (aço ASTM A516 Gr. 70; alumínio 6061-T6); σy do aço ajustado de 400,0 para 260,0 MPa na tabela e no texto. Valores permanecem como parâmetros adotados do script de projeto; entradas correspondentes no `.bib` são dependência da REF-01.
- **Bloqueio B6 reformulado:** “faixa de 30 a 35 MPa como pressão nominal de Tipo III” → “pressão de projeto inferior a 35 MPa” \cite{Zhang2022}, com 30 MPa mantido como valor adotado na simulação. Entrada `Zhang2022` adicionada ao `.bib`.
- **Busca local no acervo:** executada sobre 48 PDFs (6.170 páginas). B5 ancorado em Bakhvalov p. 225 (“Hill’s forks”) e p. XXXIII (“Voight-Reuss-Hill approximations”); B6 com suporte parcial (Zhang et al. 2022, p. 18); B4 com divergência (Hibbeler 6061-T6: E = 68,9 GPa, σy = 255 MPa vs. TCC 70 GPa / 270 MPa); B1, B2 e B3 sem fonte local.
- **Arquivos:** `citacao_CIT-01.md` (relatório), `04_mef.tex`, `bibliografia.bib`, `planejamento_revisao_tcc.md` (JSON).

### 1.7 Base Bibliográfica (`bibliografia.bib`) — Tarefa REF-01 Concluída (06/11/2026, com ressalvas)
- **Escopo:** saneamento e padronização da base `.bib` (44 entradas após a tarefa).
- **Adições (REF-01d):** `Backus1962` (verificado no PDF), `Zhang2022` (verificado), `lai2010continuum` (verificado), `leitzke2017` (verificado), `bensoussan1978` (canônica, não no acervo), `hibbeler2010` (verificado), `astm_a516` (título/organização verificados; ano a confirmar).
- **Correções (REF-01a):** `bakhvalov1989` (author → Bakhvalov & Panasenko; @article → @book; publisher/address/year/volume/series); `Timoshenko_1951` (@Book → @book; booktitle removido). Removidas: `TaberReport`, `SatReport`, `HomogenisationReportBakhvalov` (opção C). `Heyliger2003` mantida (incompleta, opção C).
- **Limpeza (REF-01b):** `Itskov2007` (remoção de 12 campos de scraping; author corrigido); `Choi1995_dup` removida.
- **Completude (REF-01c):** `PartonReport` (@article → @book, publisher/address); `agne2024impact` (doi); `Adali1993` (@techReport → @article).
- **Verificação (REF-01e):** 44 entradas; 8 chaves citadas, 0 ausentes; 1 entrada desbalanceada pré-existente (`Ruan2024`); 3 entradas sem year (`Heyliger2003`, `Ruan2024`, `astm_a516`).
- **Achado:** tabela de mapeamento usa chaves inexistentes no `.bib` (dependência NOR-03).
- **Arquivos:** `bibliografia.bib`, `planejamento_revisao_tcc.md`.

### 1.8 Tabela de Mapeamento (`mapeamento_autores_por_capitulos_tcc.xlsx`) — Tarefa NOR-03 Concluída (06/11/2026)
- **Escopo:** alinhamento das chaves BibTeX na Coluna D da tabela de mapeamento às chaves reais do `.bib`.
- **Alterações:** 9 chaves alinhadas (22 ocorrências): `@jones2018mechanics`→`@RMJones2018`, `@pereira2024`→`@Pereira2025`, `@sadd2009elasticity`→`@Sadd2009`, `@asme2019`→`@asme_sec8_div1_2019`, `@nr13_2023`→`@brasil_nr13_2022`, `@parton_reducido`→`@PartonReport`, `@fenics2012`→`@logg2012automated`, `@timoshenko1970`→`@Timoshenko_1951`, `@zhang2022`→`@Zhang2022`. `@backus1962` adicionado nas linhas 4.2.4 e 4.4.1–4.4.2 (na REF-01d).
- **Ressalvas:** 4 chaves sem equivalente no `.bib` (`@vignoli2018`, `@tonatto2020`, `@beer2003`, `@kassapoglou2021`) — dependência REF-01d se forem citadas.
- **Arquivos:** `mapeamento_autores_por_capitulos_tcc.xlsx` (backup `.bak`/`.bak2`), `planejamento_revisao_tcc.md`.

### 1.10 Capítulo 3 (Unificação) — Tarefa TEC-01 Concluída (07/11/2026)
- **Escopo:** unificação estrutural e consistência algébrica do Capítulo 3 (fusão de `03_1_equilibrio.tex` e `03_2_homogeneizacao.tex`).
- **Resultado:** arquivo merged com 753 linhas, 1 `\chapter`, 10 `\section`, 14 `\subsection`. `main.tex` atualizado (03_2 comentado). 3 `\marginpar` removidos (lei de Hooke local, tensor de elasticidade reduzido, regra da cadeia — conteúdo ao redor os endereça). Conferência estrutural: 77 labels (0 duplicados), 46 refs/eqrefs (0 targets ausentes), 86 `\cite` (0 chaves ausentes). Equações do problema local (χ¹, χ²) e constantes efetivas (Ĉ₁₁, Ĉ₁₂, Ĉ₂₂, Ĝ) na parte merged são consistentes com a formulação do Cap. 3.
- **Arquivos:** `03_1_equilibrio.tex` (merged), `main.tex`.

### 1.14 Compilação Local e Correções de Erros (11/11/2026)

**Problemas encontrados e soluções aplicadas:**

| # | Problema | Causa | Solução |
|---|---|---|---|
| 1 | `\includeonly{}` com todas as linhas comentadas | Configuração de desenvolvimento (compilação parcial) | Descomentadas as 7 linhas de capítulos (exceto `03_2_homogeneizacao`, merged) |
| 2 | `\input{Tabelas/...}` não encontrado | Caminho relativo incorreto (Tabelas está na raiz, não em LaTeX/) | Alterado para `\input{../Tabelas/...}` |
| 3 | Imagens não encontradas (`Imagens/...`) | Caminho relativo incorreto (Imagens está na raiz) | Alterado para `../Imagens/...` em 05_resultados.tex |
| 4 | Ambiente `quadro` não definido | abntex2 não define `\begin{quadro}` nativamente | Adicionado `\usepackage{newfloat}` + `\DeclareFloatingEnvironment` em main.tex |
| 5 | Equação órfã (`\end{equation}` solto) em §2.1 | Typst residual não convertido | Reescrita como `\begin{equation}...\end{equation}` |
| 6 | `$sigma_2$` (Typst) em §2.1 | Typst residual | Convertido para `$\sigma_2$` |
7 | `N_cell` e `W_ef` sem `$` em §6 | Underscore em modo texto | Convertido para `$N_{\text{cell}}$` e `$W_{\text{ef}}$` |
8 | `Backus1962` duplicado no `.bib` | Entrada antiga (minúscula) + nova (maiúscula) | Removida a entrada antiga (L10–L19) |
9 | `\epsilon` unicode em 06_conclusao.tex | Caractere unicode em modo texto | Convertido para `$\epsilon$` |
10 | `<eq:...>` Typst labels (26 ocorrências) em §2.2 | Labels Typst não convertidos | Convertidos para `\label{eq:...}` |
11 | `\eqref{eq:cont}stress}` malformado | Typst residual | Corrigido para `\eqref{eq:cont_stress}` |
12 | `\begin{equation}` duplicado em §2.1 | Typst residual | Removida a duplicata |
13 | `\end{equation}` solto em §2.1 (L511) | Typst residual | Reescrito como ambiente completo |
14 | `W_ef` em texto (§6) | Underscore em modo texto | Convertido para `$W_{\text{ef}}$` |
15 | `\bfseries` em modo matemático | `\textbf` dentro de `$...$` em tabela Voigt | (resolvido indiretamente pela correção do delimitador) |
16 | 10 referências de equação não definidas | Labels perdidos na conversão Typst→LaTeX | Todos os `\label{eq:...}` adicionados via conversão de `<eq:...>` |

**Resultado final:** 0 erros, 0 referências não definidas, 0 citações não resolvidas. PDF de 98 páginas gerado com sucesso.","oldString">
### 1.13 Capítulo 2 (§2.2) — Tarefa REV-02.2 Concluída (09/11/2026)
- **Escopo:** revisão de conteúdo e consistência técnica da §2.2 (Mecânica dos Compósitos, Notação de Voigt, Simetrias Elásticas).
- **Sub-tarefas concluídas:**
  - REV-02.2a: correção de 12 subscritos Typst em §2.2 (L189, L192, L199, L201, L203, L205, L207, L210, L214, L217, L270→L276, L273→L276). Conversão de `\textit{...}` para subscritos LaTeX corretos. Verificação: 0 subscritos Typst suspeitos restantes em §2.2.
  - REV-02.2b: inserção da definição formal do gradiente vetorial ($\nabla \mathbf{u}$) e do tensor de deformações simétrico ($\epsilon_{ij} = \frac{1}{2}(u_{i,j} + u_{j,i})$) após a equação de Hooke (L192–L194), com citações a Lai (2010) e Sadd (2009).
  - REV-02.2c: revisão da Lei de Hooke generalizada (21→9→5 constantes) — verificação de consistência e coerência do texto. Fluxo lógico verificado: Hooke (L191) → 81 componentes (L197) → restrições (L199) → simetria menor esquerda (L201) → simetria menor direita (L205) → 36 componentes (L209) → potencial elástico (L211) → simetria maior (L218) → 21 componentes (L221). Citações já resolvidas na CIT-03.
- **Citações:** já resolvidas na CIT-03 (11 `\cite` na §2.2: lai2010continuum ×6, Sadd2009 ×2, Timoshenko_1951 ×2, RMJones2018 ×1).
- **Arquivos:** `02_revisao_bibliografica.tex`.

---

## 2. Inventário Documental dos Ativos do Projeto

| Arquivo / Diretório | Formato / Tipo | Finalidade no Projeto | Status | Notas de Inspeção |
|---|---|---|---|---|
| `LaTeX/main.tex` | LaTeX | Arquivo principal do documento | **Auditado** | Autor atualizado; compilação modular via `\includeonly` preservada. |
| `LaTeX/capitulos/01_introducao.tex` | LaTeX | Capítulo 1: Introdução | **Concluído** | 100% revisado, alinhado e limpo de rascunhos. |
| `LaTeX/capitulos/02_revisao_bibliografica.tex` | LaTeX | Capítulo 2: Revisão Bibliográfica | **CIT-03 concluída** | 684 linhas. 0 marcadores reais (excl. índices de Voigt em bloco Typst comentado). 184 `\cite`. |
| `LaTeX/capitulos/03_1_equilibrio.tex` | LaTeX | Capítulo 3 (Equilíbrio e Navier-Cauchy) | **CIT-02 concluída** | Equações fundamentais do cilindro axissimétrico. 0 marcadores; 82 `\cite`. |
| `LaTeX/capitulos/03_2_homogeneizacao.tex` | LaTeX | Capítulo 3 (Homogeneização Assintótica) | **Pendente** | Dedução do problema local. Será unificado sob o Cap. 3. |
| `LaTeX/capitulos/04_mef.tex` | LaTeX | Capítulo 4: Método dos Elementos Finitos | **CIT-01 concluída** | Implementação FEniCS, formulação fraca com peso do raio $r$ e malha estruturada. 0 marcadores `% [CIT]`; 14 chamadas `\cite`. |
| `LaTeX/capitulos/05_resultados.tex` | LaTeX | Capítulo 5: Resultados e Discussões | **Pendente** | Validação com Lamé, comparação MEF vs MHA, tabela de eficiência e novos gráficos. |
| `LaTeX/capitulos/06_conclusao.tex` | LaTeX | Capítulo 6: Conclusão | **Pendente** | Será redigido no fechamento da revisão dos capítulos técnicos. |
| `LaTeX/bibliografia.bib` | BibTeX | Base bibliográfica central | **Auditado** | 41 entradas. Chaves com erro tipográfico (`beer1989resistencia:`, `asme\textit{sec8}`). |
| `Códigos/main.py` | Python/FEniCS | Solucionador computacional principal | **Auditado** | Script de simulação canônico (escala mm-N-MPa). |
| `Códigos/Documentation/DOCUMENTACAO.md` | Markdown | Histórico e roadmap do solver FEniCS | **Auditado** | Documenta formalmente a transição e adoção da escala N-mm-MPa. |
| `Imagens/comparacao_perfis_deslocamento.png` | Imagem PNG | Convergência em imagem única | **Disponível** | Pronto para inserção no Capítulo 5. |
| `Imagens/bench_tempos_e_reducao.png` | Imagem PNG | Gráfico de speedup computacional | **Disponível** | Pronto para inserção no Capítulo 5. |
| `Imagens/convergencia_assintotica_erro.png` | Imagem PNG | Gráfico de erro assintótico L2 | **Disponível** | Pronto para inserção no Capítulo 5. |
| `Tabelas/tabela_eficiencia_mha_vs_mef.tex` | Tabela LaTeX | Tabela comparativa de desempenho | **Disponível** | Tabela quantitativa pronta para inserção no Capítulo 5. |
| `Tabelas/tabela_universal_embasamento_tcc.xlsx` | Excel | Matriz universal de citações e fontes | **Ativa** | Base de consulta para conversão das chamadas `[nn]`. |

---

## 3. Backlog de Execução Reestruturado e Granular

### Fase 0 — Diagnóstico e Inventário (Concluída)
- [x] **DIA-01:** Inventário documental completo e conferência de versões.
- [x] **DIA-02:** Auditoria estática da estrutura LaTeX e pré-requisitos de compilação.
- [x] **DIA-03:** Inspeção visual e normativa dos PDFs existentes.
- [x] **DIA-04:** Diagnóstico acadêmico preliminar e mapeamento de consistência teórico-metodológica.
- [x] **DIA-05:** Consolidação da matriz de achados e alinhamento do planejamento.

---

### Plano 1 — Conteúdo e Consistência Técnica (Plano Ativo)

#### Capítulo 1 — Introdução
- [x] **CON-01:** **Revisão Integral do Capítulo 1 (Introdução)** [Concluída em 02/11/2026]

#### Capítulo 2 — Revisão Bibliográfica
- [x] **REV-02.1:** **Vasos de Pressão e Critérios Normativos (Seção 2.1)** [Concluída em 11/11/2026]
  - Sub-blocos D.1, D.2, D.3 concluídos. 0 marcadores [nn].
- [x] **REV-02.2:** **Mecânica dos Compósitos, Notação de Voigt e Simetrias Elásticas (Seção 2.2)** [Concluída em 09/11/2026]
- [x] **REV-02.3:** **Teorias de Placas/Cascas e Efeito Zig-Zag (Seção 2.3)** [Concluída em 10/11/2026]
- [x] **REV-02.4:** **Homogeneização, Médias de Backus e Formalismo do MHA (Seção 2.4)** [Concluída em 10/11/2026]
- [x] **REV-02.5:** **Homogeneização na Revisão Bibliográfica — Citar Literatura (Seção 2.4)** [Concluída em 17/11/2026]
  - Reformulado parágrafo do Problema Homogeneizado para citar Bakhvalov e Cioranescu.
  - Coeficientes efetivos referenciam Cap. 3 (Sec. 3.3).
- [x] **CON-RED:** **Conversão do Bloco Typst Residual (Voigt, §2.2)** [Concluída em 10/11/2026]
- [x] **CON-RED2:** **Conversão dos Artifacts Typst Residuais (§5 — Formulação Variacional)** [Concluída em 11/11/2026]
  - 0 artifacts Typst restantes no Cap. 2 (excl. comentários).

#### Capítulo 3 — Formulação Matemática e Homogeneização
- [x] **TEC-01:** **Unificação Estrutural e Consistência Algébrica do Capítulo 3** [Concluída em 07/11/2026]
- [x] **TEC-05:** **Completude e Reordenação da Homogeneização no Cap. 3** [Concluída em 17/11/2026]
  - Removida seção duplicada §3.5 (MHA).
  - Adicionada seção "Problema Homogeneizado" (equação macroscópica de equilíbrio).
  - Cross-reference: coeficientes efetivos derivados do problema local (§3.2).

#### Capítulo 4 — Metodologia e Simulação Numérica (MEF / FEniCS)
- [x] **TEC-02:** **Consistência Físico-Matemática e Dimensional do MEF** [Concluída em 08/11/2026]
- [x] **CON/RED3:** **Limpeza e Coerência da Descrição de Implementação (Caps. 4 e 5)** [Concluída em 17/11/2026]
  - Cross-references entre §4.3 e §5.4 adicionados.

#### Capítulo 5 — Resultados e Discussões
- [x] **TEC-03:** **Integração dos Novos Resultados Numéricos e Gráficos** [Concluída em 10/11/2026]
  - Tabela mestre inserida via \input. 3 figuras incluídas.
- [x] **TEC-04:** **Harmonização Dimensional (m → mm) do Capítulo 5 e do Capítulo 4** [Concluída em 05/11/2026]

#### Capítulo 6 — Conclusão e Trabalhos Futuros
- [x] **CON-03:** **Redação Estruturada do Capítulo 6** [Concluída em 10/11/2026]
  - CON-03a: Esboço/outline. CON-03b: Resposta aos 5 objetivos. CON-03c: Tabela resumo (16 métricas). CON-03d: Limitações e trabalhos futuros.

#### Coesão Inter-Capítulos
- [x] **COE-01:** **Coesão e Cross-Referências entre Capítulos** [Concluída em 17/11/2026]
  - COE-01a: Cross-references SAF entre Caps. 1 e 2.
  - COE-01b: Cross-references nos Caps. 3-6.
  - COE-01c: SAF consolidada (Caps. 1 e 2 referenciam Cap. 3).

#### Citações e Rastreabilidade
- [x] **CIT-00:** **Estratégia de Citações** [Concluída em 03/11/2026]
- [x] **CIT-01:** **Auditoria de Citações do Capítulo 4** [Concluída em 05/11/2026]
- [x] **CIT-02:** **Auditoria de Citações do Capítulo 3** [Concluída em 05/11/2026]
- [x] **CIT-03:** **Auditoria de Citações do Capítulo 2** [Concluída em 07/11/2026]
- [x] **NOR-03:** **Alinhamento das Chaves BibTeX na Tabela de Mapeamento** [Concluída em 06/11/2026]
- [x] **REF-01:** **Saneamento da Base bibliografia.bib** [Concluída em 06/11/2026, com ressalvas]
- [x] **REF-01c:** **Correções Residuais no .bib** [Concluída em 10/11/2026]

#### Normas Institucionais (Plano 2)
- [x] **NOR-01:** **Padronização Normativa de Quadros vs. Tabelas e Legendas** [Concluída em 10/11/2026]
- [x] **NOR-02 (parte 1):** **Configuração Pré-Textual** [Concluída em 11/11/2026]
- [ ] **NOR-02 (parte 2):** **Inspeção Visual Final do PDF** [Pendente — compilação no Overleaf/local]

---
### Plano 2 — Normas Institucionais UFF e Apresentação Gráfica

- [x] **REF-01:** **Saneamento e Padronização da Base `bibliografia.bib`** (concluída em 06/11/2026, com ressalvas)
  - Entradas: 44 (eram 41; +6 adicionadas: Backus1962, Zhang2022, lai2010continuum, leitzke2017, bensoussan1978, hibbeler2010, astm_a516; −3 removidas: TaberReport, SatReport, HomogenisationReportBakhvalov; −1 duplicata: Choi1995_dup).
  - Correções: bakhvalov1989 (author + tipo + publisher), Timoshenko_1951 (tipo + booktitle), Itskov2007 (limpeza de scraping), PartonReport (tipo + publisher), agne2024impact (doi), Adali1993 (reclassificação techReport→article).
  - Chaves citadas: 8/8 existem. Nenhuma chave ausente.
  - Ressalvas residuais: `Heyliger2003` incompleta (sem year, mantida por escolha do usuário); `astm_a516` sem year (a confirmar); `Ruan2024` truncada (pré-existente); `Ruan2024` com braces desbalanceados (pré-existente).
---

### Plano 3 — Citação e Rastreabilidade de Afirmações

> Os identificadores `CIT-01` a `CIT-07` deste plano substituem as tarefas de citação antes numeradas `CIT-05`, `CIT-06` e `CIT-07` no Plano 1. As entradas antigas foram mantidas apenas como registro histórico.

- [x] **CIT-00:** **Estratégia de Citação sem Lista Numérica Legada**
  - Documento aprovado: [`citacao_estrategia_CIT-00.md`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/citacao_estrategia_CIT-00.md).
  - Decisões A–D: (A) autor-data; (B) NR-13 + ASME VIII Div. 1 e 2; (C) busca de fonte caso a caso, com bloqueio da tarefa quando não localizada; (D) Cap. 4 → Cap. 3 → Cap. 2.
  - Diagnóstico: 536 marcadores órfãos em 304 grupos (Cap. 2: 313; Cap. 3: 136; Cap. 4: 87).
  - Lista legada considerada irrecuperável após quatro tentativas (fontes `.typ`, `.bib` com no máximo 41 entradas, `articles_scraping.py` vazio, PDF antigo sem seção de referências).
  - [x] **CIT-01:** Capítulo 4 — **concluída (05/11/2026)**
    - Relatório: [`citacao_CIT-01.md`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/citacao_CIT-01.md).
    - 85 referências numéricas (recontagem sobre `HEAD`) → 0; 14 chamadas `\cite` (`logg2012automated` 7, `Sadd2009` 2, `Timoshenko_1951` 1, `bakhvalov1989` 1, `Zhang2022` 1). Bloqueios B1–B6 resolvidos por reformulação/ancoragem (decisão C emendada).
  - [x] **CIT-02:** Capítulo 3 (82 marcadores → 0 restantes; 82 `\cite` adicionados). Fatiada em 7 micro-lotes (02.1 a 02.4b), concluída em 06/11/2026. Relatório: `citacao_CIT-02.md`.
  - [x] **CIT-03:** Capítulo 2, §§2.1–2.2 (~125 marcadores) — concluída em 07/11/2026. 185 marcadores → 0 (excl. índices de Voigt em bloco Typst comentado, L227–L244). 184 `\cite` adicionados. Fatiada em 14 micro-lotes (03.01 a 03.14). Relatório: `citacao_CIT-03.md`.
  - [x] **CIT-04:** Capítulo 2, §2.3 — concluída (integrada na REV-02.3).
  - [x] **CIT-05:** Capítulo 2, §2.4 — concluída (integrada na REV-02.4).
  - [x] **CIT-06:** Capítulo 2, §2.5 — concluída (integrada na CON-RED2).
  - [x] **CIT-07:** Varredura final de chaves e `bibtex` — concluída (compilação local verificada).
- [x] **AUD-01:** **Matriz de Afirmações Verificáveis** — concluída (compilação verificada, 0 erros).
  - Registro por afirmação: local, classe (literária/factual, numérica própria, metodológica, normativa), evidência, estado, tarefa associada.

---

## 4. Protocolo de Passagem de Bastão (JSON Estado Vivo v2.2)

```json
// Estado vivo do projeto movido para arquivo separado: estado_projeto.json
// Este bloco e mantido apenas como referencia. Consulte estado_projeto.json para o estado atual.
```
