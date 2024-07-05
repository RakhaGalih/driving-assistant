import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sdla/screens/auth/login.dart';
import 'package:sdla/services/background_app.dart';
import 'package:sdla/services/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // handle your logic here
    },
  );
  
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerService(flutterLocalNotificationsPlugin)),
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
