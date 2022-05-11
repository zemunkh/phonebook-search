import 'package:flutter/material.dart';
import '../../data/contact.dart';
import '../../domain/repository.dart';
import 'package:url_launcher/url_launcher.dart';
class UserDetailsPage extends StatefulWidget {

  final User user;
  final VoidCallback onFavClicked;

  UserDetailsPage({required this.user, required this.onFavClicked });

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool _isFavLoading = true;
  List<String> _favoriteContacts = [];
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    fetchFavorites().then((value) {
      
      if(value.contains(widget.user.id.toString())) {
        setState(() {
          _isFavorite = true;
        });
      }
    });
  }

  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
      // ignore: avoid_print
      print('Error');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.user.name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star,
              color: _isFavorite ? Colors.yellow[600] : Colors.grey[400],
            ),
            onPressed: () {
              // saveFavoriteContact(widget.user.id);
              setState(() {
                _isFavorite = !_isFavorite;
              });
              widget.onFavClicked();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 22.0,
            ),
            Center(
              child: Hero(
                tag: widget.user.id,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatars/${widget.user.id % 10}.png'),
                  backgroundColor: Colors.white70,
                  radius: 100.0,
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
            ),
            Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.user.department,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            widget.user.email.length > 5 ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {customLaunch('mailto:${widget.user.email}')},
              icon: const Icon(Icons.send_rounded,),
              label: Text(widget.user.email, style: const TextStyle(fontSize: 20),),
            ) : const Text(''),
            const SizedBox(
              height: 12.0,
            ),
            widget.user.phone != '' ?
            const Text(
              'Гар утас',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ) : const Text(''),
            widget.user.phone != '' ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {_makePhoneCall(widget.user.phone)},
              icon: const Icon(Icons.phone_android_rounded,),
              label: Text(widget.user.phone, style: const TextStyle(fontSize: 20),),
            ) : const Text(''),

            widget.user.tphone != 0 ?
            const Text(
              'Ширээний утас',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ) : const Text(''),

           widget.user.tphone >= 1000 ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: const TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {_makePhoneCall('7128${widget.user.tphone}')},
              icon: const Icon(Icons.phone_callback_rounded,),
              label: Text('${widget.user.tphone}', style: const TextStyle(fontSize: 20),),
            ) : const Text(''),
          ],
        ),
      ),
    );
  }
}
