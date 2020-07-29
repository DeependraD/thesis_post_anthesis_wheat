# Getting the field book ready
setwd("/media/storage/Research_2016-17/Research _Disease Screening/DOE/Hans Peter Piepho")

# Initially a data frame with a variable naming the plots is created
dhakal_design_matrix <- data.frame(plot = seq(1:240))

# First we generate a list with factors assigned to the elements.
dhakalfactors <- list(row = 1:20, rowgroup = 1:5, col = 1:12, colgroup = 1:4)

# Use of fac.gen function from dae package
require("dae")

# This generates a design matrix with the design factors
dhakal_design_matrix <- data.frame(fac.gen(generate = dhakalfactors[c(1,3)], each = 1, times = 1, order = "standard"), rowgroup = fac.gen(generate = dhakalfactors[c(2,4)], each = 12, times = 1)$rowgroup, 
                                   colgroup = fac.gen(generate = dhakalfactors[c(2,4)], each = 3, times = 4)$colgroup)

trt <- as.factor(c(24L, 111L, 2L, 3L, 4L, 49L, 1L, 29L, 2L, 103L, 1L, 110L, 2L, 
  1L, 68L, 4L, 67L, 2L, 10L, 1L, 11L, 93L, 4L, 3L, 3L, 65L, 4L, 
  97L, 1L, 12L, 2L, 109L, 4L, 2L, 37L, 1L, 1L, 4L, 35L, 2L, 84L, 
  1L, 4L, 3L, 112L, 2L, 28L, 83L, 4L, 51L, 2L, 1L, 1L, 69L, 3L, 
  2L, 36L, 61L, 3L, 96L, 1L, 79L, 77L, 75L, 46L, 2L, 3L, 4L, 89L, 
  4L, 62L, 1L, 105L, 2L, 3L, 2L, 3L, 104L, 76L, 38L, 1L, 4L, 47L, 
  1L, 60L, 1L, 82L, 20L, 4L, 3L, 19L, 4L, 1L, 98L, 3L, 2L, 2L, 
  39L, 1L, 4L, 106L, 100L, 2L, 71L, 9L, 3L, 17L, 3L, 4L, 63L, 1L, 
  55L, 3L, 2L, 22L, 81L, 3L, 50L, 2L, 16L, 59L, 2L, 3L, 1L, 27L, 
  73L, 91L, 3L, 1L, 57L, 8L, 4L, 64L, 3L, 43L, 5L, 2L, 3L, 1L, 
  4L, 87L, 1L, 2L, 107L, 58L, 3L, 1L, 108L, 2L, 3L, 88L, 2L, 4L, 
  4L, 14L, 21L, 4L, 4L, 31L, 78L, 2L, 52L, 1L, 13L, 45L, 86L, 1L, 
  3L, 26L, 1L, 3L, 3L, 18L, 4L, 4L, 70L, 32L, 2L, 2L, 41L, 2L, 
  72L, 7L, 1L, 56L, 4L, 102L, 3L, 2L, 66L, 3L, 4L, 90L, 4L, 101L, 
  3L, 3L, 74L, 25L, 1L, 4L, 1L, 42L, 2L, 3L, 85L, 2L, 15L, 4L, 
  23L, 33L, 1L, 80L, 3L, 53L, 4L, 1L, 6L, 34L, 54L, 94L, 1L, 4L, 
  95L, 2L, 3L, 4L, 99L, 30L, 3L, 4L, 2L, 40L, 4L, 2L, 48L, 3L, 
  44L, 1L, 92L))

dhakal_design_matrix$trt <- trt

# To generate a cimmyt_ent variable representing actual laid out plots
dhakal_design_matrix$cimmyt_ent[dhakal_design_matrix$trt == 4] <- dhakal_design_matrix$trt[dhakal_design_matrix$trt == 4]
dhakal_design_matrix$cimmyt_ent[dhakal_design_matrix$trt == 3] <- dhakal_design_matrix$trt[dhakal_design_matrix$trt == 3]
dhakal_design_matrix$cimmyt_ent[dhakal_design_matrix$trt == 2] <- dhakal_design_matrix$trt[dhakal_design_matrix$trt == 2]
dhakal_design_matrix$cimmyt_ent[dhakal_design_matrix$trt == 1] <- dhakal_design_matrix$trt[dhakal_design_matrix$trt == 1]

rm(trt, dhakalfactors)


# Read the saved csv file to load the latest data
dir()
dhakal_field_entered <- read.csv("dhakal_field_entered2.csv", header = TRUE, sep = ",")

# To see if any element of cimmyt_ent is NA:
which(is.na(as.factor(dhakal_field$cimmyt_ent)))
summary(as.factor(dhakal_field_entered$cimmyt_ent))

dhakal_field_entered$cimmyt_ent[dhakal_field_entered$ent_remark == "Line"]

# Subsetting which cimmyt_ent are doubtful and lines we get the following treatments.
ex_cimmyt_ent[which(dhakal2$ent_remark == "Doubt")]


ex_cimmyt_ent[which(dhakal2$ent_remark == "Line")]
# Combining both,
ex_cimmyt_ent[which(dhakal2$ent_remark == "Doubt" | dhakal2$ent_remark == "Line")]

# However, this gives a different result???
ex_cimmyt_ent[which(dhakal2$ent_remark == c("Line", "Doubt"))]

# Let's use a ifelse function to show new name, with "L" attached to the number before the entry cimmyt_ent 
Linestated <- ifelse(dhakal2$ent_remark == "Line", yes = paste("L", dhakal2$cimmyt_ent, sep = ""), no = dhakal2$cimmyt_ent)
Linestated1 <- ifelse(dhakal2$cimmyt_ent >= 5 , yes = paste("L", dhakal2$cimmyt_ent, sep = ""), no = Linestated)

summary(as.factor(Linestated1), maxsum = 150)


# As a part of data correction
???

# After performing the data operations write to a csv file with:
write.csv(dhakal_field_entered, file = "dhakal_field_entered2.csv", na = "", row.names = FALSE)
