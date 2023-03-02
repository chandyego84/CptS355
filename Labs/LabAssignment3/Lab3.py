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
# Reformat data so that each key is a month, each value contains dict of county:new cases
def getMonthlyCases(data):
     newData = {}

     for (county, monthsCases) in data.items():
          for (month, case) in monthsCases.items():
               if month not in newData:
                    # initialize the dict value for that month
                    newData[month] = {}
               newData[month][county] = case

     return newData

from functools import reduce
## problem 3 mostCases 
# Find the month that had the max total number of new cases in all counties
# NOTE: Should NOT use loops/recursion but use map and reduce functions
     # also use getMonthlyCases in problem2
def mostCases(data):
    newData = getMonthlyCases(data)

    # get sum of cases for each month, such that each elem in list is (month, totalCases)
          # i.e. [for each month,values in dict => (month, sum(values))]
    monthSums = list(map(lambda monthVals: (monthVals[0], sum(map(lambda caseCount: caseCount, monthVals[1].values()))), newData.items()))
    # get the max cases
    maxMonth = reduce(lambda a, b: a if a[1] > b[1] else b, monthSums)
    
    return maxMonth

## problem 4a) searchDicts(L,k)
# Takes a list of dicts L and a key K as input
# Checks each dict in L starting from end list
# if k appears in a dict, the fxn returns the value for key k
     # if k appears in > 1 dictionary, it will return the one that it finds first (closer to end of list)
# EX.:
'''
L1 = [{"x":1,"y":True,"z":"found"},{"x":2},{"y":False}] 
     searchDicts(L1,"x") returns 2 
     searchDicts(L1,"y") returns False 
     searchDicts(L1,"z")  returns   "found" 
     searchDicts(L1,"t") returns None 
'''
def searchDicts(L, k):
     for i in range(len(L)-1, -1, -1):
          # traverse list in reverse order
          for (key, val) in L[i].items():
               if (k == key):
                    return val

     return None

## problem 4b) searchDicts2(L,k)

## problem 5 - getLongest

## problem 6 - apply2nextN 

if __name__ == '__main__':
     print("Chandler is the coolest g.\n")