import os
import tdclient

my_db = "evaluation_thomasluckenbach"

apikey = os.getenv("TD_API_KEY")
with tdclient.Client(apikey) as td:
    job = td.query(my_db, "SELECT sum(amount) FROM sales_data where prod_id='13'")
    # sleep until job's finish
    job.wait()
    print("Sum amount for prod_id=13")
    for row in job.result():
        print(row)
