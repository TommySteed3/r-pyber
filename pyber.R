setwd("C:/UCI/finalhw")


ride.data <- read.csv("ride_data.csv")
city.data <- read.csv("city_data.csv")


total.fares <- aggregate(ride.data$fare, by=list(Category=ride.data$city), FUN=sum)
fare.count  <- as.data.frame(table(ride.data$city))

names(total.fares)[1]<-"city"
names(total.fares)[2]<-"sum"
names(fare.count)[1]<-"city"

merged <- merge(total.fares,fare.count)
merged <- merge(merged, city.data)


merged$average.fare <- merged$sum/merged$Freq

g <- ggplot(merged, aes(x=merged$Freq, y=merged$average.fare))
g + geom_point(aes(color=merged$type),size=merged$driver_count/6) + geom_text(aes(label=merged$city), size=3) + theme(legend.position="none")
