import 'package:flutter/material.dart';
import '../../data/contact.dart';
import '../../presentation/screens/user_details_page.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: user.id,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/user.png'),
                backgroundColor: Colors.white70,
              ),
            ),
            title: Text('${user.name}'),
            subtitle: Text(user.department),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsPage(user: user)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
