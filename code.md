# Principles of project and code organization

Some principles

### No code duplication.

Inside a project, if you find yourself writing the same lines of code more than once, put the code inside a function and apply it do the data.

Instead of
```{r} 
proc1 = GRanges(seqnames = data1$chr, ranges = IRanges(start = data1$start, end = data1$end))
proc2 = GRanges(seqnames = data2$chr, ranges = IRanges(start = data2$start, end = data2$end))
```
do
```{r}
process <- function(data) {
gr = GRanges(seqnames = data$chr, ranges = IRanges(start = data$start, end = data$end))
}
proc1 = process(data1)
proc2 = process(data2)
```
Advantages are many, including
- you're sure both datasets are processed the same way.
- fixes to the pipeline are applied to both datasets.
- More readable.
- It is easy for a reader to see that the same pipeline has been applied to both datasets and also, it is easy for the reader to see how objects are changed in the code.

### Use standard containers

Use standard containers such as `GRanges` and `SummarizedExperiment` as much as possible.  When processing data in weird file formats (like various custom text files on the internet) put them into a common data container as soon as possible and then write a function operating on this data container.  It will make the code mode re-usuable, and facilitate uniform processing of similar data from different sources.  It is hard to avoid having code which is specific to a specific file, but try and minimize this code.

### Be quick to use project specific packages

Once you have more than 1 or 2 functions, usually it is nice to store them in a separate file.  But be quick to make this file into a project specific  R package.  You get versioning and better control of the project.  I tend to do this sooner, rather than later.

### We use .rda
Not `.Rda` or .`.RData` or some other variant. 

### In general, once object per rda file.

### Always use relative paths to refer to other files (see below)

### Never use setwd() in R code

Always use code like this

```{r}
extDir = "/somewhere/"
save(object1, file = file.path(extDir, "object1.rda")
```

### Principles for external data

All projects involve small data and big data. A big difference between small and big is whether we put it under version control or not.  On the Biostat cluster we have access to `/dcs01/hansen/hansen_lab1` where we can make project specific directories.  One the cluster, use a symbolic link to this directory to refer to it, using a relative path.

```{bash}
mkdir project1
cd project1
mkdir /dcs01/hansen/hansen_lab/project1
ln -s /dcs01/hansen/hansen_lab/project1 extdata
```

Now we can do things like

```{r} 
load("../extdata/object1.rda")
```

inside the `project1` git directory.  If you then find yourself needing access to this rda on your laptop, you just do

```{bash}
mkdir extdata
scp /dcs01/hansen/hansen_lab/project1/object1.rda extdata
```

and now you can use the exact same script on your laptop as on the cluster.  Bonus: I can do the same.

Note: we should look into `git annex`

### data.frames are the evil

I have been bitten by data.frames many times.  By bitten I specifically mean that I have had really serious bugs introduced.  This means I also do the following

1. Always use `stringsAsFactors=FALSE` in `read.table`, `data.frame` and `as.data.frame`.
2. NEVER have factors in data.frames.
3. ALWAYS check that you have integers, characters, numeric, not factors.
4. Big data.frames takes up much less space if you do `rownames(data)=NULL`

### GRanges are the good

We often have genomic intervals.  data.frames and BED files are bad because we always screw up indexing (BED files are 0-indexed and the intervals are always half-close, ie. the END coordinate is not considered part of the interval).  GRanges are consistent.  Use `rtracklayer::import` to read many genomic file formats.  It kind of sucks, but this function is aware of the different standards (but assumes that whoever created the file was following the standards).

GRanges support genome versions like `genome(gr) = "hg18`. And they support something new for chromsome naming conventions:
```{r}
seqlevelsStyle(gr) <- "UCSC"
```

## plotting and screen

There are several plotting backends for R.  The default on is X11, but that one breaks if you're in a screen session.  X11 is fastest, but ugliest.  The "cairo" backend is better:
```{r}
cairo_pdf()
cairo_png()
```
On a Mac you have
```{r} 
quartz(type = "pdf")
```

For ```pdf```, for plots that needs to be post-processed in Illustrator, use ```useDingbats=FALSE```.



