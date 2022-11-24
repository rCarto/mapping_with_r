library(sf)
khm <- st_read("/home/tim/Téléchargements/khm_admbnda_adm2_gov_20181004/khm_admbnda_adm2_gov_20181004.shp")
plot(khm)
khm

dat <- read.csv("/home/tim/Téléchargements/khm_admpop_adm2_2016_v2.csv",sep = ",", dec = ",")
dat$M_TL <- dat$M_TL * 1000
dat$F_TL <- dat$F_TL * 1000
dat$T_TL <- dat$T_TL * 1000

names(khm)
khm <- merge(khm[,"ADM2_PCODE"], dat, by.x = "ADM2_PCODE", by.y= "ADM2_PCODE")

head(khm)

library(mapsf)
mf_map(khm)

library(rnaturalearth)
install.packages("crsuggest")
library(crssuggest)
cty <- ne_countries(scale = 10, returnclass = "sf")


?ne_admin1
ctry <- cty[cty$adm0_a3 %in% c("KHM", "THA", "VNM", "LAO"), ]

library(crsuggest)
khm <- st_transform(khm, 32648)
cty <- st_transform(cty, 32648)

mf_theme(bg = "lightblue")
mf_init(khm)
mf_map(ctry, border = NA, add =T)
mf_shadow(khm, add = T)
mf_map(khm, col = "beige", add =T, border  = "bisque3", lwd = .5)
mf_map(khm, "T_TL", "prop", inches = .2, col = "coral3")

khm$d <- 1000* 1000 * khm$T_TL / st_area(khm)



mf_theme(bg = "lightblue")
mf_init(khm)
mf_map(ctry, border = NA, add =T)
mf_shadow(khm, add = T)
mf_map(khm, "d", "choro", add = T)

hist(khm$d, breaks = 125)








library(sf)
khm <- st_read("/home/tim/Téléchargements/khm_admbnda_adm1_gov_20181004/khm_admbnda_adm1_gov_20181004.shp")
mf_map(khm)
dat <- read.csv("/home/tim/Téléchargements/khm_admpop_adm1_2021_v2.csv")
head(dat)

khm <- merge(khm[,"ADM1_PCODE"], dat, by.x = "ADM1_PCODE", by.y= "ADM1_PCODE")
khm <- st_transform(khm, 32648)

mf_theme(bg = "lightblue")
mf_init(khm)
mf_map(ctry, border = NA, add =T)
mf_shadow(khm, add = T)
mf_map(khm, col = "beige", add =T, border  = "bisque3", lwd = .5)
mf_map(khm, "T_TL", "prop", inches = .3, col = "coral")
khm$v <- 100 * (khm$T_80Plus+khm$T_75_79+khm$T_70_74)/ khm$T_TL
mf_map(khm, "v", "choro", breaks = "equal", add = T, border ="grey90", lwd = .5)

hist(khm$v, 10)
