** rename variables
rename PropertyCr~e PropCrime
rename TotalEstim~r Population
rename TotalEst~18y Population18b
rename Populati~18b under18
rename G childunder18
rename TotalEst~64y from18to64
rename TotalEstim~a above65
rename EstimateBe~ poorunder18
rename K poorunder18c
rename childunder18 under18c
rename L poor18to64
rename N poorabove65
rename poorunder18 poor
rename poorunder18c poorunder18
rename poor18to64 poorunder18c
rename M poor18to64
rename TotalEs~Male male
rename TotalEstim~e female
rename Percentbel~t poorperc
rename R poorunder18perc
rename poorunder18perc poorunder18p
rename poorperc poorp
rename S poorunder18cp
rename T poor18to64p
rename U poorabove65p

** Generate the demographics variables 
gen dstate = 1 if State == "Colorado"
replace dstate = 0 if missing(dstate)
replace poorp = poor/Population if missing(poorp)
replace poorunder18p = poorunder18/under18 if missing(poorunder18p)
replace poorunder18cp = poorunder18c/under18c if missing(poorunder18cp)
replace poorp = poorp*100 if poorp<2
replace poorunder18p = poorunder18p * 100 if poorunder18p < 2
replace poorunder18cp = poorunder18cp * 100 if poorunder18cp < 2
replace poor18to64p = poor18to64/from18to64*100 if missing(poor18to64p)
replace poorabove65p = poorabove65/above65*100 if missing(poorabove65p)
gen malep = male/Population*100
gen femalep = female/Population*100
gen d13 = 1 if Year >= 2013
replace d13 = 0 if missing(d13)
drop if missing(PropCrime)
drop if missing(Population)
gen under18p = under18/Population*100
gen under18cp = under18c/Population*100
gen from18to64p = from18to64/Population*100
gen above65p = above65/Population*100
gen crimerate = PropCrime/Population
replace crimerate=crimerate * 100
gen CountyFac = real(County)
encode County, generate(CountyFactor)

** Generate variables for maptile
gen county = 04003 if County == "Cochise"
replace county = 04005 if County == "Coconino"
replace county = 04013 if County == "Maricopa"
replace county = 04015 if County == "Mohave"
replace county = 04019 if County == "Pima"
replace county = 04021 if County == "Pinal"
replace county = 08001 if County == "Adams"
replace county = 08003 if County == "Alamosa"
replace county = 08005 if County == "Arapahoe"
replace county = 08009 if County == "Archuleta"
replace county = 08009 if County == "Baca"
replace county = 08007 if County == "Archuleta"
replace county = 08011 if County == "Bent"
replace county = 08013 if County == "Boulder"
replace county = 08014 if County == "Broomfield"
replace county = 08015 if County == "Chaffee"
replace county = 08017 if County == "Cheyenne"
replace county = 08019 if County == "Clear Creek"
replace county = 08021 if County == "Conejos"
replace county = 08023 if County == "Costilla"
replace county = 08025 if County == "Crowley"
replace county = 08027 if County == "Custer"
replace county = 08029 if County =="Delta"
replace county = 08031 if County == "Denver"
replace county = 08033 if County =="Dolores"
replace county = 08035 if County == "Douglas"
replace county = 08037 if County == "Eagle"
replace county = 08039 if County=="Elbert"
replace county = 08041 if County=="El Paso"
replace county = 08043 if County == "Fremont"
replace county = 08045 if County == "Garfield"
replace county = 08047 if County == "Gilpin"
replace county = 08049 if County == "Grand"
replace county = 08051 if County == "Gunnison"
replace county = 08053 if County == "Hinsdale"
replace county = 08055 if County =="Huerfano"
replace county = 08057 if County =="Jackson"
replace county = 08059 if County =="Jefferson"
replace county = 08061 if County == "Kiowa"
replace county = 08063 if County =="Lake"
replace county = 08065 if County =="La Plata"
replace county = 08067 if County == "La Plata"
 replace county = 08065 if County =="Lake"
 replace county = 08069 if County =="Larima"
replace county = 08069 if County =="Larimer"
replace county = 08071 if County == "Las Animas"
replace county = 08073 if County == "Lincoln"
replace county = 08075 if County == "Logan"
replace county = 08077 if County =="Mesa"
 replace county = 08079 if County =="Mineral"
