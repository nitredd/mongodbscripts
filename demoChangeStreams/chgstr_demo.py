import os
from pymongo import *

client = MongoClient()  #Pass the URI here, ensuring the exact DB name appears after the slash
db = client['test']

db.people.aggregate([{'$project': {'city': ["$city"]}}, {'$out': "peopleValueTrack"}]);
db.people.aggregate([{'$group': {'_id': "$city", 'cnt': {'$sum': 1}}}, {'$out': "cityCount"}])

with db.people.watch(full_document='updateLookup') as strm:
  for chg in strm:
    print(chg)
    newId = chg['documentKey']['_id']
    if chg['operationType']=='delete':
      newVal = None
    else:
      newVal = chg['fullDocument']['city']
    db.peopleValueTrack.update_one({'_id': newId}, {'$push': {'city': {'$each': [newVal], '$slice': 2, '$position': 0}}}, upsert=True)
    change_rec = db.peopleValueTrack.find_one({'_id': newId})
    if len(change_rec['city'])>1:
      #Decrement the old one
      db.cityCount.update_one({'_id': change_rec['city'][1]}, {'$inc': {'cnt': -1}}, upsert=True)
      pass
    if chg['operationType']!='delete':
      #Do the update here
      db.cityCount.update_one({'_id': change_rec['city'][0]}, {'$inc': {'cnt': 1}}, upsert=True)
