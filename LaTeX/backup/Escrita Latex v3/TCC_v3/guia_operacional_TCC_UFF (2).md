# Guia operacional do TCC — UFF
## Síntese rastreável de *Apresentação de trabalhos monográficos de conclusão de curso* (EdUFF, 2012)

**Versão 2 — revisada e validada contra o PDF original em 29/10/2026.**

> **Objetivo:** servir como guia de consulta durante a escrita e a revisão do TCC e como base para a futura automação das regras no projeto LaTeX/Overleaf.
>
> **Fonte normativa adotada:** ABREU, Estela dos Santos; TEIXEIRA, José Carlos Abreu. *Apresentação de trabalhos monográficos de conclusão de curso*. 10. ed. rev. e atual. Niterói: EdUFF, 2012 (arquivo `Regras para o Projeto Final.pdf`, 85 páginas no leitor de PDF).
>
> **Regra de escopo:** o PDF fornecido pela coordenação é a referência principal. Este guia **não** substitui orientações do PDF por versões mais recentes de normas da ABNT. Onde o PDF é omisso ou contraditório, o guia **registra a lacuna** (seção 10) em vez de inventar uma exigência.

---

## 0. Como ler este guia

### 0.1 Três tipos de conteúdo, sempre separados

| Marcador | Significado |
|---|---|
| **Regra do PDF** | Orientação que consta na publicação. Vem sempre com a referência `(§ seção, p. página)`. |
| **Implementação sugerida** | Sugestão de como aplicar ou verificar a regra no LaTeX, por script ou manualmente. **Não faz parte do PDF.** Aparece em blocos de citação iniciados por "Implementação sugerida". |
| **Lacuna / ambiguidade** | Ponto em que o PDF é omisso, contraditório ou depende de decisão da coordenação. Aparece com um código `A-nn` e é detalhado na seção 10. |

Rótulos usados nas implementações sugeridas:

- **[LaTeX]** — configurável no preâmbulo ou em ambientes próprios.
- **[Script]** — verificável por programa que leia `.tex`, `.bib` ou o resultado da compilação.
- **[Manual]** — exige leitura, julgamento ou confirmação humana.

### 0.2 Convenção de páginas

As referências `p. N` usam a **numeração impressa no livro**. Para localizar a página no leitor de PDF, some 1 (por exemplo, a p. 21 impressa é a página 22 do arquivo). As páginas iniciais (capa, créditos, sumário, apresentação) não têm numeração impressa.

### 0.3 Prioridade prática de uso

1. Resolva as decisões pendentes da seção 10 com o orientador/coordenação antes de automatizar.
2. Aplique no LaTeX as regras repetitivas de formatação (seção 3).
3. Use comandos padronizados para citações, notas, figuras e tabelas.
4. Verifique consistência entre citações e referências com script.
5. Percorra os checklists da seção 8 antes de cada entrega.

---

## 1. Visão geral do que o PDF cobre

| Assunto | Seção do livro | Páginas |
|---|---|---|
| Elementos componentes (pré-textuais, textuais, pós-textuais) | 1 | 13–19 |
| Apresentação gráfica (suporte, margens, espaçamento, paginação, numeração progressiva) | 2 | 21–23 |
| Citações (classificação, sistemas de chamada, sinais) | 3 | 25–34 |
| Referenciação bibliográfica (modelos por tipo de documento) | 4 | 35–48 |
| Notas (classificação, apresentação, expressões latinas) | 5 | 49–54 |
| Obras citadas / Obras consultadas (listas do próprio livro, usadas como exemplo) | 6 e 7 | 55–64 |
| Apêndices: esquema gráfico, modelos de capa, lombada, errata, listas | 8 | 65–73 |
| Anexos: modelos de folha de rosto, ficha, aprovação, dedicatória, agradecimento, epígrafe, resumos, glossário | 9 | 75–83 |

**O que o PDF não cobre** (e que, portanto, este guia não pode exigir): legendas, numeração e fonte de figuras e tabelas; formatação de equações; escolha de família tipográfica; DOI; modelos para relatório técnico, manual e programa de computador. Ver seção 10.

---

## 2. Estrutura do trabalho

### 2.1 Regra do PDF: ordem dos elementos

O livro apresenta duas ordenações (Figura 1, p. 13): a **Coluna um** (segundo a NBR 14724:2011) e a **Coluna dois**, que é a **adotada pelo livro** por ser considerada mais apropriada. O próprio texto trata essa escolha como **sugestão** e diz que cabe ao usuário, **com o aval do Departamento de Ensino ou da Coordenação de Curso**, escolher a mais adequada (§ 1, p. 14). A nota 4 (p. 18) acrescenta que algumas coordenações têm procedimentos próprios que devem ser observados. Ver **A-01**.

Ordem da **Coluna dois**:

| Grupo | Elementos, na ordem | Situação |
|---|---|---|
| Pré-textuais | Capa | Obrigatório |
| | Lombada | Opcional |
| | Errata | Opcional |
| | Folha de rosto | Obrigatório |
| | Folha de aprovação | Obrigatório |
| | Dedicatória | Opcional |
| | Agradecimento | Opcional |
| | Epígrafe | Opcional |
| | Resumo na língua vernácula | Obrigatório |
| | Resumo em língua estrangeira | Obrigatório |
| | **Sumário** | Obrigatório |
| | Lista de ilustrações | Opcional |
| | Lista de tabelas | Opcional |
| | Lista de abreviaturas, siglas e símbolos | Opcional |
| Textuais | Texto (introdução, desenvolvimento, conclusão) | — |
| Pós-textuais | Obras citadas | Obrigatório |
| | Obras consultadas | Opcional |
| | Apêndice(s) | Opcional |
| | Anexo(s) | Opcional |
| | Glossário | Opcional |
| | Índice(s) | Opcional |

Diferenças principais em relação à Coluna um: o sumário vem **antes** das listas (na Coluna um vem por último); a errata vem **antes** da folha de rosto; os pós-textuais começam por "Obras citadas" em vez de "Referências"; o glossário vem depois de apêndices e anexos.

### 2.2 Regras do PDF por elemento pré-textual

| Elemento | O que o PDF determina | Referência |
|---|---|---|
| **Capa** | Proteção externa com os elementos mais representativos da folha de rosto. O modelo (p. 67) traz: universidade, centro, curso, autor, título, subtítulo, local e ano. | § 1.1.1, p. 14; § 8.2, p. 67 |
| **Lombada** | Nome do autor e título impressos do alto para o pé da lombada; indicação de volumes, se houver. O livro desaconselha encadernação espiral (cita Cervo e Bervian). | § 1.1.2, p. 14; § 8.3, p. 68 |
| **Errata** | Para erros gráficos ou de outra natureza que não possam ser corrigidos nos exemplares da banca; geralmente em retalho de papel avulso, **imediatamente antes da folha de rosto**. Após a defesa, corrigir os exemplares destinados à coordenação. | § 1.1.3, p. 14; § 8.4, p. 69 |
| **Folha de rosto** | Anverso: autor; título e subtítulo; curso e área de concentração; natureza do trabalho e instituição; orientador (e coorientador); cidade; ano. Verso: ficha catalográfica (a biblioteca da SDC/UFF pode elaborá-la). Em obra com vários volumes, a folha de rosto consta em cada volume com a indicação do número. **Autor, orientador, coorientador e título em CAIXA-ALTA**; os demais elementos em caixa-baixa. | § 1.1.4, pp. 14–15; § 2.2, p. 21; § 9.1–9.2, pp. 75–76 |
| **Folha de aprovação** | Elementos da folha de rosto mais data de aprovação, nome e titulação dos membros da banca e instituições a que pertencem. | § 1.1.5, p. 15; § 9.3, p. 77 |
| **Dedicatória** | Folha opcional de homenagem. | § 1.1.6, p. 15; § 9.4, p. 78 |
| **Agradecimento** | Folha opcional, de modo sucinto, restrita ao absolutamente necessário. | § 1.1.7, pp. 15–16; § 9.5, p. 79 |
| **Epígrafe** | Citação pertinente ao tema, seguida de indicação de autoria; pode também aparecer no início de cada seção/capítulo. O livro **recomenda** incluir a fonte, cuja referência completa vai em Obras citadas. | § 1.1.8, p. 16; § 9.6, p. 80 |
| **Resumo na língua vernácula** | Síntese dos pontos relevantes (gênero do trabalho, finalidade, metodologia, resultados, conclusões), sem opiniões. **Parágrafo único, 3ª pessoa do singular, 150 a 500 palavras, espaço simples.** Seguido das palavras-chave. | § 1.1.9, p. 16; § 9.7, p. 81 |
| **Palavras-chave** (nota 2) | Logo abaixo do resumo, no mesmo alinhamento, sucedidas de dois pontos; **cada palavra-chave, inclusive a última, termina com ponto**. Termos extraídos de vocabulários controlados (disponíveis nas bibliotecas da SDC/UFF). | nota 2, p. 16 |
| **Resumo em língua estrangeira** | Versão do resumo em idioma de grande divulgação (*Abstract*, *Resumen*, *Résumé*), **em folha própria**. | § 1.1.10, p. 16; § 9.8, p. 82 |
| **Sumário** | Títulos das principais seções com páginas, como **reprodução exata dos títulos do corpo do trabalho**; não se confunde com índice. Em obra com vários volumes, o sumário completo consta em cada um. | § 1.1.11, p. 17 |
| **Listas** | Opcionais; relacionam ilustrações, tabelas, abreviaturas etc. **na ordem em que aparecem no texto**, com páginas. Ilustrações, exceto tabelas e quadros, recebem o título genérico de **figuras**. Se muito numerosas, ilustrações e tabelas devem ter listas próprias. | § 1.1.12, p. 17; § 8.5–8.6, pp. 70–71 |
| **Lista de abreviaturas, siglas e símbolos** | Relação **em ordem alfabética**, com os significados; se muito numerosos, listas próprias. | § 1.1.12.2, p. 17; § 8.7–8.8, pp. 72–73 |

