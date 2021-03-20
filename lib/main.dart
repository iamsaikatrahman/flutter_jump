import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jump/datePicker.dart';
import 'package:flutter_jump/jumtopbottom.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Scroll To Top & Bottom';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          "/jumptopbottom": (_) => JumpTopBottom(),
          "/datepicker": (_) => DatePicker(),
        },
        home: MianPage(),
      );
}

class MianPage extends StatefulWidget {
  @override
  _MianPageState createState() => _MianPageState();
}

class _MianPageState extends State<MianPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/jumptopbottom");
                },
                child: Text("JumpTopBottom"),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/datepicker");
                },
                child: Text("DatePicker"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit!'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
              SizedBox(height: 16),
            ],
          ),
        ) ??
        false;
  }
}
