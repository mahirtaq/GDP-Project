
source("setup.R")

library(gam)



# predictor_names = names(data)
# predictor_names = subset(predictor_names, subset=predictor_names != RESPONSE_NAME)

predictor_names = c("pwt_shhc", "pwt_gc", "pwt_rt", "ictd_taxinc", "ictd_taxindirect", "bci_bcistd", "ef_for", "year", "pwt_ple", "pwt_sgcf", "ictd_nontax", "aid_crnc",
                    "ictd_taxinsc", "ictd_taxexsc", "aid_crsc", "pwt_me", "ictd_taxnresinsc", "pwt_pli", "ictd_taxnresexsc", "ross_oil_netexpc", "ross_gas_price", "pwt_plgc",
                    "dr_eg", "ross_oil_price", "fi_index", "pwt_xr", "shec_se", "pwt_tfp", "ictd_revexsc")


smooth_spline_predictors_string = paste(RESPONSE_NAME, " ~ ", sep="") # s(aid_cpnc, 2.5)"

# df = 100
df = 4
for (name in predictor_names) {
    smooth_spline_predictors_string = paste(smooth_spline_predictors_string, "s(", name, ", ", df, ") + ", sep="")
}

smooth_spline_predictors_string = substr(smooth_spline_predictors_string, 1, nchar(smooth_spline_predictors_string) - 3)

gam_fitted = gam(as.formula(smooth_spline_predictors_string), data=train_data)

# par(mfrow=c(1,3))

# plot(gam_fitted, col="blue")



