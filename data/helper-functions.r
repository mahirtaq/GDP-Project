if (!exists("old_print")) {
    old_print = print
}

print = function(...) {
    # argg <- c(as.list(environment()), list(...))
    old_print(c(...))
}

save = function(data, file_name) {
    write.csv(data, file = file_name)
    print("Saved", file_name)
}

calculate_percent_changes = function(variable, years) {
    ## when a percent change cannot be calculated, leaves an NA there

    percent_changes = rep(NA, length(variable))
    for (i in 2:length(variable)) {
    # start in the second one bc calculating change
        if (years[i-1] == years[i] - 1 && 
            is.numeric(variable[i-1]) && is.numeric(variable[i])) {
            percent_changes[i] = (variable[i] - variable[i - 1])/(variable[i - 1]) * 100
        }
    }
    return(percent_changes)
}
