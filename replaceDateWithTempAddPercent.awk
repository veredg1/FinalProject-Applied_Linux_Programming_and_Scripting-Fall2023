#!/usr/bin/gawk -f
BEGIN{
    #weather and school are the read files
    weatherfile = "manhattanWeather20152019.gz"
    schoolTypefile  = "2015-2019_Daily_Attendance+type.gz"
    FS = "|"
    OFS = "|"
    readcommandw = "zcat " weatherfile
    readcommands = "zcat " schoolTypefile

    #puts the tempature as the values in a dictionary, while
    #the keys are the date. 
    while ( (readcommandw | getline) > 0) {
	temp = 2
	date = 1
	daytemp[$date] = $temp
    }

    close(readcommandw)
    FS = "|"
    OFS = "|"
    #uses the date to access the temperature value in the dictionary made earlier so that the
    #date can be replaced with the temperature for the final data result that will be used to make the
    #graph in the next file 
    while((readcommands | getline) > 0){
	percent = ($4 / $3) * 100
	print $1,daytemp[$2],$3,$4,percent 
    }
    close(readcommands)
    
}
    


