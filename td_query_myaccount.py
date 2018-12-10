import os
import tdclient

my_db = "evaluation_thomasluckenbach"
apikey = os.getenv("TD_API_KEY")

with tdclient.Client(apikey) as client:
    for db in client.databases():
            print(" ")
            for table in db.tables():
                print("db",table.db_name)
                print("table",table.table_name)
                print("count",table.count)
                print("schema",table.schema)

