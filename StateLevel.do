encode State, gen(state)
gen co = 1 if state == 2
replace co = 0 if missing(co)
gen coyear = co * Year
gen t = 0 if Year < 2013
reg CrimeRate state Year coy if t == 0
outreg2 using olsresultsstate.xls, e(r2_a F rss) stats(coef, tstat) excel