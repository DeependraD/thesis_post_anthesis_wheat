pdf_files <- list.files("C:/Users/Acer/Desktop/attendables/thesis_draft_latex_standalone/thesis_files/figure-latex/", 
                        pattern = ".pdf$", full.names = TRUE)

# set directory to where you want to output to be placed
setwd("C:/Users/Acer/Desktop/attendables/thesis_draft_latex_standalone/converted_pdfs/")
purrr::map(pdf_files, 
           ~ pdftools::pdf_convert(.x, format = "png", 
                                   dpi = 120))
