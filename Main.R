############################################################################################
# 1. 
############################################################################################

# Loading the airqulaity data
library(datasets)
data(airquality)
str(airquality)
# Copy the dataset to a new data.frame, removing rows containing NA values
d.rm.na <- na.omit(as.data.frame(airquality))
str(d)

############################################################################################
# 2.1
############################################################################################

# Select only numerical values
library(dplyr)
d.stat <- select(d.rm.na, Ozone, Solar.R, Temp, Wind)

# Calculating statistical measures 
# Trial, extra statistics
summary(d.stat)

# 
#ozone.mean <- mean(airquality$Ozone, airquality$Solar.R, trim = 0, na.rm = TRUE)
#solar.mean <- mean(airquality$Solar.R, trim = 0, na.rm = TRUE)
means <- apply(d.stat, 2, mean)
medians <- apply(d.stat, 2, median)
stds <- apply(d.stat, 2, sd)
vars <- apply(d.stat, 2, var)

###########################################################################################
# 2.2 
###########################################################################################

# Plot Ozone versus Temp (linear regression fit)
library(ggplot2)
qplot(Temp, Ozone, data=d.rm.na, geom=c("point", "smooth"))

# Plot Ozone versus Wind (linear regression fit)
library(ggplot2)
qplot(Wind, Ozone, data=d.rm.na, geom=c("point", "smooth"))

d <- d.rm.na
# Create a new Date column from Month and Day, using "1973" as the year 
d$Date <- as.Date(paste("1973", d$Month, d$Day, sep="-"), "%Y-%m-%d")

# Select only Temp, Ozone, and Date
library(dplyr)
d <- select(d, Temp, Ozone, Date)

# Reshape into long format
library(reshape2)
d <- melt(d, id="Date")

# Plot Temp and Ozone in time series with loess regression curves
ggplot(d, aes(x=Date, y=value, colour=variable, group=variable)) +
  geom_point(aes(y=value, colour=variable)) + geom_smooth(method="loess")

########################################################################################
# 3
########################################################################################

# Loading data for step 3
library(dplyr)
d.for.3 <- select(d.rm.na, Ozone, Solar.R, Temp, Wind)

#plot(density(d.for.3$Ozone))

# Create a sample of 153 numbers which are normally distributed.

norm.distrib <- rnorm(111)

#plot(density(norm.distrib))

# Plot the density of normally distributed data and Ozone, Radiation, Temperature and Wind

par(mfrow=c(2,4))
plot(density(norm.distrib), main = "Normal")
plot(density(d.for.3$Ozone), main = "Ozone")
plot(density(d.for.3$Solar.R), main = "Radiation")
plot(density(d.for.3$Temp), main = "Temerature")
plot(density(d.for.3$Wind), main = "Wind")

# qq-plots

par(mfrow=c(2,5))
qqnorm(norm.distrib, main = "Normal Distribution")
qqnorm(d.for.3$Ozone, main = "Ozone")
qqnorm(d.for.3$Solar.R, main = "Radiation")
qqnorm(d.for.3$Temp, main = "Temperature")
qqnorm(d.for.3$Wind, main = "Wind")

# Check normalisation/shapiro test

#shapiro.test(d.for.3$Ozone)
#shapiro.test(d.for.3$Solar.R)
#shapiro.test(d.for.3$Temp)
#shapiro.test(d.for.3$Wind)

########################################################################################
# 4.
########################################################################################

# 4.1 Linear regression, Least Squares Method on Ozone vs Solar Radiation

Y<- d.rm.na[,"Ozone"] # select Target attribute
X<- d.rm.na[,"Solar.R"] # select Predictor attribute

model1<- lm(Y~X)
model1 # provides regression line coefficients i.e. slope and y-intercept

par(mfrow=c(2,2))
plot((Y~X), main="Ozone vs Solar Radiation") # scatter plot between X and Y
abline(model1, col="blue", lwd=3) # add regression line to scatter plot to see relationship between X and Y

# 4.2 Linear regression, Least Squares Method on Ozone vs Wind Radiation

Y<- d.rm.na[,"Ozone"] # select Target attribute
X<- d.rm.na[,"Wind"] # select Predictor attribute

model2<- lm(Y~X)
model2 # provides regression line coefficients i.e. slope and y-intercept

plot((Y~X), main="Ozone vs Wind") # scatter plot between X and Y
abline(model2, col="blue", lwd=3) # add regression line to scatter plot to see relationship between X and Y


###########################################################################################
# 5
###########################################################################################

# To run shiny, go to user interface (ui.r) and run it from there by pressing run program button in R-Studio.
