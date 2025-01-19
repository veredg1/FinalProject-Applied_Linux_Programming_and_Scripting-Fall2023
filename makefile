all:  SemesterProjectGraph temp_percent_school.gz 2015-2019_Temp_Attendance_Percent.gz School_by_type.gz  2015-2019_Daily_Attendance+type.gz 2015-2019_Daily_Attendance.gz manhattanWeather20152019.gz 


SemesterProjectGraph: temp_percent_school.gz temp_percent_lowerschool.gz temp_percent_highschool.gz temp_percent_middleschool.gz creategraph.py
	./creategraph.py
#makes the graph of the data found in this project

temp_percent_school.gz: 2015-2019_Temp_Attendance_Percent.gz returntemppercentschoolbyschool.py
	./returntemppercentschoolbyschool.py

#Gets daily school attendance data divided by: schooltype, weather, percent of students released early
2015-2019_Temp_Attendance_Percent.gz: 2015-2019_Daily_Attendance+type.gz manhattanWeather20152019.gz replaceDateWithTempAddPercent.awk
	./replaceDateWithTempAddPercent.awk | gzip  > 2015-2019_Temp_Attendance_Percent.gz

#this looks at the school type file and the attendance file and combines the two into 1 file, so it prints out school dbn +school type, date, kids enrolled, kids released
2015-2019_Daily_Attendance+type.gz: School_by_type.gz 2015-2019_Daily_Attendance.gz combineSchoolTypeAttendance.py
	./combineSchoolTypeAttendance.py


#looks at the number of kids enrolled per grade and assigns each school a tag of "L" "M" "H" or a combination of the two: "L" - elementary "M" - middle school "H" - highschool, which is school type. 
School_by_type.gz: 2013-2018_Demographic_Snapshot_School.tsv.gz getSchoolType.awk
	./getSchoolType.awk | gzip  > School_by_type.gz


#returns the combined daily attendance of new york city public schools in the years 2015-2019
2015-2019_Daily_Attendance.gz: 2015-2018_Historical_Daily_Attendance.tsv.gz 2018-2019_Daily_Attendance.tsv.gz createAttendanceFile.awk
	./createAttendanceFile.awk | gzip > 2015-2019_Daily_Attendance.gz


#creates a file of the temperature at 12 pm in New York City every day of 2015 and 2019
manhattanWeather20152019.gz: manhattanWeatherClean.gz manhattanWeatherGrep.py
	./manhattanWeatherGrep.py 

clean:
	rm 2015-2019_Daily_Attendance.gz 2015-2019_Daily_Attendance+type.gz School_by_type.gz  manhattanWeather20152019.gz  2015-2019_Temp_Attendance_Percent.gz SemesterProjectGraph.pdf
