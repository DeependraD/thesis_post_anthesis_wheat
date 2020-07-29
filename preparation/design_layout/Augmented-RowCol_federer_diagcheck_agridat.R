require(agridat)
dat <- federer.diagcheck
# vignette(package = "agridat", topic = "agridat_examples")

# Show the layout in Federer 1998.
dat$check <- ifelse(dat$gen == "G121" | dat$gen=="G122", "C","N")
desplot(yield ~ col*row, dat, text=gen, show.key=FALSE,
        shorten='no', col=check, cex=.8, col.text=c("black","white"))

# My addition to get genotypes as numeric and enable ordering them.
splitted_gen <- strsplit(as.character(dat$gen), split = "G", fixed = FALSE)
gen_numbers <- vector()
for(i in 1:180) {
  gen_numbers[i] <- as.numeric(splitted_gen[[i]][2])
}
length(which(gen_numbers > 120))# Since number assignment for check varieties is above 120.

with(dat, by(gen, col, as.character))
with(dat, by(gen, row, as.character))
rm(i, gen_numbers, splitted_gen)
with(dat, length(unique(row)))
with(dat, length(unique(col)))

# Only to match SAS results
dat$row <- 16 - dat$row
dat=dat[order(dat$col, dat$row), ]

# Add row / column polynomials to the data.
# The scaling factors sqrt() are arbitrary, but used to match SAS
nr <- length(unique(dat$row))
nc <- length(unique(dat$col))
rpoly <- poly(dat$row, degree=10) * sqrt(nc)
cpoly <- poly(dat$col, degree=10) * sqrt(nr)
dat <- transform(dat,
                 c1 = cpoly[,1], c2 = cpoly[,2], c3 = cpoly[,3],
                 c4 = cpoly[,4], c6 = cpoly[,6], c8 = cpoly[,8],
                 r1 = rpoly[,1], r2 = rpoly[,2], r3 = rpoly[,3],
                 r4 = rpoly[,4], r8 = rpoly[,8], r10 = rpoly[,10])

dat$trtn <- ifelse(dat$gen == "G121" | dat$gen=="G122", dat$gen, "G999")
dat$new <- ifelse(dat$gen == "G121" | dat$gen=="G122", "N", "Y")
dat <- transform(dat, trtn=factor(trtn), new=factor(new))

m1 <- lm(yield ~ c1 + c2 + c3 + c4 + c6 + c8
         + r1 + r2 + r4 + r8 + r10
         + c1:r1 + c2:r1 + c3:r1 + gen, data = dat)
# To get Type III SS use the following
if(require(car)) {
  Anova(m1, type=3) # Matches PROC GLM output
}

# lmer
dat$one <- factor(rep(1, nrow(dat)))
library(lme4)
m2 <- lmer(yield ~ trtn + (0+r1|one) + (0+r2|one) + (0+r4|one) + (0+r8|one) + (0+r10|one)
           + (0+c1|one) + (0+c2|one) + (0+c3|one) + (0+c4|one) + (0+c6|one) + (0+c8|one)
           + (0+r1:c1|one) + (0+r1:c2|one) + (0+r1:c3|one) +(1|new:gen)
           , data = dat)
# Error: grouping factors must have > 1 sampled level
m2        # Matches variance comps from PROC MIXED
ranef(m2) # Matches random effects from PROC MIXED

## Not run: 
# asreml
m3 <- asreml(yield ~ -1 + trtn, data=dat,
             random = ~ r1 + r2 + r4 + r8 + r10 +
               c1 + c2 + c3 + c4 + c6 + c8 + r1:c1 + r1:c2 + r1:c3 + new:gen)
coef(m3)
summary(m3)$varcomp

## End(Not run)