replace county = 08081 if County =="Moffat"
replace county = 08083 if County =="Montezuma"
replace county = 08085 if County =="Montrose"
replace county = 08087 if County =="Morgan"
replace county = 08089 if County =="Otero"
replace county = 08091 if County =="Ouray"
replace county = 08093 if County =="Park"
replace county = 08095 if County =="Phillips"
replace county = 08097 if County =="Pitkin"
replace county = 08099 if County =="Prowers"
replace county = 08101 if County =="Pueblo"
replace county = 08103 if County =="Rio Blanco"
replace county = 08105 if County =="Rio Grande"
replace county = 08107 if County =="Routt"
replace county = 08109 if County =="Saguache"
replace county = 08111 if County =="San Juan"
replace county = 08113 if County =="San Miguel"
replace county = 08115 if County =="Sedgwick"
replace county = 08117 if County =="Summit"
replace county = 08119 if County =="Teller"
replace county = 08121 if County =="Washington"
replace county = 08123 if County =="Weld"
replace county = 04027 if County =="Yuma"
replace county = 04025 if County == "Yavapai"
rename State statename
rename County countyname
gen state = floor(county/1000)
rename county CountryReal
gen county=string(CountryReal)
replace county = "0"+county
replace county = "04027" if countyname == "Yuma"
drop CountryReal
replace state = 4 if countyname == "Yuma"
destring county, replace
replace crimerate = PropCrime/Population*100000

** Data Summary
outreg2 if (state == 8 & d13 == 1) using CountyYearSum4.xls, replace sum(detail) keep(crimerate under18p from18to64p above65p) eqkeep(N meanmin max p25 p50 p75 Var sd)
outreg2 if (state == 8 & d13 == 0) using CountyYearSum3.xls, replace sum(detail) keep(crimerate under18p from18to64p above65p) eqkeep(N meanmin max p25 p50 p75 Var sd)
outreg2 if (state == 4 & d13 == 1) using CountyYearSum2.xls, replace sum(detail) keep(crimerate under18p from18to64p above65p) eqkeep(N meanmin max p25 p50 p75 Var sd)
outreg2 if (state == 4 & d13 == 0) using CountyYearSum1.xls, replace sum(detail) keep(crimerate under18p from18to64p above65p) eqkeep(N meanmin max p25 p50 p75 Var sd)

** Draw Maps
maptile PropCrime if Year == 2013 & state == 4, mapif(state==4) geo(county2014) cutvalues(1000,2000,3000,5000,7000,10000)
maptile PropCrime if Year == 2018 & state == 4, mapif(state==4) geo(county2014) cutvalues(1000,2000,3000,5000,7000,10000)
maptile PropCrime if Year == 2013 & state == 8, mapif(state==8) geo(county2014) cutvalues(15,30,50,100,250,3000)
maptile PropCrime if Year == 2018 & state == 8, mapif(state==8) geo(county2014) cutvalues(15,30,50,100,250,3000)

** Regression without interaction
reg crimerate under18p from18to64p d13##dstate
outreg2 using olsresults.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p i.YearFactor d13##dstate
outreg2 using olsresults.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p i.CountyFactor d13##dstate
outreg2 using olsresults.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p i.YearFactor i.CountyFactor d13##dstate
outreg2 using olsresults.xls, e(r2_a F rss) stats(coef, tstat) excel

** Regression with interaction
reg crimerate under18p from18to64p under18pd from18to64pd d13##dstate
outreg2 using olsresults1.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p under18pd from18to64pd i.YearFactor d13##dstate
outreg2 using olsresults1.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p under18pd from18to64pd i.CountyFactor d13##dstate
outreg2 using olsresults1.xls, e(r2_a F rss) stats(coef, tstat) excel
reg crimerate under18p from18to64p under18pd from18to64pd i.YearFactor i.CountyFactor d13##dstate
outreg2 using olsresults1.xls, e(r2_a F rss) stats(coef, tstat) excel

** Residual Plot
reg crimerate under18p from18to64p i.YearFactor i.CountyFactor d13##dstate
rvfplot, mlabel(statename)
rvfplot, mlabel(countyname)
reg crimerate under18p from18to64p under18pd from18to64pd i.YearFactor i.CountyFactor d13##dstate
rvfplot, mlabel(statename)
rvfplot, mlabel(countyname)
