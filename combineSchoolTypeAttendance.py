#!/usr/bin/env python3
import gzip

schoolType = gzip.open("School_by_type.gz","rt") #get school type
schoolAttendance = gzip.open("2015-2019_Daily_Attendance.gz","rt") #get school attendance
combineResult = gzip.open("2015-2019_Daily_Attendance+type.gz","wt") #the result file

linet = schoolType.readline() 
linea = schoolAttendance.readline()
nameTypeDict = {}

count = 0
#puts the name of the school as keys of a dictionary
#and then puts the type of school (L, M, H, or whatever combination it is) as the value of the dictionary
while linet:
    if count > 0:
        fieldst = linet.split("|")
        name = fieldst[0]
        typ = fieldst[1].strip()
        if name not in nameTypeDict:
            nameTypeDict[name] = typ  
    else:
        count += 1
            
    linet = schoolType.readline()

schoolType.close()

#then the value of the school name in the dictionary is accessed here, so that the
#school type can be concatenated together with the school name and that will get printed out in the combined result write file
count = 0
while linea:
    if count > 0:
        fieldsa = linea.split("|")
    
        sname = fieldsa[0]
        if sname in nameTypeDict.keys():
            stype = nameTypeDict[sname]
            nametype = sname + stype
            combineResult.writelines(nametype + "|" + str(fieldsa[1]) + "|" + str(fieldsa[2]) + "|" +  str(fieldsa[3]))
    
    
    
        
    else:
        count += 1

    linea = schoolAttendance.readline()

schoolAttendance.close()
combineResult.close()
