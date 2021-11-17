# This is the script for the course 
# Introduction to systematic searching and meta-analysis with R.

# Download packages
install.packages("metafor")
install.packages("readxl")

# Activate packages
library(metafor)
library(readxl)

# Import and view file. Remember to keep the script and excel files in the same folder and set working directory.
Shi_20 <- read_excel("Shi_20.xlsx")
View(Shi_20)

# Reference for the example study:
# Shi, Y., Ma, Y., MacLeod, J., & Yang, H. H. (2020). College students cognitive learning outcomes in flipped classroom instruction: 
# A meta-analysis of the empirical literature. Journal of Computers in Education, 7(1), 79-103. https://doi.org/10.1007/s40692-019-00142-8 

# Finding the effect sizes and their variances using the escalc function. 
# Use the slab argument to include study labels as part of the data frame, which is useful for plots.
Shi_20 <- escalc(measure="SMD", n1i=n1i, n2i=n2i, m1i=m1i, m2i=m2i, sd1i=sd1i, sd2i=sd2i, data = Shi_20, vtype = "UB", append = TRUE, slab=paste(authors, year, sep=", "))
View(Shi_20)

# Fitting a random effects meta-analysis model to the data using the rma function
res_Shi_20 <- rma.uni(yi, vi, data=Shi_20)
# Looking at the output
res_Shi_20

# Running a forest plot. 
# For a simple version without headings, the function 'forest(res_Sci_20)' is enough.
frpl_Shi_20 <- forest(res_Shi_20, at=(c(-2, 0, 2, 4, 7)), xlim=c(-6,9),
                      cex=.75, header="Author(s) and Year",
                      mlab="Summary estimate for a RE model") 


# Running a funnel plot
fupl_Shi_20 <- funnel(res_Shi_20)

# Meta-regression. 
reg_Shi_20 <- rma(yi, vi, mods = factor(method), data=Shi_20)
reg_Shi_20 <- rma(yi, vi, mods = ~ year, data=Shi_20)
reg_Shi_20
