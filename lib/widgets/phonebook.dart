import 'package:flutter/material.dart';
import '../../data/contact.dart';
import '../../domain/repository.dart';
import '../../presentation/components/loading_widget.dart';
import '../../presentation/components/user_tile.dart';

class Phonebook extends StatefulWidget {
  const Phonebook({ Key? key }) : super(key: key);

  @override
  State<Phonebook> createState() => _PhonebookState();
}

class _PhonebookState extends State<Phonebook> {
  final List<User> _users = <User>[];
  List<User> _usersDisplay = <User>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        print(_usersDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (!_isLoading) {
          return index == 0 ? _searchBar() : UserTile(user: _usersDisplay[index - 1]);
        } else {
          return LoadingView();
        }
      },
      itemCount: _usersDisplay.length + 1,
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _usersDisplay = _users.where((u) {
              var name = u.name.toLowerCase();
              var tphone = u.tphone.toString();
              var phone = u.phone.toLowerCase();
              var email = u.email.toLowerCase();
              var department = u.department.toLowerCase();
              return name.contains(searchText) || email.contains(searchText) || department.contains(searchText) || tphone.contains(searchText) || phone.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Нэр, утас, алба, и-мейл...',
        ),
      ),
    );
  }
}