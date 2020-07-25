import json
import subprocess
from datetime import datetime, timedelta, date
import time
import os
import re

def printCompanymac(myjson, key):
    if type(myjson) == str:
        #print("yes")
        myjson = json.loads(myjson)
        #print(type(myjson))
    if type(myjson) is dict:
        for jsonkey in myjson:
            if type(myjson[jsonkey]) in (list, dict):
                printCompanymac(myjson[jsonkey], key)
            elif jsonkey == key:
                return myjson[jsonkey].split("T")[0]
    elif type(myjson) is list:
        for item in myjson:
            if type(item) in (list, dict):
                printCompanymac(item, key)



def findNumberOfcreated(days : int, patterndate: str):
    path = os.path.abspath('metadata.json')
    with open(path) as f:
        data = json.loads(f.read())
        pattern='[12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])'
        Count = 0
        for json_inner_array in data:
            ObjectCreateDate=printCompanymac(json_inner_array, "creationTimestamp")
            datelimit = datetime.today() - timedelta(days=days)
            datelimit=str(datelimit.date())
            ObjectcreationDate=date(*(int(s) for s in ObjectCreateDate.split('-')))
            NumberofDaysBefore=date(*(int(s) for s in datelimit.split('-')))
            if ObjectcreationDate < NumberofDaysBefore and re.match(pattern, patterndate):
                Count += 1
            else:
                print("Please check the pattern of date should 'YYYY-MM-DD")
        print("Objects created before {} number of days and date was {} and count {} ".format(days, datelimit, Count))

findNumberOfcreated(7, "2020-12-12")



