#!/bin/bash
# ------------------------------------------------------------------
# [Jason N.] StemDNS
#          Basic DNS tool pulling results from seperate sources
# ------------------------------------------------------------------

clear
echo -n "Enter Domain: " ;
read domain;
break=$(printf "\x2D%.0s" {1..27}) ;
pns=$(dig -t SOA +trace $domain|
	grep Received|
	sed -n 3p| 
	cut -d "(" -f2 | cut -d ")" -f1  
2>/dev/null)

clear

#parent name servers

echo -e "============== --Parent Name Servers-- ============== " 

echo "The parent nameserver $pns. Reports $domain nameservers as:"
	echo "$break" 
	dig @$pns -t NS $domain |sed -n '14,21p'

echo -e "\n\n============== --Local Resolver Return-- ==============";
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

#Mail DNS reporting 

echo -e "\n\n=================================== --Mail DNS Report for $domain (Google)-- ===================================\n" ;

        echo -e "---------------------------- DKIM ---------------------------- \n";
                dig @8.8.8.8 -t txt default._domainkey.$domain +short ;

        echo -e "------------------------ SPF (TXT Values)-------------------- \n" ;
                dig @8.8.8.8 -t txt $domain +short;

        echo -e "---------------------------- MX Records --------------------- \n" ;
                dig @8.8.8.8 -t MX $domain +short
                echo "-----" 

                for i in $(dig @8.8.8.8 -t MX +short $domain| awk '{print$2}') ;

                        do host $i ;

                done

echo -e "\n-JN"

