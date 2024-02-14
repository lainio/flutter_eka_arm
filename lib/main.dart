import 'package:authn/authn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eka_arm/base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebAuthn Translator Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WebAuthn Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Wiget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accountName = "demo_";
  String _pinCode = "99";
  String _jwt = "";

  Future register() async {
    final jwt = await authnCmd("register", _accountName, _pinCode);
    debugPrint('jwt: $jwt');
  }

  Future login() async {
    final jwt = await authnCmd("login", _accountName, _pinCode);
    debugPrint('=== jwt ===');
    debugPrint(jwt);
    debugPrint('=== jwt ===');
    setState(() {
      _jwt = jwt;
    });
  }

  void _onSubmittedAccount(String value) {
    setState(() {
      _accountName = value;
      debugPrint('input: $_accountName');
    });
  }

  void _onSubmittedPIN(String value) {
    setState(() {
      _pinCode = value;
      debugPrint('input: $_pinCode');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BasePage(
      child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Register new account',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Sign up using your TPM or virtual secure element.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              'Your account name: ($_accountName, $_pinCode)',
            ),
            TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Account',
              ),
              onSubmitted: _onSubmittedAccount,
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              maxLength: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PIN',
              ),
              onSubmitted: _onSubmittedPIN,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: register,
                child: const Text('sign up'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  side: BorderSide(
                      width: 2, color: Theme.of(context).primaryColor),
                ),
                onPressed: login,
                child: const Text('I already have an account'),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'JWT: ($_jwt)',
            ),
          ],
        ),
      ),
    );
  }
}
