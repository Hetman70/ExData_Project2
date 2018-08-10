##############################################################################
#
# FILE
#   plot6.R
#
# OVERVIEW
#   Using data collected from the  
#   “ National Emissions Inventory (NEI)”, 
#   load the data, Subset the data, reconstruct the required plots, 
#   and outputting the resulting plot6.png file.
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

# Subset of the data which corresponds to vehicles
vehicles <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehiclesScc <- scc[vehicles,]$SCC
vehiclessummarySsc <- summarySsc[summarySsc$SCC %in% vehiclesScc,]

# Subset the vehicles data by each city's fip and add city name.
vehiclesBaltimoresummarySsc <- vehiclessummarySsc[vehiclessummarySsc$fips=="24510",]
vehiclesBaltimoresummarySsc$city <- "Baltimore City"
vehiclesLAsummarySsc <- vehiclessummarySsc[vehiclessummarySsc$fips=="06037",]
vehiclesLAsummarySsc$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothsummarySsc <- rbind(vehiclesBaltimoresummarySsc,vehiclesLAsummarySsc)

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 1
library(ggplot2)

ggp <- ggplot(bothsummarySsc, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        guides(fill=FALSE) + 
        theme_bw() +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot6.png", height = 480, width = 480)
dev.off()