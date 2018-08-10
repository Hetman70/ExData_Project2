##############################################################################
#
# FILE
#   plot4.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot4.png file.
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

combRelated <- grepl("comb", scc$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", scc$SCC.Level.Four, ignore.case=TRUE) 
coalComb <- (combRelated & coalRelated)
combScc <- scc[coalComb,]$SCC
combSummSsc <- summarySsc[summarySsc$SCC %in% combScc,]

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
library(ggplot2)

ggp <- ggplot(combSummSsc,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="green",width=0.75) +
        theme_bw() +  
        guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot4.png", height = 480, width = 640)
dev.off()