import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_ai_chatgpt/authentication/registration_screen.dart';
import 'package:open_ai_chatgpt/authentication/user_information_screen.dart';
import 'package:open_ai_chatgpt/constants/constants.dart';
import 'package:open_ai_chatgpt/main_screens/home_screen.dart';
import 'package:open_ai_chatgpt/providers/authentication_provider.dart';
import 'package:open_ai_chatgpt/providers/my_theme_provider.dart';
import 'package:open_ai_chatgpt/themes/my_theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyThemeProvider()),
    ChangeNotifierProvider(create: (_) => AuthenticationProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    getCurrentTheme();
    super.initState();
  }

  void getCurrentTheme() async {
    await Provider.of<MyThemeProvider>(context, listen: false).getThemeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme:
              MyTheme.themeData(isDarkTheme: value.themeType, context: context),
          initialRoute: Constants.registrationScreen,
          routes: {
            Constants.registrationScreen: (context) => const RegistrationScreen(),
            Constants.homeScreen: (context) => const HomeScreen(),
            Constants.userInformationScreen: (context) => const UserInformationScreen(),
          },
        );
      },
    );
  }
}
