tab_mm_nearestGene <- tabItem(
  tabName = "mm_nearestGene",
  fluidRow(
    column(
      width = 1
    ),
    column(
      width = 10,
      fluidRow(
        tags$h1("Input"),
        box(
          width = 12,
          title = "Step1: Select the Species",
          status = "primary",
          selectInput(
            "species_selection_nearestGene",
            label = "",
            choices = names(species_list)
          ),
          tags$br(),
          tags$span(
            tags$strong("Species Level: ")
          ),
          textOutput("species_level_nearestGene", inline = TRUE)
        )
      ),
      fluidRow(
        box(
          title = "Step2: Choose Peak File",
          width = 6,
          status = "info",
          fileInput(
            "peak_input_nearestGene",
            label = "",
            multiple = TRUE,
            accept = c(
              ".bed",
              ".bed.gz"
            )
          ),
          tags$span(
            tags$strong("Peak Level: ")
          ),
          textOutput("peak_level_nearestGene", inline = TRUE)
        ),
        box(
          width = 6,
          title = "Step3: Annotation",
          status = "warning",
          tags$h4(
            tags$i(class = "far fa-bell"),
            id = "cc",
            "Please Check the Species Level and Peaks Level"
          ),
          actionButton(
            "annotation_nearestGene",
            tags$strong("Click to Run"),
            class = "btn btn-success"
          )
        )
      ),
      fluidRow(
        tags$h1("Results"),
        box(
          width = 12,
          tabBox(
            width = "auto",
            type = "tabs",
            # title = "Results",
            tabPanel(
              "Annotation",
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
              "Peak-Gene Alias",
              plotOutput("peakGeneAlias_plot_nearestGene")
            )
          )
        )
      )
    ),
    column(
      width = 1
    )
  )
)