import 'package:flutter/material.dart';
import 'package:max_cafe/pages/contact_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/menu_page.dart';
import 'pages/order_page.dart';
import 'pages/review_page.dart';
import 'pages/about_page.dart';
import 'pages/logout_page.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print("Gagal inisialisasi Firebase: $e");
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: const MaxCafeApp(),
    ),
  );
}

class MaxCafeApp extends StatelessWidget {
  const MaxCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Max Cafe',

      // Pengaturan Tema Global
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: const Color(0xFFFFC107),
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: Colors.black,
        // Menyeragamkan tampilan tombol di seluruh aplikasi
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC107),
            foregroundColor: Colors.black,
          ),
        ),
      ),

      // Rute Navigasi
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
        '/order': (context) => const OrderPage(),
        '/reviews': (context) => const ReviewPage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
        '/logout': (context) => const LogoutPage(),
      },
    );
  }
}
