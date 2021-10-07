
#BiocManager::install("shangguandong1996/FindIT2")
library(FindIT2)
library(shiny)
library(shinydashboard)


library(TxDb.Athaliana.BioMart.plantsmart28)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

seqlevels(TxDb.Athaliana.BioMart.plantsmart28) <- paste0("Chr", c(1:5, "M", "C"))

species_list <- c(TxDb.Athaliana.BioMart.plantsmart28,
                  TxDb.Hsapiens.UCSC.hg19.knownGene)

names(species_list) <- c("arabidopsis", "hg19")


source("ui_mm_nearestGene.R", local = TRUE)
source("ui_mm_geneScan.R", local = TRUE)
source("ui_mm_geneBound.R", local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "FindIT2 online server"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("mm_nearestGene", tabName = "mm_nearestGene", icon = icon("dna")),
      menuItem("mm_geneScan", tabName = "mm_geneScan", icon = icon("dna")),
      menuItem("mm_geneBound", tabName = "mm_geneBound", icon = icon("dna"))
    )
  ),
  dashboardBody(
    tabItems(
      tab_mm_nearestGene,
      tab_mm_geneScan,
      tab_mm_geneBound
    )
    
  )
)


server <- function(input, output) { 
  
  source("server_mm_nearestGene.R", local = TRUE)
  source("server_mm_geneScan.R", local = TRUE)
  source("server_mm_geneBound.R", local = TRUE)
  
}

shinyApp(ui, server)