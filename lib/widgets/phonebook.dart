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
  bool _isFavLoading = true;
  final TextEditingController _controller = TextEditingController();
  bool _showBackToTopButton = false;
  final ScrollController _scrollController = ScrollController();
  List<String> _favoriteContacts = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // print('Something happening ${_scrollController.offset}');
      if (_scrollController.offset >= 400) {
        setState(() {
          _showBackToTopButton = true;
        });
      } else {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    });

    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        print(_usersDisplay.length);
      });
    });

    fetchFavorites().then((value) {
      setState(() {
        _isFavLoading = false;
        _favoriteContacts = value;
      });
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 600), curve: Curves.linear);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (!_isLoading && !_isFavLoading) ? ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : 
            UserTile(
              user: _usersDisplay[index - 1],
              isFavorite: _favoriteContacts.contains(_usersDisplay[index - 1].id.toString()),
              onFavoriteClicked: () {
                saveFavoriteContact(_usersDisplay[index - 1].id).then((val){
                  fetchFavorites().then((value) {
                    setState(() {
                      _favoriteContacts = value;
                    });
                  });
                });
              }
            );
        },
        itemCount: _usersDisplay.length + 1,
      ) : LoadingView(),
      floatingActionButton: _showBackToTopButton == false ? null : FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _controller,
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
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Нэр, утас, алба, и-мейл...',
          suffixIcon: _controller.text.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.text = '';
                fetchUsers().then((value) {
                  setState(() {
                    _isLoading = false;
                    _users.addAll(value);
                    _usersDisplay = _users;
                    print(_usersDisplay.length);
                  });
                });
              },
            ),
        ),
      ),
    );
  }
}