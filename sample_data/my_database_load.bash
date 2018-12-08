#!/bin/bash

my_db="evaluation_thomasluckenbach"
my_table="sales_data"

# create json file from csv file
# require

./csv2json_hash.bash ${mytable}.csv

# create table and import data from json file
  td apikey:set $TD_API_KEY
  td table:import evaluation_thomasluckenbach sales_data --auto-create-table --json sales_data.json 
  #td table:import evaluation_thomasluckenbach customer_data --auto-create-table --json custom.json 

echo Show table details of my database $my_db
td database:show ${my_db}

exit
