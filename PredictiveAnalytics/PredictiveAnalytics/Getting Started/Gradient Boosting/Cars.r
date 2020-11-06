# Copyright Syncfusion Inc. 2001 - 2016. All rights reserved.
# Use of this code is subject to the terms of our license.
# A copy of the current license can be obtained at any time by e-mailing
# licensing@syncfusion.com. Any infringement will be prosecuted under
# applicable laws. 


# If you are not familiar with R you can obtain a quick introduction by downloading
# R Succinctly for free from Syncfusion - http://www.syncfusion.com/resources/techportal/ebooks/rsuccinctly
# R Succinctly is also included with this installation and is available here
# Installed Drive :\Program Files (x86)\Syncfusion\Essential Studio\XX.X.X.XX\Infrastructure\EBooks\R_Succintly.pdf OF R Succinctly
# Uncomment below lines to install necessary packages if not installed already
#install.packages("gbm")
#install.packages("devtools")
#install.packages("rJava")
#install_github(repo = "jpmml/r2pmml")
# install.packages("caret")

# Load below packages
library(caret) # This package is specifically loaded for Cars dataset shipped within it.
library(devtools)
library(gbm)
library(rJava)
library(r2pmml)

# Here we directly load the cars dataset installed with the "caret" package.
data(cars)
# Omit rows with missing values
cars = na.omit(cars)

# Code below demonstrates loading the same dataset from a CSV file shipped with our installer.
# Please check installed samples (Data) location to set actual working directory 
# Uncomment below lines and comment out the code to read data from CSV file.
# setwd("C:/actual_data_location")
# cars= read.csv("Cars.csv")


# Divide dataset for training and test
trainData<-cars[1:643,]
testData<-cars[644:804,]

# Applying the GBM - laplace function to predict cens
cars_GBM =  gbm(Price~., data=trainData,distribution="laplace")

# Display the predicted results
# Predict "Price" column probability for test data set
carsTestProbabilities =predict.gbm(cars_GBM, newdata=testData, n.trees=100,type="response")
# Display predicted probabilities
carsTestProbabilities

# PMML generation
r2pmml(cars_GBM,"Cars.pmml")



# The code below is used for evaluation purpose. 
# The model is applied for original cars data set and predicted results are saved in "ROutput.csv"
# "ROutput.csv" file used for comparing the R results with PMML Evaluation engine results

# Load Original "cars" dataset from "caret" package
data(cars)
# Omit rows with missing values
carsOriginal = na.omit(cars)

# Applying GBM to entire dataset and save the results in a CSV file
carsEntireProbabilities = predict.gbm(cars_GBM,carsOriginal,n.trees=100,type="response")

# Save predicted value in a data frame
result = data.frame(carsEntireProbabilities)
names(result) = c("Predicted_RetailPrice")

# Write the results in a CSV file
write.csv(result,"ROutput.csv",quote=F)

