# Treasure Data Demo

Treasure Data Sample Query on a Hive Table

## Requirements

`td-client` supports the following versions of Python.
`tc-cli` cli for TD

* Python 2.7+
* Python 3.3+
* PyPy

## Install and Setup

You will nead tools for CSV and JSON file conversion
```sh
 gem install orderedhash
 gem install csv2json
```
You will need to Download the TD Toolbelt (CLI)

Treasure Data Toolbelt https://toolbelt.treasuredata.com/
Installing: https://support.treasuredata.com/hc/en-us/articles/360001525887-Installing-and-Updating-the-Treasure-Data-CLI

Install the python client

```sh
$ pip install td-client
```

```sh
$ pip install certifi
```

# Get this Sample Demo
Clone this repo

```sh
cd my_demo_location
git clone https://github.com/tluck/TD-demo.git 
```


### Setup 
Note:
the sample data will be converted from CSV to JSON using a ruby tool called csv2json

TreasureData API key will be read from environment variable `TD_API_KEY`, if none is given via arguments to `tdclient.Client`.
Here is the link to retrieve your API key : http://docs.treasuredata.com/articles/get-apikey


### Importing data

Run this command to import the sample data to the sample database - will create the sales_data table

```
cd TD-Demo/sample_data
./my_database_load.bash
```

```python
import sys
import tdclient

with tdclient.Client() as td:
    for file_name in sys.argv[:1]:
        td.import_file("evaluation_thomasluckenbach", "sales_data", "csv", file_name)
```
### Query

The sample query script runs a query to find the sum and count of column1 where column2=value

For example column1 is the sales amount of a set of product_id listed on column2

This demo will extract the total number sales and total sales revenue for a given product_id

You can specify and alternate DB and table if desired.

Defaults are:
DB=evaluation_thomasluckenbach
Table=sales_data
Sum over column: amount
where column: prod_id=value

```sh
cd TD-Demo
./my_database_query.bash <db>
```

Then, enter a valid like 13 or 121

Run and see the results!

