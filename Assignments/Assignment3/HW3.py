# CptS 355 - Spring 2023 - Assignment 3 - Python

# Please include your name and the names of the students with whom you discussed any of the problems in this homework
# Name:
# Collaborators: 

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

from functools import reduce

## problem 1(a) - aggregate_log  - 5%
# Description: want to keep track of number of hours you study for each course daily (dictionary)
# keys are course numbers, values are dictionaries which include number of hours you studied on particular day of week
# FXN: adds up number of hours you studied on each day of week
# returns summed values as dictionary
# EX.:
'''
log_input = {'CptS355':{'Mon':3,'Wed':2,'Sat':2}, 
             'CptS360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10}, 
             'CptS321':{'Tue':2,'Wed':2,'Thu':3}, 
             'CptS322':{'Tue':1,'Thu':5,'Sat':2}}  
'''
# {'Fri': 10, 'Mon': 6, 'Sat': 4, 'Thu': 8, 'Tue': 5, 'Wed': 6} 
# NOTE: should not change input dict value, should not hardcode keys/value
### using no higher-order functions :(
def aggregate_log(logInput):
     dayCountDict = {}

     for (course, days) in logInput.items():
          for (day, hours) in days.items():
               if (day not in dayCountDict):
                    dayCountDict[day] = hours
               else:
                    dayCountDict[day] += hours
     
     return dayCountDict

## problem 1(b) - combine_dict– 6%
# Description: combines two given study logs
# returns: merged dictionary
     # values of common keys should be summed
# EX.:
'''
log1 = {'Mon':3,'Wed':2,'Sat':2} 
log2 = {'Mon':3,'Tue':2,'Wed':2,'Fri':10} 
combine_dict(log1,log2)  
'''
# returns: {'Mon': 6, 'Wed': 4, 'Sat': 2, 'Tue': 2, 'Fri': 10}
def combine_dict(log1, log2):
     combinedDict = {}

     for day, hour in log1.items():
          # if key not found (not initialized in combinedDict) => init day to 0
          combinedDict[day] = combinedDict.get(day, 0) + hour

     for day, hour in log2.items():
          #  if key not found (not initialized in combinedDict) => init day to 0
          combinedDict[day] = combinedDict.get(day, 0) + hour
     
     return combinedDict

## problem 1(c) - merge_logs– 12%


## problem 2(a) - most_hours – 15%


## problem 2(b) - filter_log – 15%


## problem 3 - graph_cycle – 12% 


## problem 4 - filter_iter – 15% 


## problem 5 - merge – 10% 

if __name__ == '__main__':
     log1 = {'Mon':3,'Wed':2,'Sat':2} 
     log2 = {'Mon':3,'Tue':2,'Wed':2,'Fri':10} 
     print(combine_dict(log1,log2))
