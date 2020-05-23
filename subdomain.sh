input=$1
domain=$2
for i in $(cat $input)
 do
    now=$(host -t CNAME  $i | sed s/"$i is an alias for"// | sed "/no CNAME/d" | sed 's/ //g' ) 
     
   #echo  -e $now |sed  "/not found/d" | grep -e $domain 
   if [[ $input =~ $domain ]];
then
    echo -e " $i \e[1;42m  "not vulnerable" \e[0m"
else
    #echo "False"
    #echo  -e $i'\t'$now
    status=$(curl -s -o /dev/null -w "\n%{http_code}" $now >/dev/null 2>&1) 
    if [[ $status == 404 ]]
then
    #echo  -e $i "is vullnerable to takeove ==? pointing to \t" $now
    echo -e " $i \e[1;31m  "is vullnerable to takeove ==? pointing to \t" $now \e[0m"

else
   #echo $i "not vulnerable"
echo -e " $i \e[1;42m  "not vulnerable" \e[0m"

fi
fi


done