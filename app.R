
library(FindIT2)
library(shiny)
library(shinydashboard)


library(TxDb.Athaliana.BioMart.plantsmart28)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

sl <- paste0("Chr", c(1:5, "M", "C"))
seqlevels(TxDb.Athaliana.BioMart.plantsmart28) <- sl

species_list <- c(
  TxDb.Athaliana.BioMart.plantsmart28,
  TxDb.Hsapiens.UCSC.hg19.knownGene
)

names(species_list) <- c("arabidopsis", "hg19")

source("ui_mm_nearestGene.R", local = TRUE)
source("ui_mm_geneScan.R", local = TRUE)
source("ui_mm_geneBound.R", local = TRUE)

ui <- dashboardPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "demo.css"),
  ),
  header = dashboardHeader(title = "FindIT2 Online Server"),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(
        "mm_nearestGene",
        tabName = "mm_nearestGene",
        icon = icon("dna")
      ),
      menuItem(
        "mm_geneScan",
        tabName = "mm_geneScan",
        icon = icon("dna")
      ),
      menuItem(
        "mm_geneBound",
        tabName = "mm_geneBound",
        icon = icon("dna")
      )
    )
  ),
  body = dashboardBody(
    tabItems(
      tab_mm_nearestGene,
      tab_mm_geneScan,
      tab_mm_geneBound
    ),
    tags$footer(
      tags$span(
        icon("question"),
        "If you have any question, please report in ",
        tags$a(
          "[GitHub issue]",
          href = "https://github.com/WangLab-CEMPS/FindIT2_shiny/issues"
        ),
        tags$br()
      ),
      tags$span(
        tags$strong("available input example: "),
        tags$a("ChIPseq；", href = "static/Chip.gz"),
        tags$a("ATAC；", href = "static/Chip.gz"),
        tags$a("Gene-List    ", href = "static/gene.txt")
      )
    )
  )
)


server <- function(input, output) {
  source("server_mm_nearestGene.R", local = TRUE)
  source("server_mm_geneScan.R", local = TRUE)
  source("server_mm_geneBound.R", local = TRUE)
}

shinyApp(ui, server)