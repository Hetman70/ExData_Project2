##############################################################################
#
# FILE
#   plot5.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot5.png file.
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

vehicles <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehiclesScc <- scc[vehicles,]$SCC
vehiclessummarySsc <- summarySsc[summarySsc$SCC %in% vehiclesScc,]
baltimoreVehiclessummarySsc <- vehiclessummarySsc[vehiclessummarySsc$fips=="24510",]

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
library(ggplot2)

ggp <- ggplot(baltimoreVehiclessummarySsc,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="grey",width=0.75) +
        theme_bw() +  
        guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot5.png", height = 480, width = 480)
dev.off()