import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

Widget infoText(String value, IconData iconData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(iconData, color: Colors.blueGrey),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
          ),
        ),
      ),
    ],
  );
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: const DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/cnslogo.png'),
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoText(
                        'Улаанбаатар хот, Хан-Уул дүүрэг, 21-р дугаар хороо, Буянт-Ухаа',
                        Icons.location_pin),
                    infoText('71281659', Icons.phone_android_rounded),
                    infoText('cns_office@mcaa.gov.mn', Icons.email_outlined),
                  ],
                ),
              ),
            ),
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 5.0, bottom: 20.0),
          ),
          Card(
            child: Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: const DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('assets/nav.jpg'))),
              child: const Padding(
                padding: const EdgeInsets.fromLTRB(12, 200, 0, 0),
                child: Text(
                  'Навигацийн хэсэг 2022 он',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            ),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          ),
        ],
      ),
    );
  }
}
