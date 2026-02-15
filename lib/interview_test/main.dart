import 'package:flutter/material.dart';
import 'package:flutter_deep/interview_test/presentation/providers/counter_provider.dart';
import 'package:flutter_deep/interview_test/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CounterProvider())],
      child: MaterialApp(
        title: 'Interview Test App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const LoginScreen(),
      ),
    );
  }
}
