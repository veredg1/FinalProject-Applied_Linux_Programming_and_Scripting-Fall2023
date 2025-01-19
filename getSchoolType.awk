#!/usr/bin/gawk -f
BEGIN{
    FS = "\t"
    OFS = "|"

    school = 1
    grk = 6
    gr1 = 7
    gr2 = 8
    gr3 = 9
    gr4 = 10
    gr5 = 11
    gr6 = 12
    gr7 = 13
    gr8 = 14
    gr9 = 15
    gr10 = 16
    gr11 = 17
    gr12 = 18

    
    readFile = "2013-2018_Demographic_Snapshot_School.tsv.gz"
    readCommand = "zcat " readFile
    
    
    while((status = readCommand | getline) > 0) {
	schoolType = "" #reset the school type for every line 

	#if the school has kids in Elementary school grades, mark L
	if (($grk ~ /[0-9]*[1-9]+/)|| ($gr1 ~ /[0-9]*[1-9]+/) || ($gr2 ~ /[0-9]*[1-9]+/) || ($gr3 ~ /[0-9]*[1-9]+/) || ($gr4 ~ /[0-9]*[1-9]+/) || ($gr5 ~ /[0-9]*[1-9]+/)){
	    schoolType = "L"

	   #if the school has kids in a middle school grade then mark M. make sure that the L mark is there as well if it's also an elementary school
	} if (($gr6 ~ /[0-9]*[1-9]+/) || ($gr7 ~ /[0-9]*[1-9]+/) || ($gr8 ~ /[0-9]*[1-9]+/)){
	    schoolType = schoolType "M"

	   #if the school has kids in a high school grade then mark M. leave any other marks that were there from before
	} if ( ($gr9 ~ /[0-9]*[1-9]+/) || ($gr10 ~ /[0-9]*[1-9]+/) || ($gr11 ~ /[0-9]*[1-9]+/) || ($gr12 ~ /[0-9]*[1-9]+/)) {
	    schoolType = schoolType "H"
	} 
        print $school, schoolType, $5, $grk,$gr1,$gr2,$gr3,$gr4,$gr5,$gr6,$gr7,$gr8,$gr9,$gr10,$gr11,$gr12
	if (schoolType) {
	    print $school, schoolType }
    }

}
