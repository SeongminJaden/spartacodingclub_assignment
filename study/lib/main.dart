import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Study',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/logo.png', width: 150, height: 150),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('kakao Login');
              },
              child: Text('kakao Login'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('instagram Login');
              },
              child: Text('instagram Login'),
            ),
          ],
        ),
      ),
    );
  }
}
