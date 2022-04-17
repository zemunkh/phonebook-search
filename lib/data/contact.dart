
class User {
  int id = 0;
  String name ="";
  String email ="";
  String department ="";
  int tphone = 0;
  String phone ="";


  User(this.id, this.email, this.name, this.department, this.tphone, this.phone);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    department = json['department'];
    tphone = json['tphone'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['department'] = this.department;
    data['tphone'] = this.tphone;
    data['phone'] = this.phone;
    return data;
  }
}