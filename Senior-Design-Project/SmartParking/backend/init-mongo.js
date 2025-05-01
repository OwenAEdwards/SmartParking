db = db.getSiblingDB('SmartParkingDb');  // Switch to the target database
db.createUser({
    user: 'myUser',
    pwd: 'myPassword',
    roles: [{ role: 'readWrite', db: 'SmartParkingDb' }]
});
