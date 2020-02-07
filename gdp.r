
# run once not to make loading too slow
if (!exists("data") || is.function(data)) {
    data = read.csv(file="data/quality-of-government-no-outlying-countries-years.csv", header=TRUE, sep=",")
}

## interesting data names:
# gdp:
# - mad_gdppc Real GDP per Capita ***RESPONSE***
#       Real GDP per capita in 2011 US dollars; multiple benchmarks; includes data from 1946-2016
# - mad_gdppc1900 Real GDP per Capita (year 1900) US dolar 2011
#     Our response variable only includes observations from 1946-2016, so it is useful to have more data for gdp for the countries that existed in 1900
# - gle_cgdpc   *** don't keep, redundant and less data points than mad_gdppc. ***
# - gle_gdp     *** don't keep, less data points (only to year 2000) and contains interpolated data ***
# - gle_rgdpc   *** don't keep, less data points ***
# - pwt_rgdp    *** don't keep, less data, real gdp at constant 2011 national prices ***
# - pwt_slcgdp  *** don't keep, share of labour compensation in GDP at current national ***

train_ids = sample(1:nrow(data), size = round(nrow(data)*0.8))

train_data = data[train_ids, ]
test_data = data[-train_ids, ]

linear_regression_model = lm(mad_gdppc ~ . - cname - cname_year - cname_year.1, data = train_data)

train_predictions = predict.lm(
  linear_regression_model, train_data)
test_predictions = predict.lm(
  linear_regression_model, test_data)

train_error_mse = mean(
  (train_predictions - train_data$mad_gdppc)^2)
test_error_mse = mean(
  (test_predictions - test_data$mad_gdppc)^2)
