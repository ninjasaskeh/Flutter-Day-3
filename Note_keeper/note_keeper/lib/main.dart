import 'package:flutter/material.dart';


import 'pages/note_page.dart';


void main() {
 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
 const MyApp({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Flutter Demo',
     theme: ThemeData(
       primaryColor: Colors.black,
       scaffoldBackgroundColor: Colors.blueGrey.shade900,
       appBarTheme: const AppBarTheme(
         backgroundColor: Colors.transparent,
         elevation: 0
       )
     ),
     home: const NotePage(),
   );
 }
}





