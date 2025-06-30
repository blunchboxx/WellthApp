
import 'package:firebase_core/firebase_core.dart';                  // Added from codelab
import 'package:flutter/material.dart';
import 'package:wellth_app/auth/login_or_register.dart';
import 'package:wellth_app/home.dart';

import 'app.dart';
import 'firebase_options.dart'; 
import 'pages/custom_login_page.dart';
import 'pages/register_page.dart';
import 'package:wellth_app/auth/auth.dart';

// Added from codelab

// TODO(codelab user): Get API key
const clientId = '600688007911-m0c0a2tmvf3bk21itqh4vkcod40566jv.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp(clientId: clientId));
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key, required String clientId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),

      //temp to setup register page - need to implement routes

      //home: CustomLoginPage(clientId: clientId,),
      //home: HomeScreen(),
    );
    // Define routes

  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();

//     return Scaffold(
//       body: Column(
//         children: [Text('A random DOPE idea:'), 
//         Text(appState.current.asLowerCase),
        
//         ElevatedButton(
//           onPressed: () {
//             print('button pressed!');
//           },
//           child: Text('Next'),
//         ),
        
//         ],
//       ),
//     );
//   }
// }