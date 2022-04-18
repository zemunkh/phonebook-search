import 'package:flutter/material.dart';
import '../../data/contact.dart';
import 'package:url_launcher/url_launcher.dart';
class UserDetailsPage extends StatelessWidget {

  final User user;

  UserDetailsPage({required this.user});

  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
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
        title: Text('${user.name}'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: Hero(
                tag: user.id,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/user.png'),
                  backgroundColor: Colors.white70,
                  radius: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 22.0,
            ),
            Text(
              '${user.name}',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              '${user.department}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.email}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
                FlatButton(
                  onPressed: () {
                    customLaunch('mailto:${user.email}?subject=Contact%20Information&body=Type%20your%20mail%20here');
                  },
                  child: Icon(
                    Icons.email,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
                FlatButton(
                  onPressed: () {
                    // customLaunch('tell:+976-${user.phone}');
                    _makePhoneCall(user.phone);
                  },
                  child: Icon(
                    Icons.phone,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