> **Implementação sugerida.** [Manual] Conferir a presença e a ordem dos elementos no PDF compilado. [Script] Verificar no `main.tex` quais elementos pré-textuais são emitidos e em que ordem. [LaTeX] Se a Coluna dois for adotada, reordenar sumário e listas no arquivo principal. Nenhuma dessas ações deve ser feita antes da decisão **A-01**.

### 2.3 Regras do PDF para os elementos textuais

- A organização depende da área de conhecimento e da modalidade da monografia; de modo geral compreende **introdução, desenvolvimento e conclusão** (§ 1.2, pp. 17–18).
- O livro não impõe um formato interno único para o desenvolvimento.
- A nota 4 (p. 18) lembra que coordenações e departamentos podem ter procedimentos próprios (ver **A-01**).

### 2.4 Regras do PDF para os elementos pós-textuais

| Elemento | O que o PDF determina | Referência |
|---|---|---|
| **Obras citadas** | Lista das referências dos documentos **citados** no trabalho; organizada segundo o sistema de chamada adotado; no fim do trabalho ou de seções. O livro sugere desdobrar a seção "Referências" da NBR em *Obras citadas* e *Obras consultadas* (ver **A-08**). | § 1.3.1.1, p. 18 |
| **Obras consultadas** | Opcional; lista **alfabética** dos documentos consultados e **não citados**. Se adotada, as obras citadas que estiverem em listas no fim de seções/capítulos devem constar também nela. | § 1.3.1.2, p. 18; § 4.2.6.2, p. 47 |
| **Apêndices e anexos** | Apêndice: elaborado pelo próprio autor para complementar a argumentação sem prejudicar o núcleo do trabalho. Anexo: documento não elaborado pelo autor que fundamenta, comprova ou ilustra. **Apêndices e anexos constituem seções primárias, e cada um deles uma seção secundária.** Embora a NBR use letras maiúsculas como indicativos, o livro **sugere o sistema numérico** quando se usa numeração progressiva (exemplo: `8 APÊNDICES`, `8.1 ...`). | § 1.3.2, p. 19 |
| **Glossário** | Lista alfabética de palavras ou expressões técnicas de uso restrito, dialetais, arcaicas etc. | § 1.3.3, p. 19; § 9.9, p. 83 |
| **Índice** | Lista de palavras ou frases ordenadas por critério (assuntos, nomes, cronologia) com remissão ao texto; não se confunde com sumário. | § 1.3.4, p. 19 |

---

## 3. Apresentação gráfica

### 3.1 Regras do PDF: suporte, margens e recuos

| Item | Regra | Referência |
|---|---|---|
| Papel | Branco ou reciclado, **A4 (21 × 29,7 cm)**. | § 2.1, p. 21 |
| Anverso e verso | Pré-textuais no anverso (exceto a ficha catalográfica, no verso da folha de rosto). **Recomenda-se** que textuais e pós-textuais usem anverso e verso. | § 2.1, p. 21 |
| Margem superior | 3 cm da borda superior. | § 2.2.1 a, p. 21; esquema p. 65 |
| Margem inferior | 2 cm da borda inferior. | § 2.2.1 b, p. 21; esquema p. 65 |
| Margem lateral, anverso | **Esquerda 3 cm.** Direita **2 cm** (indicada só no esquema). | § 2.2.1 c, p. 21; esquema p. 65 |
| Margem lateral, verso | **Esquerda 2 cm.** Direita **3 cm** (indicada só no esquema). | § 2.2.1 c, p. 21; esquema p. 66 |
| Recuo de parágrafo | Texto: tabulação de **1,5 cm** na primeira linha. **O esquema indica 1,25 cm.** Ver **A-03**. | § 2.2.1 d, p. 21; esquemas pp. 65–66 |
| Alíneas | Recuo de **1,5 cm** da margem esquerda do texto (o esquema indica 1,25 cm; ver **A-03**); a partir da segunda linha, alinhadas pela primeira letra do texto da alínea; espaço simples dentro da alínea e **1,5 entre alíneas**. | § 2.2.1 e, p. 22; § 2.2.2, p. 22 |
| Citações longas | Recuo de **4 cm** da margem esquerda do texto, corpo menor (fonte 10, por exemplo), espaço simples, **separadas do texto anterior e do posterior por dois espaços simples**. | § 2.2.1 f, p. 22; esquemas pp. 65–66 |
| Referências | Alinhadas à margem esquerda do texto. | § 2.2.1 g, p. 22 |

### 3.2 Regras do PDF: espaçamento e fonte

- Texto em **espaço 1,5** e **fonte 12** (§ 2.2.2, p. 22).
- **Espaço simples** em: citações longas, notas, referências bibliográficas e resumos (vernácula e estrangeira). As **alíneas** também são em espaço simples; o livro observa que a ABNT esqueceu de listá-las entre as exceções, e que a NBR 6024:2012 (seção 4.2) as trata assim (Obs., p. 22).
- Entre alíneas, incisos e referências bibliográficas em lista: espaço **1,5** (§ 2.2.2, p. 22).
- Notas de rodapé: obedecem às margens do texto e são separadas dele por **filete de 5 cm iniciado na margem esquerda** e por espaço simples (§ 2.2.2, p. 22; § 5.4.1, p. 51).
- Títulos de seção: digitados a partir da margem esquerda, **a um espaço do indicativo numérico**, e separados por espaço **1,5** (§ 2.2.2, p. 22).
- O PDF **não prescreve família tipográfica**. A única menção está no colofão do livro (composto em Times New Roman, corpo 12, p. 84). Ver **A-04**.
- O PDF **não prescreve tamanho** para notas e legendas além de "fonte menor que a do corpo" (§ 5.4.1, p. 51). O valor 10 aparece apenas como exemplo para citações longas. Ver **A-06**.

### 3.3 Regras do PDF: paginação

- Todas as folhas são **contadas**, mas a numeração sequencial em algarismos arábicos aparece **apenas a partir da parte textual** (§ 2.2.3, p. 22).
- Posição: **anverso, canto superior direito; verso, canto superior esquerdo**; a numeração fica a **2 cm da borda superior** e o último algarismo a **2 cm da borda externa** da folha (§ 2.2.3, p. 22; esquemas pp. 65–66).
- Em obra com mais de um volume, **única sequência** de numeração, do primeiro ao último volume, inclusive apêndices e anexos (§ 2.2.3, p. 23).

### 3.4 Regras do PDF: numeração progressiva e títulos

- O livro **sugere** numeração progressiva das seções (NBR 6024:2012) (§ 2.3, p. 23).
- O título é antecedido de um indicativo numérico e separado dele por **um espaço** (§ 2.3.1, p. 23).
- **Títulos sem indicativo numérico** — errata, agradecimentos, lista de ilustrações, lista de abreviaturas e siglas, lista de símbolos, resumos, sumário, referências, glossário, apêndice(s), anexo(s) e índice(s) — devem ser **centralizados** (§ 2.3.2, p. 23, citando a NBR 14724:2011). Dedicatória e epígrafe não constam dessa relação.
- Para destacar títulos, usam-se **gradativamente** CAIXA-ALTA, caixa-baixa, versal, versalete, corpo menor, negrito ou itálico (§ 2.3.3, p. 23). Exemplo do livro:

