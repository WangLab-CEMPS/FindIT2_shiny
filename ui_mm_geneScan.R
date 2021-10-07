tab_mm_geneScan <- tabItem(
  tabName = "mm_geneScan",
  box(
    title = "Input",
    # input
    selectInput(
      "species_selection_geneScan",
      label = "select the species",
      choices = names(species_list)
    ),
    tags$div(
      tags$span("species level:"),
      textOutput("species_level_geneScan", inline = TRUE)
    ),
    fileInput(
      "peak_input_geneScan",
      "Choose Peak File",
      multiple = TRUE,
      accept = c(".bed",
                 ".bed.gz")
    ),
    tags$div(
      tags$span("peak level: "),
      textOutput("peak_level_geneScan", inline = TRUE)
    ),
    tags$p("Please check the species level and peak level"),
    
    # output
    numericInput("upstream","upstream size", value = 500,min=0),
    numericInput("downstream", "downstream size", value = 500,min=0),
    selectInput("feature_type", "feature type", choices = c("gene_id","feature_id")),
    tags$p("annotation"),
    actionButton("annotation_geneScan", "Run"),
    
  ),
  tabBox(
    title = "Result",
    
    type = "tabs",
    tabPanel(
      "annotation",
      DT::dataTableOutput("annotation_table_geneScan"),
      downloadButton("download_anno_geneScan", "Download")
    ),
    tabPanel(
      "assocPairNumber",
      DT::dataTableOutput("assocPairNumber_table_geneScan"),
      downloadButton("download_assoc_geneScan", "Download")
    ),
    tabPanel(
      "peakGeneAlias",
      plotOutput("peakGeneAlias_plot_geneScan")
    )
  )
)
