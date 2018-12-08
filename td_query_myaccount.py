import os
import tdclient
my_db = "evaluation_thomasluckenbach"
apikey = os.getenv("TD_API_KEY")
with tdclient.Client(apikey) as client:
    for db in client.databases():
            print(db.tables)
            for table in db.tables():
                print("db",table.db_name)
                print("table",table.table_name)
                print("count",table.count)
                print("schema",table.schema)


# user, host
#    job = client.query("evaluation_thomasluckenbach", "SELECT count(*) FROM sales_data")
    job = client.query(my_db, "SELECT count(*) FROM sales_data")
    # sleep until job's finish
    job.wait()
    for row in job.result():
        print(row)

#con = tdclient.connect(db="sample_datasets")
#cursor = con.cursor()
#cursor.execute("SELECT user FROM www_access")
#print cursor.fetchone()
#print cursor.description
