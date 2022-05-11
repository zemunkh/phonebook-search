import 'package:flutter/material.dart';
import '../../data/contact.dart';
import '../../domain/repository.dart';
import '../../presentation/components/loading_widget.dart';
import '../../presentation/components/user_tile.dart';


class FavoriteContacts extends StatefulWidget {
  const FavoriteContacts({ Key? key }) : super(key: key);

  @override
  State<FavoriteContacts> createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  final List<User> _users = <User>[];
  List<User> _favoriteUsers = <User>[];
  bool _isLoading = true;
  bool _isFavLoading = true;

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

    fetchFavorites().then((favs) {
      setState(() {
        _isFavLoading = false;
        _favoriteContacts = favs;
      });
      fetchUsers().then((users) {
        setState(() {
          users.forEach((u) { 
            if(favs.contains(u.id.toString())) {
              _users.add(u);
            }
          });
          setState(() {
            _isLoading = false;
            _favoriteUsers = _users;
          });
          print(_favoriteUsers.length);
        });
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
      body: (!_isLoading && !_isFavLoading) ? 
        _favoriteContacts.isEmpty ? 
        const Center(child: Text('Бүртгэл байхгүй'),) : ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return UserTile(
              user: _favoriteUsers[index],
              isFavorite: _favoriteContacts.contains(_favoriteUsers[index].id.toString()),
              onFavoriteClicked: () {
                saveFavoriteContact(_favoriteUsers[index].id).then((val){
                  fetchFavorites().then((value) {
                    setState(() {
                      _favoriteContacts = value;
                    });
                  });
                });
              }
            );
        },
        itemCount: _favoriteUsers.length,
      ) : LoadingView(),
      floatingActionButton: _showBackToTopButton == false ? null : FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}