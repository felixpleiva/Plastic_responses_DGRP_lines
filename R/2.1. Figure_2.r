# ------------------------------------------------------------------------------
# Data generated by F?lix P Leiva (e-mail: felixpleiva@gmail.com)
# Script created by F?lix P Leiva (e-mail: felixpleiva@gmail.com)
# ------------------------------------------------------------------------------
# When using the data or code from this manuscript, please cite it as:

#Leiva FP, Boerrigter JGJ & Verberk WCEP. (2022). The role of cell size in
#shaping responses to oxygen and temperature in fruit flies. Zenodo.
#https://doi.org/10.5281/zenodo.5949049.
#------------------------------------------------------------------------------
#Cleaning working space
rm(list=ls())
today<-format(Sys.Date(),"%Y%m%d")
# ------------------------------------------------------------------------------
# set the working directory to the folder containing this script:
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# check directory
getwd()
# ------------------------------------------------------------------------------
# #Libraries
library(lme4)
library(dplyr)
library(car)
library(visreg)
library(AICcmodavg)
library(nlme)
library(lattice)
library(tidyr)
library(broom)
# ------------------------------------------------------------------------------
# create a folder for the outputs produced by running this script (if it doesn't
# already exist)
if (!file.exists("../Outputs")) dir.create("../Outputs")
# '../' goes up one level from the current working directory, so this creates
# the 'Outputs' folder just outside the 'R' folder
# ------------------------------------------------------------------------------
# load data
dat<-read.csv("../Outputs/1.1.1. Data to fit the models.csv")
# ------------------------------------------------------------------------------
# See data structure and transform if necessary
str(dat)
dat$sex<-as.factor(dat$sex)
#-------------------------------------------------------------------------------
# Most informative models (Tables S1-S3, Supplementary information)
#-------------------------------------------------------------------------------
# fresh mass
m5<-lmer(fresh_mass_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

# wing area
w5<-lmer(wing_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

# cell area
c5<-lmer(cell_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

################################################################################
########                         FRESH MASS HYPOXIA           ##################
################################################################################
# Extract general and random intercepts for fresh mass model
m_int_25180     <- ranef(m5)$stock[1,1]# small
m_int_25182     <- ranef(m5)$stock[2,1]# small
m_int_28141     <- ranef(m5)$stock[4,1]# medium
m_int_28247     <- ranef(m5)$stock[6,1]# medium
m_int_28196     <- ranef(m5)$stock[5,1]# large
m_int_25203     <- ranef(m5)$stock[3,1]# large

# Extract slopes per predictor for fresh mass model
x <- c(17,25)
m5<-lmer(fresh_mass_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ylarge_a <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 10 + m_slope_sex + m_slope_temp_oxy * 10 * x)

m5<-lmer(fresh_mass_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ysmall_a <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 10 + m_slope_sex + m_slope_temp_oxy * 10 * x)

m5<-lmer(fresh_mass_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ymedium_a <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 10 + m_slope_sex + m_slope_temp_oxy * 10 * x)

# PLOT
m5<-lmer(fresh_mass_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_a<-visreg(m5,'temperature', by='cell_area_cat',cond = list(oxygen=10),
               print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)

################################################################################
########                         FRESH MASS NORMOXIA           ##################
################################################################################
# Extract general and random intercepts for fresh mass model
m_int_25180     <- ranef(m5)$stock[1,1]# small
m_int_25182     <- ranef(m5)$stock[2,1]# small
m_int_28141     <- ranef(m5)$stock[4,1]# medium
m_int_28247     <- ranef(m5)$stock[6,1]# medium
m_int_28196     <- ranef(m5)$stock[5,1]# large
m_int_25203     <- ranef(m5)$stock[3,1]# large

# Extract slopes per predictor for fresh mass model
x <- c(17,25)
m5<-lmer(fresh_mass_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ylarge_b <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 21 + m_slope_sex + m_slope_temp_oxy * 21 * x)

m5<-lmer(fresh_mass_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ysmall_b <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 21 + m_slope_sex + m_slope_temp_oxy * 21 * x)

m5<-lmer(fresh_mass_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
m_inter_general <- summary(m5)$coefficients[1, 1]
m_slope_temp     <- summary(m5)$coefficients[2, 1]
m_slope_oxy      <- summary(m5)$coefficients[3, 1]
m_slope_sex      <- summary(m5)$coefficients[6, 1]
m_slope_temp_oxy <- summary(m5)$coefficients[7, 1]
ymedium_b <- c(m_inter_general + m_slope_temp * x + m_slope_oxy * 21 + m_slope_sex + m_slope_temp_oxy * 21 * x)


# PLOT
m5<-lmer(fresh_mass_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_b<-visreg(m5,'temperature', by='cell_area_cat',cond = list(oxygen=21),
       print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)

################################################################################
########                        WING AREA HYPOXIA           ##################
################################################################################
# Extract random intercepts for wing area model
w_int_25180     <- ranef(w5)$stock[1,1]# small
w_int_25182     <- ranef(w5)$stock[2,1]# small
w_int_28141     <- ranef(w5)$stock[4,1]# medium
w_int_28247     <- ranef(w5)$stock[6,1]# medium
w_int_28196     <- ranef(w5)$stock[5,1]# large
w_int_25203     <- ranef(w5)$stock[3,1]# large

# Extract slopes per predictor for wing area model
x <- c(17,25)
w5<-lmer(wing_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
w_inter_general <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ylarge_c <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 10 + w_slope_sex + w_slope_temp_oxy * 10 * x)

w5<-lmer(wing_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
w_inter_general  <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ysmall_c <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 10 + w_slope_sex + w_slope_temp_oxy * 10 * x)

w5<-lmer(wing_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
w_inter_general <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ymedium_c <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 10 + w_slope_sex + w_slope_temp_oxy * 10 * x)

# PLOT

w5<-lmer(wing_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_c<-visreg(w5,'temperature', by='cell_area_cat',cond = list(oxygen=10),
               print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)
               
################################################################################
########                        WING AREA NORMOXIA           ##################
################################################################################
# Extract random intercepts for wing area model
w_int_25180     <- ranef(w5)$stock[1,1]# small
w_int_25182     <- ranef(w5)$stock[2,1]# small
w_int_28141     <- ranef(w5)$stock[4,1]# medium
w_int_28247     <- ranef(w5)$stock[6,1]# medium
w_int_28196     <- ranef(w5)$stock[5,1]# large
w_int_25203     <- ranef(w5)$stock[3,1]# large

# Extract slopes per predictor for wing area model
x <- c(17,25)
w5<-lmer(wing_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
w_inter_general  <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ylarge_d <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 21 + w_slope_sex + w_slope_temp_oxy * 21 * x)

w5<-lmer(wing_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
w_inter_general  <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ysmall_d <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 21 + w_slope_sex + w_slope_temp_oxy * 21 * x)

w5<-lmer(wing_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
w_inter_general  <- summary(w5)$coefficients[1, 1]
w_slope_temp     <- summary(w5)$coefficients[2, 1]
w_slope_oxy      <- summary(w5)$coefficients[3, 1]
w_slope_sex      <- summary(w5)$coefficients[6, 1]
w_slope_temp_oxy <- summary(w5)$coefficients[7, 1]
ymedium_d <- c(w_inter_general + w_slope_temp * x + w_slope_oxy * 21 + w_slope_sex + w_slope_temp_oxy * 21 * x)

# PLOT
# labels
labs= c("0.4","0.6","0.8","1.0","1.2")
xs= log10(c(0.4,0.6,0.8,1.0,1.2))

w5<-lmer(wing_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_d<-visreg(w5,'temperature', by='cell_area_cat',cond = list(oxygen=21),
               print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)

################################################################################
########                        CELL AREA HYPOXIA           ##################
################################################################################
# Extract random intercepts for cell area model
c_int_25180     <- ranef(c5)$stock[1,1]# small
c_int_25182     <- ranef(c5)$stock[2,1]# small
c_int_28141     <- ranef(c5)$stock[4,1]# medium
c_int_28247     <- ranef(c5)$stock[6,1]# medium
c_int_28196     <- ranef(c5)$stock[5,1]# large
c_int_25203     <- ranef(c5)$stock[3,1]# large

# Extract slopes per predictor for cell area model
x <- c(17,25)
c5<-lmer(cell_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
c_inter_general  <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ylarge_e <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 10 + c_slope_sex + c_slope_temp_oxy * 10 * x)

c5<-lmer(cell_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
c_inter_general  <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ysmall_e <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 10 + c_slope_sex + c_slope_temp_oxy * 10 * x)

c5<-lmer(cell_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
c_inter_general <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ymedium_e <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 10 + c_slope_sex + c_slope_temp_oxy * 10 * x)

# PLOT
c5<-lmer(cell_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_e<-visreg(c5,'temperature', by='cell_area_cat',cond = list(oxygen=10),
               print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)

################################################################################
########                        CELL AREA NORMOXIA           ##################
################################################################################
# Extract random intercepts for cell area model
c_int_25180     <- ranef(c5)$stock[1,1]# small
c_int_25182     <- ranef(c5)$stock[2,1]# small
c_int_28141     <- ranef(c5)$stock[4,1]# medium
c_int_28247     <- ranef(c5)$stock[6,1]# medium
c_int_28196     <- ranef(c5)$stock[5,1]# large
c_int_25203     <- ranef(c5)$stock[3,1]# large

# Extract slopes per predictor for cell area model
x <- c(17,25)
c5<-lmer(cell_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)
c_inter_general  <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ylarge_f <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 21 + c_slope_sex + c_slope_temp_oxy * 21 * x)

c5<-lmer(cell_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="small") +  sex + (1|stock), data=dat)
c_inter_general  <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ysmall_f <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 21 + c_slope_sex + c_slope_temp_oxy * 21 * x)

c5<-lmer(cell_area_log ~ temperature * oxygen * relevel(as.factor(cell_area_cat),ref="medium") +  sex + (1|stock), data=dat)
c_inter_general <- summary(c5)$coefficients[1, 1]
c_slope_temp     <- summary(c5)$coefficients[2, 1]
c_slope_oxy      <- summary(c5)$coefficients[3, 1]
c_slope_sex      <- summary(c5)$coefficients[6, 1]
c_slope_temp_oxy <- summary(c5)$coefficients[7, 1]
ymedium_f <- c(c_inter_general + c_slope_temp * x + c_slope_oxy * 21 + c_slope_sex + c_slope_temp_oxy * 21 * x)

# PLOT
c5<-lmer(cell_area_log ~ temperature * oxygen * cell_area_cat +  sex + (1|stock), data=dat)

plot_f<-visreg(c5,'temperature', by='cell_area_cat',cond = list(oxygen=21),
               print.cond=TRUE,overlay=TRUE,jitter=0.1,legend = FALSE)

# ------------------------------------------------------------------------------
# Figure 2
setwd("../Outputs/")
{
pdf("2.2.1. Figure 2.pdf",width = 7,height = 10,useDingbats = FALSE)
#png("2.2.1. Figure 2.png",width = 7,height = 10,units = "in",res = 600)
par(mfrow=c(3,2),tcl=-0.4, family="serif",omi=c(0,0,0,0.1))
#-------------------------------------------------------------------------------
par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_a$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"), 
     ylab="fresh mass (mg)",
     ylim=c(0.4,1.2),
     las = 1,
     xaxt="n",
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)

lines(x,(10^ylarge_a),col="#B8860B",lwd=4)
lines(x,(10^ymedium_a),col="#6495ED",lwd=4)
lines(x,(10^ysmall_a),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_a + m_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_a + m_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_a + m_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_a + m_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_a + m_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_a + m_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Hypoxia (10 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(a)"), cex=1.4,bty="n")
#-------------------------------------------------------------------------------
par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_b$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"), 
     ylab="fresh mass (mg)",
     ylim=c(0.4,1.2),
     las = 1,
     xaxt="n",
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)

lines(x,(10^ylarge_b),col="#B8860B",lwd=4)
lines(x,(10^ymedium_b),col="#6495ED",lwd=4)
lines(x,(10^ysmall_b),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_b + m_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_b + m_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_b + m_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_b + m_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_b + m_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_b + m_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Normoxia (21 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(b)"), cex=1.4,bty="n")
#-------------------------------------------------------------------------------
labs= c("5","7.5","10","12.5","15")
xs= c(500000,750000,1000000,1250000,1500000)

par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_c$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"),
     ylab=expression(paste("wing area (",mu, m^2,"× 100,000)")),
     ylim=c(500000,1500000),
     las = 1,
     xaxt="n",
     yaxt="n",
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)
axis(2, at=xs, labels=labs, cex.axis=1.2,las=1)

lines(x,(10^ylarge_c),col="#B8860B",lwd=4)
lines(x,(10^ymedium_c),col="#6495ED",lwd=4)
lines(x,(10^ysmall_c),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_c + w_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_c + w_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_c + w_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_c + w_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_c + w_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_c + w_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Hypoxia (10 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(c)"), cex=1.4,bty="n")
#-------------------------------------------------------------------------------
labs= c("5","7.5","10","12.5","15")
xs= c(500000,750000,1000000,1250000,1500000)

par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_d$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"), 
     ylab=expression(paste("wing area (",mu, m^2,"× 100,000)")),
     ylim=c(500000,1500000),
     las = 1,
     xaxt="n",
     yaxt="n",
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)
axis(2, at=xs, labels=labs, cex.axis=1.2,las=1)

lines(x,(10^ylarge_d),col="#B8860B",lwd=4)
lines(x,(10^ymedium_d),col="#6495ED",lwd=4)
lines(x,(10^ysmall_d),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_d + w_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_d + w_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_d + w_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_d + w_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_d + w_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_d + w_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Normoxia (21 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(d)"), cex=1.4,bty="n")
# ------------------------------------------------------------------------------
par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_e$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"), 
     ylab=expression(paste("cell area (",mu, m^2,")")),
     xaxt="n",
     ylim=c(80,220),
     las=1,
     xlim=c(14,28),
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)

lines(x,(10^ylarge_e),col="#B8860B",lwd=4)
lines(x,(10^ymedium_e),col="#6495ED",lwd=4)
lines(x,(10^ysmall_e),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_e + c_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_e + c_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_e + c_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_e + c_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_e + c_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_e + c_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Hypoxia (10 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(e)"), cex=1.4,bty="n")
#-------------------------------------------------------------------------------
par(mai=c(0.85,0.82,0,0))
plot(10^visregRes ~temperature,data=plot_f$res,
     pch=16,cex=1.5,col=c('#B8860B70','#6495ED70','#B2ABD270')[as.factor(cell_area_cat)],
     xlab=expression("temperature ("*~degree*C*")"), 
     ylab=expression(paste("cell area (",mu, m^2,")")),
     xaxt="n",
     ylim=c(80,220),
     las=1,
     xlim=c(14,28),
     cex.axis=1.2,cex.lab=1.4)

#update axis
axis(1,at=c(17,25), labels=c("17","25"),cex.axis=1.2)

lines(x,(10^ylarge_f),col="#B8860B",lwd=4)
lines(x,(10^ymedium_f),col="#6495ED",lwd=4)
lines(x,(10^ysmall_f),col="#B2ABD2",lwd=4)

lines(x,(10^(ylarge_f + c_int_28196)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ylarge_f + c_int_25203)), col='#B8860B50',lty=2,lwd=4) 
lines(x,(10^(ymedium_f + c_int_28141)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ymedium_f + c_int_28247)), col='#6495ED50',lty=2,lwd=4) 
lines(x,(10^(ysmall_f + c_int_25180)), col='#B2ABD250',lty=2,lwd=4) 
lines(x,(10^(ysmall_f + c_int_25182)), col='#B2ABD250',lty=2,lwd=4) 

# Add a legend
legend("top", legend=c("Normoxia (21 kPa)"), cex=1.4,bty="n")
legend("bottomleft", legend=c("large", "medium","small"),
       lty = c(1,1,1),lwd=3,bty="n",cex=1.2, 
       col=c('#B8860B', '#6495ED','#B2ABD2'))
legend("topleft", legend=c("(f)"), cex=1.4,bty="n")
# ------------------------------------------------------------------------------
dev.off()
}
# ------------------------------------------------------------------------------
# saving session information with all packages versions for reproducibility purposes
sink("../Outputs/2.1.1. Figure_2_R_session.txt")
sessionInfo()
sink()
################################################################################
############################ END OF SCRIPT #####################################
################################################################################