// ----------------------------------------------------------------------------
// DADOS DO TRABALHO
// ----------------------------------------------------------------------------
//
// #show: dados.with(...) define os metadados do trabalho.
// Título, autor, instituição, etc. são definidos aqui UMA VEZ.
// Os elementos (capa, folha de rosto, resumo) leem automaticamente.
//
// MODIFIQUE os valores abaixo com seus dados reais.

#show: dados.with(
  // --- Dados básicos do trabalho ---
  titulo: "Uma proposta de pacote para normas ABNT em Typst",
  // DICA: Se não tiver subtítulo, remova ou comente a linha abaixo
  subtitulo: [Material didático para a disciplina \ Software Livre para Edição de Textos Matemáticos],

  // --- Dados do autor ---
  autor: "Cláudio Código",

  // --- Dados da instituição ---
  instituicao: "Universidade Federal de Jataí",
  faculdade: "Instituto de Ciências Exatas e Tecnológicas",
  programa: "PROFMAT - Programa de Mestrado Profissional em Rede em Matemática",
  // DICA para graduação:
  //   programa: "Curso de Bacharelado em Matemática",

  // --- Local e data ---
  local: "Jataí",
  ano: 2026,

  // --- Natureza do trabalho ---
  // Para DISSERTAÇÃO de mestrado:
  natureza: "Dissertação apresentada ao PROFMAT - Programa de Mestrado Profissional em Rede em Matemática do Instituto de Ciências Exatas e Tecnológicas da Universidade Federal de Jataí",
  objetivo: "como requisito parcial para obtenção do título de Mestre.",

  // Para TCC de graduação (descomente e adapte):
  // natureza: "Trabalho de Conclusão de Curso apresentado ao Curso de Licenciatura em Matemática da Universidade Federal de Jataí",
  // objetivo: "como requisito parcial para obtenção do grau de Licenciado em Matemática.",

  // Para TESE de doutorado (descomente e adapte):
  // natureza: "Tese apresentada ao Programa de Pós-Graduação em Matemática da Universidade Federal de Jataí",
  // objetivo: "como requisito parcial para obtenção do título de Doutor em Matemática.",

  // --- Orientação ---
  orientador: "Prof. Dr. Esdras Teixeira Costa",
  // DICA: Se tiver coorientador, descomente:
  // coorientador: "Prof. Dr. Nome do Coorientador",

  // --- Palavras-chave ---
  palavras-chave: ("Palavra-chave 1", "Palavra-chave 2", "Palavra-chave 3", "Palavra-chave 4"),
  palavras-chave-en: ("Keyword 1", "Keyword 2", "Keyword 3", "Keyword 4"),
)

// ----------------------------------------------------------------------------
// FORMATAÇÃO ABNT
// ----------------------------------------------------------------------------
//
// #show: normas-abnt.with(...) aplica a formatação ABNT ao documento:
//   - Fonte (Times New Roman ou Arial), margens, espaçamento, headings, etc.
//
// Os dados do trabalho já foram definidos acima em dados().

#show: normas-abnt.with(
  // Opções: "Times New Roman" (padrão) ou "Arial"
  fonte: "Times New Roman",

  // Bibliografia automática (opcional):
  // Se você tiver um arquivo .bib com suas referências:
  // arquivo-bibliografia: "referencias.bib",
)


// ============================================================================
// PARTE 2: CAPA E FOLHA DE ROSTO
// ============================================================================
//
// A capa e a folha de rosto são elementos obrigatórios (NBR 14724:2024).
// Elas contêm informações essenciais sobre o trabalho.

// ----------------------------------------------------------------------------
// CAPA E FOLHA DE ROSTO
// ----------------------------------------------------------------------------
// Todos os dados vêm automaticamente do dados() acima.
// Não é preciso repetir título, autor, instituição, etc.

#capa()
#folha-rosto()