```
1 SEÇÃO PRIMÁRIA
1.1 SEÇÃO SECUNDÁRIA
1.1.1 Seção terciária
1.1.1.1 Seção quaternária
1.1.1.1.1 Seção quinária
```

### 3.5 Implementação sugerida (não é regra do PDF)

> **Implementação sugerida.**
> - [LaTeX] Centralizar em um único bloco do preâmbulo: papel A4, margens (3/2/3/2 cm no anverso e espelhadas no verso), tamanho 12, espaçamento 1,5, recuo de parágrafo, ambiente próprio de citação longa (recuo de 4 cm, fonte menor, espaço simples, espaçamento de dois espaços simples antes e depois) e ambiente próprio de alíneas.
> - [LaTeX] Configurar a numeração de página para iniciar apenas na parte textual e para alternar canto superior direito (anverso) e esquerdo (verso), a 2 cm da borda superior.
> - [LaTeX] Configurar o filete de 5 cm e o espaço simples nas notas de rodapé.
> - [Manual] Conferir as margens do PDF compilado, sobretudo no verso. O projeto atual usa `twoside`, mas as margens efetivas precisam ser medidas na auditoria (Etapa 3).
> - **Não fixar** recuo de parágrafo nem família tipográfica antes das decisões **A-03** e **A-04**.

---

## 4. Citações

### 4.1 Regra do PDF: o que é citação e onde aparece

Citações são os conceitos, informações, ideias e sugestões colhidos em outras fontes e mencionados no texto (§ 3, p. 25). Podem aparecer no **texto** ou em **notas de rodapé** (§ 3.1, p. 25).

### 4.2 Regra do PDF: classificação adotada pelo livro

O livro **deliberadamente não segue** a classificação da NBR 10520:2002 e adota a classificação das obras clássicas (§ 3.2, p. 25). A terminologia abaixo deve ser preservada. Atenção: **"direta" e "indireta" indicam se a fonte foi consultada diretamente ou por intermédio de outra obra; não indicam se há transcrição literal.** A distinção literal × livre é dada por **formal × conceitual**.

| Categoria | Definição resumida | Referência |
|---|---|---|
| **Formal direta** (literal ou textual) | Transcrição literal de texto de uma obra, **sem intermediação** de outrem. | § 3.2.1.1, p. 25 |
| **Formal indireta** (citação de citação) | Transcrição de texto **já citado por outro autor**, cujo original não foi possível consultar. Exige a expressão *apud* e a referência do original em nota de rodapé. | § 3.2.1.2, p. 26 |
| **Conceitual direta** (livre, em síntese ou paráfrase) | Reprodução **livre** do texto original, que foi consultado. | § 3.2.2.1, p. 26 |
| **Conceitual indireta** (livre, em síntese ou paráfrase) | Reprodução livre de informação de **outro documento que não o original**; há intermediação de outro autor. Só se justifica quando o original é inacessível. | § 3.2.2.2, p. 26 |
| **Mista** | Combinação de formal e conceitual: termos ou expressões do autor original entre aspas, complementados por trechos parafraseados. | § 3.2.3, p. 27 |

O livro define a citação conceitual como a reprodução **fiel** das ideias do autor, com indicação precisa da fonte (§ 3.2.2, p. 26). Em **todas** as categorias a indicação da fonte é obrigatória.

### 4.3 Regra do PDF: citação formal direta, curta e longa

**Até 3 linhas** (§ 3.2.1.1, p. 25; § 3.5.1, p. 31):

- Inserida no próprio parágrafo, **entre aspas duplas**.
- Se o texto citado já tiver algo entre aspas duplas, estas viram **aspas simples**: `“... ‘...’ ...”`.

**Mais de 3 linhas** (citação longa) (§ 3.2.1.1, p. 26; § 2.2.1 f, p. 22; § 3.5.1, p. 31):

| Aspecto | Regra | Referência |
|---|---|---|
| Forma | Parágrafo independente, **sem aspas duplas** externas. | § 3.2.1.1, p. 26 |
| Recuo | **4 cm** da margem esquerda do texto. | § 2.2.1 f, p. 22 |
| Fonte | Corpo menor que o do texto (**fonte 10**, por exemplo). | § 2.2.1 f, p. 22 |
| Espaçamento interno | **Simples.** | § 2.2.1 f, p. 22 |
| Separação do texto | **Dois espaços simples** antes e depois. | § 2.2.1 f, p. 22 |
| Citação dentro de citação longa | Vem entre **aspas duplas** (segundo Araújo, 2011, pp. 93–94, citado no livro). | § 3.5.1, p. 31 |
| Chamada | Autor-data ao final, no formato do sistema adotado, como nos exemplos do livro. | pp. 25, 28 |
| Citação formal direta **em rodapé** | Sempre entre aspas, **qualquer que seja a extensão**. | § 5.4.1.2, p. 54 |

**Citação traduzida** (nota 5, p. 25): seguir a chamada com a menção **(tradução nossa)** entre parênteses. É aconselhável que o texto original conste em nota de rodapé. A nota explicativa de rodapé também serve para transcrever o original ou traduzir o trecho (§ 5.2 d, p. 50).

O PDF **não especifica** recuo à direita, recuo de primeira linha, alinhamento ou forma de contar "3 linhas" para citações longas. Ver **A-05**.

> **Implementação sugerida.** [LaTeX] Criar um ambiente único para citação longa (recuo esquerdo de 4 cm, fonte 10, espaçamento simples, dois espaços simples antes e depois) e usá-lo em todo o trabalho. [Script] Procurar blocos de texto entre aspas muito longos nos `.tex` para sugerir conversão ao ambiente. [Manual] Decidir se uma citação passa de 3 linhas olhando o PDF compilado.

### 4.4 Regra do PDF: citação de citação (*apud*)

- No texto, entre parênteses: autor do documento **original**, ano, a expressão ***apud*** e o autor da obra **efetivamente consultada** (com ano e página). Exemplo do livro: `(LUFT, 1974 apud NAHUZ; FERREIRA, 1989, p. 69)` (§ 3.2.1.2, p. 26).
- A **referência bibliográfica do documento original não consultado** deve figurar em **nota de rodapé** (§ 3.2.1.2, p. 26).
- Só se justifica quando há **impossibilidade de acesso ao original** (Obs., p. 26).
- A mesma estrutura vale para a citação conceitual indireta (exemplo, p. 27) e para a chamada com o autor na frase: `Para Houaiss (1967 apud ARAÚJO, 2011, p. 92)` (§ 3.4.1 d, p. 28).
- Observação verificada: no exemplo do livro, **Luft não aparece em Obras citadas** (conferidas as pp. 55–59); a obra consultada (Nahuz e Ferreira) é a que consta. Ver **A-09**.

### 4.5 Regra do PDF: informação obtida por canais informais

Aulas, palestras, debates, entrevistas e comunicações pessoais: após a menção, escrever **(informação verbal)** entre parênteses e indicar a fonte (quem, quando, onde) em **nota de rodapé** (§ 3.3, p. 27; § 3.5.5 d, p. 34).

### 4.6 Regra do PDF: sistemas de chamada

O trabalho deve adotar **um** sistema, **autor-data** ou **numérico**, mantido ao longo de todo o texto e correspondente às listas de Obras citadas/consultadas e às notas (§ 3.4, pp. 27–28).

**Autor-data** (§ 3.4.1, pp. 28–30):

| Situação | Regra | Página |
|---|---|---|
| Elementos da chamada | Último sobrenome do(s) autor(es), **ou** nome da instituição, **ou** primeira palavra do título (seguida de reticências se a entrada for pelo título), mais ano e página(s). | 28 |
| Autor na frase | `Segundo Almeida (1991, p. 81)`: sobrenome com inicial maiúscula, fora de parênteses. | 28 |
| Autor fora da frase | `(ALMEIDA, 1991, p. 81)`: sobrenome em CAIXA-ALTA, dentro de parênteses; várias obras separadas por **ponto e vírgula**. | 29 |
| Uma página | `p. 69` | 28 |
| Páginas consecutivas | `p. 30-39` ou `p. 50 et seq.` | 28 |
| Páginas não consecutivas | `p. 80; 84; 86` | 28 |
| Síntese de várias partes da obra | `passim` | 28 |
| Síntese da obra **no todo** | **Não** se indicam páginas. | 28 |
| Sobrenomes coincidentes | Acrescentar as **iniciais dos prenomes**; se ainda houver coincidência, prenomes por extenso. Ex.: `(OLIVEIRA, D., 1983)`. | 29 |
| Mesmo autor, mesmo ano | Distinguir com **letras minúsculas** após o ano, sem espaço: `1974a`, `1974b`, conforme a lista de referências. | 29 |
| Páginas em citação direta | A NBR exige indicar página/volume/tomo/seção; para citação indireta é opcional. **Em trabalhos acadêmicos, o livro aconselha indicar páginas em qualquer tipo de citação.** | 30 |

