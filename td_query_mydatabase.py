import os
import tdclient

my_db = "evaluation_thomasluckenbach"

apikey = os.getenv("TD_API_KEY")

with tdclient.Client(apikey) as td:
    job = td.query(my_db, "SELECT count(amount), sum(amount) FROM sales_data where prod_id='13'")
    job.wait()
    print("Total Count and Sum amount for prod_id=13")
    for row in job.result():
        print(row)

    job = td.query(my_db, "SELECT TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS day,\
        COUNT(1) AS pv, sum(amount) FROM sales_data\
        WHERE  prod_id='13'\
        GROUP BY TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST')\
        ORDER BY day ASC")
    job.wait()
    print("Orders and Revenue by day for prod_id=13")
    for row in job.result():
        print(row)
