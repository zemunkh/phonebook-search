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
        title: Text('${user.name}'),
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
                tag: user.id,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatars/${user.id % 10}.png'),
                  backgroundColor: Colors.white70,
                  radius: 100.0,
                ),
              ),
            ),
            const SizedBox(
              height: 22.0,
            ),
            Text(
              user.name,
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
                user.department,
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
            user.email.length > 5 ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {customLaunch('mailto:${user.email}')},
              icon: const Icon(Icons.send_rounded,),
              label: Text(user.email, style: const TextStyle(fontSize: 20),),
            ) : const Text(''),
            const SizedBox(
              height: 12.0,
            ),
            user.phone != '' ?
            const Text(
              'Гар утас',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ) : const Text(''),
            user.phone != '' ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {_makePhoneCall(user.phone)},
              icon: const Icon(Icons.phone_android_rounded,),
              label: Text(user.phone, style: const TextStyle(fontSize: 20),),
            ) : const Text(''),

            user.tphone != 0 ?
            const Text(
              'Ширээний утас',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ) : const Text(''),

           user.tphone >= 1000 ?
            TextButton.icon(
              style: TextButton.styleFrom(
                shadowColor: Colors.blue,
                textStyle: const TextStyle(color: Colors.blue),
                backgroundColor: Colors.white,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ), 
              ),
              onPressed: () => {_makePhoneCall('7128${user.tphone}')},
              icon: const Icon(Icons.phone_callback_rounded,),
              label: Text('${user.tphone}', style: const TextStyle(fontSize: 20),),
            ) : const Text(''),
          ],
        ),
      ),
    );
  }
}