**Numérico** (§ 3.4.2, p. 30): algarismos arábicos em numeração **única e consecutiva** para todo o documento ou por seções; **não recomeça a cada página**; as referências são ordenadas pelos números de chamada. Formas admitidas: número entre parênteses `(2)` ou sobrescrito.

> **Implementação sugerida.** O projeto usa `abntex2cite` com opção `alf`, isto é, **autor-data**. [LaTeX] Manter esse sistema e usar sempre os comandos `\cite`, `\citeonline` (ou equivalentes) para a forma com o autor na frase. [Script] Listar citações cujas chaves não existam no `.bib` e entradas nunca citadas. [Manual] Verificar se cada citação sustenta o que está afirmado. [Script/Manual] Conferir se o comportamento de `et al.` do pacote (opções `abnt-etal-cite` e `abnt-etal-list`) coincide com a regra do PDF (até três autores listados; `et al.` acima disso; ver § 4.1.1.1, p. 36 e nota 14). Ver **A-07**.

### 4.7 Regra do PDF: sinais e convenções

| Sinal | Uso descrito | Referência |
|---|---|---|
| Aspas duplas `“ ”` | Citação formal direta de até 3 linhas. Aspas simples `‘ ’` para o que já estava entre aspas dentro dela. | § 3.5.1, p. 31 |
| Asterisco `*` | Chamada para nota de rodapé **quando há concomitância com outro sistema de chamada**; a numeração com asterisco reinicia a cada página (segundo Araújo, 2011, p. 96). Não é previsto pela NBR 10520. | § 3.5.2, p. 31 |
| Colchetes `[ ]` | Acréscimos, interpolações ou explicações do autor do trabalho dentro do texto citado. | § 3.5.3, p. 32 |
| `[...]` | **Supressão** de palavras ou frases do original. | § 3.5.3, p. 32 |
| `[sic]` | Erro existente no texto citado; vem **imediatamente após** o elemento errado. | § 3.5.3, p. 32 |
| `[?]` | Algo que suscita **dúvida** no texto citado. | § 3.5.3, p. 33 |
| `[!]` | Algo que se quer **enfatizar** no texto citado. | § 3.5.3, p. 33 |
| Grifo | Para destacar trecho da citação literal, o livro **sugere itálico** seguido **imediatamente** de uma das expressões entre colchetes: `[sem grifo no original]`, `[grifo nosso]`, `[grifo meu]` ou `[grifo do autor]`. O livro registra que isso **difere** do previsto na NBR 10520 (que pede "grifo nosso" entre parênteses após a chamada). | § 3.5.4, p. 33 |
| Parênteses `( )` | Chamadas (número ou autor-data-página), expressões adicionadas ao texto, coleções e séries nas referências. | § 3.5.5, p. 34 |

Regra geral: **não altere silenciosamente** uma citação direta; indique supressões, acréscimos e destaques.

---

## 5. Referências bibliográficas

### 5.1 Regras do PDF: princípios

- Elementos essenciais de uma referência: **autor, título e subtítulo, edição, local (cidade), editora, ano**; complementados por número de páginas/volumes, série e notas (§ 4, p. 35).
- Elementos que não constam no documento mas podem ser identificados entram **entre colchetes** (Obs., p. 35). Exemplos de uso no livro: `[S. l.]`, `[Rio de Janeiro]`.
- Se houver mais de um local para uma editora, usa-se o primeiro ou o mais destacado; havendo mais de duas editoras, a primeira ou a de maior destaque (notas 8 e 9, p. 35).
- A norma de base é a **NBR 6023:2002**; o livro reconhece que existem outros padrões (APA, MLA, CBE, Chicago) em uso, mas o modelo proposto é o da ABNT (§ 4, p. 35).
- **Entrada:** último SOBRENOME em CAIXA-ALTA, seguido do prenome. Mais de três autores: indica-se só o primeiro seguido de **et al.**; é facultado indicar todos quando a menção de todos for indispensável (nota 14, p. 36).
- **Edição:** indicada a partir da segunda (§ 4.1.1, p. 36).
- Destaque tipográfico do título (nota 11, p. 36, remetendo à nota 7, p. 32): o PDF trata o grifo como negrito, itálico etc.; os exemplos impressos do livro usam itálico no título.

### 5.2 Regras do PDF: tabela de consulta rápida por tipo de documento

| Tipo de documento | Seção | Página |
|---|---|---|
| Livro, entrada por pessoa física (1 autor; até 3 autores; mais de 3 autores) | § 4.1.1.1 | 36 |
| Livro, entrada por pessoa jurídica | § 4.1.1.2 (e nota 15) | 37 |
| Livro, entrada pelo título | § 4.1.1.3 | 37 |
| **Tese, dissertação e TCC** | § 4.1.2 | 37 |
| Parte de livro, mesma autoria do todo (`In: ______.`) | § 4.2.1.1 | 38 |
| Parte de livro, autoria diferente do todo (`In: SOBRENOME, Prenome.`) | § 4.2.1.2 | 38 |
| Separata de livro | § 4.2.1.3 | 38–39 |
| Periódico, fascículo no todo | § 4.2.2.1 | 39 |
| Fascículo com título próprio (número especial, suplemento) | § 4.2.2.1.1 | 39 |
| Fascículo sem título próprio | § 4.2.2.1.2 | 39 |
| **Artigo de periódico (fascículo em parte)** | § 4.2.2.2 | 40 |
| Separata de revista | § 4.2.2.3 | 40 |
| Artigo de jornal (com e sem autoria) | § 4.2.2.4 | 40–41 |
| Evento no todo (anais) | § 4.2.3.1 | 41 |
| **Trabalho em evento (em parte)** | § 4.2.3.2 | 41 |
| Atos normativos (leis, decretos) | § 4.2.4 | 42 |
| Documentos eletrônicos: considerações gerais | § 4.2.5 | 42–43 |
| Monografia/base de dados no todo (on-line e CD-ROM), e em parte | § 4.2.5.1.1 | 43–44 |
| Tese, dissertação eletrônica | § 4.2.5.1.2 | 44 |
| Artigo de revista eletrônico | § 4.2.5.1.3 | 44 |
| Artigo de jornal eletrônico | § 4.2.5.1.4 | 45 |
| Evento em parte (on-line e CD-ROM) | § 4.2.5.1.5 | 45 |
| Homepage | § 4.2.5.1.6 | 45–46 |
| Listas de discussão (no todo; mensagem) | § 4.2.5.1.7 | 46 |
| E-mail (e nota 20) | § 4.2.5.1.8 | 46 |
| Localização das referências: fim do texto, fim de seções, rodapé | § 4.2.6 | 47–48 |
| Lista de Obras citadas do próprio livro (exemplo de lista) | § 6 | 55–59 |
| Lista de Obras consultadas do próprio livro | § 7 | 61–63 |

### 5.3 Regras do PDF: esquemas dos modelos mais prováveis neste trabalho

Os esquemas abaixo reproduzem a estrutura dos modelos do livro. Para detalhes e exemplos completos, consultar as páginas indicadas.

**Livro** (§ 4.1.1, p. 36)
`SOBRENOME, Prenome. Título: subtítulo. Nº da edição (a partir da 2ª). Local: Editora, ano. Nº total de páginas ou de volumes. (Coleção/Série). Notas.`

**Tese, dissertação, TCC** (§ 4.1.2, p. 37)
`SOBRENOME, Prenome. Título: subtítulo. Local da instituição, ano de aceitação. Nº de folhas (f.). Tipo de trabalho (Curso) – Unidade de Ensino, Instituição, local, ano.`

**Parte de livro, autoria diferente** (§ 4.2.1.2, p. 38)
`SOBRENOME, Prenome. Título da parte. In: SOBRENOME, Prenome (do todo). Título do todo: subtítulo. Edição. Local: Editora, ano. Total de páginas. Volume/seção, página inicial-final.`

**Artigo de periódico** (§ 4.2.2.2, p. 40)
`SOBRENOME, Prenome. Título do artigo: subtítulo. Título da revista, local: Editor, volume ou ano. Número do fascículo, página inicial-final, período, ano.`
Exemplo do livro: `Ciência e Cultura, São Paulo: SBPC, v. 38, n. 12, p. 1984-1991, dez. 1986.`

