import 'package:fb_auth_provider/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/auth_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthRepository>().signout();
              },
              icon: Icon(
                Icons.exit_to_app,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flutter_favorite.png',
                    width: 100,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Provider',
                    style: TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
