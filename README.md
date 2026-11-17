# TCC — Análise Multiescala de Vasos de Pressão Cilíndricos Multicamadas

## Descrição do Projeto

Trabalho de Conclusão de Curso (TCC) em Engenharia/Física sobre **análise mecânica multiescala de vasos de pressão cilíndricos multicamadas** com periodicidade radial, comparando o **Método de Homogeneização Assintótica (MHA)** com o **Método dos Elementos Finitos (MEF)** em termos de precisão e eficiência computacional.

### Objetivo Geral
Realizar uma análise mecânica multiescala de vasos de pressão cilíndricos multicamadas com periodicidade radial, estabelecendo uma comparação sistemática e quantitativa de precisão e eficiência computacional entre o MHA e o MEF.

### Objetivos Específicos
1. Formular o problema de equilíbrio mecânico do cilindro compósito microperiódico.
2. Aplicar o formalismo do MHA ao problema formulado.
3. Deduzir analiticamente os coeficientes elásticos efetivos para a configuração bilaminada bimetálica.
4. Implementar e calibrar um solucionador numérico axissimétrico no FEniCS, validando via Lamé.
5. Comparar quantitativamente a precisão e a eficiência computacional entre MHA e MEF.

## Estrutura do Projeto

```
├── LaTeX/                    # Código-fonte LaTeX do TCC
│   ├── main.tex              # Documento principal
│   ├── capitulos/            # Capítulos (01 a 06)
│   ├── bibliografia.bib      # Base bibliográfica (44 entradas)
│   └── Tabelas/              # Tabelas auxiliares
├── Tabelas/                  # Tabelas compiladas (.tex, .csv)
├── Imagens/                  # Figuras e gráficos
├── Códigos/                  # Scripts Python (FEniCS, geração de tabelas)
├── planejamento_revisao_tcc.md  # Planejamento e histórico de revisão
├── estado_projeto.json        # Estado vivo do projeto (JSON)
├── citacao_CIT-01.md          # Auditoria de citações — Cap. 4
├── citacao_CIT-02.md          # Auditoria de citações — Cap. 3
├── citacao_CIT-03.md          # Auditoria de citações — Cap. 2
└── README.md                  # Este arquivo
```

## Escala e Parâmetros do Projeto
- **Sistema de unidades:** N-mm-MPa (Newtons, milímetros, megapascais)
- **Geometria:** R_int = 9,0 mm, R_ext = 11,0 mm, t = 2,0 mm, H = 2,0 mm
- **Pressão interna:** p = 30 MPa
- **Materiais:** Aço carbono (ASTM A516 Gr. 70) / Liga de alumínio 6061-T6
- **Fração volumétrica:** V₁ = V₂ = 0,5

## Resultados Principais
- **Validação Lamé:** erro relativo nulo (< 10⁻¹² mm)
- **Convergência MHA:** erro L² de 0,4968% (10 células) → 0,0250% (200 células); taxa linear O(ε)
- **Alívio de massa:** 32,69% (0,6597 vs 0,9802 kg/m)
- **Resistência específica:** bimetálico 79,13 MPa·m/kg (+2,80% vs aço 76,97)
- **Speedup computacional:** 25,1× (0,250 s → 0,010 s)
- **Redução de DOFs:** > 96%

## Planejamento e Histórico de Revisão

O planejamento completo está em [`planejamento_revisao_tcc.md`](planejamento_revisao_tcc.md), com o estado vivo em [`estado_projeto.json`](estado_projeto.json).

### Tarefas Concluídas (28)
- **Diagnóstico:** DIA-01 a DIA-05
- **Conteúdo:** CON-01, CON-03 (Cap. 6), TEC-01 (unificação Cap. 3), TEC-02 (MEF), TEC-03 (resultados), TEC-04 (harmonização), TEC-05 (homogeneização Cap. 3)
- **Citações:** CIT-00 a CIT-03 (Caps. 2, 3, 4)
- **Bibliografia:** REF-01, REF-01c (44 entradas, braces balanceados)
- **Normas:** NOR-01 (Quadros vs. Tabelas), NOR-02 (pré-textual), NOR-03 (mapeamento BibTeX)
- **Revisão Cap. 2:** REV-02.1 a REV-02.5, CON-RED, CON-RED2
- **Coesão:** COE-01a (cross-references SAF)

### Tarefas Pendentes
- **COE-01b/01c:** Cross-references nos Caps. 3–6 + consolidar definição de SAF
- **CON/RED3:** Limpeza da descrição de implementação (Caps. 4 e 5)
- **NOR-02 (parte 2):** Inspeção visual final do PDF (compilação local)

## Compilação

### Local (MiKTeX)
```bash
cd LaTeX
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

### Overleaf
Upload da pasta `LaTeX/` e compilar normalmente.

## Tecnologias
- **LaTeX:** abntex2 (norma ABNT), abntex2cite (alf)
- **MEF:** FEniCS (Python)
- **Homogeneização:** MHA (Método de Homogeneização Assintótica)
- **Análise:** Python (NumPy, Matplotlib, Pandas)

## Autor
Luiz Gustavo da Silva Pereira — UFF (Universidade Federal Fluminense)