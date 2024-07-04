import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sdla/screens/auth/login.dart';
import 'package:sdla/services/background_app.dart';
import 'package:sdla/services/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerService()),
        ChangeNotifierProvider(create: (_) => SelectedDateProvider()),
      ],
      child: const MainApp(),
    ),
  );
  });
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Poppins",
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue),
        home: const Login());
  }
}
