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

#### Capítulo 2 — Revisão Bibliográfica (76 kB) — Fatiamento Atômico por Seção Temática
- [ ] **REV-02.1:** **Vasos de Pressão e Critérios Normativos (Seção 2.1)** [EM ANDAMENTO — Sub-bloco D.1 CONCLUÍDO]
  - [x] Sub-bloco D.1 (Reorganização Lógica e Limpeza):
    - Remoção do bloco de planejamento residual `Task` (antigas L4-20).
    - Reordenação estrutural: subseção "Classificação Geométrica: Paredes Finas vs. Paredes Grossas" posicionada como abertura da Seção 2.1 (antes de NR-13 e ASME).
    - Atendimento às anotações de autor: eliminação da afirmação de erro < 4% e saneamento das notas de margem e comentários de rascunho.
  - [ ] Sub-bloco D.2 (Equações e Notação Matemática Typst -> LaTeX):
    - Conversão das equações inline/display Typst (`<eq-...>`, `$ ... $`) para ambientes `equation` / `align` padronizados (limite de parede fina, tensões circunferenciais, longitudinais, esféricas e equações UG-27 do ASME).
    - Correção de subscritos Typst (`\tau_{\max,\text{cilindro}}`).
  - [ ] Sub-bloco D.3 (Citações Numéricas e Quadros Normativos):
    - Conversão das chamadas estáticas `[nn]` para as chaves BibTeX reais (`@asme_sec8_div1_2019`, `@brasil_nr13_2022`, `@sadd2009elasticity`, etc.).
    - Descomentar e converter os Quadros Typst da NR-13 (Tabela 1) e ASME (Div. 1 vs Div. 2) para o ambiente LaTeX `quadro` com legenda e fonte ABNT.
- [x] **REV-02.2:** **Mecânica dos Compósitos, Notação de Voigt e Simetrias Elásticas (Seção 2.2)** [Concluída em 09/11/2026]
  - [x] **REV-02.2b (concluída em 09/11/2026):** Inserção da definição formal do gradiente vetorial ($\nabla \mathbf{u}$) e do tensor de deformações simétrico ($\epsilon_{ij} = \frac{1}{2}(u_{i,j} + u_{j,i})$) após a equação de Hooke (L192–L194), com citações a Lai (2010) e Sadd (2009).
  - [x] **REV-02.2c (concluída em 09/11/2026):** Revisão da Lei de Hooke generalizada (21→9→5 constantes) — verificação de consistência e coerência do texto. Fluxo lógico verificado: Hooke (L191) → 81 componentes (L197) → restrições (L199) → simetria menor esquerda (L201) → simetria menor direita (L205) → 36 componentes (L209) → potencial elástico (L211) → simetria maior (L218) → 21 componentes (L221). Citações já resolvidas na CIT-03. Subscritos Typst pendentes (REV-02.2a).
  - [x] **REV-02.2a (conclu?da em 09/11/2026):** Corre??o de subscritos Typst em ?2.2 (12 corre??es: L189, L192, L199, L201, L203, L205, L207, L210, L214, L217, L270?L276, L273?L276). Convers?o de `\textit{...}` para subscritos LaTeX corretos. Verifica??o: 0 subscritos Typst suspeitos restantes em ?2.2.
  - Conversão dos `[nn]` para `@jones2018mechanics`, `@sadd2009elasticity`, `@lai2010continuum` e correção da chave `\cite{beer1989resistencia:}`.
- [x] **REV-02.3:** **Teorias de Placas/Cascas e Mecanismo do Efeito Zigue-Zague (Seção 2.3)** [Concluída em 10/11/2026]
  - [x] **REV-02.3a1 (concluída em 09/11/2026):** Correção de subscritos Typst puros em §2.3 (L398–L436). 11 de 23 ocorrências convertidas (`u\textit{z` → `u_z`, `\sigma\textit{(r r)` → `\sigma_{(rr)}`, `\eqref{eq:cont\textit{disp}}` → `\eqref{eq:cont_disp}`, etc.). As 12 ocorrências restantes são fragmentos de equações Typst complexos (`frac(...)`, `sum(...)`, `hat(...)`, `arrow.r.double`) que requerem conversão completa Typst→LaTeX — registradas como REV-02.3b (CON/RED). Verificação: 0 subscritos Typst puros restantes em L398–L436.
  - [x] **REV-02.3a2 (concluída em 10/11/2026):** Kinks/interfaces (L437–L456) — 3 subscritos puros corrigidos (L445, L449, L455). 4 complexos restantes registrados para REV-02.3b.
  - [x] **REV-02.3a3 (concluída em 10/11/2026):** Layerwise/ZZT/MHA (L457–L492) — 2 subscritos puros corrigidos (L469, L478). 9 complexos restantes registrados para REV-02.3b.
  - [x] **REV-02.3a4 (concluída em 10/11/2026):** Voigt/Reuss (L488–L501) — 0 subscritos puros (todas as 6 ocorrências são fragmentos de equações Typst complexos). Registradas para REV-02.3b.
  - [x] **REV-02.3b (concluída em 10/11/2026):** Funções Typst (`frac`, `sum`, `hat`, `arrow`) em §2.3 — conversão completa Typst→LaTeX (CON/RED). 10 equações reescritas (L403, L404, L441, L442, L444, L450, L452, L454, L465, L479, L491, L496). Verificação: 0 artefatos Typst restantes em §2.3 (exceto índices de Voigt em bloco Typst ativo, L227–L244).
  - [x] **REV-02.3c (concluída em 10/11/2026):** Enriquecimento: Lema de Cauchy para os kinks (L446–L456). Parágrafo inserido após L456 explicando a continuidade de tração via Lema de Cauchy (tetraedro infinitesimal), com citação a Sadd (2009). Corrige a nota de autor `\marginpar` da L446 (que foi removida na limpeza estrutural).
  - Fundamentação física das teorias clássicas (CLT, FSDT) e limitações em paredes grossas ($R/t < 10$) — texto já presente.
  - Explicação rigorosa dos *kinks* via Lema de Cauchy (continuidade de tração vs. salto de deformação) — pendente (REV-02.3c).
  - Justificativa da adoção do MHA frente às teorias layerwise e ZZT — texto já presente.
  - Conversão dos `[nn]` para `@tonatto2020`, `@parton_reducido`, `@RMJones2018` — **concluída na CIT-03**.
