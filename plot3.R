##############################################################################
#
# FILE
#   plot3.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot3.png file.
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

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
library(ggplot2)
ggp <- ggplot(baltimoraSsc,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        theme_bw() + 
        guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free") +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(ggp)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot3.png", height = 480, width = 640)
dev.off()