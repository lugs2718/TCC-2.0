//#import "@preview/pinit:0.2.2": *
#import "@preview/gentle-clues:1.2.0": *
#import "@preview/drafting:0.2.2": inline-note, margin-note, set-margin-note-defaults//,note-outline
#import "@preview/fletcher:0.5.2" as fletcher: diagram, edge, node

#import "@preview/codly:0.2.0": *
#import "@preview/codly-languages:0.1.0": *

// Inicialização obrigatória do codly no documento
#show: codly-init.with()

// Configuração visual para o TCC
// Configuração visual para o TCC corrigida
#codly(
  languages: (
    py: (name: "Python", color: rgb("#2b5b84"), icon: "🐍"),
  ),
  //zebra-fill: luma(245),
  fill: none, // <-- Adicione isso!
  stroke-width: 0.5pt,
  stroke-color: luma(200),
  radius: 2pt,
)

```py
# =======================================================
    # 1. PARÂMETROS GEOMÉTRICOS E FÍSICOS
    # =======================================================
    R_int, R_ext = 9.0, 11.0 #Raio interno e externo
    H = 2.0 # Expessura
    P_int = 10e6 # Pressão interna

    # Material 1 (Ex: Aço) e Material 2 (Ex: Alumínio)
    E1, nu1 = 200e9, 0.3
    E2, nu2 = 70e9, 0.33

    # Número de camadas (Volume fraction 50/50)
    N_camadas = 200
    interfaces = np.linspace(R_int, R_ext, N_camadas + 1)[1:-1] # Exclui as extremidades

    # =======================================================
    # 2. CÁLCULO DOS COEFICIENTES HOMOGENEIZADOS (MHA)
    # Baseado na Teoria de Laminação (Homogeneização Assintótica 1D)
    # =======================================================
    def get_C_matrix(E, nu):
        # Retorna C11 e C12 para material isotrópico
        C11 = E * (1 - nu) / ((1 + nu) * (1 - 2 * nu))
        C12 = E * nu / ((1 + nu) * (1 - 2 * nu))
        G = E / (2 * (1 + nu))
        return C11, C12, G

    C11_1, C12_1, G_1 = get_C_matrix(E1, nu1)
    C11_2, C12_2, G_2 = get_C_matrix(E2, nu2)

    V1 = 0.5 # Fração de volume da camada 1
    V2 = 0.5 # Fração de volume da camada 2
    # Por que a soluçãp diverge quando altero as frações volumétricas?
    # Possivelmente pois este código não está completamente adaptado à frações fora do 50/50

    # Coeficientes Efetivos (Média Harmônica na direção radial, Aritmética nas outras)
    C11_eff = 1.0 / (V1/C11_1 + V2/C11_2)
    C12_eff = C11_eff * (V1 * C12_1/C11_1 + V2 * C12_2/C11_2)
    C22_eff = (V1*C11_1 + V2*C11_2) - (V1*(C12_1**2)/C11_1 + V2*(C12_2**2)/C11_2) + (C12_eff**2)/C11_eff # Esse eu ainda não calculei
    G_eff = 1.0 / (V1/G_1 + V2/G_2) # Nem esse

    # =======================================================
    # 3. MALHA E FRONTEIRAS (Comum para ambos os modelos)
    # =======================================================
    # 800 elementos em R para garantir 20 elementos DENTRO de cada camada
    mesh = RectangleMesh(Point(R_int, 0.0), Point(R_ext, H), 800, 10)
```

#show: codly-init.with()

// https://xkcd.com/1195/
#import fletcher.shapes: diamond
// #set text(font: "Comic Neue", weight: 600) // testing: omit
#diagram(
  node-stroke: 1pt,
  node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
  edge("-|>"),
  node(
    (0, 1),
    align(center)[
      Hey, wait,\ this flowchart\ is a trap!
    ],
    shape: diamond,
  ),
  edge("d,r,u,l", "-|>", [Yes], label-pos: 0.1),
)