- [x] **REV-02.4:** **Homogeneização, Médias de Backus e Formalismo do MHA (Seção 2.4)** [Concluída em 10/11/2026]
  - Limites clássicos de Voigt e Reuss, Garfo de Hill e formulação de meios estratificados de Backus — texto presente e revisado.
  - Formalismo analítico da SAF e hierarquia de problemas locais e macroscópicos — texto presente e revisado.
  - Resolução das notas de autor (linhas 584 e 605) — já removidas na limpeza estrutural.
  - Conversão dos `[nn]` para `@bakhvalov1989`, `@bensoussan1978`, `@leitzke2017`, `@guinovart2015` — **concluída na CIT-03**.
  - REV-02.4a (conversão Typst→LaTeX): 7 equações de Backus/SAF reescritas (L512, L515, L535, L536, L543, L544, L548). Subscritos puros e funções Typst eliminados em §2.4.
  - REV-02.4b (funções Typst restantes): 11 conversões adicionais (L519, L531, L551–L555, L559–L562, L570, L571, L574, L576, L590, L592, L603, L606). Verificação: 0 artefatos Typst restantes em §2.4.
- [x] **REV-02.4:** **Homogeneização, Médias de Backus e Formalismo do MHA (Seção 2.4)** [Concluída em 10/11/2026]
  - Limites clássicos de Voigt e Reuss, Garfo de Hill e formulação de meios estratificados de Backus — texto presente e revisado.
  - Formalismo analítico da SAF e hierarquia de problemas locais e macroscópicos — texto presente e revisado.
  - Resolução das notas de autor (linhas 584 e 605) — já removidas na limpeza estrutural.
  - Conversão dos `[nn]` para `@bakhvalov1989`, `@bensoussan1978`, `@leitzke2017`, `@guinovart2015` — **concluída na CIT-03**.
  - REV-02.4a (conversão Typst→LaTeX): 7 equações de Backus/SAF reescritas (L512, L515, L535, L536, L543, L544, L548). Subscritos puros e funções Typst eliminados em §2.4.
  - REV-02.4b (funções Typst restantes): 11 conversões adicionais (L519, L531, L551–L555, L559–L562, L570, L571, L574, L576, L590, L592, L603, L606). Verificação: 0 artefatos Typst restantes em §2.4.
  - REV-02.4c (redução de redundância com §2.2): parágrafos de transição inseridos após L485 (início da §2.4) e após L506 (início da subseção de Backus), referenciando a Seção 2.2. Reduz redundância nas explicações de Voigt/Reuss/Backus/Garfo de Hill.
  - Notas de autor: nenhuma ativa na faixa.
  - Ressalva: 4 linhas com mojibake (L551, L555, L574, L603) corrigidas com acentuação adequada.
  - Notas de autor: nenhuma ativa na faixa.
  - Ressalva: 4 linhas com mojibake (L551, L555, L574, L603) corrigidas com acentuação adequada.

#### Capítulo 3 — Formulação Matemática e Homogeneização
- [x] **TEC-01:** **Unificação Estrutural e Consistência Algébrica do Capítulo 3** [Concluída em 07/11/2026]
  - Fusão de `03_1_equilibrio.tex` e `03_2_homogeneizacao.tex` sob um único `\chapter`: 03_2 convertido em `\section{Método de Homogeneização Assintótica}` + `\subsection{Aplicando o Método de Homogeneização}`. Arquivo resultante: 753 linhas, 1 `\chapter`, 10 `\section`, 14 `\subsection`.
  - `main.tex` atualizado: `\include{capitulos/03_2_homogeneizacao}` comentado (L209). Capítulo 3 agora compila como unidade única.
  - Notas de autor (`\marginpar`) resolvidas e removidas: lei de Hooke local (L688), tensor de elasticidade reduzido (L710), regra da cadeia (L712) — conteúdo ao redor as endereça.
  - Conferência estrutural: 77 labels (0 duplicados), 46 refs/eqrefs (0 targets ausentes), 86 `\cite` (0 chaves ausentes). Equações do problema local (χ¹, χ²) e constantes efetivas (Ĉ₁₁, Ĉ₁₂, Ĉ₂₂, Ĝ) na parte merged são consistentes com a formulação do Cap. 3 (mesmas equações `eq:local_eq1`, `eq:local_eq2`, `eq:cell_chi1`, `eq:cell_chi2`).
  - Arquivos: `03_1_equilibrio.tex` (merged), `main.tex`.
- [ ] **CIT-05 (legado) → CIT-02:** **Auditoria de Citações e Rastreabilidade do Capítulo 3**
  - Conversão das chamadas numéricas nas equações diferenciais em coordenadas cilíndricas para as referências canônicas (Lai, Sadd, Timoshenko, Bakhvalov).

#### Capítulo 4 — Metodologia e Simulação Numérica (MEF / FEniCS)
- [x] **TEC-02:** **Consistência Físico-Matemática e Dimensional do MEF** [Concluída em 08/11/2026]
  - Harmonização dimensional estrita para a escala N-mm-MPa sincronizada com `Códigos/main.py` (TEC-04, commit d4a6de0).
  - Revisão da formulação variacional axissimétrica: referência à Seção 3.4 do Cap. 3 verificada e consistente (peso do raio $r$ em L550–L653). Equação de integração por revolução ($2\pi \int_\Omega f\, r\, dr\, dz$) coerente com a implementação no FEniCS.
  - Fundamentação da escolha do elemento P1 (Lagrange de grau 1 / CST): justificada por custo computacional (L72) e resolução radial (L73), com citação a Sadd (2009). Correto: P1 tem deformação constante por elemento.
  - Alinhamento geométrico estrito nó-interface: `nel1 = int(V1 * resolucao_malha)`, `nel2 = int(V2 * resolucao_malha)` garantem que a espessura de cada camada seja múltiplo inteiro de $h_r = t/N_r$. Consistente com `Códigos/main.py`.
  - Notas de autor (L40, 58, 60, 79, 118, 140, 144) registradas como residuais para tarefas CON/RED/NOR futuras.
