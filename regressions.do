cd "/Users/revekkagershovich/Documents/Filling_system/Academic/Taste-Based_Discrimination/1_data/2_intermediate"

import delimited "gss_no_normal_vignettes.csv", clear varnames(1)

* start with missing
gen vignette_cat = .

* adult vignettes: keep original codes
replace vignette_cat = vigversn if !missing(vigversn)

* child vignettes: shift codes by +100 so they are unique
replace vignette_cat = chldvig + 100 if missing(vigversn) & !missing(chldvig)

* check
tab vignette_cat

reg stigma_index i.race c.age i.degree i.sex i.year i.region i.vignette_cat, vce(robust)

esttab using "stigma_regression.tex", replace se star(* 0.10 ** 0.05 *** 0.01) label
