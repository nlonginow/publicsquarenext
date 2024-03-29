import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publicsquarenext/themore/register.dart';
import 'package:publicsquarenext/themore/support.dart';

import 'themore/about.dart';
import 'app_bottom_navigation.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'myCustomApp',
    options: FirebaseOptions(
      appId: '1:544405577623:android:6689052af84cc70a7d6ed2',
      apiKey: 'AIzaSyCCzbQ2085XmGbl7XnVteh6wxg9KFXaLA8',
      messagingSenderId: '544405577623',
      projectId: 'tpsmobile-f19f3',
    ),
  );
  runApp(MyApp());
}

// Initialize the app to the Firebase project, and authenticate to the admin user
void initializeFirebase() async {
  await Firebase.initializeApp(
    name: 'myCustomApp',
    options: FirebaseOptions(
      appId: '1:544405577623:android:6689052af84cc70a7d6ed2',
      apiKey: 'AIzaSyCCzbQ2085XmGbl7XnVteh6wxg9KFXaLA8',
      messagingSenderId: '544405577623',
      projectId: 'tpsmobile-f19f3',
    ),
  );
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signInWithEmailAndPassword(
    email: "nicklonginow@gmail.com",
    password: "P@ssw0rd060504",
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  analytics.setCurrentScreen(screenName: 'MainScreen');
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: BottomNavigatorProvider())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
      home: const PrimaryApp(),
          routes: {
            '/register': (context) => Register(sourcePage: 'HOME'),
            '/about': (context) => About(),
            '/support': (context) => Support(),
          },
        ));
  }
}