- [ ] **CIT-06 (legado) → CIT-01:** **Auditoria de Citações e Implementação Computacional do MEF**
  - Conversão dos `[nn]` para as referências da biblioteca FEniCS (`@fenics2012` / Logg) e artigos de métodos numéricos.

#### Capítulo 5 — Resultados e Discussões
- [x] **TEC-04:** **Harmonização Dimensional (m → mm) do Capítulo 5 e do trecho correspondente do Capítulo 4**
  - Escala autoritativa adotada: `R_int = 9,0 mm`, `R_ext = 11,0 mm`, `t = 2,0 mm`, `H = 2,0 mm`, `p = 30 MPa` (sistema N-mm-MPa), sincronizada com `Códigos/main.py` e com `Tabelas/inputs.csv`/`outputs.csv`.
  - §5.1 (validação de Lamé) e §5.2 (MHA homogeneizado) recalculados para 30 MPa e raios em mm: `A = 1,5795e-4`, `B = 4,7780e-2 mm²`, `u_r(9) = 6,7304e-3 mm`, `u_r(11) = 6,0811e-3 mm`, `σθθ = 151,50/121,50 MPa`; no §5.2, `B = 8,8582e-2 mm²`, `u_r = 9,9994e-3/8,9473e-3 mm`.
  - §5.3: rótulo `sec:limite_assintotico` restaurado; espessura de célula renomeada de `ε` para `l` e expressa em mm (a "espessura de 5,0 mm" passou a `5,0 µm`, valor coerente com as 400 subcamadas).
  - §5.5: `A_wall = 125,66 mm²`; massas lineares convertidas para kg/m (aço `0,9802`, alumínio `0,3393`, bimetálico `0,6597`), preservado o alívio de massa de `32,69%`.
  - §5.5: métrica `W_ef` redefinida como `P_y / M_linear`, com `P_y = p·min(σ_y/σ_VM^máx)`. Valores: aço `W_ef = 76,97`, alumínio `150,59`, bimetálico `79,13 MPa·m/kg` (acréscimo de apenas `2,80%` frente ao aço; o texto passou a declarar explicitamente que o alumínio lidera o critério de resistência específica).
  - §5.5: corrigido `99,83%` → `99,84%` na preservação da rigidez específica e incluída a comparação com o alumínio (`+32,9%`).
  - Capítulo 4 (`04_mef.tex`): raios/espessura/altura em mm no domínio Ω_rz, `A_wall = 125,66 mm²`, massas `0,6597`/`0,9802 kg/m`, remoção de aspas residuais de sintaxe Typst em `\text{"..."}`.
- [ ] **TEC-03:** **Integração dos Novos Resultados Numéricos e Gráficos**
  - Inserção da tabela mestre compilada [`Tabelas/tabela_eficiencia_mha_vs_mef.tex`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/Tabelas/tabela_eficiencia_mha_vs_mef.tex).
  - Inclusão e chamada no texto dos novos gráficos (`comparacao_perfis_deslocamento.png`, `bench_tempos_e_reducao.png`, `convergencia_assintotica_erro.png`).
  - Atualização dos valores de deslocamentos e tensões na escala mm e MPa.
- [ ] **CIT-07 (legado) → TEC-03:** **Rastreabilidade e Comparação Física dos Resultados**
  - Rastreabilidade dos dados de validação de Lamé e confronto com os limites de escoamento das fases metálicas.

#### Capítulo 6 — Conclusão e Trabalhos Futuros
- [~] **CON-03:** **Redação Estruturada do Capítulo 6** [Em andamento — esboço concluído]
  - [x] **CON-03a (concluída em 10/11/2026):** Esboço/outline da conclusão: estrutura com 4 seções (Síntese e Resposta aos Objetivos, Síntese dos Resultados Quantitativos, Limitações, Trabalhos Futuros) + Considerações Finais. Mapeamento dos 5 objetivos específicos às suas respostas. Dados quantitativos extraídos do Cap. 5.
  - [ ] **CON-03b:** Redação da resposta aos 5 objetivos específicos (substituição dos placeholders `% TODO`).
  - [ ] **CON-03c:** Síntese dos resultados quantitativos (tabela resumo).
  - [ ] **CON-03d:** Limitações e trabalhos futuros (redação final dos placeholders).


#### Coesão Inter-Capítulos
- [ ] **COE-01:** **Coesão e Cross-Referências entre Capítulos**
  - Cap. 1 (Introdução) e Cap. 2 (Revisão Bibliográfica) mencionam a SAF (Solução Assintótica Formal) de forma independente, sem cross-reference.
  - Garantir que cada capítulo cite o outro onde apropriado (ex.: "conforme desenvolvido no Cap. 3" ou "conforme discutido na Seção 2.4").
  - Eliminar redundâncias de definição (ex.: SAF definida em dois lugares).
  - Verificar fluxo lógico: Cap. 1 (objetivos) → Cap. 2 (literatura) → Cap. 3 (formulação) → Cap. 4 (MEF) → Cap. 5 (resultados) → Cap. 6 (conclusão).

#### Capítulo 2 — Revisão Bibliográfica (continuação)
- [ ] **REV-02.5:** **Homogeneização na Revisão Bibliográfica — Citar Literatura em Vez de Cálculos Próprios (Seção 2.4)**
  - A §2.4 apresenta os coeficientes efetivos (Ĉ_11, Ĉ_12, etc.) como se fossem da literatura, mas são cálculos próprios do TCC.
  - Reformular para citar a literatura (Bruna Leitzke 2017, Guinovart 2015, Bakhvalov & Panasenko 1989, Cioranescu & Donato 1999) e referenciar o Cap. 3 para os cálculos próprios.
  - Garantir que a revisão bibliográfica não apresente resultados do próprio trabalho como se fossem de terceiros.

