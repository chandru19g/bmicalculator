import 'package:bmicalculator/routes/routes.dart';
import 'package:bmicalculator/services/ad_service.dart';
import 'package:bmicalculator/services/banner_service.dart';
import 'package:bmicalculator/services/value_service.dart';
import 'package:bmicalculator/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // final adState = AdService();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueService>(
          create: (context) => ValueService(),
        ),
        ChangeNotifierProvider<AdService>(
          create: (context) => AdService(),
        ),
        ChangeNotifierProvider<BannerService>(
          create: (context) => BannerService(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Bmi Calculator',
          darkTheme: Themes.dark,
          themeMode: ThemeMode.dark,
          initialRoute: RouteManager.homeScreen,
          onGenerateRoute: RouteManager.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
