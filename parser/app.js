const fs = require("fs");

let cleanedContacts = []

fs.readFile("./newContacts.json", "utf8", (err, jsonString) => {
  if (err) {
    console.log("Error reading file from disk:", err);
    return;
  }
  try {
    const contacts = JSON.parse(jsonString);

    for (let index = 0; index < contacts.length; index++) {
      const tphone = contacts[index].tphone;
      const phone = contacts[index].phone;
      // if(typeof tphone === 'string') {
      //   contacts[index].tphone = 0
      // }
      // if(typeof phone === 'number') {
      //   contacts[index].phone = contacts[index].phone.toString()
      // }
      // cleanedContacts.push(contacts[index])
      console.log("T phone: ", typeof tphone);
    }
    // saveNewContacts(cleanedContacts)
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