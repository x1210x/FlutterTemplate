import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/data/rest_client.dart';
import 'package:flutter_template/ui/detail/photo.dart';
import 'package:flutter_template/ui/detail/webview.dart';
import 'package:flutter_template/ui/home/home.dart';
import 'package:flutter_template/ui/splash/splash.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

EventBus eventBus = EventBus();
RestClient restClient = RestClient(Dio(BaseOptions(headers: headers))
  ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90
  )));

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(title: 'Flutter Template')
      },
      onGenerateRoute: (settings) {
        if (settings.name != null && settings.name != '/') {
          return createRoute(settings.name!, settings.arguments);
        } else {
          return null;
        }
      },
    );
  }
}

Route createRoute(String route, Object? arguments) => PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) {
    if (route == PhotoScreen.routeName) {
      return PhotoScreen(param: arguments as PhotoParam);
    } else if (route == WebViewScreen.routeName) {
      final args = arguments as WebViewArguments;
      return WebViewScreen(title: args.title, url: args.url);
    }
    throw Exception();
  },
  transitionDuration: const Duration(milliseconds: 200),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child
    );
  }
);