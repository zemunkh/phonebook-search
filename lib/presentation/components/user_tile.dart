import 'package:flutter/material.dart';
import '../../data/contact.dart';
import '../../domain/repository.dart';
import '../../presentation/screens/user_details_page.dart';

class UserTile extends StatelessWidget {
  final User user;
  final bool isFavorite;
  final VoidCallback onFavoriteClicked;
  UserTile({required this.user, required this.isFavorite, required this.onFavoriteClicked});
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
                backgroundImage: AssetImage('assets/avatars/${user.id % 10}.png'),
                backgroundColor: Colors.white70,
              ),
            ),
            title: Text('${user.name}'),
            subtitle: Text(user.department),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsPage(user: user, onFavClicked: () => onFavoriteClicked())));
            },
            trailing: IconButton(
              icon: Icon(Icons.star,
                color: (isFavorite) ? Colors.yellow[600] : Colors.grey[300],
              ),
              onPressed: () => onFavoriteClicked(),
            ),
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