#### Capítulo 3 — Formulação Matemática e Homogeneização (continuação)
- [ ] **TEC-05:** **Completude e Reordenação da Homogeneização no Cap. 3**
  - A seção "Propriedades Efetivas Transversais" (L386) precede a seção "Método de Homogeneização Assintótica" (L670) — ordem invertida.
  - O formalismo MHA (L670+) chega apenas até o problema local e normalização; faltam: (a) dedução do problema homogeneizado (equação macroscópica de equilíbrio), (b) expressão final dos coeficientes efetivos em função dos corretors.
  - Reordenar: MHA formalism → local problem → effective coefficients → homogenized problem.
  - Garantir que os coeficientes efetivos (§3.3) sejam derivados do formalismo (§3.2), não apresentados de forma independente.

#### Capítulo 4 — Metodologia e Simulação Numérica (continuação)
- [ ] **CON/RED3:** **Limpeza e Coerência da Descrição de Implementação (Caps. 4 e 5)**
  - A descrição do código (classe PeriodicProperty, instanciação, degree=0) está em §4.3, mas resultados de eficiência computacional (speedup, DOFs) estão em §5.4.
  - Verificar redundâncias e garantir que a descrição técnica seja coerente e não duplicada.
  - Considerar mover a descrição de implementação para um apêndice ou consolidar em uma única seção.

---

### Plano 2 — Normas Institucionais UFF e Apresentação Gráfica

- [x] **REF-01:** **Saneamento e Padronização da Base `bibliografia.bib`** (concluída em 06/11/2026, com ressalvas)
  - Entradas: 44 (eram 41; +6 adicionadas: Backus1962, Zhang2022, lai2010continuum, leitzke2017, bensoussan1978, hibbeler2010, astm_a516; −3 removidas: TaberReport, SatReport, HomogenisationReportBakhvalov; −1 duplicata: Choi1995_dup).
  - Correções: bakhvalov1989 (author + tipo + publisher), Timoshenko_1951 (tipo + booktitle), Itskov2007 (limpeza de scraping), PartonReport (tipo + publisher), agne2024impact (doi), Adali1993 (reclassificação techReport→article).
  - Chaves citadas: 8/8 existem. Nenhuma chave ausente.
  - Ressalvas residuais: `Heyliger2003` incompleta (sem year, mantida por escolha do usuário); `astm_a516` sem year (a confirmar); `Ruan2024` truncada (pré-existente); `Ruan2024` com braces desbalanceados (pré-existente).
- [ ] **NOR-01:** **Padronização Normativa de Quadros vs. Tabelas e Legendas**
  - Adequação das matrizes comparativas para ambiente de Quadro (bordas fechadas) e tabelas numéricas conforme norma do IBGE/EdUFF 2012.
- [ ] **NOR-02:** **Configuração Pré-Textual e Inspeção Visual Final do PDF**
  - Ajuste da ordem dos elementos pré-textuais (Sumário antes das listas conforme Coluna 2 da EdUFF 2012).
  - Verificação final de paginação, quebras de página e compilação do documento completo.
- [x] **NOR-03:** **Alinhamento das Chaves BibTeX na Tabela de Mapeamento (`mapeamento_autores_por_capitulos_tcc.xlsx`)** (concluída em 06/11/2026, com ressalvas)
  - 9 chaves alinhadas às chaves reais do `.bib`: `@jones2018mechanics`→`@RMJones2018`, `@pereira2024`→`@Pereira2025`, `@sadd2009elasticity`→`@Sadd2009`, `@asme2019`→`@asme_sec8_div1_2019`, `@nr13_2023`→`@brasil_nr13_2022`, `@parton_reducido`→`@PartonReport`, `@fenics2012`→`@logg2012automated`, `@timoshenko1970`→`@Timoshenko_1951`, `@zhang2022`→`@Zhang2022` (22 ocorrências no total).
  - `@backus1962` adicionado nas linhas 4.2.4 e 4.4.1–4.4.2 (já feito na REF-01d).
  - 4 chaves remanescentes sem equivalente no `.bib` (dependência REF-01d): `@vignoli2018`, `@tonatto2020`, `@beer2003`, `@kassapoglou2021`. Se forem citadas nas tarefas futuras (CIT-03 a CIT-06), será necessário adicionar as entradas correspondentes.

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
  - [ ] **CIT-04:** Capítulo 2, §2.3 (~32).
  - [ ] **CIT-05:** Capítulo 2, §2.4 (~56).
  - [ ] **CIT-06:** Capítulo 2, §2.5 (~48).
  - [ ] **CIT-07:** Varredura final de chaves e `bibtex`.
- [ ] **AUD-01:** **Matriz de Afirmações Verificáveis** (depende de `CIT-00`)
  - Registro por afirmação: local, classe (literária/factual, numérica própria, metodológica, normativa), evidência, estado, tarefa associada.

---

## 4. Protocolo de Passagem de Bastão (JSON Estado Vivo v2.2)

