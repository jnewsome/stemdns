#!/bin/bash
# ------------------------------------------------------------------
# [Jason N.] TreeDNS
#          Basic DNS tool pulling results from seperate sources
# ------------------------------------------------------------------

clear 
echo -n "Enter Domain: " ;
read domain; 
echo -n "Enter HOST: " ; 
read host; 
break=$(printf "\x2D%.0s" {1..27}) ; 

#echo -e "\n" 

clear 

#DNS reported from local resolves 

echo -e "============== --Local Resolver Return-- ==============";
	echo "A record for $domain:"; 
	echo "$break";  
		echo "$domain IN A $(dig -t A $domain +short)";
	echo "-----"
		
		for i in $(dig -t A $domain +short); 

			do dig -x $i +short && host $i ; 

		done

	echo -e "\nNS for $domain:";
	echo "$break"; 
		dig -t NS $domain +short; 
	echo -e "\nSOA for $domain (Serial: $(dig -t SOA $domain +short|awk '{print$3}')):" ; 
	echo "$break" ;  
		dig -t SOA $domain +short ; 

#DNS reported from Google Resolvers 

echo -e "\n============== --Google DNS Return-- ==============" ; 
	echo "A record for $domain:"; 
	echo "$break" ; 
		echo "$domain IN A $(dig @8.8.8.8 -t A $domain +short)"
        echo "-----"
                
		for i in $(dig @8.8.8.8 -t A $domain +short); 

			do dig -x $i +short && host $i ; 

		done

	echo -e "\nNS for $domain:"; 
	echo "$break"; 
		dig @8.8.8.8 -t NS $domain +short
	echo -e "\nSOA for $domain (Serial: $(dig @8.8.8.8 -t SOA $domain +short|awk '{print$3}')):"; 
	echo "$break" ; 
		dig @8.8.8.8 -t SOA $domain +short; 

#DNS reported from $host 

echo -e "\n============== --$host DNS Return-- ==============" ; 
	echo "A record for $domain:" ; 
	echo "$break" ; 
		echo "$domain IN A $(dig @$host -t A $domain +short)"
        echo "-----"

                for i in $(dig @$host -t A $domain +short); 

			do dig -x $i +short && host $i ; 

		done

	echo -e "\nNS for $domain:"; 
	echo "$break"; 
		dig @$host -t NS $domain +short; 
	echo -e "\nSOA for $domain (Serial: $(dig @$host -t SOA $domain +short|awk '{print$3}')):" ;
	echo "$break" ; 
		dig @$host -t SOA $domain +short;

echo -e "\n"

#Mail DNS reporting 

echo -e "=================================== --Mail DNS Report for $domain (Google)-- ===================================" ; 

        echo -e "---------------------------- DKIM ---------------------------- \n"; 
                dig @8.8.8.8 -t txt default._domainkey.$domain +short ; 

        echo -e "---------------------------- SPF ---------------------------- \n" ; 
                dig @8.8.8.8 -t txt $domain +short; 

        echo -e "---------------------------- MX Records --------------------- \n" ; 
                dig @8.8.8.8 -t MX $domain +short 
                echo "-----" 

                for i in $(dig @8.8.8.8 -t MX +short $domain| awk '{print$2}') ;

                        do host $i ; 

                done

        echo -e "---------------------------- SOA ---------------------------- \n" ;    
                dig @8.8.8.8 -t soa $domain +short

#echo -e "\nJN"
