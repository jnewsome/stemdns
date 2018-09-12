echo -n "Enter Domain: " ; 
read domain; 

echo -e "\n\n"

echo -e "=================================== Mail DNS Report for $domain =================================== \n" ; 

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

echo -e "\nJN"
