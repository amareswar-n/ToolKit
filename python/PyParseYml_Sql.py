## Install modules sqlparse and pyyaml for this pkg to work 


import os
import sqlparse
import yaml
from yaml.loader import SafeLoader


def ParseSql(filePath):
    #filePath = "/Volumes/MyDrive/src/main/resources/sql/hl/hl_ongoing.sql"
    filename = os.path.basename(filePath)
    
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
                 TblNames.append([filename, txt[txt.index("FROM")+1].upper()])
                 #print(txt[txt.index("FROM")+1].upper())
              elif "JOIN" in txt and txt.index("JOIN")+1 < len(txt):
                 TblNames.append([filename, txt[txt.index("JOIN")+1].upper()])
                 #print(txt[txt.index("JOIN")+1].upper())
          except Exception as e:
              print(e)
    #print ( TblNames)
    return TblNames
              


def write_to_csv(lst):
   with open("/Users/amar/Desktop/001.csv", 'w') as csvfile:
       for tbl in lst:
           csvfile.write(tbl + '\n')   
   csvfile.close()

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

    #write_to_csv(TableNames)
    #print(" ".join(TableNames))
    print ( TableNames)
    

   
#YmlFile = "/Volumes/MyDrive/src/main/resources/hl_al_ongoing.yaml"
#YmlPath = "hl_al_ongoing.yaml"
path="/Volumes/MyDrive/src/main/resources/sql/hl/"
loop_path(path)



