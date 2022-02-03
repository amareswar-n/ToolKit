## Install modules sqlparse and pyyaml for this pkg to work 


import os
import sqlparse
import yaml
import pandas as pd
from yaml.loader import SafeLoader


def ParseSql(filePath):
    #filePath = "/Volumes/MyDrive/src/main/resources/sql/hl/hl_ongoing.sql"
    if os.path.exists(filePath):    
       # filename = os.path.basename(filePath)
        sql_file = open(filePath, "r")
        
        sql = sql_file.read()
        sql_file.close()
        
        formatted_sql = sqlparse.format(sql, strip_comments=True, strip_ws=True,  indent_columns= True, reindent_aligned = True, keyword_case='upper')
        formatted_sql = sqlparse.format(formatted_sql, comma_first = True, reindent = True,)
        
        TblNames = list([] )
        
        for line in formatted_sql.splitlines():
          txt = line.strip().split()
          if len(txt) > 1 and ('FROM' in txt or 'JOIN' in txt):
              try:
                  if "FROM" in txt and txt.index("FROM")+1 < len(txt):
                     #TblNames.append([filename, txt[txt.index("FROM")+1].upper()])
                     TblNames.append([txt[txt.index("FROM")+1].upper()])
                     #print(txt[txt.index("FROM")+1].upper())
                  elif "JOIN" in txt and txt.index("JOIN")+1 < len(txt):
                     #TblNames.append([filename, txt[txt.index("JOIN")+1].upper()])
                     TblNames.append([txt[txt.index("JOIN")+1].upper()])
                     #print(txt[txt.index("JOIN")+1].upper())
              except Exception as e:
                  print(e)
        #print ( TblNames)
        for Tbl in TblNames:
           if len(str(Tbl)) <= 6:
               #print(str(Tbl) + str(len(str(Tbl))))
               TblNames.remove(Tbl)

        return TblNames
              
def write_to_excel(basePath, data):
    df = pd.DataFrame(data)
    writer = pd.ExcelWriter('/Users/amar/Desktop/001.xlsx', engine='xlsxwriter')
    df.to_excel(writer, sheet_name='welcome', index=False, header = None)
    writer.save()
    

def loop_path(path):
    TableNames = []
    #filePath = "/Volumes/MyDrive/src/main/resources/sql/hl/hl_ongoing.sql"
    # dirs=directories
    for (root, dirs, file) in os.walk(path):
        for f in file:
            if '.sql' in f:
                filePath = path + f
                #print(filePath) 
                TableNames.append(ParseSql(filePath))

    print ( TableNames)
    
def getparams(task, dataframe, basePath):
   # nowdf = ("ETL task", "Data Frame", "Table Name", "Filter", "Persist","URI", "References","")
    #print(dataframe)
    table = Filter = uri = persist = references = ""
    #print( "-----------------")
    #print(dataframe["name"])
    for key in dataframe:
        if key == "table":
            table = dataframe[key]
            #print(table)
        elif key == "filter":
            Filter = dataframe[key]
            #print(Filter)
        elif key == "uri":
            uri = basePath + dataframe[key]
            #print(uri)
        elif key == "persist":
            persist = dataframe[key]
        #hiveTable
        #partitionBy
        if task == "transform.sql": 
            references = ParseSql(uri)
            if references is not None:
                references = str(references).replace('[','').replace(']','').replace("'","").replace("(","").replace(")","").replace(",","\n")
        nowdf = (task, dataframe["name"], table, Filter, persist, uri, "".join(str(references)), "" )
    return (nowdf)            

# def GetTableNames(dataframes):
#     for df in dataframes:
#       print(str(df[6]).)
            
YmlFile = "/Volumes/MyDrive/src/main/resources/hl_al_ongoing.yaml"
basePath = os.path.dirname(YmlFile)
#print(basePath)

dataframes= []
stream = open(YmlFile, 'r')
pipeline = yaml.load(stream, Loader=SafeLoader)
header = ("ETL task", "Data Frame", "Table Name", "Filter", "Persist","URI", "Referenced Dataframes","Referenced Tables")

dataframes.append(header)

for etl in pipeline:
    for key, value in etl.items():
       # print ("------>" + key ) #+ " : " + str(value)
        if key == "extract.hive" or key == "load.parquet" or  key == "transform.sql":
            #print(" ETL TASK " ) #+ str(value ) )
            for inp, dfs in value.items():
                for dataframe in dfs: 
                   thisdf = getparams(key, dataframe, basePath)
                   dataframes.append(thisdf)
GetTableNames(dataframes)
#write_to_excel(basePath, dataframes)
#print(dataframes[39])  
