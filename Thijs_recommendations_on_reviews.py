#Importing all the libraries
import numpy as np
import csv as csv

#Reading all the data in the csv file, and making it ready to be used in further programming
with open ('Userreviews.csv') as data:
    readdata = csv.reader(data)
    header = next(readdata)
    data = list(readdata)

#When looking at the data is became clear that it is structured in eleven different catagories. The first being the
#most important ones. 0=Moviename, 1= metaScore, 2=Author, ...

#The total amount of reviews is calculated by the following code.
print ("The amount of reviews is:", len(data)-1)

#The data needs to be made smaller, because it is too much to process. It is brought down to 1000
movies = data[:][0]
for i in range (0,1000):
    movies = [data [i][0].split(";") for i in range (0,1000)]

#Making a list with all the movies called (X)
X = []
for i in range (0,1000):
    X += [movies[i][2]]

#Making a list of authors(2) with the same favorite movie called (Y)
Y = []
nameFfilm = "the-hitmans-bodyguard"
for i in range(0,1000):
    if movies[i][0] == nameFfilm:
        Y += [movies[i][2]]
    
#Making a list of other recommended movies of authors with the same favorite movie called (Z)
Z = []
for j in range (0,len(Y)):
    recfilm = Y[j]
    for i in range (0,1000):
        if movies[i][2] == recfilm:
            Z += [movies[i][0]]

#After defining Z, the list will be printed into a csv file
np.savetxt("RecommendationsOnReview.csv",
           Z, delimiter =", ", fmt ='% s')