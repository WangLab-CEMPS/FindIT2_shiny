

#output$text <- DT::dataTableOutput()
output$species_level_geneScan <- renderText({
  txdb <- species_list[[input$species_selection_geneScan]]
  
  seq_levels <- seqlevels(txdb)
  seq_levels <- seq_levels[1:min(10, length(seq_levels))]
  paste(seq_levels, collapse = ",")
  
})

output$peak_level_geneScan <- renderText({
  if (is.null(input$peak_input_geneScan)) {
    return("")
  } else{
    df <- data.table::fread(input$peak_input_geneScan$datapath)
    unique(df$V1)
  }
  
  
})

peakAnno_geneScan <- eventReactive(input$annotation_geneScan, {
  txdb <- species_list[[input$species_selection_geneScan]]
  
  file_path <- input$peak_input_geneScan$datapath
  fromMACS2 <- FALSE
  if (!fromMACS2) {
    peak_GR <- rtracklayer::import(con = file_path, format = "BED")
    colnames(S4Vectors::mcols(peak_GR))[1] <- "feature_id"
  } else{
    peak_GR <- FindIT2::loadPeakFile(file_path, fromMACS2 = fromMACS2,
                                     narrowPeak = TRUE)
    
  }
  peakAnno <- mm_geneScan(peak_GR, txdb,
                          input$upstream, 
                          input$downstream)
  print(class(peakAnno))
  peakAnno
})


output$annotation_table_geneScan <- DT::renderDataTable({
  peakAnnoDf <- peakAnno_geneScan()
  as.data.frame(peakAnnoDf)
  
})


output$download_anno_geneScan <- downloadHandler(
  filename = function() {
    paste("peak_annotation", ".csv", sep = "")
  },
  content = function(file) {
    peakAnnoDf <- peakAnno_geneScan()
    write.csv(as.data.frame(peakAnnoDf), file, row.names = FALSE)
  }
)



output$assocPairNumber_table_geneScan <- DT::renderDataTable({
  peakAnno <- peakAnno_geneScan()
  getAssocPairNumber(peakAnno, input$feature_type)
  
})

output$download_assoc_geneScan <- downloadHandler(
  filename = function() {
    paste("peak_assocation_pair_number", ".csv", sep = "")
  },
  content = function(file) {
    peakAnno <- peakAnno_geneScan()
    df <- getAssocPairNumber(peakAnno)
    write.csv(df, file, row.names = FALSE)
  }
)



output$peakGeneAlias_plot_geneScan <- renderPlot({
  peakAnno <- peakAnno_geneScan()
  plot_peakGeneAlias_summary(peakAnno, output_type=input$feature_type)
  
})




