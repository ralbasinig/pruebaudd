import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:noteu_app/screens/home.dart';
import 'package:noteu_app/screens/splashscreen.dart';
import 'package:noteu_app/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: AppTheme.light, // Usa el tema claro definido en AppTheme
      darkTheme: AppTheme.dark, // Usa el tema oscuro definido en AppTheme
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
return const Mantenedor();
  }
}