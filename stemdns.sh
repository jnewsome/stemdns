#!/bin/bash
# ------------------------------------------------------------------
# [Jason N.] StemDNS
#          Basic DNS tool pulling results from seperate sources
# ------------------------------------------------------------------

#GLOBAL VARIABLES
#Line Break
break=$(printf "\x2D%.0s" {1..27}) ;
#Parent DNS
pns=$(dig -t SOA +trace $1|
        grep Received|
        sed -n 3p|
        cut -d "(" -f2 | cut -d ")" -f1
2>/dev/null)
#COLORS
#Red
_R=$(tput setaf 1)
#White
_W=$(tput sgr0)
#Yellow
_Y=$(tput setaf 3)
#Green
_G=$(tput setaf 2)
#Magenta
_P=$(tput setaf 5)
#Cyan
_C=$(tput setaf 6)
# -----------------------------------
clear
#parent name servers
echo "$_Y<code>$_W"
echo -e "$_G=-=-=-=-=-=-=-= --Parent Name Servers-- =-=-=-=-=-=-=-=$_R\n"
echo -e "The parent nameserver $pns. Reports $1 nameservers as: $_P"
        echo "$_C$break$_P"
        dig @$pns -t NS $i |sed -n '14,21p'
echo "$_Y</code>$_W"
echo "$_Y<code>$_W"
echo -e "$_G=-=-=-=-=-=-=-= --Local Resolver Return-- =-=-=-=-=-=-=-=$_R";
        echo -e "$_R\nA/AAAA record for $1: $_P";
        echo "$_C$break$_P"
                echo "$1 IN A $(dig -t A $1 +short)";
                echo "AAAA for $1 $(dig -t AAAA $1 +short)" ;
        echo "$_C-----$_P"

                for i in $(dig -t A $1 +short);

                        do dig -x $i +short && host $i ;

                done

        echo -e "$_R\nNS for $1:$_P";
        echo "$_C$break$_P"
                dig -t NS $1 +short;
        echo -e "$_R\nSOA for $1 (Serial: $(dig -t SOA $1 +short|awk '{print$3}')):" ;
        echo "$_C$break$_P"
                dig -t SOA $1 +short ;
echo "$_Y</code>$_W"

#DNS reported from Google Resolvers

echo "$_Y<code>$_W"
echo -e "$_G=-=-=-=-=-=-=-= --Google DNS Return-- =-=-=-=-=-=-=-=$_G" ;
        echo -e "$_R\nA/AAAA record for $1: $_P";
        echo "$_C$break$_P"
                echo "$1 IN A $(dig @8.8.8.8 -t A $1 +short)"
                echo "AAAA for $1 $(dig -t AAAA $1 +short)" ;
        echo "$_C-----$_P"

                for i in $(dig @8.8.8.8 -t A $1 +short);

                        do dig -x $i +short && host $i ;

                done

        echo -e "$_R\nNS for $1:$_P";
        echo "$_C$break$_P"
                dig @8.8.8.8 -t NS $1 +short
        echo -e "$_R\nSOA for $1 (Serial: $(dig @8.8.8.8 -t SOA $1 +short|awk '{print$3}')):";
        echo "$_C$break$_P"
                dig @8.8.8.8 -t SOA $1 +short;
echo "$_Y</code>$_W"

#Mail DNS reporting

echo "$_Y<code>$_W"
echo -e "$_G=-=-=-=-=-=-=-= ---Mail DNS Report for $1 (Google)--- =-=-=-=-=-=-=-=$_R\n" ;

        echo -e "$_C----------------------------$_R DKIM $_C---------------------------- $_P\n";
                dig @8.8.8.8 -t TXT default._domainkey.$1 +short ;

        echo -e "$_C-----------------------$_R Default DMARC $_C------------------------$_P\n";
                dig @8.8.8.8 -t TXT _dmarc.$1 +short

        echo -e "$_C------------------------$_R SPF (TXT Values)$_C--------------------$_P\n" ;
                dig @8.8.8.8 -t TXT $1 +short;

        echo -e "$_C----------------------------$_R MX Records $_C---------------------$_P\n" ;
                dig @8.8.8.8 -t MX $1 +short
                echo "-----"

                for i in $(dig @8.8.8.8 -t MX +short $1| awk '{print$2}') ;

                        do host $i ;

                done
echo "$_G=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "$_Y</code>$_W"
echo -e "$(tput setaf 4)\n-JN$(tput sgr0)"

