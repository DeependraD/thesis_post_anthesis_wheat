
dmat <- data.frame(row = c(1, 2, 3, 4, 1, 2, 3, 4), col = c(1, 1, 1, 1, 3, 3, 3, 3), text = c("L106", "3", "1", "L79", "L106", "3", "1", "L79"), row_c = c(0, NA, NA, NA, NA, NA, NA, 5), col_c = c(1.5, 1.5, 1.5, 1.5, 3.5, 3.5, 3.5, 3.5))

# png(filename = "1st one third block.png", width = 3000, height = 1600, units = "px", pointsize = 11, bg = "white", res = 300)

desplot(form = text ~ row * col, data = dmat, text = text,
        shorten = "no", cex = 6.5, show.key = F, out1 = text)

# dev.off()

getwd()

