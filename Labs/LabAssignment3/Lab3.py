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
# Takes a list of tuples (tL) and a key k as input
# Each tuple in the input list includes an integer index val and dict
# Index in each tuple represents a link to another tuple in the list
     # e.g., index 3 refers to 4th tuple
# Fxn: checks dict in each tuple in tL starting from end of list and following the
     # indexes specified in the tuples.
# EX.:
     # [(0,d0),(0,d1),(0,d2),(1,d3),(2,d4),(3,d5),(5,d6)]
     # the fxn will check dicts d6, d5, d3, d1, d0 in order => return the first value found for key k
          # if k can't be found in any dict => return None

# Function: return the value of first key that matches k (starting from end)
# :param currVal: if a k is found in that dict, this holds the corresponding val closest to front of list
# :param nex: holds the list index which will be searched in next recursive call
def searchDicts2Helper(L, k, nex):
     if (nex == 0):
          # we reached the end of the list (front of the list) OMG!!! WOW! ZOO WEE MAMA!
          if (k in L[nex][1].keys()):
               return L[nex][1][k]
          
          return None # could not find a matching key

     else:
          # not at front of list yet
          if (k in L[nex][1].keys()):
               return L[nex][1][k]
          return searchDicts2Helper(L, k, L[nex][0])

# Precondition: List is NOT empty
     # TODO: if it is empty, we can add an additional check
def searchDicts2(L, k):
     endListIndex = len(L) - 1
     return searchDicts2Helper(L, k, L[endListIndex][0])

#### OOPS I DID IT SO IT RETURNS NUMBER AT CLOSEST TO FRONT, NOT CLOSEST TO END ####
# :param currVal: if a k is found in that dict, this holds the corresponding val closest to front of list
# :param nex: holds the list index which will be searched in next recursive call
'''
def searchDicts2Helper(L, k, currVal, nex):
     if (nex == 0):
          # we reached the end of the list (front of the list) OMG!!! WOW! ZOO WEE MAMA!
          if (k in L[nex][1].keys()):
               currVal = L[nex][1][k]
          
          return currVal

     else:
          # not at front of list yet
          if (k in L[nex][1].keys()):
               currVal = L[nex][1][k]
          return searchDicts2Helper(L, k, currVal, L[nex][0])

def searchDicts2(L, k):
     endListIndex = len(L) - 1
     return searchDicts2Helper(L, k, None, L[endListIndex][0])
'''

### A ITERATIVE SOLUTION, OOPS ###
'''
     for i in range(len(L)-1, -1, -1):
          # traverse through list in reverse order
          if (k in L[i][1].keys()):
               return L[i][1][k]

          i = L[i][0] # change index to what tuple links to
     
     return None
'''           

## problem 5 - getLongest
# Takes arbitraryily nested list of strings (L) and returns longest string in L
# NOTE: Longest string can be found at any nesting level, so it should recursively
     # check all sublists
# Do not assume max depth for nesting
# If > 1 string with max length, return the one that appears earlier in list
# :param L: list or sublist
# :param currMax: current max length string in list
# :param nex: index in list
def getLongestHelper(L, currMax, nex):
     if (type(L[nex]) == list):
          # current element is another list (sublist)
          subListMax = getLongestHelper(L[nex], "", 0) # start from beginning of the sublist
          if (len(subListMax) > len(currMax)):
               currMax = subListMax

     if (nex == len(L)-1):
          # reached end of the list
          if (len(L[nex]) > len(currMax)):
               # found new max
               currMax = L[nex]

          return currMax

     else:
          if (len(L[nex]) > len(currMax)):
               # found newMax
               currMax = L[nex]
          return getLongestHelper(L, currMax, nex + 1)

# Precondition: List is NOT empty
     #TODO: if it is empty, we can add an additional check
def getLongest(L):
     startIndex = 0
     return getLongestHelper(L, "", startIndex)

## problem 6 - apply2nextN 

if __name__ == '__main__':
     L = ['hi', 'imy']
