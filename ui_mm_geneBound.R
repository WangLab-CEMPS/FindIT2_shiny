tab_mm_geneBound <- tabItem(
  tabName = "mm_geneBound",
  fluidRow(
    column(width = 1),
    column(
      width = 10,
      fluidRow(
        tags$h1("Input"),
        box(
          title = "Step1: Select the Species",
          width = 6,
          status = "primary",
          selectInput(
            "species_selection_geneBound",
            label = "",
            choices = names(species_list)
          ),
          tags$br(),
          tags$span(
            tags$strong("Species Level: ")
          ),
          textOutput("species_level_geneBound", inline = TRUE)
        ),
        box(
          title = "Step2: Choose Peak File(s)",
          width = 6,
          status = "warning",
          fileInput(
            "peak_input_geneBound",
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
          textOutput("peak_level_geneBound", inline = TRUE)
        )
      ),
      fluidRow(
        box(
          title = "Step3: Submit a Gene List",
          width = 6,
          status = "danger",
          fileInput(
            "geneBound_input_gene",
            label = "",
            multiple = TRUE,
            accept = c(
              ".txt",
              ".txt.gz"
            ),
            placeholder = " a text file with one gene one line"
          ),
          tags$table(
            tags$tr(tags$td("For Example: "), tags$td("AT5G01015")),
            tags$tr(tags$td(""), tags$td("AT5G67570"))
          )
        ),
        box(
          title = "Annotation",
          status = "info",
          tags$h4(
            tags$i(class = "far fa-bell"),
            id = "cc",
            " Please Check the Species Level and Peaks Level"
          ),
          actionButton("annotation_geneBound",
            tags$strong("Click to Run"),
            class = "btn btn-info"
          ),
        )
      ),
      fluidRow(
        tags$div(
          id = "dd",
          DT::dataTableOutput("annotation_table_geneBound"),
          tags$h1(
            "Get the Results: ",
            downloadButton("download_anno_geneBound", "Download")
          )
        )
      )
    ),
    column(width = 1)
  )
)