**Trabalho em evento** (§ 4.2.3.2, p. 41)
`SOBRENOME, Prenome. Título do trabalho. In: TÍTULO DO EVENTO, nº., ano, local. Tipo do documento... Local: Editora, ano. Total de páginas ou volumes. Volume/seção, página inicial-final.`

**Qualquer documento on-line** (§ 4.2.5.1, pp. 43–46)
Mesmo modelo do documento impresso, acrescido de `Disponível em: <endereço eletrônico>. Acesso em: dia mês ano.` O horário de acesso é opcional (nota 19, p. 43).

**Observações dos modelos eletrônicos** (§ 4.2.5, pp. 42–43): registrar a **data de acesso** porque URLs mudam; só devem ser citados documentos eletrônicos de **forma pública**, acessíveis a todos os interessados. A nota 20 (p. 46) lembra que **e-mails** só devem ser referenciados quando não houver outra fonte, por serem informais e efêmeros.

### 5.4 Regras do PDF: ordenação e localização das listas

- No sistema **autor-data**, as referências são apresentadas em **ordem alfabética** pela entrada (pessoa física, pessoa jurídica ou título) (§ 4.2.6.1, p. 47).
- **Mesmo autor, mesma página:** a partir da segunda obra, a entrada pode ser substituída por um filete sublinear (`______.`), com as obras em ordem alfabética de título; em **página diferente**, a entrada volta a ser completa (§ 4.2.6.1, p. 47).
- **Mesmo autor e mesma obra em outra edição:** autor e título são ambos substituídos por filete (§ 4.2.6.1, p. 47).
- As listas podem estar **no fim do texto**, **no fim de seções** ou **no rodapé**; para a monografia, o livro considera apenas essas localizações (§ 4.2.6, p. 47). Referências no rodapé não são comuns em TCCs, mas facilitam a leitura; nesse caso o uso de expressões latinas torna-se indispensável (§ 4.2.6.3, pp. 47–48).
- Obras consultadas, se adotadas, são uma lista separada de Obras citadas (§ 1.3.1.2, p. 18).

### 5.5 Implementação sugerida (não é regra do PDF)

> **Implementação sugerida.**
> - [Script] Validador do `bibliografia.bib`: chaves duplicadas, chaves citadas inexistentes, entradas nunca citadas, campos vazios ou suspeitos por tipo de entrada.
> - [Manual] Conferir cada entrada contra a fonte original (nomes, título, ano, páginas, URL).
> - [Script/Manual] Comparar a saída do estilo bibliográfico com os modelos do PDF (por exemplo: `Disponível em` e `Acesso em`; `et al.`; `______.` para repetição de autor; `f.` para teses). O que o estilo gerar de diferente deve ser registrado como exceção, não corrigido às cegas.
> - **Limite importante:** o PDF não traz modelo para relatório técnico, manual, norma técnica como fonte de consulta ou software (ver **A-10**). O `.bib` atual contém entradas de tipos que não têm modelo no PDF.

---

## 6. Notas de rodapé

### 6.1 Regras do PDF: classificação e finalidade

| Tipo | Definição | Referência |
|---|---|---|
| **Nota de referência** | Também chamada bibliográfica, de conteúdo ou de autoridade; é a referência correspondente a uma citação. | § 5.1.1, p. 49 |
| **Nota explicativa** | Também chamada de esclarecimento; usada para explicações, remissões a outras partes do texto, tradução ou versão de citações em outro idioma. Deve ser **objetiva, sucinta e clara**. | § 5.1.2, p. 50 |

Finalidades das notas de rodapé (§ 5.2, p. 50): (a) indicar a fonte das citações; (b) remeter a outras partes do trabalho, obras e autores; (c) acrescentar considerações complementares que prejudicariam o desenvolvimento do texto; (d) transcrever o trecho em língua original ou traduzir em vernáculo o trecho em língua estrangeira.

O livro registra que o uso de notas deve ser parcimonioso, segundo Hubner (2002), e que a NBR prevê notas apenas no rodapé, embora a maioria dos autores aceite também notas no fim de seções (§ 5, p. 49).

### 6.2 Regras do PDF: chamada, numeração e apresentação

| Aspecto | Regra | Referência |
|---|---|---|
| Chamada | Número arábico **sobrescrito** (ou alinhado entre parênteses), colocado **após o sinal de pontuação**. | § 5.3, p. 50; § 5.4.1.1, p. 51 |
| Numeração | **Única e consecutiva para cada capítulo ou parte**; **não reinicia a cada página**. No rodapé, o número vai sempre sobrescrito. | § 5.4.1.1, p. 51 |
| Filete | Notas separadas do texto por **espaço simples** e por **filete de 5 cm** iniciado na margem esquerda. | § 5.4.1, p. 51 |
| Texto da nota | **Espaço simples** e **fonte menor** que a do corpo. | § 5.4.1, p. 51 |
| Primeira linha | A primeira letra da nota começa **um espaço** após o indicativo de chamada. | § 5.4.1, p. 51 |
| Linhas seguintes | Abaixo da **primeira letra da linha anterior**, deixando o indicativo em destaque. | § 5.4.1, p. 51 |
| Integridade | O texto de uma nota explicativa deve estar **inteiro na página em que começa**. | § 5.4.1.2, p. 54 |
| Notas explicativas | Mesma numeração e disposição das notas de referência; alíneas e incisos em sequência, separados por **ponto e vírgula**. | § 5.4.1.2, p. 54 |

### 6.3 Regras do PDF: combinação com o sistema de chamada

- Quando o sistema numérico é adotado para as notas **explicativas**, convém usar o sistema **autor-data** para as citações/notas de **referência** (Obs., p. 51). O sistema numérico para notas explicativas só pode ser usado quando o de referência é autor-data (§ 5.4.1.2, p. 54).
- Se uma referência é citada **pela primeira vez em nota de rodapé**, ela é apresentada **completa e exatamente como em Obras citadas**; as demais menções do mesmo documento são **abreviadas**, com expressões latinas (§ 5.4.1.1, pp. 51–52).
- O livro afirma que referências bibliográficas no rodapé **não são comuns** em teses, dissertações e TCCs (§ 4.2.6.3, p. 47; § 5.4.1.1.1, p. 53).

### 6.4 Regras do PDF: expressões e abreviaturas latinas (§ 5.4.1.1.1, pp. 52–53)

Uso **com muito critério**, para não prejudicar a inteligibilidade (p. 52). O livro observa que essas expressões são normalmente grafadas em itálico, mas adotou a forma da NBR 10520:2002, seção 7 (nota 21, p. 52). Ver **A-12**.

| Expressão | Significado | Onde se usa | Regra de uso |
|---|---|---|---|
| ***apud*** | em, extraída de, citada por, segundo | Texto e rodapé | Citações **indiretas** (ver seção 4.4 deste guia). |
| ***cf.*** | confira | Texto e rodapé | Recomendar consulta a trabalhos de outros autores ou a notas do mesmo trabalho. |
| ***ibidem*** / ***ibid.*** | na mesma obra | Texto e rodapé | Indica que a obra é a **mesma da citação imediatamente anterior**. Não repete sobrenome e ano; acrescenta só a página, quando diferente (`ibid., p. 3`). Só deve ser usada quando se refere à obra **imediata e anteriormente** citada (p. 53). |
| ***idem*** / ***id.*** | o mesmo autor | Rodapé | **Outra obra** do autor imediata e anteriormente citado; indicar ano e página (`id., 1991, p. 60`). |
| ***op. cit.*** | obra citada | Rodapé | Obra de autor **já citado, mas não na nota imediatamente anterior**; após o sobrenome, `op. cit.` e a página (`Almeida, op. cit., p. 40`). |
| ***passim*** | aqui e ali | Texto e rodapé | Referência genérica a várias passagens, **sem páginas determinadas**. |
| ***et seq.*** / ***sequentia*** | seguinte | Texto ou rodapé | Quando não se quer citar todas as páginas (`p. 30 et seq.`). |
| ***loc. cit.*** | no lugar citado | **Somente rodapé** | **Mesma página** de obra já citada, **havendo outras notas intercaladas**. |

**Outras expressões usadas no texto** (§ 5.4.1.1.2, p. 54): *ad lit.* (ao pé da letra); *ca.* (aproximadamente, para datas); *e.g.* (por exemplo); *et al.* (mais de três autores: primeiro autor seguido de *et al.*); *in:* (parte extraída de documento no todo); *infra* (abaixo); *supra* (acima); *v.g.* (por exemplo).

