#!/usr/bin/env python3
import gzip
import re 
readFile = gzip.open("manhattanWeatherClean.gz","rt")
writeFile = gzip.open("manhattanWeather20152019.gz","wt")

line = readFile.readline()
count = 0
while line:
    if count > 0:
        fields = line.split("|")
        date = fields[1]
        temp = round(float(fields[6]))
        year = date[0:4]
        ymd = date[0:4] + date[5:7] + date[8:10]
        hour = date[11:13]
        weekDay = date[len(date) - 4: ]
        if re.match(r'201[5-9]' ,year) and re.match(r'12',hour) and not(re.match(r'(Fri|Sat|Sun)',weekDay)):
            writeFile.writelines(str(ymd) +  "|" + str(temp) + "\n")
    else:
        count += 1
    line = readFile.readline()
        
    

readFile.close()
writeFile.close()
    
