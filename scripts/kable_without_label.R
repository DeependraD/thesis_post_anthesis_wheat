# kable without label

format_args = function(x, args = list()) {
  args$x = x
  args$trim = TRUE
  replace_na(do.call(format, args), is.na(x))
}

replace_na = function(x, which = is.na(x), to = getOption('knitr.kable.NA')) {
  if (is.null(to)) return(x)
  x[which] = to
  x
}

kable_wo_label <- function (x, format, digits = getOption("digits"), row.names = NA, 
          col.names = NA, align, caption = NULL, format.args = list(), 
          escape = TRUE, ...) 
{
  if (missing(format) || is.null(format)) 
    format = getOption("knitr.table.format")
  if (is.null(format)) 
    format = if (is.null(pandoc_to())) 
      switch(out_format() %n% "markdown", latex = "latex", 
             listings = "latex", sweave = "latex", html = "html", 
             markdown = "markdown", rst = "rst", stop("table format not implemented yet!"))
  else if (isTRUE(opts_knit$get("kable.force.latex")) && 
           is_latex_output()) {
    "latex"
  }
  else "pandoc"
  if (is.function(format)) 
    format = format()
  if (format != "latex" && !missing(align) && length(align) == 
      1L) 
    align = strsplit(align, "")[[1]]
  # if (!is.null(caption) && !is.na(caption))
  #   caption = paste0(create_label("tab:", opts_current$get("label"),
  #                                 latex = (format == "latex")), caption)
  if (inherits(x, "list")) {
    if (format == "pandoc" && is_latex_output()) 
      format = "latex"
    res = lapply(x, kable, format = format, digits = digits, 
                 row.names = row.names, col.names = col.names, align = align, 
                 caption = NA, format.args = format.args, escape = escape, 
                 ...)
    res = unlist(lapply(res, paste, collapse = "\n"))
    res = if (format == "latex") {
      kable_latex_caption(res, caption)
    }
    else if (format == "html" || (format == "pandoc" && is_html_output())) 
      kable_html(matrix(paste0("\n\n", res, "\n\n"), 1), 
                 caption = caption, escape = FALSE, table.attr = "class=\"kable_wrapper\"")
    else {
      res = paste(res, collapse = "\n\n")
      if (format == "pandoc") 
        kable_pandoc_caption(res, caption)
      else res
    }
    return(structure(res, format = format, class = "knitr_kable"))
  }
  if (!is.matrix(x)) 
    x = as.data.frame(x)
  if (identical(col.names, NA)) 
    col.names = colnames(x)
  m = ncol(x)
  isn = if (is.matrix(x)) 
    rep(is.numeric(x), m)
  else sapply(x, is.numeric)
  if (missing(align) || (format == "latex" && is.null(align))) 
    align = ifelse(isn, "r", "l")
  digits = rep(digits, length.out = m)
  for (j in seq_len(m)) {
    if (is_numeric(x[, j])) 
      x[, j] = round(x[, j], digits[j])
  }
  if (any(isn)) {
    if (is.matrix(x)) {
      if (is.table(x) && length(dim(x)) == 2) 
        class(x) = "matrix"
      x = format_matrix(x, format.args)
    }
    else x[, isn] = format_args(x[, isn], format.args)
  }
  if (is.na(row.names)) 
    row.names = has_rownames(x)
  if (!is.null(align)) 
    align = rep(align, length.out = m)
  if (row.names) {
    x = cbind(` ` = rownames(x), x)
    if (!is.null(col.names)) 
      col.names = c(" ", col.names)
    if (!is.null(align)) 
      align = c("l", align)
  }
  n = nrow(x)
  x = replace_na(to_character(as.matrix(x)), is.na(x))
  if (!is.matrix(x)) 
    x = matrix(x, nrow = n)
  x = trimws(x)
  colnames(x) = col.names
  if (format != "latex" && length(align) && !all(align %in% 
                                                 c("l", "r", "c"))) 
    stop("'align' must be a character vector of possible values 'l', 'r', and 'c'")
  attr(x, "align") = align
  res = do.call(paste("kable", format, sep = "_"), list(x = x, 
                                                        caption = caption, escape = escape, ...))
  structure(res, format = format, class = "knitr_kable")
}
