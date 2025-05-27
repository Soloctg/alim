import 'package:alim/auth/login_screen.dart';
import 'package:alim/auth/register_screen.dart';
import 'package:alim/screens/cart_screen.dart';
import 'package:alim/screens/checkout_screen.dart';
import 'package:alim/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:alim/screens/details_screen.dart';
import 'package:alim/screens/home_screen.dart';
import 'package:alim/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:alim/models/cart_model.dart';
import 'firebase_options.dart'; // auto-generated
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const AlimApp(),
    ),
  );
}

class AlimApp extends StatelessWidget {
  const AlimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlimUdo Farms',
      theme: ThemeData(
        primaryColor: Color(0xFFD17B33),
        scaffoldBackgroundColor: const Color.fromARGB(255, 22, 1, 1),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/cart': (context) => CartScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8A4E2F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/welcome.png'),

            CircularProgressIndicator(color: Colors.amberAccent),
          ],
        ),
      ),
    );
  }
}
