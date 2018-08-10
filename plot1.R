##############################################################################
#
# FILE
#   plot1.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot1.png file.
#   See README.md for details.

# Antonio Avella

##############################################################################
# STEP 0A - Get data
##############################################################################

# load the data
rm(list = ls())
summarySsc <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

##############################################################################
# STEP 0B - Subsetdata
##############################################################################

totEmiss<- aggregate(Emissions ~ year, summarySsc, sum)

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
clrs <- c("blue", "yellow","red" ,"green" )
barplot(height=totEmiss$Emissions/1000000, 
        names.arg=totEmiss$year,
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission in megatons'),
        ylim=c(0,8),
        main=expression('Total PM'[2.5]*' emissions at various years in megatons'),
        col=clrs)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()