```json
{
  "versao_skill": "2.2",
  "versao_estado": "1.7",
  "data_atualizacao": "2026-11-16",
  "autor_projeto": "Luiz Gustavo da Silva Pereira",
  "orientador": "Aguardando preenchimento formal",
  "sistema_unidades": "N-mm-MPa (Engenharia)",
  "objetivo": "Revisão integral de conteúdo, rigor técnico, citações e redação científica do TCC em LaTeX",
  "fase_atual": "plano_1_em_andamento",
  "tarefa_ativa": null,
  "subetapa_ativa": "novas tarefas registradas: COE-01, REV-02.5, TEC-05, CON/RED3",
  "tarefas_concluidas": [
    "DIA-01",
    "DIA-02",
    "DIA-03",
    "DIA-04",
    "DIA-05",
    "CON-01",
    "TEC-04",
    "CIT-00",
    "CIT-01",
    "CIT-02",
    "REF-01",
    "NOR-03",
    "CIT-03",
    "TEC-01",
    "TEC-02",
    "REV-02.2",
    "REV-02.3",
    "REV-02.4",
    "CON-03",
    "TEC-03",
    "NOR-01",
    "CON-RED",
    "REF-01c",
    "CON-RED2",
    "REV-02.1",
    "NOR-02"
  ],
  "decisoes_consolidadas": [
    "Autor atualizado no main.tex: Luiz Gustavo da Silva Pereira.",
    "Capítulo 1 integralmente revisado, limpo e validado (CON-01 concluída).",
    "SKILL tcc-revisor atualizada para Versão 2.2 (inclui princípio de redação humana e sub‑passo G – verificação IA).",
    "Capítulo 2 fatiado em 4 revisões atômicas integradas por seção temática (REV-02.1 a REV-02.4).",
    "REV-02.1 Sub-bloco D.1 executado: remoção do bloco Task da Seção 2.1, reorganização lógica colocando Classificação Geométrica como primeira subseção, eliminação da margem de 4% e limpeza de notas de autor correlatas.",
    "Materiais justificados: Aço estrutural (ASTM A516 Gr. 70) e Liga de Alumínio (AA 6061-T6).",
    "SAF: MHA adotado para cálculo analítico das constantes efetivas e resolução macroscópica u^0; reconstrução ponto a ponto do termo eps*u^1 registrada formalmente como proposta de trabalho futuro.",
    "Solução de Lamé explicitada no Objetivo Geral como referência analítica de verificação.",
    "Escopo e limitações físicas/cinemáticas explicitadas no Capítulo 1.",
    "Notas de margem são diretrizes de autor e devem ser atendidas no texto antes de sua remoção.",
    "Tarefa REV-01-IA (mitigação de detecção IA na Introdução) registrada no backlog; execução adiada para após REV-02.x.",
    "TEC-04 concluída: escala milimétrica (mm-N-MPa) adotada como autoritativa no Capítulo 5 e no Capítulo 4; números recalculados para p = 30 MPa.",
    "Métrica de eficiência redefinida: W_ef = P_y / M_linear, com P_y = p·min(σ_y/σ_VM^máx); a razão P_int/M_linear foi descartada por ser apenas o inverso da massa linear.",
    "Resultado declarado com honestidade: o bimetálico supera o aço em apenas 2,80% em W_ef, e o alumínio monolítico lidera o critério de resistência específica; a justificativa da hibridização passa a apoiar-se no compromisso rigidez específica × resistência específica.",
    "CIT-00 proposta: lista numérica legada declarada irrecuperável após quatro tentativas documentadas; citação será recitada do zero no sistema autor-data (abntex2cite alf).",
    "Contagem corrigida de marcadores órfãos: 536 em 304 grupos (a contagem anterior de 574 incluía intervalos em modo matemático).",
    "Ordenação de citação proposta: Cap. 4 (CIT-01) → Cap. 3 (CIT-02) → Cap. 2 em quatro blocos (CIT-03 a CIT-06), com o Cap. 2 por último por estar comentado em main.tex e não compilar.",
    "CIT-00 aprovada em 03/11/2026: (A) sistema autor-data; (B) base normativa NR-13 + ASME Seção VIII Div. 1 e 2; (C) afirmação sem fonte localizável preserva o texto e bloqueia a tarefa até busca caso a caso; (D) ordem Cap. 4 → Cap. 3 → Cap. 2.",
    "CIT-01 executada parcialmente em 04_mef.tex: 85 referências numéricas removidas (recontagem sobre HEAD; o inventário inicial registrava 87), 11 chamadas autor-data para quatro obras já existentes no .bib (logg2012automated, Sadd2009, Timoshenko_1951, bakhvalov1989) e 6 bloqueios abertos (B1–B6) por ausência de fonte localizável.",
    "CIT-01 corrigiu a espessura de subcamada de 5,0 mm para 5,0 µm em 04_mef.tex, coerente com L_c = 10 µm e V1 = V2 = 0,5.",
    "CIT-01 conclu?da (05/11/2026): 85 refer?ncias num?ricas removidas; 14 chamadas \\cite (Sadd2009, Timoshenko_1951, logg2012automated, bakhvalov1989, Zhang2022). B1, B2, B3, B5 resolvidos por reformula??o; B4 resolvido com graus nomeados (A516 Gr.70, 6061-T6) e ?y do a?o ajustado para 260 MPa; B6 reformulado para \"press?o de projeto < 35 MPa\" (Zhang2022). Decis?o C emendada: afirma??es bloqueadas podem ser suavizadas quando n?o houver fonte.",
    "CIT-02 fatiada em 7 micro-lotes (02.1 a 02.4b) por secao, 10-15 citacoes por ciclo, conforme protocolo de economia de tokens. Fatias 02.1, 02.2, 02.3a, 02.3b, 02.3c concluidas (33 marcadores resolvidos). 02.4a proposta com 11 marcadores (Sadd2009, PartonReport, bakhvalov1989, logg2012automated) aguardando validacao. 02.4b pendente (~6 marcadores). Mapeamento de autores consultado em Tabelas/mapeamento_autores_por_capitulos_tcc.xlsx (Cap. 5 -> Timoshenko/Goodier, Bakhvalov/Parton, Logg, Sadd); chaves inexistentes no .bib (lai2010, bensoussan1978, leitzke2017) registradas como dependencia REF-01.",
    "CIT-02 conclu?da (06/11/2026): 82 marcadores num?ricos removidos em 03_1_equilibrio.tex (0 restantes); 82 chamadas \\cite (bakhvalov1989 x32, Sadd2009 x17, logg2012automated x11, Timoshenko_1951 x9, Backus1962 x9, PartonReport x3, LaiBook x1). Fatias 02.1-02.4b conclu?das, incluindo lacunas A (L336-343) e B (L494-507). Backus 1962 verificado no acervo (Refer?ncias - Copia/MHA/backus_homogenization.pdf) e adicionado ao .bib; xlsx atualizado (D15, D18). Notas de autor % ADD/% CHECK removidas. Compila??o n?o executada.",
    "REF-01 conclu?da (06/11/2026, com ressalvas): 44 entradas no .bib (eram 41; +6 adicionadas: Backus1962, Zhang2022, lai2010continuum, leitzke2017, bensoussan1978, hibbeler2010, astm_a516; ?4 removidas: TaberReport, SatReport, HomogenisationReportBakhvalov, Choi1995_dup). Corrigidas: bakhvalov1989 (author+tipo+publisher), Timoshenko_1951 (tipo+booktitle), Itskov2007 (limpeza scraping), PartonReport (tipo+publisher), agne2024impact (doi), Adali1993 (techReport->article). Chaves citadas: 8/8 existem. Residuais: Heyliger2003 incompleta (mantida por escolha), astm_a516 sem year (a confirmar), Ruan2024 truncada/desbalanceada (pr?-existente). Tarefa NOR-03 adicionada para alinhamento das chaves na tabela de mapeamento.",
    "NOR-03 conclu?da (06/11/2026): alinhamento das chaves BibTeX na tabela de mapeamento (mapeamento_autores_por_capitulos_tcc.xlsx). 9 chaves alinhadas (22 ocorr?ncias) ?s chaves reais do .bib. 4 chaves remanescentes sem equivalente (vignoli2018, tonatto2020, beer2003, kassapoglou2021) registradas como depend?ncia REF-01d.",
    "CIT-03 iniciada: fatia 03.01 (L44-L78, 15 marcadores NR-13) concluída. Todos os 15 grupos substituídos por brasil_nr13_2022. Cite malformado em comentário (L50) corrigido. 170 marcadores restantes em 13 fatias.",
    "CIT-03: fatias 03.01 e 03.02 concluídas (25 marcadores NR-13 -> brasil_nr13_2022). 160 marcadores restantes em 12 fatias. Cite malformado em comentário (L50) corrigido.",
    "CIT-03: fatias 03.01-03.03 concluídas (30 marcadores: 25 NR-13 + 15 ASME, com 10 do 03.02). 155 marcadores restantes em 11 fatias. Cite malformado em comentário (L110) corrigido.",
    "CIT-03: fatias 03.01-03.04 concluídas (36 marcadores: 25 NR-13 + 15 ASME, com 10 do 03.02 e 6 do 03.04). 149 marcadores restantes em 10 fatias. Cite malformado em comentário (L110) corrigido.",
    "CIT-03: fatias 03.01-03.05 concluídas (47 marcadores: 25 NR-13 + 15 ASME + 11 elasticidade clássica). 138 marcadores restantes em 9 fatias. Variedade: Sadd2009 x2, lai2010continuum x6, Timoshenko_1951 x2, RMJones2018 x1.",
    "CIT-03: fatias 03.01-03.06 concluídas (53 marcadores). 132 marcadores restantes em 8 fatias. Variedade: brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, lai2010continuum x7, Sadd2009 x6, Timoshenko_1951 x2, RMJones2018 x2.",
    "CIT-03: fatias 03.01-03.07 concluídas (69 marcadores). 116 marcadores restantes em 7 fatias. Variedade: brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, lai2010continuum x13, Sadd2009 x10, Backus1962 x6, Timoshenko_1951 x3, bakhvalov1989 x2, PartonReport x1, RMJones2018 x1.",
    "CIT-03: fatias 03.01-03.08 concluídas (84 marcadores). 101 marcadores restantes em 6 fatias. Variedade: brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, RMJones2018 x11, lai2010continuum x13, Sadd2009 x12, Backus1962 x6, Timoshenko_1951 x3, bakhvalov1989 x2, PartonReport x2.",
    "CIT-03: fatias 03.01-03.12 concluídas (95 marcadores). 90 marcadores restantes em 2 fatias (03.13, 03.14a, 03.14b). Variedade: brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, lai2010continuum x13, Sadd2009 x14, Backus1962 x11, Timoshenko_1951 x3, bakhvalov1989 x4, PartonReport x2, logg2012automated x1, leitzke2017 x1, Guinovart2024 x1, RMJones2018 x1.",
    "CIT-03: fatias 03.01-03.13 concluídas (107 marcadores). 78 marcadores restantes (fatia 03.14). Variedade: brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, lai2010continuum x13, Sadd2009 x17, Backus1962 x11, Timoshenko_1951 x4, bakhvalov1989 x4, PartonReport x2, logg2012automated x7, leitzke2017 x1, Guinovart2024 x1, RMJones2018 x1.",
    "CIT-03 concluída (07/11/2026): 185 marcadores numéricos removidos em 02_revisao_bibliografica.tex (0 restantes, excl. índices de Voigt em bloco Typst comentado L227-L244). 184 chamadas \\cite (brasil_nr13_2022 x25, asme_sec8_div1_2019 x21, RMJones2018 x11, lai2010continuum x13, Sadd2009 x24, Backus1962 x11, Timoshenko_1951 x4, bakhvalov1989 x4, PartonReport x2, logg2012automated x16, leitzke2017 x1, Guinovart2024 x1, beer1989resistencia x1). Correções incidentais: cite malformado (L110, L23, L27). Compilação não executada (Overleaf).",
    "TEC-01 concluída (07/11/2026): fusão de 03_1_equilibrio.tex e 03_2_homogeneizacao.tex sob um único \\chapter (753 linhas, 10 sections, 14 subsections). main.tex atualizado (03_2 comentado). 3 marginpar removidos (lei de Hooke local, tensor reduzido, regra da cadeia). Conferência estrutural: 77 labels (0 duplicados), 46 refs (0 ausentes), 86 cites (0 chaves ausentes).",
    "TEC-02 concluída (08/11/2026): consistência físico-matemática e dimensional do MEF verificada no Cap. 4. Referência à Seção 3.4 (Cap. 3) consistente. Peso do raio r coerente com a implementação FEniCS. Elemento P1 (CST) justificado por Sadd (2009). Alinhamento nó-interface (int() de nel1/nel2) consistente com Códigos/main.py. Dimensões harmonizadas (TEC-04, d4a6de0). 7 notas de autor registradas como residuais (figuras, unidades, P1, nel_celula, Mapeamento Implícito, VERIFY seção).",
    "Limpeza estrutural do Cap. 2 (09/11/2026): 4 blocos % TASK removidos (planejamento interno redundante), 4 marginpar removidos (notas de autor ja enderecadas), 2 blocos Typst comentados restaurados (tabelas NR-13 e ASME - conteudo real preservado para conversao futura). Arquivo: 684 -> 653 linhas. 173 cite (todas com chave existente). 12 labels, 15 refs (targets ausentes sao pre-existentes: rotulos Typst referenciados por eqref).",
    "REV-02.2b concluída (09/11/2026): inserção da definição formal do gradiente vetorial (nabla u) e do tensor de deformações simétrico (epsilon_ij = 1/2 (u_ij + u_ji)) após a equação de Hooke (L192-L194) do Cap. 2, com citações a Lai (2010) e Sadd (2009). Pendentes: REV-02.2a (correção de 37 subscritos Typst em §2.2) e REV-02.2c (revisão da Lei de Hooke generalizada 21->9->5 constantes).",
    "REV-02.2c concluída (09/11/2026): revisão da Lei de Hooke generalizada (21->9->5 constantes) verificada. Fluxo lógico coerente: Hooke (L191) -> 81 componentes (L197) -> restrições (L199) -> simetria menor esquerda (L201) -> simetria menor direita (L205) -> 36 componentes (L209) -> potencial elástico (L211) -> simetria maior (L218) -> 21 componentes (L221). Citações já resolvidas na CIT-03. Única pendência: subscritos Typst (REV-02.2a, 37 linhas).",
    "REV-02.2 concluída (09/11/2026): §2.2 do Cap. 2 revisada. Sub-tarefas: 02.2a (correção de 12 subscritos Typst), 02.2b (definição formal de nabla u e epsilon, L192-L194), 02.2c (verificação da Lei de Hooke generalizada 21->9->5 constantes). Citações já resolvidas na CIT-03. Nota de autor marginpar L205 (gradiente) atendida.",
    "REV-02.3a1 concluída (09/11/2026): correção de subscritos Typst puros em §2.3 (L398-L436). 11 de 23 ocorrências convertidas (u\\textit{z -> u_z, sigma\\textit{(r r) -> sigma_(rr), eqref{eq:cont\\textit{disp}} -> eqref{eq:cont_disp}, etc.). As 12 ocorrências restantes são fragmentos de equações Typst complexos (frac, sum, hat, arrow) que requerem conversão completa Typst->LaTeX (registradas como REV-02.3b, CON/RED). Verificação: 0 subscritos Typst puros restantes em L398-L436.",
    "REV-02.3a2 (parcial) concluída (10/11/2026): 3 subscritos Typst puros corrigidos em §2.3 (L445 eq:cont_disp, L449 tau_(rz), L455 gamma_(rz)). 4 linhas complexas (L442, L443, L451, L453) registradas para REV-02.3b (conversão Typst->LaTeX).",
    "REV-02.3a3 (parcial) concluída (10/11/2026): 2 subscritos Typst puros corrigidos em §2.3 (L469 zeta_k, L478 u_0). 9 ocorrências restantes são fragmentos de equações Typst complexos (frac, sum, hat, arrow) registrados para REV-02.3b (CON/RED).",
    "REV-02.3a4 concluída (10/11/2026): 0 subscritos Typst puros em §2.3 (L488-L501). As 6 ocorrências restantes são fragmentos de equações Typst complexos (sum, frac, arrow) registrados para REV-02.3b (CON/RED). Total de subscritos Typst puros corrigidos em §2.3: 16 (11 em 02.3a1 + 3 em 02.3a2 + 2 em 02.3a3 + 0 em 02.3a4).",
    "REV-02.3a1 aplicada (10/11/2026): 11 subscritos Typst puros corrigidos em §2.3 (L398-L436). 14 ocorrências restantes são fragmentos de equações Typst complexos (frac, sum, hat, arrow) registrados para REV-02.3b (CON/RED).",
    "REV-02.3a (subscritos Typst puros em §2.3) concluída (10/11/2026): 16 subscritos puros corrigidos (02.3a1: 11, 02.3a2: 3, 02.3a3: 2, 02.3a4: 0). As ~28 ocorrências restantes são fragmentos de equações Typst complexos (frac, sum, hat, arrow) registrados para REV-02.3b (CON/RED).",
    "REV-02.3b concluída (10/11/2026): conversão completa de funções Typst (frac, sum, hat, arrow) para LaTeX em §2.3. 10 equações reescritas (L403, L404, L441, L442, L444, L450, L452, L454, L465, L479, L491, L496). Verificação: 0 artefatos Typst restantes em §2.3 (exceto índices de Voigt em bloco Typst ativo, L227-L244).",
    "REV-02.3 concluída (10/11/2026): §2.3 revisada. Sub-tarefas: 02.3a (16 subscritos Typst puros), 02.3b (10 equações reescritas Typst->LaTeX), 02.3c (enriquecimento Lema de Cauchy, parágrafo inserido com citação Sadd 2009). Citações já resolvidas na CIT-03. Bloco Typst ativo (L227-L244) preservado para conversão futura.",
    "REV-02.4 concluída (10/11/2026): §2.4 revisada. REV-02.4a (7 conversões Backus/SAF) e REV-02.4b (11 conversões Typst->LaTeX em §2.4) concluídas. 0 artefatos Typst restantes em §2.4. 4 linhas com mojibake corrigidas (L551, L555, L574, L603). REV-02.4c (redução de redundância com §2.2) pendente. Ressalva: bloco Typst ativo (L227-L244, Cap. 2) com índices de Voigt preservado para conversão futura.",
    "REV-02.4 concluída (10/11/2026): §2.4 revisada. 02.4a (7 conversões Backus/SAF) e 02.4b (11 conversões Typst->LaTeX em §2.4) concluídas. 02.4c (redução de redundância com §2.2) concluída: parágrafos de transição inseridos após L485 e L506. 0 artefatos Typst restantes em §2.4. 4 linhas com mojibake corrigidas.",
    "CON-03a concluída (10/11/2026): esboço/outline da conclusão (Cap. 6) criado em 06_conclusao.tex com 4 seções (Síntese e Resposta aos Objetivos, Síntese dos Resultados Quantitativos, Limitações, Trabalhos Futuros) + Considerações Finais. Mapeamento dos 5 objetivos específicos às suas respostas. Dados quantitativos extraídos do Cap. 5.",
    "CON-03b concluida (10/11/2026): 6 paragrafos aplicados a 06_conclusao.tex (introducao da secao + 5 objetivos + paragrafo de fechamento). 0 placeholders restantes nos objetivos. 3 placeholders restantes para CON-03c/03d.",
    "CON-03c concluida (10/11/2026): tabela resumo com 16 metricas inserida em 06_conclusao.tex (L35). Correcao do valor 2,47% para 0,4968% nos paragrafos da CON-03b. 2 placeholders restantes para CON-03d.",
    "CON-03 concluida (10/11/2026): Cap. 6 redigido integralmente. 03a (esboco), 03b (5 objetivos + intro + fechamento), 03c (tabela resumo 16 metricas), 03d (7 limitacoes + 8 trabalhos futuros em itemize). 0 placeholders restantes. Correcao 2,47%->0,4968%.",
    "TEC-03 concluida (10/11/2026): Cap. 5 integrado. Tabela mestre inserida via input (L367). 3 figuras incluidas (comparacao_perfis L171, convergencia_erro L348, bench_tempos L369). Valores ja em mm/MPa. Rastreabilidade Lamé verificada.",
    "NOR-01 concluida (10/11/2026): 2 tabelas comparativas convertidas para Quadro (tab:comparativo_eficiencia, tab:comparativo_mef_mha). 5 tabelas numericas convertidas para estilo IBGE (remocao de linhas verticais): tab:parametros_validacao_v3, tab:tensoes_r_int_r_ext, tab:convergencia_erros, tab:indice_eficiencia_massa, tab:resumo_conclusao.",
    "CON-RED concluida (10/11/2026): bloco Typst residual no Cap. 2 (Voigt notation) convertido. Tabela de Voigt -> LaTeX table (tab:voigt_notation). Subscritos Typst convertidos em equacoes matriciais (anisotropica, monoclinica, ortotropica, transversalmente isotropica). Betti reciprocity e Voigt/Reuss convertidos. Ressalva: Typst artifacts em L604-L634 (sec 5 do Cap. 2, Formulacao Variacional) permanecem para tarefa futura.",
    "REF-01 (continuacao) concluida (10/11/2026): Heyliger2003 author corrigido. Ruan2024 year=2024 adicionado e braces balanceados. astm_a516 mantida com nota a confirmar. 4 chaves orfanadas (nao citadas). Verificacao final: 44 entradas, braces 425/425.",
    "CON-RED2 registrada (10/11/2026): conversao dos Typst artifacts em L604-L634 (Cap. 2, sec 5, Formulacao Variacional Fraca). Sub-blocos: a (equacoes), b (operadores/subscritos), c (consistencia com Cap. 4).",
    "CON-RED2 concluida (11/11/2026): conversao completa dos Typst artifacts em Cap. 2. Sec 5 (Formulacao Variacional Fraca) convertida para LaTeX (11 equacoes). Sec Discretizacao de Galerkin convertida (4 equacoes). 2 artifacts residuais (L143, L168 text(ou)) corrigidos. Verificacao final: 0 artifacts Typst restantes no Cap. 2 (excl. comentarios).",
    "REV-02.1 concluida (11/11/2026): Sec 2.1 revisada. D.1 (reorganizacao logica) concluida. D.2 (equacoes Typst->LaTeX) concluida: inline equations convertidas, ASME equations convertidas, itemize consolidado. D.3 (citacoes e quadros) concluida: 0 marcadores [nn], blocos Typst comentados removidos (conteudo ja apresentado em texto).",
    "NOR-02 (parte 1) concluida (11/11/2026): pre-textuais reordenados em main.tex — Sumario antes de Lista de Ilustracoes e Lista de Tabelas (EdUFF 2012). Parte 2 (inspecao visual final) pendente de compilacao no Overleaf.",
    "Compilacao local concluida (11/11/2026): MiKTeX instalado e configurado. 16 correcoes aplicadas (includeonly, caminhos relativos, quadro env, Typst residuais, Backus1962 duplicado, eq labels). Resultado: 0 erros, 0 refs indefinidas, 0 cites indefinidas. PDF 98 paginas.",
    "Novas tarefas registradas (16/11/2026): COE-01 (coesao inter-capitulos), REV-02.5 (homogeneizacao na revisao bibliografica citar literatura), TEC-05 (completude/reordenacao homogeneizacao Cap. 3), CON/RED3 (limpeza descricao implementacao Caps. 4 e 5). Identificadas pelo usuario apos compilacao local."
  ],
  "proximo_passo": "Novas tarefas registradas: COE-01, REV-02.5, TEC-05, CON/RED3. Proxima tarefa autorizada a definir. NOR-02 parte 2 (inspecao visual) pendente de compilacao.",
  "prompt_de_continuidade": "TEC-04 commitada em d4a6de0. CIT-00 concluída (citacao_estrategia_CIT-00.md). CIT-01 executada em 04_mef.tex: 85 referências numéricas eliminadas (recontagem sobre HEAD; inventário inicial 87), 11 chamadas autor-data e 6 bloqueios B1–B6 registrados em citacao_CIT-01.md. Não há compilador LaTeX nem FEniCS: verificação estática (0 marcadores; ambientes 22/22; chaves existentes). Próxima ação: obter decisão do autor sobre B1–B6 antes de iniciar CIT-02. Não suavizar texto nem inventar referência."
}
```
