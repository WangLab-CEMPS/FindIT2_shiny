

#output$text <- DT::dataTableOutput()
output$species_level_nearestGene <- renderText({
  txdb <- species_list[[input$species_selection_nearestGene]]
  
  seq_levels <- seqlevels(txdb)
  seq_levels <- seq_levels[1:min(10, length(seq_levels))]
  paste(seq_levels, collapse = ",")
  
})

output$peak_level_nearestGene <- renderText({
  if (is.null(input$peak_input_nearestGene)) {
    return("")
  } else{
    df <- data.table::fread(input$peak_input_nearestGene$datapath)
    unique(df$V1)
  }
  
  
})

peakAnno_near <- eventReactive(input$annotation_nearestGene, {
  txdb <- species_list[[input$species_selection_nearestGene]]
  
  file_path <- input$peak_input_nearestGene$datapath
  fromMACS2 <- FALSE
  if (!fromMACS2) {
    peak_GR <- rtracklayer::import(con = file_path, format = "BED")
    colnames(S4Vectors::mcols(peak_GR))[1] <- "feature_id"
  } else{
    peak_GR <- FindIT2::loadPeakFile(file_path, fromMACS2 = fromMACS2,
                                     narrowPeak = TRUE)
    
  }
  peakAnno <- mm_nearestGene(peak_GR, txdb)
  peakAnno
})


output$annotation_table_nearestGene <- DT::renderDataTable({
  peakAnnoDf <- peakAnno_near()
  as.data.frame(peakAnnoDf)
  
})


output$download_anno_nearestGene <- downloadHandler(
  filename = function() {
    paste("peak_annotation", ".csv", sep = "")
  },
  content = function(file) {
    peakAnnoDf <- peakAnno_near()
    write.csv(as.data.frame(peakAnnoDf), file, row.names = FALSE)
  }
)




output$annoDistance_plot_nearestGene <- renderPlot({
  pa <- peakAnno_near()
  plot_annoDistance(pa)
})


output$assocPairNumber_table_nearestGene <- DT::renderDataTable({
  peakAnno <- peakAnno_near()
  getAssocPairNumber(peakAnno)
  
})

output$download_assoc_nearestGene <- downloadHandler(
  filename = function() {
    paste("peak_assocation_pair_number", ".csv", sep = "")
  },
  content = function(file) {
    peakAnno <- peakAnno_near()
    df <- getAssocPairNumber(peakAnno)
    write.csv(df, file, row.names = FALSE)
  }
)



output$peakGeneAlias_plot_nearestGene <- renderPlot({
  peakAnno <- peakAnno_near()
  plot_peakGeneAlias_summary(peakAnno)
  
})




