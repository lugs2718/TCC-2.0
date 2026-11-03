# Relatório de Diagnóstico e Inventário do TCC (Fase 0 — Revisão Expandida)
**Projeto:** *Análise de um tubo cilíndrico multicamadas por meio da homogeneização assintótica numérica e método dos elementos finitos*  
**Autor:** Luiz Gustavo da Silva Pereira  
**Instituição:** Universidade Federal Fluminense (UFF) — EEIMVR / Departamento de Engenharia Mecânica  
**Data da Auditoria:** 02 de novembro de 2026 (Consolidação da Etapa 1 e Expansão Estruturada do Backlog)  
**Status do Projeto:** Fase 0 concluída; Tarefa CON-01 concluída; Backlog expandido em tarefas granulares.

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

### 1.4 Capítulo 2 (Revisão Bibliográfica) — Execução do Sub-bloco D.1 da Tarefa REV-02.1
- **Fatiamento Estruturado:** Divisão formal do Capítulo 2 em 4 tarefas atômicas sequenciais (`REV-02.1` a `REV-02.4`).
- **Remoção de Prompts Residuais:** Exclusão integral do bloco `Task` visível no corpo do texto (antigas linhas 4–20).
- **Reorganização do Fluxo Lógico:** A subseção *Classificação Geométrica: Paredes Finas vs. Paredes Grossas* foi transferida para a abertura da Seção 2.1, estabelecendo os fundamentos mecânicos do vaso de pressão antes de introduzir as exigências legais e normativas da NR-13 e do ASME Seção VIII.
- **Saneamento de Incertezas Bibliográficas:** Removida a alegação sem comprovação bibliográfica de erro analítico menor que 4%, a tag de rascunho `\#strike[...]` e os comentários/marginpars associados.

---

## 2. Inventário Documental dos Ativos do Projeto

| Arquivo / Diretório | Formato / Tipo | Finalidade no Projeto | Status | Notas de Inspeção |
|---|---|---|---|---|
| `LaTeX/main.tex` | LaTeX | Arquivo principal do documento | **Auditado** | Autor atualizado; compilação modular via `\includeonly` preservada. |
| `LaTeX/capitulos/01_introducao.tex` | LaTeX | Capítulo 1: Introdução | **Concluído** | 100% revisado, alinhado e limpo de rascunhos. |
| `LaTeX/capitulos/02_revisao_bibliografica.tex` | LaTeX | Capítulo 2: Revisão Bibliográfica | **Em Análise** | 76 kB. Múltiplas marcações `[nn]` a converter para chaves BibTeX; notas de autor a resolver. |
| `LaTeX/capitulos/03_1_equilibrio.tex` | LaTeX | Capítulo 3 (Equilíbrio e Navier-Cauchy) | **Pendente** | Equações fundamentais do cilindro axissimétrico. |
| `LaTeX/capitulos/03_2_homogeneizacao.tex` | LaTeX | Capítulo 3 (Homogeneização Assintótica) | **Pendente** | Dedução do problema local. Será unificado sob o Cap. 3. |
| `LaTeX/capitulos/04_mef.tex` | LaTeX | Capítulo 4: Método dos Elementos Finitos | **Pendente** | Implementação FEniCS, formulação fraca com peso do raio $r$ e malha estruturada. |
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

### Plano 1 — Conteúdo, Consistência Técnica e Citações (Plano Ativo)

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
- [ ] **REV-02.2:** **Mecânica dos Compósitos, Notação de Voigt e Simetrias Elásticas (Seção 2.2)**
  - Inserção da definição matemática formal do gradiente vetorial ($\nabla \mathbf{u}$) e tensor simétrico $\boldsymbol{\varepsilon}$ (nota da linha 233).
  - Revisão da lei de Hooke generalizada (21 constantes) até ortotropia curvilínea (5 constantes de Backus).
  - Conversão dos `[nn]` para `@jones2018mechanics`, `@sadd2009elasticity`, `@lai2010continuum` e correção da chave `\cite{beer1989resistencia:}`.
- [ ] **REV-02.3:** **Teorias de Placas/Cascas e Mecanismo do Efeito Zigue-Zague (Seção 2.3)**
  - Fundamentação física das teorias clássicas (CLT, FSDT) e limitações em paredes grossas ($R/t < 10$).
  - Explicação rigorosa dos *kinks* via Lema de Cauchy (continuidade de tração vs. salto de deformação).
  - Justificativa da adoção do MHA frente às teorias layerwise e ZZT.
  - Conversão dos `[nn]` para `@tonatto2020`, `@parton_reducido`, `@RMJones2018`.
- [ ] **REV-02.4:** **Homogeneização, Médias de Backus e Formalismo do MHA (Seção 2.4)**
  - Limites clássicos de Voigt e Reuss, Garfo de Hill e formulação de meios estratificados de Backus.
  - Formalismo analítico da SAF e hierarquia de problemas locais e macroscópicos.
  - Resolução das notas de autor (linhas 584 e 605) para evitar redundâncias com o Capítulo 3.
  - Conversão dos `[nn]` para `@bakhvalov1989`, `@bensoussan1978`, `@leitzke2017`, `@guinovart2015`.

#### Capítulo 3 — Formulação Matemática e Homogeneização
- [ ] **TEC-01:** **Unificação Estrutural e Consistência Algébrica do Capítulo 3**
  - Fusão dos arquivos `03_1_equilibrio.tex` e `03_2_homogeneizacao.tex` sob um único comando `\chapter`, transformando a segunda parte em `\section`.
  - Resolução das notas de autor: explicitação da expansão do operador diferencial pela regra da cadeia e inserção da lei de Hooke local.
  - Conferência analítica das funções de perturbação $\chi^1(y)$, $\chi^2(y)$ e das constantes efetivas de Backus ($\hat{\mathcal{C}}_{11}, \hat{\mathcal{C}}_{12}, \hat{\mathcal{C}}_{22}, \hat{G}$).