> **Implementação sugerida.** O PDF permite, mas não exige, o uso dessas abreviaturas, e seus exemplos têm pequenas inconsistências de pontuação e caixa (ver **A-12**). Como regra prática, **em caso de dúvida, repetir a chamada autor-data completa** em vez de usar *ibid.*, *idem*, *op. cit.* ou *loc. cit.*; essas expressões se tornam erradas se uma nota for inserida ou movida. [LaTeX] Se forem usadas, definir macros únicas (por exemplo, para *apud* e *passim*). [Script] Procurar ocorrências de `ibid`, `idem`, `op. cit.` e `loc. cit.` e listá-las para conferência manual da sequência de notas. [LaTeX/Manual] Verificar se o reinício da numeração de notas **por capítulo** está ativo na classe usada.

---

## 7. Figuras, tabelas, listas e demais elementos gráficos

### 7.1 O que o PDF efetivamente determina

- As ilustrações, **exceto tabelas e quadros**, recebem o título genérico **"figuras"** (§ 1.1.12.1, p. 17).
- A **lista de ilustrações** reúne títulos e/ou legendas de tabelas, quadros e outras ilustrações (mapas, diagramas, plantas, fotografias, gráficos), com as páginas, na ordem em que aparecem no texto; se muito numerosas, têm listas próprias (§ 1.1.12, § 1.1.12.1, p. 17).
- Para elaborar e apresentar **tabelas**, o livro manda seguir as **Normas de apresentação tabular do IBGE** (nota 3, p. 17). Esse documento **não faz parte do PDF**; ver **A-13**.
- Modelos de lista de ilustrações, lista de tabelas, lista de abreviaturas, siglas e símbolos e lista de abreviaturas: pp. 70–73 (**A-11**).
- Apêndices e anexos: ver seção 2.4.

### 7.2 O que o PDF **não** determina

O PDF **não contém** regras sobre: posição ou formato da legenda de figuras e tabelas; numeração de figuras, tabelas e equações; inclusão da fonte abaixo de figuras e tabelas; formatação ou numeração de equações; chamada obrigatória de cada figura no texto; tamanho de letra em tabelas. A versão 1 deste guia listava alguns desses itens como "regras"; eles foram **retirados** (ver seção 11).

> **Implementação sugerida (boa prática geral, não é regra do PDF).** [LaTeX] Usar `\label` e `\ref`/`\autoref` para todas as figuras, tabelas e equações, e `\caption` em todas as figuras e tabelas. [Script] Listar `\label` nunca referenciados e `\ref` sem `\label`. [Manual] Confirmar com a coordenação se o IBGE (tabelas) e outras convenções de legenda e fonte são exigidos. Até lá, tratar esses itens como padrão de qualidade, não como exigência do PDF.

---

## 8. Checklists de conformidade

Cada item corresponde a uma regra do PDF (com referência) ou, quando indicado, a uma boa prática que **não** vem do PDF.

### 8.1 Estrutura (antes da entrega)

- [ ] Ordem dos elementos conferida com a decisão tomada em **A-01** (§ 1, pp. 13–14).
- [ ] Capa presente (§ 1.1.1, p. 14).
- [ ] Folha de rosto completa: autor, título, curso e área, natureza e instituição, orientador/coorientador, cidade, ano; autor, orientador e título em CAIXA-ALTA (§ 1.1.4, pp. 14–15; § 2.2, p. 21).
- [ ] Ficha catalográfica no verso da folha de rosto, se exigida pela coordenação (**A-14**) (§ 1.1.4, p. 15).
- [ ] Folha de aprovação com data, banca, titulação e instituições (§ 1.1.5, p. 15).
- [ ] Resumo em parágrafo único, 3ª pessoa, 150 a 500 palavras, espaço simples (§ 1.1.9, p. 16).
- [ ] Palavras-chave abaixo do resumo, após dois pontos, cada uma terminada em ponto (nota 2, p. 16).
- [ ] Resumo em língua estrangeira, em folha própria (§ 1.1.10, p. 16).
- [ ] Sumário reproduzindo exatamente os títulos do corpo do trabalho (§ 1.1.11, p. 17).
- [ ] Listas (ilustrações, tabelas, abreviaturas/siglas/símbolos), se adotadas, na ordem de aparição no texto e com páginas (§ 1.1.12, p. 17).
- [ ] Introdução, desenvolvimento e conclusão (§ 1.2, p. 17).
- [ ] Obras citadas (ou a denominação decidida em **A-08**) (§ 1.3.1.1, p. 18).
- [ ] Obras consultadas, se adotada, separada de Obras citadas, incluindo as obras citadas listadas no fim de seções, quando for o caso (§ 1.3.1.2, p. 18).
- [ ] Apêndices e anexos como seções primárias, cada um como seção secundária, com indicativo numérico (§ 1.3.2, p. 19).
- [ ] Glossário e índice, se adotados (§ 1.3.3–1.3.4, p. 19).

### 8.2 Formatação

- [ ] Papel A4 (§ 2.1, p. 21).
- [ ] Margens: superior 3 cm; inferior 2 cm; anverso esquerda 3 cm e direita 2 cm; verso esquerda 2 cm e direita 3 cm (§ 2.2.1, p. 21; esquemas pp. 65–66).
- [ ] Recuo de parágrafo conforme a decisão de **A-03**.
- [ ] Texto em fonte 12 e espaço 1,5 (§ 2.2.2, p. 22).
- [ ] Citações longas: recuo de 4 cm, corpo menor, espaço simples, dois espaços simples antes e depois (§ 2.2.1 f, p. 22).
- [ ] Notas, referências e resumos em espaço simples (§ 2.2.2, p. 22).
- [ ] Alíneas: recuo, alinhamento pela primeira letra, espaço simples interno e 1,5 entre alíneas (§ 2.2.1 e, p. 22).
- [ ] Títulos a um espaço do indicativo, separados por espaço 1,5; títulos sem indicativo centralizados (§ 2.2.2, p. 22; § 2.3.2, p. 23).
- [ ] Paginação: folhas contadas; número visível só a partir da parte textual; canto superior direito (anverso) e esquerdo (verso), a 2 cm da borda superior (§ 2.2.3, p. 22).
- [ ] Filete de 5 cm e espaço simples nas notas de rodapé (§ 5.4.1, p. 51).

### 8.3 Citações

- [ ] Sistema de chamada único e consistente em todo o trabalho (§ 3.4, pp. 27–28).
- [ ] Citação formal direta de até 3 linhas entre aspas duplas; aspas simples para o que já estava entre aspas (§ 3.2.1.1, p. 25).
- [ ] Citação com mais de 3 linhas em bloco, sem aspas duplas externas, com a formatação da seção 4.3 (§ 3.2.1.1, p. 26).
- [ ] Página(s) indicada(s) em citações diretas e, por recomendação do livro, também nas demais (§ 3.4.1, p. 30).
- [ ] Citações conceituais (paráfrases) com a fonte indicada (§ 3.2.2, p. 26).
- [ ] *Apud* usado só quando o original é inacessível; referência do original em nota de rodapé (§ 3.2.1.2, p. 26).
- [ ] Citação traduzida seguida de *(tradução nossa)* e, de preferência, original em nota (nota 5, p. 25).
- [ ] Informação obtida em aula, palestra, entrevista ou comunicação pessoal marcada com *(informação verbal)* e fonte em nota (§ 3.3, p. 27).
- [ ] Supressões `[...]`, acréscimos `[ ]`, `[sic]`, `[?]`, `[!]` e grifos (itálico + `[grifo nosso]` etc.) sinalizados (§ 3.5, pp. 31–34).
- [ ] Sobrenomes coincidentes e obras do mesmo autor e ano (a, b) distinguidos (§ 3.4.1, p. 29).

### 8.4 Referências

- [ ] Toda citação tem referência correspondente (§ 3.4, p. 28).
- [ ] Cada referência segue o modelo do seu tipo de documento (seção 5.2 deste guia).
- [ ] Documentos on-line com `Disponível em` e `Acesso em` (§ 4.2.5.1, pp. 43–46).
- [ ] Mais de três autores: primeiro autor + *et al.* (nota 14, p. 36).
- [ ] Ordem alfabética; repetição de autor com `______.` só na mesma página (§ 4.2.6.1, p. 47).
- [ ] Referências alinhadas à margem esquerda, espaço simples e 1,5 entre elas (§ 2.2.1 g e § 2.2.2, p. 22).
- [ ] Sem chaves bibliográficas duplicadas e sem entradas incompletas (boa prática, não vem do PDF).
- [ ] Entradas conferidas contra os documentos originais (boa prática, não vem do PDF).

### 8.5 Notas de rodapé

