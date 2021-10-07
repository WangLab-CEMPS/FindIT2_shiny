

#output$text <- DT::dataTableOutput()
output$species_level_geneBound <- renderText({
  txdb <- species_list[[input$species_selection_geneBound]]
  
  seq_levels <- seqlevels(txdb)
  seq_levels <- seq_levels[1:min(10, length(seq_levels))]
  paste(seq_levels, collapse = ",")
  
})

output$peak_level_geneBound <- renderText({
  if (is.null(input$peak_input_geneBound)) {
    return("")
  } else{
    df <- data.table::fread(input$peak_input_geneBound$datapath)
    unique(df$V1)
  }
  
  
})

peakAnno_geneBound <- eventReactive(input$annotation_geneBound, {
  txdb <- species_list[[input$species_selection_geneBound]]
  
  file_path <- input$peak_input_geneBound$datapath
  gene_path <- input$geneBound_input_gene$datapath
  
  fromMACS2 <- FALSE
  if (!fromMACS2) {
    peak_GR <- rtracklayer::import(con = file_path, format = "BED")
    colnames(S4Vectors::mcols(peak_GR))[1] <- "feature_id"
  } else{
    peak_GR <- FindIT2::loadPeakFile(file_path, fromMACS2 = fromMACS2,
                                     narrowPeak = TRUE)
  }
  
  genes <- read.table(gene_path)$V1
  
  
  peakAnno <- mm_geneBound(peak_GR, txdb, genes)
  peakAnno
})


output$annotation_table_geneBound <- DT::renderDataTable({
  peakAnnoDf <- peakAnno_geneBound()
  as.data.frame(peakAnnoDf)
  
})


output$download_anno_geneBound <- downloadHandler(
  filename = function() {
    paste("peak_annotation", ".csv", sep = "")
  },
  content = function(file) {
    peakAnnoDf <- peakAnno_geneBound()
    write.csv(as.data.frame(peakAnnoDf), file, row.names = FALSE)
  }
)



