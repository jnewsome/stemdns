#!/bin/bash
# ------------------------------------------------------------------
# [Jason N.] MDNS Version 2.2 (Now with Colors!)
#
#                Mail DNS tool for DKIM, SPF, MX, SOA
#                 for $domain as reported by Google.
#
#   Create file named stemdns.sh and add the alias to your bash
#                         profile.
#
#                          Usage:
#
#                   ~$ mdns $domain.com
# ------------------------------------------------------------------

#COLORS
_R=$(tput setaf 1)
_W=$(tput sgr0)
_Y=$(tput setaf 3)
_G=$(tput setaf 2)
clear

echo "$_Y<code>$_W"
echo -e "$_R====================================================================================================="
echo -e "                 =====-----===== Mail DNS Report for $1 =====-----=====" ;
echo -e "===================================================================================================== \n"

        echo -e "$_G------------- DKIM ($_Y Default|Google|Office365$_G ) --------------$(tput setaf 5) \n";
                dig @8.8.8.8 -t txt default._domainkey.$1 +short ;
                dig @8.8.8.8 -t txt google._domainkey.$1 +short ;
                dig @8.8.8.8 -t txt selector1._domainkey.$1 +short ;
                dig @8.8.8.8 -t txt selector2._domainkey.$1 +short ;
        echo -e "$_G----------------------- Default DMARC ------------------------$(tput setaf 5) \n";
                dig @8.8.8.8 -t txt _dmarc.$1 +short
        echo -e "$_G---------------------- SPF (TXT Values) ----------------------$(tput setaf 5) \n" ;
                dig @8.8.8.8 -t txt $1 +short;

        echo -e "$_G---------------------------- MX Records ---------------------$(tput setaf 5) \n" ;
                dig @8.8.8.8 -t MX $1 +short
                echo "-----"

                for i in $(dig @8.8.8.8 -t MX +short $1| awk '{print$2}') ;

                        do host $i ;

                done

        echo -e "$_G---------------------------- SOA ----------------------------$(tput setaf 5) \n" ;
                dig @8.8.8.8 -t soa $1 +short
echo -e "$_R==================================================================================================="
echo "$_Y</code>$_W"
echo -e "$(tput setaf 4)\n-JN$(tput sgr0)"
