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
### try using no higher-order functions?????!!! :(
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
# Description: Define a fxn merge_logs which takes a list of course log dicts
# returns: dict which includes the combined logs for each class
     # i.e., logs of each class should be merged to a single dict
     # NOTE: should use combine_dict defind above
'''
EX.:
log_list = [{'CptS355':{'Mon':3,'Wed':2,'Sat':2},'CptS360':{'Mon':3,'Tue':2,'Wed':2,'Fri':10},   
             'CptS321':{'Tue':2,'Wed':2,'Thu':3},'CptS322':{'Tue':1,'Thu':5,'Sat':2}}, 
            {'CptS322':{'Mon':2},'CptS360':{'Thu':2, 'Fri':5},'CptS321':{'Mon':1,'Sat':3}}, 
            {'CptS355':{'Sun':8},'CptS360':{'Fri':5},'CptS321':{'Mon':4},'CptS322':{'Sat':3}}] 
'''
# returns:
'''
{'CptS355': {'Mon': 3, 'Wed': 2, 'Sat': 2, 'Sun': 8},  
 'CptS360': {'Mon': 3, 'Tue': 2, 'Wed': 2, 'Fri': 20, 'Thu': 2},  
 'CptS321': {'Tue': 2, 'Wed': 2, 'Thu': 3, 'Mon': 5, 'Sat': 3},  
 'CptS322': {'Tue': 1, 'Thu': 5, 'Sat': 5, 'Mon': 2}} 
'''
def merge_logs(logList):     
     mergedLogs = {}

     for log in logList:
          for course in log.keys():
               if (course in mergedLogs):
                    # course already exist in mergedLogs => update the mergedLogs[course]
                    mergedLogs[course] = combine_dict(log[course], mergedLogs[course])     
               else:
                    mergedLogs[course] = log[course].copy() # deep copy
                    ###print(f"id1: {id(mergedLogs[course])}, id2: {id(log[course])}") 

     return mergedLogs

## problem 2(a) - most_hours – 15%
# Descroption: Consider combined log output from above. Assume you want to find the course
     # with max total study time.
# FXN: takes log_input data as input
     # returns: course having the max total hours
# EX.:
     '''
     log_input = {'CptS355': {'Mon': 3, 'Wed': 2, 'Sat': 2, 'Sun': 8},  
             'CptS360': {'Mon': 3, 'Tue': 2, 'Wed': 2, 'Fri': 20, 'Thu': 2},  
             'CptS321': {'Tue': 2, 'Wed': 2, 'Thu': 3, 'Mon': 5, 'Sat': 3},  
             'CptS322': {'Tue': 1, 'Thu': 5, 'Sat': 5, 'Mon': 2}} 
     '''
     # returns: ('CptS360', 29)
#NOTE: should NOT use loops/recursion but use map, reduce, and/or filter funcitons

def most_hours(log):
     mostHours = reduce(lambda a, b: a if a[1] > b[1] else b,
                    map(lambda course: (course, reduce(lambda a, b: a + b, log.get(course).values())), # tuple: (course, sum course hours)
                              filter(lambda course: bool(log.get(course)), log))) # get courses that have hours from log
     '''
     ### USING FOR LOOP ###
     mostHours = (None, 0)
     for course in log:
          courseSum = reduce(lambda a,b: a+b, log.get(course).values()) # sum course hours
          if (courseSum > mostHours[1]):
               mostHours = (course, courseSum)
     '''
     
     return mostHours

## problem 2(b) - filter_log – 15%
# Consider the log input in problem 1a; Want to find courses that you study for on a particular day of week
     # for more than some number of hours
# Takes log_input data as input
     # returns: courses that has the given day in its log with >= required number of hours
# EX.:
'''
log_input = {'CptS355': {'Mon': 3, 'Wed': 2, 'Sat': 2, 'Sun': 8},  
             'CptS360': {'Mon': 3, 'Tue': 2, 'Wed': 2, 'Fri': 20, 'Thu': 2},  
             'CptS321': {'Tue': 2, 'Wed': 2, 'Thu': 3, 'Mon': 5, 'Sat': 3},  
             'CptS322': {'Tue': 1, 'Thu': 5, 'Sat': 5, 'Mon': 2}} 
'''
     # returns: ['CptS355', 'CptS360', 'CptS321']
#NOTE: should not use loops/recursion. Use map/reduce/filter

def filter_log(log, day, hours):
     return None

## problem 3 - graph_cycle – 12% 


## problem 4 - filter_iter – 15% 


## problem 5 - merge – 10% 

if __name__ == '__main__':
     log_input = {'CptS355': {'Mon': 3, 'Wed': 2, 'Sat': 2, 'Sun': 8},  
          'CptS360': {'Mon': 3, 'Tue': 2, 'Wed': 2, 'Fri': 20, 'Thu': 2},  
          'CptS321': {'Tue': 2, 'Wed': 2, 'Thu': 3, 'Mon': 5, 'Sat': 3},  
          'CptS322': {'Tue': 1, 'Thu': 5, 'Sat': 5, 'Mon': 2}} 

     print(most_hours(log_input))