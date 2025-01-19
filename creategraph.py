#!/usr/bin/env python3
import matplotlib.pyplot as plt
import gzip
import pyspark

lowerschoolfile = gzip.open("temp_percent_lowerschool.gz","rt")
middleschoolfile = gzip.open("temp_percent_middleschool.gz","rt")
highschoolfile = gzip.open("temp_percent_highschool.gz","rt")

files = [lowerschoolfile,middleschoolfile,highschoolfile]


colors = [("Lower School","red"),("Middle School","blue"),("High School","green")]

x = [[],[],[]]
y = [[],[],[]]
for i in range(len(files)):
    color = colors[i][1]
    tag = colors[i][0]
    line = files[i].readline().strip()
    while line:
        points = line.split(",")
        curx = float(points[0])
        cury = float(points[1])
        x[i].append(curx)
        y[i].append(cury)
        line = files[i].readline().strip()
        
fig,ax = plt.subplots()
for i in range(len(x)):
    color = colors[i][1]
    tag = colors[i][0]
    ax.scatter(x[i],y[i],c = color,label = tag)








ax.legend()
ax.set_xlabel("Temperature (degrees fahreinheit)")
ax.set_ylabel("Percent of students released early (log scale)")
ax.set_yscale("log")
ax.set_title("Percent of Students Released Early by Temperature")
plt.savefig("SemesterProjectGraph.pdf")
    
    



    