- [ ] **CIT-05:** **Auditoria de Citações e Rastreabilidade do Capítulo 3**
  - Conversão das chamadas numéricas nas equações diferenciais em coordenadas cilíndricas para as referências canônicas (Lai, Sadd, Timoshenko, Bakhvalov).

#### Capítulo 4 — Metodologia e Simulação Numérica (MEF / FEniCS)
- [ ] **TEC-02:** **Consistência Físico-Matemática e Dimensional do MEF**
  - Harmonização dimensional estrita para a escala de engenharia **mm-N-MPa** sincronizada com o código `Códigos/main.py`.
  - Revisão da formulação variacional axissimétrica, destacando o papel crítico do peso do raio $r$ no integrando bidimensional.
  - Fundamentação da escolha do elemento finito de Lagrange linear ($P_1$) e do alinhamento geométrico estrito nó-interface.
- [ ] **CIT-06:** **Auditoria de Citações e Implementação Computacional do MEF**
  - Conversão dos `[nn]` para as referências da biblioteca FEniCS (`@fenics2012` / Logg) e artigos de métodos numéricos.

#### Capítulo 5 — Resultados e Discussões
- [ ] **TEC-03:** **Integração dos Novos Resultados Numéricos e Gráficos**
  - Inserção da tabela mestre compilada [`Tabelas/tabela_eficiencia_mha_vs_mef.tex`](file:///g:/Meu%20Drive/UFF/TCC%20-%20Wesley/Escrita%20TCC/Tabelas/tabela_eficiencia_mha_vs_mef.tex).
  - Inclusão e chamada no texto dos novos gráficos (`comparacao_perfis_deslocamento.png`, `bench_tempos_e_reducao.png`, `convergencia_assintotica_erro.png`).
  - Atualização dos valores de deslocamentos e tensões na escala mm e MPa.
- [ ] **CIT-07:** **Rastreabilidade e Comparação Física dos Resultados**
  - Rastreabilidade dos dados de validação de Lamé e confronto com os limites de escoamento das fases metálicas.

#### Capítulo 6 — Conclusão e Trabalhos Futuros
- [ ] **CON-03:** **Redação Estruturada do Capítulo 6**
  - Resposta individualizada aos 5 objetivos específicos estabelecidos na Introdução.
  - Síntese dos resultados quantitativos (alívio de peso de $32{,}7\%$, speedup de até $25{,}1\times$, convergência $\mathcal{O}(\epsilon)$).
  - Formalização explícita de limitações e trabalhos futuros (reconstrução do corretor local $\epsilon \mathbf{u}^1$, plasticidade, efeitos térmicos).

---

### Plano 2 — Normas Institucionais UFF e Apresentação Gráfica

- [ ] **REF-01:** **Saneamento e Padronização da Base `bibliografia.bib`**
  - Conferência da conformidade com a ABNT NBR 6023 (EdUFF 2012).
  - Limpeza de chaves quebradas e padronização dos campos autor, título, local, editora e ano.
- [ ] **NOR-01:** **Padronização Normativa de Quadros vs. Tabelas e Legendas**
  - Adequação das matrizes comparativas para ambiente de Quadro (bordas fechadas) e tabelas numéricas conforme norma do IBGE/EdUFF 2012.
- [ ] **NOR-02:** **Configuração Pré-Textual e Inspeção Visual Final do PDF**
  - Ajuste da ordem dos elementos pré-textuais (Sumário antes das listas conforme Coluna 2 da EdUFF 2012).
  - Verificação final de paginação, quebras de página e compilação do documento completo.

---

## 4. Protocolo de Passagem de Bastão (JSON Estado Vivo v2.2)

```json
{
  "versao_skill": "2.2",
  "versao_estado": "1.5",
  "data_atualizacao": "2026-11-02T19:56:00-03:00",
  "autor_projeto": "Luiz Gustavo da Silva Pereira",
  "orientador": "Aguardando preenchimento formal",
  "sistema_unidades": "N-mm-MPa (Engenharia)",
  "objetivo": "Revisão integral de conteúdo, rigor técnico, citações e redação científica do TCC em LaTeX",
  "fase_atual": "plano_1_em_andamento",
  "tarefa_ativa": "REV-02.1",
  "subetapa_ativa": "D.2_equacoes_e_D.3_citacoes",
  "tarefas_concluidas": [
    "DIA-01", "DIA-02", "DIA-03", "DIA-04", "DIA-05", "CON-01"
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
    "Tarefa REV-01-IA (mitigação de detecção IA na Introdução) registrada no backlog; execução adiada para após REV-02.x."
  ],
  "proximo_passo": "Concluir a tarefa REV-02.1 executando os Sub-blocos D.2 (conversão das equações Typst para LaTeX) e D.3 (conversão das citações [nn] para chaves BibTeX e conversão dos Quadros comentados).",
  "prompt_de_continuidade": "A tarefa ativa é REV-02.1 (Seção 2.1 de 02_revisao_bibliografica.tex). O Sub-bloco D.1 (reorganização lógica e limpeza de rascunhos) já foi aplicado com sucesso no arquivo .tex. Prossiga imediatamente com o Sub-bloco D.2 (converter equações Typst das linhas 13, 21, 25, 31, 35-40, 146, 171 para LaTeX padrão) e Sub-bloco D.3 (mapear citações numéricas [nn] para chaves BibTeX e reativar/formatar os Quadros da NR-13 e ASME)."
}
```
