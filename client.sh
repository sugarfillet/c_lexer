#!/usr/bin/env bash
#set -x
#LAMJ=`echo '{"method":"ListAllMethod"}' | ncat 127.1.1.1 12307 | sed '$d;1d;s#\t*##g' | cut -d':' -f2 | sed 's#"#(#;s#"#)#' `
#get all methods 
#AM=`echo '{"method":"ListAllMethod"}' | ncat 127.1.1.1 12307 | sed '$d;1d;s#\t*##g' | cut -d':' -f2 | sed 's#"##g' `
#AMA=(${AM})
#echo ${#AMA[*]}

initializeANSI()
{
	 esc="" # if this doesn't work, enter an ESC directly
	  
	  blackf="${esc}[30m";  redf="${esc}[31m";  greenf="${esc}[32m"
	   yellowf="${esc}[33m"  bluef="${esc}[34m";  purplef="${esc}[35m"
	    cyanf="${esc}[36m";  whitef="${esc}[37m"
	     
	     blackb="${esc}[40m";  redb="${esc}[41m";  greenb="${esc}[42m"
	      yellowb="${esc}[43m"  blueb="${esc}[44m";  purpleb="${esc}[45m"
	       cyanb="${esc}[46m";  whiteb="${esc}[47m"
	        
	        boldon="${esc}[1m";  boldoff="${esc}[22m"
		 italicson="${esc}[3m"; italicsoff="${esc}[23m"
		  ulon="${esc}[4m";   uloff="${esc}[24m"
		   invon="${esc}[7m";   invoff="${esc}[27m"
		    
		    reset="${esc}[0m"
}

CPU(){


	cpu=`echo '{"method":"GetCmdTopH"}' | ncat 127.1.1.1 12307 | sed '1d;$d;s#\t##g' | sed 's/:/#/'|cut -d '#' -f2 | xargs echo -e | sed '$d'|head -n5|egrep 'Cpu';`
	cpuvarr=(`echo ${cpu} | cut -d':' -f2 | sed  's/ //g;s/[[:lower:]]//g;s/,/ /g; s/0\.$/0.0/g' ;`);
	cpukarr=('un-niced user processes' 'kernel process' 'niced user processes' 'idle ' 'waiting for io' 'hardware INT' 'software INT' 'stolen from this vm by HV' )
	for(( i = 0 ; i < ${#cpukarr[*]} ; i++ )){
	       printf "%25s : %5s" "${cpukarr[i]}"   "${cpuvarr[i]}" ;
	       echo;
       } 
	echo ;
#print graph

       echo -ne "cpu[||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||]\r";
      # cpucarr=('${redf}','${greenf}','${yellowf}','${bluef}','${purplef}','${cyanf}','${whitef}','${blackf}');
      # cpucarr=('redf' 'greenf' 'yellowf' 'bluef' 'purplef' 'cyanf' 'whitef' 'blackf');
       echo -n 'cpu[';
	for(( i = 0 ; i < ${#cpuvarr[*]} ; i++ )){
            perc=`echo ${cpuvarr[i]} | awk -F. '{ printf $1 }' `;
	    for (( j = 0 ; j < perc ; j++ )){
	    
		    #how to R parse a variable 
		    case $i in 
			    0 ) 
				echo -n ${redf}\|;;
		            1 ) 		
				echo -n ${greenf}\|;;	
			    2 ) 
				echo -n ${yellowf}\|;;
		            3 ) 		
				echo -n ${bluef}\|;;	
			    4 ) 
				echo -n ${purplef}\|;;
		            5 ) 		
				echo -n ${cyanf}\|;;	
			    6 ) 
				echo -n ${whitef}\|;;
		            7 ) 		
				echo -n ${blackf}\|;;	
		    esac 
	    }
	       echo -n "${reset}";
	       
	}

	
}

MEM(){

	echo '{"method":"GetCmdFree"}' | ncat 127.1.1.1 12307 | sed '1d;$d;s#\t##g' | sed 's/:/#/'|cut -d '#' -f2 | xargs echo -e | sed '$d';
	mem=`echo '{"method":"GetCmdFree"}' | ncat 127.1.1.1 12307 | sed '1d;$d;s#\t##g' | sed 's/:/#/'|cut -d '#' -f2 | xargs echo -e | sed '$d';`;
	memvarr=(`echo $mem | cut -d' ' -f 8,9,10 `);
	memkarr=(total used free)
	for (( i = 0 ; i < ${#memkarr[*]} ; i++ )){
		printf "%5s : %8s"  ${memkarr[i]} ${memvarr[i]}	
		echo ;
	}
	echo ;
	

       echo -ne "mem[||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||]\r";
       echo -n 'mem[';
       total=${memvarr[0]}
       used=${memvarr[1]}
       free=${memvarr[2]}
       perc= $(( used*100/total )) 
       echo $perc
	    for (( j = 0 ; j < perc ; j++ )){
	    
				echo -n ${redf}\|;
}
}

DISK(){

	echo '{"method":"GetCmdDf"}' | ncat 127.1.1.1 12307 | sed '1d;$d;s#\t##g' | sed 's/:/#/'|cut -d '#' -f2 | xargs echo -e | sed '$d';


}

main(){
	initializeANSI;
echo -e "========cpu==========\n";

CPU;
echo ;
echo -e "========mem==========\n";
MEM;
echo ;
#echo -e "========disk==========\n";
#DISK;
#echo ;
}

main
