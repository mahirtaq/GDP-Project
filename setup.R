set.seed(420)

# run once not to make loading too slow
if (!exists("data") || !is.data.frame("data")) {
    data = read.csv(file="data/quality-of-government-final.csv", header=TRUE, sep=",")
    data = subset(data, select=c(-X, -cname)) # remove X
}

train_ids = sample(1:nrow(data), size = round(nrow(data)*0.8))

train_data = data[train_ids, ]
test_data = data[-train_ids, ]

RESPONSE_NAME = "gdp_percent_change"
