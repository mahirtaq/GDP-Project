
# Nic's working directory
#working_directory = "C:/Users/Nic/Documents/Studies/Stats 415/stats-415-project/data"
#Parth's working directory
#working_directory = "/Desktop/winter2019/stats415/stats-415-project/data"
working_directory = "C:/Users/mahir/Desktop/stats-415-project/data"
# xxx's working directory
# working_directory = "xxx's path/stats-415-project/data"

setwd(working_directory)

# imports
source("helper-functions.r")

# Read CSV into R
if (!exists("quality_of_government")) {
  print("Loading data")
  quality_of_government <- read.csv(file="quality-of-government.csv", header=TRUE, sep=",")
}

# check that data was read correctly
print(dim(quality_of_government))


# These are countries formed after 1970
countries_to_remove = c("South Sudan",
                        "Palau",
                        "Kazakhstan",
                        "Turkmenistan",
                        "Tajikistan",
                        "Kyrgyzstan",
                        "Moldova",
                        "Slovenia",
                        "Belarus",
                        "Namibia",
                        "Brunei",
                        "St Kitts and Nevis",
                        "Antigua and Barbuda",
                        "Belize",
                        "St Vincent and the Grenadines",
                        "St Lucia",
                        "Dominica",
                        "Tuvalu",
                        "Djibouti",
                        "Seychelles",
                        "Suriname",
                        "Angola",
                        "Papua New Guinea",
                        "Sao Tome and Principe",
                        "Comoros",
                        "Cape Verde",
                        "Mozambique",
                        "Grenada",
                        "Guinea-Bissau",
                        "Bahamas",
                        "Bahrain",
                        "United Arab Emirates",
                        "Qatar",
                        "Bangladesh",
                        "Fiji")

# Removing countries formed after 1970
quality_of_government = subset(quality_of_government, !(cname %in% countries_to_remove))

# Removing data before certain year
quality_of_government = subset(quality_of_government, year > 1980)

print("Dimension of data after removing countries and years")

dim(quality_of_government)


# save dataset after first step of preprocessing
save(quality_of_government, "quality-of-government-no-outlying-countries-years.csv")

# dealing with missing data test
quality_of_government_no_missing_wip = quality_of_government

quality_of_government_no_missing = quality_of_government_no_missing_wip
save(quality_of_government_no_missing_wip, "quality-of-government-no-outlying-countries-years-missing-data-dealt.csv")

#list of surveys to keep
surveys_to_keep = c(
  "^cname",
  "cname_year",
  "^year",
  "^aid_",
  "^bci_",
  "^fao_",
  "^fi_",
  "^gea_",
  "^gle_",
  "^gol_",
  "^hf_",
  "^ictd_",
  "^icrg_",
  "^mad_",
  "^p_",
  "^ciri_",
  "^diat_",
  "^dr_",
  "^ef_",
  "^eob_",
  "^pwt_",
  "^ross_",
  "^shec_"
)

var_names_to_keep = c()
for (survey_code in surveys_to_keep){
  indices = grep(survey_code, names(quality_of_government), value=TRUE)
  var_names_to_keep = append(var_names_to_keep, indices)
}

quality_of_government = subset(quality_of_government, select=var_names_to_keep)

print("Dimension of dataset after choosing columns")
dim(quality_of_government)

nrows = nrow(quality_of_government)
ncols = ncol(quality_of_government)

# Plotting missing data by rows
num_na_row = rep(0, nrows)
for(i in 1:nrows){
  num_na_row[i] = sum(is.na(quality_of_government[i,]))
}

percent_na_row = (num_na_row/ncols)*100
plot(seq(1,nrows),percent_na_row, xlab="rows", ylab="Percent of missing data")


# Plotting missing data by columns
num_na_col = rep(0, ncols)
for(i in 1:ncols){
  num_na_col[i] = sum(is.na(quality_of_government[,i]))
}
percent_na_col = (num_na_col/nrows)*100
plot(seq(1,ncols),percent_na_col, xlab="cols", ylab="Percent of missing data")

# Plotting percentage of missing data vs number p\of columns with that much data missing
zero_to_hundred = seq(1,100)
vars_included = rep(0,100)
for(i in 1:100){
  vars_included[i] = sum(percent_na_col < i)
}
names(quality_of_government)
#which(names(quality_of_government))
plot(vars_included, zero_to_hundred, ylab="Percent of Missing Data", xlab="Num variables with that less than that much missing data")

# Dropping uneeded gdp predictors
drops = c("gle_cgdpc", "gle_gdp", "gle_rgdpc", "pwt_rgdp", "pwt_slcgdp")
quality_of_government = subset(quality_of_government, select = -drops)

#quality_of_government$year = quality_of_government$year-2018
#write.csv(quality_of_government, file="post_processing.csv")

