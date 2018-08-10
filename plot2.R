##############################################################################
#
# FILE
#   plot2.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot2.png file.
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

baltimoraSsc<- summarySsc[summarySsc$fips=="24510",]
baltimoraEmiss <- aggregate(Emissions ~ year, baltimoraSsc,sum)

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
clrs <- c("blue", "yellow","red" ,"green" )
barplot(height=baltimoraEmiss$Emissions/1000, 
        names.arg=baltimoraEmiss$year,
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission in kilotons'),
        ylim=c(0,4),
        main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'),
        col=clrs)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()