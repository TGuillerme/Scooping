# Data input
dryad_data_2015 <- read.csv("../Data/Dryad_annual_stats_2015.csv", stringsAsFactors = FALSE)

# 1 - Get the data publication date.
system()

# 2 - Get the paper publication date.
# 3 - Get the number of data citations.
# 4 - Get the date for first citation for the data.
# 5 - Compare the first data citation date with the publication date.

# 5.1 - What is the occurrence of data cited before the associated DOI?
# 5.1.1 - Of those, which are not written by the authors in the paper associated with the data? <- proportion of scooped datasets
# 5.2 - Is there a difference in number of downloads/citations for datasets published before associated data published?



# For Figshare, use rfigshare package. see ?fs_details()
# https://github.com/ropensci/rfigshare/blob/master/inst/examples/tutorial.Rmd