#!/usr/bin/gawk -f
BEGIN {
    FS = "\t"
	OFS = "|"

	#files for 2015-2018 school years and 2018-2019 school year respectively
	File2015 = "2015-2018_Historical_Daily_Attendance.tsv.gz"
	File2018 = "2018-2019_Daily_Attendance.tsv.gz"


	#read in the days that shouldn't be counted in from a separate file
    while((Status = getline < "attendance_exceptions.txt") > 0) {
	Date = $0
		AttendanceExceptionsArr[Date] = 1
}


    #commands to read the compressed attendance files
    ReadCommand2015 = "zcat " File2015
    ReadCommand2018 = "zcat " File2018


    #write out the attendance data from 2015-2018 school years
    while((Status = ReadCommand2015 | getline) > 0) {
	FS = "\t"
	OFS = "|"

	#field 2 has the date, and I am reformating it so that it will have  the same format as my 2018-2019 school year date
	if ($2 ~ /^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/) {
	   Year = substr($2,7)
	   Format2018Date = substr($2,7)  substr($2,1,2)  substr($2,4,2)

	   #check to make sure that the date isn't a date that shouldn't be printed out
	   if (!(AttendanceExceptionsArr[Format2018Date] == 1)){
	       print $1,Format2018Date,$4, $7  #print out the school DBN, date, number of students enrolled,numberofstudentsreleased to the new attendance file}

	   }
	}


    }
    close(ReadCommand2015)

	#write out the attendance data from the 2018-2019 school year
    while((status2 = ReadCommand2018 | getline) > 0) {
	Date = 2

		#check to make sure the date should be printed out
	if (!(AttendanceExceptionsArr[$Date] == 1)) {
	    print $1, $Date, $3, $6 ;#prints out school DBN, date, number of students enrolled and number released to the same new attendance file

	}

    }

    close(ReadCommand2018)

}


    

       
