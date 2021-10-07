tab_mm_nearestGene <- tabItem(
  tabName = "mm_nearestGene",
  box(
    title = "Input",
    # input
    selectInput(
      "species_selection_nearestGene",
      label = "select the species",
      choices = names(species_list)
    ),
    tags$div(
      tags$span("species level:"),
      textOutput("species_level_nearestGene", inline = TRUE)
    ),
    fileInput(
      "peak_input_nearestGene",
      "Choose Peak File",
      multiple = TRUE,
      accept = c(".bed",
                 ".bed.gz")
    ),
    tags$div(
      tags$span("peak level: "),
      textOutput("peak_level_nearestGene", inline = TRUE)
    ),
    tags$p("Please check the species level and peak level"),
    
    # output
    tags$p("annotation"),
    actionButton("annotation_nearestGene", "Run"),
    
  ),
  tabBox(
    title = "Result",
    
    type = "tabs",
    tabPanel(
      "annotation",
      DT::dataTableOutput("annotation_table_nearestGene"),
      downloadButton("download_anno_nearestGene", "Download")
    ),
    tabPanel("Plot", plotOutput("annoDistance_plot_nearestGene")),
    tabPanel(
      "assocPairNumber",
      DT::dataTableOutput("assocPairNumber_table_nearestGene"),
      downloadButton("download_assoc_nearestGene", "Download")
    ),
    tabPanel(
      "peakGeneAlias",
      plotOutput("peakGeneAlias_plot_nearestGene")
    )
  )
)
