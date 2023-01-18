from requests import get 
import json
all = json.loads(open("data.json","r").read())
required = ['Qatar','Iran','South Korea','Saudi Arabia','Japan','Australia','Germany','Denmark','France','Belgium','Croatia','Spain','Serbia','United Kingdom','Netherlands','Switzerland','Portugal','Poland','Wales','Brazil','Argentina','Ecuador','Uruguay','Ghana','Senegal','Tunisia','Morocco','Cameroon','Canada','United States','Mexico','Costa Rica']
print(len(required))

added = []
x = 0
for country in all:
	for r in required:
		if r == country['name']:
			print("'{0}': require('../../img/{0}.svg'),".format(country['code'].lower()))
			#print("UPDATE teams SET cc='{0}' WHERE name='{1}';".format(country['code'].lower(),country['name']))
			x += 1
			added.append(r)


for r in required:
	if r not in added:
		print(r)

print(x)
