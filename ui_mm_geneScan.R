tab_mm_geneScan <- tabItem(
  tabName = "mm_geneScan",
  fluidRow(
    id = "mm_geneScan",
    column(
      width = 1,
    ),
    column(
      width = 10,
      fluidRow(
        tags$h1("Input"),
        box(
          title = "Step1: Select the Species",
          width = 12,
          status = "info",
          # input
          tags$div(
            selectInput(
              "species_selection_geneScan",
              label = "",
              choices = names(species_list)
            ),
            tags$br(),
            tags$span(
              tags$strong("Species Level: "),
              textOutput("species_level_geneScan", inline = TRUE)
            ),
          )
        )
      ),
      fluidRow(
        column(
          width = 5,
          box(
            title = "Step2: Adjust Parameters",
            status = "primary",
            width = 12,
            tags$br(),
            numericInput("upstream", "Upstream Size", value = 500, min = 0),
            tags$br(),
            tags$br(),
            numericInput("downstream", "Downstream Size", value = 500, min = 0),
            tags$br(),
            tags$br(),
            selectInput("feature_type",
              "Feature Types",
              choices = c("gene_id", "feature_id")
            ),
            tags$br(),
            tags$br()
          )
        ),
        column(
          width = 7,
          box(
            title = "Step3: Choose Peak File(s)",
            status = "danger",
            width = 12,
            tags$div(
              fileInput(
                "peak_input_geneScan",
                label = "",
                multiple = TRUE,
                accept = c(
                  ".bed",
                  ".bed.gz"
                )
              ),
              tags$span(
                tags$strong("Peaks Level: ")
              ),
              textOutput("peak_level_geneScan", inline = TRUE),
              tags$br()
            ),
          ),
          box(
            title = "Step4: Annotation",
            status = "warning",
            width = 12,
            tags$h4(
              tags$i(class = "far fa-bell"),
              id = "cc",
              " Please Check the Species Level and Peaks Level"
            ),
            actionButton("annotation_geneScan",
              tags$strong("Click to Run"),
              class = "btn btn-warning"
            )
          )
        )
      ),
      fluidRow(
        tags$h1("Results"),
        box(
          width = 12,
          height = "100%",
          tabBox(
            width = "auto",
            type = "tabs",
            tabPanel(
              "Annotation",
              DT::dataTableOutput("annotation_table_geneScan"),
              downloadButton("download_anno_geneScan", "Download")
            ),
            tabPanel(
              "assocPairNumber",
              DT::dataTableOutput("assocPairNumber_table_geneScan"),
              downloadButton("download_assoc_geneScan", "Download")
            ),
            tabPanel(
              "Peak-Gene Alias",
              plotOutput("peakGeneAlias_plot_geneScan")
            )
          )
        )
      ),
    ),
    column(
      width = 1,
    )
  )
)