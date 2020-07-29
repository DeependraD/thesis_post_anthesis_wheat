# Latex source files for standalone compilation

## Point to the suitable pandoc build to use for conversion

```
cd /d path\to\where\the\standalone\source\files\are

# earlier versions of pandoc might produce errors, 
# so to use the newer builts provide full path to executables
# for example, I usually place different versions in 
# subdirectories of Rstudio\bin.

# choose an appropriate version wisely.
# path\to\where\the\standalone\source\files\are>"C:\Program Files\RStudio\bin\pandoc\pandoc_2.3\pandoc.exe" --version
```

## To `pdf`

```
pdflatex thesis.tex
```

## To `markdown` text

```
pandoc -s thesis.tex -o thesis_mark.text
```

## To `word` document

```
pandoc -s thesis.tex -o thesis_word.docx
```