- [ ] Notas explicativas objetivas, sucintas e claras (§ 5.1.2, p. 50).
- [ ] Numeração consecutiva por capítulo, sem reiniciar a cada página (§ 5.4.1.1, p. 51).
- [ ] Chamada após o sinal de pontuação (§ 5.3, p. 50).
- [ ] Nota inteira na página em que começa (§ 5.4.1.2, p. 54).
- [ ] Expressões latinas usadas só com sequência de notas conferida (§ 5.4.1.1.1, pp. 52–53).

### 8.6 Revisão humana (boas práticas, não vêm do PDF)

- [ ] As fontes citadas sustentam as afirmações a que estão associadas.
- [ ] Transcrições literais comparadas com o original.
- [ ] Figuras, tabelas e equações chamadas no texto.
- [ ] PDF final lido visualmente, e não apenas compilado sem erros.
- [ ] Exigências específicas da coordenação atendidas.

---

## 9. Matriz de automação para o projeto LaTeX

> **Esta seção é implementação sugerida.** Nada aqui é regra do PDF; cada linha aponta a regra do PDF que ela serve. Itens marcados com "depende" só devem ser implementados depois da decisão indicada na seção 10.

| ID | Regra servida (PDF) | Método | Tipo | Limite |
|---|---|---|---|---|
| M-01 | Papel A4, margens, anverso/verso (§ 2.1, § 2.2.1) | Configuração central no preâmbulo | [LaTeX] | Depende de **A-02**. Conferir medição no PDF compilado. |
| M-02 | Fonte 12, espaço 1,5 (§ 2.2.2) | Configuração central | [LaTeX] | Família tipográfica: **A-04**. |
| M-03 | Recuo de parágrafo e alíneas (§ 2.2.1 d–e) | Configuração central e ambiente de alíneas | [LaTeX] | Depende de **A-03**. |
| M-04 | Citação longa (§ 2.2.1 f; § 3.2.1.1) | Ambiente próprio | [LaTeX] | Depende de **A-05**. Não detecta citação longa digitada à mão. |
| M-05 | Detecção de citações longas sem ambiente | Procura por blocos entre aspas longos nos `.tex` | [Script] | Heurística; sempre exige conferência manual. |
| M-06 | Paginação (§ 2.2.3) | Estilo de página com posição por anverso/verso e início na parte textual | [LaTeX] | Conferir visualmente. |
| M-07 | Notas: filete de 5 cm, fonte menor, espaço simples, numeração por capítulo (§ 5.4) | Configuração central | [LaTeX] | Tamanho exato da fonte: **A-06**. |
| M-08 | Numeração progressiva; títulos sem indicativo centralizados (§ 2.3) | Comandos de seção da classe | [LaTeX] | Não digitar números à mão. |
| M-09 | Elementos pré-textuais obrigatórios presentes (§ 1.1) | Checklist 8.1 e leitura do `main.tex` | [Script/Manual] | Depende de **A-01** e **A-14**. Elementos podem vir de arquivos incluídos. |
| M-10 | Resumo: 150–500 palavras, parágrafo único (§ 1.1.9) | Contagem de palavras do ambiente `resumo` | [Script] | Verifica formato, não qualidade. |
| M-11 | Palavras-chave: dois pontos e ponto final em cada uma (nota 2) | Expressão regular no ambiente `resumo` | [Script] | — |
| M-12 | Toda citação tem entrada no `.bib` (§ 3.4) | Script e/ou avisos de compilação | [Script] | Comandos de citação personalizados precisam ser reconhecidos. |
| M-13 | Entradas do `.bib` nunca citadas | Comparação `.bib` × `.tex` | [Script] | Entradas incluídas intencionalmente por `\nocite`. |
| M-14 | Página em citações (§ 3.4.1, p. 30) | Listar `\cite` sem argumento de página para revisão | [Script] | Recomendação do livro, não erro; síntese da obra no todo dispensa página. |
| M-15 | Sinais `[...]`, `[sic]`, grifo com expressão (§ 3.5) | Procurar `grifo`, `[sic]` e reticências sem colchetes | [Script/Manual] | Só sinaliza candidatos. |
| M-16 | *Apud*, *ibid.*, *idem*, *op. cit.*, *loc. cit.* (§ 3.2.1.2; § 5.4.1.1.1) | Listar todas as ocorrências | [Script/Manual] | Só a leitura confirma a sequência correta. |
| M-17 | *(informação verbal)* com nota (§ 3.3) | Procurar a expressão e conferir a nota | [Script/Manual] | — |
| M-18 | Campos obrigatórios por tipo de entrada | Validador do `.bib` | [Script] | Campo preenchido não garante dado correto; tipos sem modelo no PDF: **A-10**. |
| M-19 | Aparência das referências × modelos do PDF (§ 4) | Comparação visual de uma amostra por tipo | [Manual] | O estilo do pacote pode diferir do PDF; registrar exceções. |
| M-20 | Listas na ordem de aparição (§ 1.1.12) | Geradas pelo LaTeX | [LaTeX] | Rótulos das listas: **A-11**. |
| M-21 | `\label`/`\ref` de figuras, tabelas e equações (boa prática) | Listar rótulos sem uso e referências sem rótulo | [Script] | Não vem do PDF (seção 7.2). |
| M-22 | Correção e pertinência das fontes | Leitura crítica | [Manual] | Não é verificável por sintaxe. |

---

## 10. Registro de ambiguidades, lacunas e decisões pendentes

Nenhuma das questões abaixo foi resolvida por suposição. Cada uma indica o que o PDF diz, o conflito ou a lacuna, e quem deve decidir. **Estado de todas: pendente.**

| ID | Tema | O que o PDF diz | Conflito ou lacuna | Decisão necessária |
|---|---|---|---|---|
| **A-01** | Ordem dos elementos e nome da lista final | Apresenta Coluna um e Coluna dois, adota a dois por **sugestão**, sujeita ao **aval da coordenação**; nota 4 (p. 18) admite procedimentos próprios dos cursos (§ 1, pp. 13–14). | O projeto atual coloca listas **antes** do sumário (ordem da Coluna um) e usa o comando padrão de bibliografia. Ver observações abaixo. | Coordenação/orientador: qual coluna e qual nome ("Obras citadas" ou "Referências"). |
| **A-02** | Margens direitas | O texto lista só superior, inferior e lateral **esquerda** (§ 2.2.1). | A direita (2 cm no anverso, 3 cm no verso) aparece **somente nos esquemas** (pp. 65–66). No esquema do verso, o rótulo da borda direita diz "Borda esquerda da folha" (erro editorial evidente). | Confirmar que os valores do esquema valem. |
| **A-03** | Recuo de parágrafo e alíneas | Texto: **1,5 cm** (§ 2.2.1 d–e, pp. 21–22). | Esquemas gráficos (pp. 65–66): **1,25 cm**. O `main.tex` atual usa 1,25 cm. | Coordenação: 1,5 ou 1,25 cm. |
| **A-04** | Família tipográfica | Só diz "fonte 12" (§ 2.2.2). O colofão informa que o próprio livro foi composto em Times New Roman (p. 84). | O PDF não prescreve a fonte. O projeto usa Latin Modern. | Confirmar se há exigência de Times New Roman ou equivalente. |
| **A-05** | Detalhes da citação longa | Recuo de 4 cm, fonte menor, espaço simples, dois espaços simples antes e depois (§ 2.2.1 f). | Não especifica recuo à direita, recuo de primeira linha, alinhamento, nem como contar "3 linhas". | Definir convenção do projeto e registrá-la como escolha própria. |
| **A-06** | Tamanho de fonte de notas e legendas | "Fonte menor" (§ 5.4.1). Fonte 10 só é dada como exemplo para citações longas. | Tamanho exato das notas e das legendas não é especificado. | Definir convenção do projeto. |
| **A-07** | Opções do pacote de citação | `et al.` só acima de três autores (nota 14, p. 36). Citação com três autores é listada por inteiro (p. 13: `OLIVEIRA; LIMA; LIMA`). | O projeto carrega `abntex2cite` com `alf, abnt-etal-cite=2, abnt-etal-list=0, abnt-full-initials=yes`. O efeito exato dessas opções frente à regra do PDF **não foi verificado**. | Verificar na Etapa 3 compilando exemplos com 2, 3 e 4 autores. |
| **A-08** | "Obras citadas" × "Referências" | O livro **sugere** o desdobramento em Obras citadas e Obras consultadas (§ 1.3.1, p. 18); a NBR usa só "Referências". | O título final depende da decisão da coordenação. | Coordenação/orientador. |
| **A-09** | Referência do original em citação *apud* | Vai em nota de rodapé (§ 3.2.1.2, p. 26). No exemplo do livro, Luft **não** consta em Obras citadas (conferido pp. 55–59). | Eco, citado na p. 49, recomenda que obras citadas em nota reapareçam na bibliografia final. | Confirmar a prática desejada. Até lá, seguir o exemplo do livro. |
| **A-10** | Tipos de documento sem modelo | Há modelos para livros, teses, artigos, jornais, eventos, atos normativos e documentos eletrônicos (seção 5.2). | **Sem modelo** para relatório técnico, manual, programa de computador e para DOI/ISSN. O `.bib` do projeto contém tipos `techReport` e `manual`. | Pedir orientação à coordenação ou à biblioteca da SDC/UFF; enquanto isso, adaptar o modelo mais próximo e registrar a adaptação. |
| **A-11** | Modelos de listas | Modelo de lista de ilustrações (p. 70) usa `Fig. 1`, `Quadro 1`, `Tab. 1`. Modelo de lista de tabelas (p. 71) usa `TABELA 1 –`. | Rótulos diferentes entre os dois modelos. O texto pede lista de abreviaturas "em ordem alfabética" (p. 17), mas o modelo da p. 72 agrupa por tipo. | Escolher um padrão e aplicar de forma uniforme. |
| **A-12** | Inconsistências editoriais do PDF | — | Exemplos com pontuação variável (`op. cit.,` e `op. cit.`; `Almeida` e `ALMEIDA`); `ARAUJO, 2011p. 92` sem vírgula (p. 28); a nota 21 (p. 52) diz que essas expressões são normalmente grafadas em itálico, mas que o livro adotou a forma da NBR 10520, seção 7, sem esclarecer qual é; a Obs. da § 4.2.5.1.2 remete à "seção 4.1.2, p. 40", que está na **p. 37**. | Tratar como erro de revisão do livro; usar o padrão mais frequente e uniforme. |
| **A-13** | Normas de tabelas | A nota 3 (p. 17) manda seguir as Normas de apresentação tabular do IBGE. | O documento do IBGE não faz parte do PDF e não foi consultado. | Confirmar se a exigência vale para o TCC. |
| **A-14** | Modelos para graduação | Os modelos de folha de rosto, ficha, aprovação, dedicatória, agradecimento, epígrafe e resumo (pp. 75–82) são de **teses e dissertações**. | Adaptação ao TCC de graduação (natureza do trabalho, banca, ficha catalográfica) não está exemplificada. | Coordenação: modelos oficiais do curso, se existirem. |

