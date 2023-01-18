import csv 
from datetime import datetime

file = open('/home/user/Downloads/matches.csv','r')
csv_data = csv.reader(file)

x = 0
query = str()
output = open("/home/user/Downloads/matches.sql",'w')
for row in csv_data:
    x += 1
    if x == 1: continue

    date = row[0]
    countries = row[1]
    countries = countries.replace('\u200b','')
 
    countries = countries.replace('Holland','Netherlands')
    time = row[4]
    team_1 = countries.split(' vs. ')[0]
    team_2 = countries.split(' vs. ')[1]

    if team_1[0] == '': print(team_1.index(10))

    remove = ['nd','of','st','th','nd']
    for r in remove: date = date.replace(r,'')

    date_obj = datetime.strptime(date + " 2022", '%B %d %Y')
    date = date_obj.strftime('%Y-%m-%d ' + time)

    cmd = "INSERT INTO matches(team_1,team_2,due) VALUES( ( SELECT id FROM teams WHERE name='{0}' ) , ( SELECT id FROM teams WHERE name='{1}' ), '{2}');\n".format(team_1, team_2, date)
    query += cmd
    print(cmd)
output.write(query)
output.close()