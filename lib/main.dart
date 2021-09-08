import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rd_expanse/ui/constants.dart';
import 'package:rd_expanse/ui/global/app_themes.dart';
import 'package:rd_expanse/ui/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const MainAppWithTheme()),
  );
}

class MainAppWithTheme extends StatefulWidget {
  const MainAppWithTheme({
    Key? key,
  }) : super(key: key);

  @override
  _MainAppWithThemeState createState() => _MainAppWithThemeState();
}

class _MainAppWithThemeState extends State<MainAppWithTheme> {
  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<void> getMessages() async {
    await query.getAllSms.then((value) {
      if (value.length > 30) {
        messages = value.sublist(0, 30);
      } else {
        messages = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RD Expanse',
      debugShowCheckedModeBanner: false,
      theme: appThemeData[AppTheme.light],
      home: const HomePage(),
    );
  }
}
