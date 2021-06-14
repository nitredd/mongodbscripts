//Execute these first
db.people.insertOne({_id: 1, name: "Neil", city: "Mumbai"})
db.people.insertOne({_id: 2, name: "Nidhi", city: "Hyderabad"})
//Start the script here, then look at cityCount before and after each of the following
db.people.updateOne({_id: 1}, {$set:{city:"Hyderabad"}})
db.people.updateOne({_id: 1}, {$set:{city:"Delhi"}})
db.people.insertOne({_id: 3, name: "Nitin", city: "Dubai"})
db.people.deleteOne({_id: 3})

