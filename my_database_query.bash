#!/bin/bash

if [[ $1x == x ]]
then
custom=0
my_db="evaluation_thomasluckenbach"
my_table="sales_data"
my_col="prod_id"
my_sum="amount"
else
custom=1
my_db=$1
printf "Enter table name to query:"
read my_table
fi

td database:show ${my_db} > dbshow.txt
if [[ $? != 0 ]]; 
then 
    printf "**** Error on accessing DB $my_db";
    exit 1; 
fi

printf "\nUsing DB: $my_db to Query table: $my_table \n"
printf "The query of value entered of column: $my_col \n and will calculate the count and sum of column: $my_sum \n\n"

if [[ $custom == 1 ]]
then
    printf "Enter table name to query: "
    read my_table
    printf "Enter column name to query: "
    read my_col
fi

td table:list $my_db > run.out
if [[ $? != 0 ]]; 
then 
    printf "**** Error on accessing table $my_db";  
    cat run.txt
    printf "Show available tables \n"
    cat dbshow.txt
    exit 1; 
fi

printf "Show table \n"
td table:show $my_db $my_table > run.out
cat run.out

printf "\nDetermining valid list items ... "
td query -d ${my_db} -w  "select distinct($my_col) from ${my_table} " -o list.txt -f csv > run.txt
printf "Done\n"
list=( $(cat list.txt) )

output=query_daterange.txt
printf "\nDetermine Time Range for table: $my_table ... "
td query -d ${my_db} -w -o $output "select from_unixtime(min(time)) as Min_Date, from_unixtime(max(time)) as Max_Date from ${my_table}" > run.txt
printf "Done\n"
if [[ $? != 0 ]]; then printf "**** Error running job\n"; cat run.txt ; exit 1; fi
printf "The Min Date        and Max Date\n" 
cat $output

while (true)
do

echo
echo
printf "Enter a Value to query - or zero to quit: " 
read ans

if [[ $ans == 0 ]]
then
    break
fi

# make sure the item is the list of items
queried=0
for p in ${list[*]}
do 
if [[ $ans == $p ]]
then  
    my_query=$ans
    output=query.txt
    test -e $output && rm $output
    printf "\nGetting cumulative data for $my_col=${my_query} ..."
    td query -d ${my_db} -w -o $output "select count(${my_sum}) as sales, sum(${my_sum}) as revenue from ${my_table} where ${my_col}='${my_query}'" > run.out
    if [[ $? != 0 ]]; then printf "**** Error running job\n"; cat run.out ; exit 1; fi
    values=( $(cat $output) )
    printf " For a total number of %d transactions, the Sales Revenue = $ %10.2f \n" ${values[*]}
    queried=1
    break
fi 
done

if [[ $queried == 0 ]]; 
then 
    printf "\n\n Try again - Enter a valid value for $my_col \n"
fi

# while
done

exit
