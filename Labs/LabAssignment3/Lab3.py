# CptS 355 - Spring 2023 - Lab 3
# Chandler Juego

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

## problem 1 getNumCases 
# Description: Having a datasset which reports monthly new COVID cases in 2020.
     # The keys of the dict are county names, the values are dicts which include
     # the monthly new COVID cases.
     # NOTE: Some counties may not have new cases in some months.
# FXN: Calculates number of new cases for a given list of counties
# during a given list of months.

def getNumCases(data, counties, months):
     newCases = 0
     for county in counties:
          # check each county's data
          for month in months:
               newCases += data[county][month]

     return newCases


## problem 2 getMonthlyCases

from functools import reduce
## problem 3 mostCases 

## problem 4a) searchDicts(L,k)
## problem 4b) searchDicts2(L,k)

## problem 5 - getLongest

## problem 6 - apply2nextN 