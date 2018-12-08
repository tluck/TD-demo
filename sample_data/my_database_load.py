import sys
import tdclient
import os

apikey = os.getenv("TD_API_KEY")
with tdclient.Client(apikey) as client:
#    #for file_name in sys.argv[:1]:
#    for file_name in file:
        client.import_file("evaluation_thomasluckenbach", "sales_data", "json", "sales_data.json")
