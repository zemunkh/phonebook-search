const { constants } = require("buffer");
const fs = require("fs");

let cleanedContacts = []

fs.readFile("./contacts.json", "utf8", (err, jsonString) => {
  if (err) {
    console.log("Error reading file from disk:", err);
    return;
  }
  try {
    const contacts = JSON.parse(jsonString);
    contacts.sort(function(a, b) {
      return (a.email > b.email) ? 1 : -1
    });
    // console.log('Sorted: ', sorted[0])
    for (let index = 0; index < contacts.length; index++) {
      const tphone = contacts[index].tphone;
      const phone = contacts[index].phone;
      if(typeof tphone === 'string') {
        contacts[index].tphone = 0
      }
      if(typeof phone === 'number') {
        contacts[index].phone = contacts[index].phone.toString()
      }
      contacts[index].phone = contacts[index].phone.replace('-', '');
      cleanedContacts.push(contacts[index])
      // console.log("T phone: ", typeof phone);
      console.log("Phone: ", contacts[index].phone);
    }

    
    saveNewContacts(contacts)


  } catch (err) {
    console.log("Error parsing JSON string:", err);
  }
});

const saveNewContacts = function(data) {
  const jsonString = JSON.stringify(data)
  fs.writeFile('./newContacts.json', jsonString, err => {
    if (err) {
        console.log('Error writing file', err)
    } else {
        console.log('Successfully wrote file')
    }
  })
}