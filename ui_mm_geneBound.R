tab_mm_geneBound <- tabItem(
  tabName = "mm_geneBound",
  box(
    title = "Input",
    # input
    selectInput(
      "species_selection_geneBound",
      label = "select the species",
      choices = names(species_list)
    ),
    tags$div(
      tags$span("species level:"),
      textOutput("species_level_geneBound", inline = TRUE)
    ),
    fileInput(
      "peak_input_geneBound",
      "Choose Peak File",
      multiple = TRUE,
      accept = c(".bed",
                 ".bed.gz")
    ),
    tags$div(
      tags$span("peak level: "),
      textOutput("peak_level_geneBound", inline = TRUE)
    ),
    tags$p("Please check the species level and peak level"),

    fileInput(
      "geneBound_input_gene",
      "gene list",
      multiple = TRUE,
      accept = c(".txt",
                 ".txt.gz"),
      placeholder = " a text file with one gene one line"
    ),
        
    # output
    tags$p("annotation"),
    actionButton("annotation_geneBound", "Run"),
    
  ),
  box(
    title = "annotation",
    DT::dataTableOutput("annotation_table_geneBound"),
    downloadButton("download_anno_geneBound", "Download")

)
)