### Observações preliminares sobre o projeto (para a Etapa 3; não são correções)

Itens observados no `main.tex` e no `.bib` durante a validação, **sem auditoria completa**:

- Classe `abntex2` com `12pt`, `openright`, `twoside`, `a4paper`.
- `\setlength{\parindent}{1.25cm}` (ver **A-03**).
- Fonte `lmodern` (ver **A-04**).
- Ordem pré-textual: resumo, abstract, lista de ilustrações, lista de tabelas, sumário (ver **A-01**).
- O `main.tex` **não emite folha de aprovação**, que o PDF classifica como obrigatória (§ 1.1.5, p. 15). Também não emite dedicatória, agradecimentos, epígrafe, errata nem lista de abreviaturas (todos opcionais, exceto a aprovação).
- Opções de `abntex2cite` conforme **A-07**.
- `bibliografia.bib`: 41 entradas (20 `article`, 7 `techReport`, 7 `book`, 3 `manual`, 2 `inproceedings`, 1 `misc`, 1 `incollection`).
- Os problemas de compilação identificados na inspeção preliminar (relatório de andamento, seção 6) **não foram reavaliados nesta revisão** e permanecem fora do escopo atual.

---

## 11. Registro de revisão: o que mudou da versão 1 para a versão 2

| Tema | Na versão 1 | Na versão 2 | Motivo |
|---|---|---|---|
| Classificação das citações | Seções "indireta/citação de citação", "paráfrase" e "mista", sem a estrutura do livro. | Classificação completa **formal/conceitual × direta/indireta + mista**, com a observação de que o livro não segue a NBR 10520 (seção 4.2). | § 3.2, pp. 25–27. |
| Citações longas | Recuo, fonte e espaço. | Acrescentados: dois espaços simples antes e depois, citação dentro de citação longa em aspas duplas, regra de aspas em rodapé, lacunas registradas (A-05). | § 2.2.1 f, p. 22; § 3.5.1, p. 31; § 5.4.1.2, p. 54. |
| Margens | Superior, inferior e esquerda. | Margens **direitas** (esquemas) e **conflito 1,5 × 1,25 cm** (A-02, A-03). | Esquemas, pp. 65–66; § 2.2.1, pp. 21–22. |
| Paginação | Cantos superiores. | Acrescentada a distância de 2 cm da borda superior e da borda externa. | § 2.2.3, p. 22. |
| Resumo | Apenas "síntese seguida de palavras-chave". | Parágrafo único, 3ª pessoa, 150–500 palavras, espaço simples; formato das palavras-chave. | § 1.1.9, p. 16; nota 2, p. 16. |
| Estrutura | Tabela sem a ordem do livro. | Ordem da Coluna dois, diferenças da Coluna um e pendência de aval (A-01). | § 1, pp. 13–14. |
| Apêndices e anexos | Descrição geral. | Como seções primárias com indicativo numérico; apêndice × anexo. | § 1.3.2, p. 19. |
| Páginas em citações | "Quando disponível/aplicável". | O livro **aconselha** páginas em qualquer tipo de citação. | § 3.4.1, p. 30. |
| Referências | "Modelos mínimos" genéricos, com **DOI**. | Tabela por seção e página e esquemas do próprio PDF. **DOI retirado**: o PDF não o prevê (A-10). | § 4, pp. 35–48. |
| Notas de rodapé | Um parágrafo e uma lista de cinco itens genéricos. | Seção 6 completa: tipos, finalidade, chamada, numeração, filete, expressões latinas com regra de uso, notas explicativas. | § 5, pp. 49–54. |
| "Não usar uma nota para substituir a referência bibliográfica" | Apresentado como orientação do livro. | **Retirado**: não consta no PDF. | Não localizado. |
| Figuras e tabelas | Checklist de legenda, numeração, fonte e legibilidade apresentado como regra. | **Retirado como regra**: o PDF não trata desses itens; mantido apenas como boa prática, claramente separada (seção 7.2). | § 1.1.12, p. 17 e nota 3. |
| Separação regra × sugestão | Marcadores [LaTeX]/[Script]/[Manual] misturados às regras. | Regras sempre com referência de página; sugestões em blocos próprios (seção 0.1). | Critério de conclusão do relatório. |
| Ambiguidades | Não registradas. | Registro com 14 itens (seção 10). | Critério de conclusão do relatório. |

### O que esta validação cobriu e o que não cobriu

- **Cobriu:** leitura integral do texto do PDF (seções 1 a 5 em detalhe; seções 6 e 7 por amostragem, por serem listas de exemplo) e inspeção visual dos dois esquemas de margens (pp. 65–66) e de uma página de referências.
- **Não cobriu:** o **desenho espacial** dos modelos de capa, lombada, folha de rosto, folha de aprovação e demais anexos (pp. 67–82), lidos apenas pelo texto (alinhamento e distâncias não foram medidos); as normas da ABNT citadas pelo livro; o documento do IBGE; e o comportamento real do pacote `abntex2cite` frente aos modelos.

---

## 12. Referência da fonte

ABREU, Estela dos Santos; TEIXEIRA, José Carlos Abreu. *Apresentação de trabalhos monográficos de conclusão de curso*. 10. ed. rev. e atual. Niterói: EdUFF, 2012. 83 p.

**Localização dos assuntos (página impressa; no leitor de PDF, some 1):**

| Assunto | Seção | Páginas |
|---|---|---|
| Elementos componentes | 1 | 13–19 |
| Apresentação gráfica | 2 | 21–23 |
| Citação | 3 | 25–34 |
| Referenciação bibliográfica | 4 | 35–48 |
| Notas | 5 | 49–54 |
| Obras citadas (lista do livro) | 6 | 55–59 |
| Obras consultadas (lista do livro) | 7 | 61–63 |
| Esquema de apresentação gráfica (anverso e verso) | 8.1 | 65–66 |
| Modelos de capa, lombada, errata, listas | 8.2–8.8 | 67–73 |
| Modelos de folha de rosto, ficha, aprovação, dedicatória, agradecimento, epígrafe, resumos, glossário | 9.1–9.9 | 75–83 |

> **Nota de escopo:** este guia consolida a publicação fornecida pela coordenação e não incorpora correções ou substituições de normas externas. Quando o texto resumido não for suficiente para decidir uma situação, prevalece a consulta ao PDF fornecido e, nos casos da seção 10, a decisão da coordenação.
