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
## problem 4b) searchDicts2(L,k)

## problem 5 - getLongest

## problem 6 - apply2nextN 

if __name__ == '__main__':
    print(mostCases({ 'King':{'Mar':2706,'Apr':3620,'May':1860,'Jun':2157,'July':5014,'Aug':4327,'Sep':2843},
            'Pierce':{'Mar':460,'Apr':965,'May':522,'Jun':647,'July':2470,'Aug':1776,'Sep':1266}, 
            'Snohomish':{'Mar':1301,'Apr':1145,'May':532,'Jun':568,'July':1540,'Aug':1134,'Sep':811}, 
            'Spokane':{'Mar':147,'Apr':222,'May':233,'Jun':794,'July':2412,'Aug':1530,'Sep':1751}, 
            'Whitman' : {'Apr':7,'May':5,'Jun':19,'July':51,'Aug':514,'Sep':732, 'Oct':278} }))
