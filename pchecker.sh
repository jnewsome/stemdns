#!/bin/bash
# ------------------------------------------------------------------
# [Jason N.] PChecker
#          Basic DNS tool detailing differing reports from multiple 
#	   sources, including the assumed HOST. 
# ------------------------------------------------------------------

echo -n "Enter Domain: " ;
read domain; 
echo -n "Enter HOST: " ; 
read host; 
break=$(printf "\x2D%.0s" {1..27}) ; 

echo -e "============== Local Resolver Return ============== \n";
	echo "A record for $domain:"; echo "$break";  
		echo "$domain IN A $(dig -t A $domain +short)";
	echo "-----"
		for i in $(dig -t A $domain +short); do dig -x $i +short && host $i ; done
	echo -e "\nSOA for $domain (Serial: $(dig -t SOA $domain +short|awk '{print$3}')):" ; 
	echo "$break" ;  
		dig -t SOA $domain +short ; 

echo -e "\n============== Google DNS Return ============== \n" ; 
	echo "A record for $domain:"; 
	echo "$break" ; 
		echo "$domain IN A $(dig @8.8.8.8 -t A $domain +short)"
        echo "-----"
                for i in $(dig @8.8.8.8 -t A $domain +short); do dig -x $i +short && host $i ; done
	echo -e "\nSOA for $domain (Serial: $(dig @8.8.8.8 -t SOA $domain +short|awk '{print$3}')):"; 
	echo "$break" ; 
		dig @8.8.8.8 -t SOA $domain +short; 

echo -e "\n============== $host DNS Return ============== \n" ; 
	echo "A record for $domain:" ; 
	echo "$break" ; 
		echo "$domain IN A $(dig @$host -t A $domain +short)"
        echo "-----"
                for i in $(dig @$host -t A $domain +short); do dig -x $i +short && host $i ; done
	echo -e "\nSOA for $domain (Serial: $(dig @$host -t SOA $domain +short|awk '{print$3}')):" ;
	echo "$break" ; 
		dig @$host -t SOA $domain +short;

echo -e "\n-JN" 
