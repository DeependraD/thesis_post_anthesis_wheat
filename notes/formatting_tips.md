`out.extra` chunk option, which can be used to shrink or expand an image loaded from a file by specifying `"scale= "`. Here we use the mathematical graph stored in the "subdivision.pdf" file.

```{r subd, results="asis", echo=FALSE, fig.cap="Subdiv. graph", out.extra="scale=0.75"}
include_graphics("figure/subdivision.pdf")
```

Here's how to rotate and enlarge figures using the `out.extra` chunk option.  (Currently this only works in the PDF version of the book.)

```{r subd2, results="asis", echo=FALSE, out.extra="angle=180, scale=1.1", fig.cap="A Larger Figure, Flipped Upside Down"}
include_graphics("figure/subdivision.pdf")
```

**Tips for Bibliographies**

- Like with thesis formatting, the sooner you start compiling your bibliography for something as large as thesis, the better. Typing in source after source is mind-numbing enough; do you really want to do it for hours on end in late April? Think of it as procrastination.
- The cite key (a citation's label) needs to be unique from the other entries.
- When you have more than one author or editor, you need to separate each author's name by the word "and" e.g. `Author = {Noble, Sam and Youngberg, Jessica},`.
- Bibliographies made using BibTeX (whether manually or using a manager) accept LaTeX markup, so you can italicize and add symbols as necessary.
- To force capitalization in an article title or where all lowercase is generally used, bracket the capital letter in curly braces.
