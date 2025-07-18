import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/pages/first_page.dart';
import 'views/pages/second_page.dart';
import 'views/pages/third_page.dart';
import 'viewmodels/first_page_viewmodel.dart';
import 'viewmodels/second_page_viewmodel.dart';
import 'viewmodels/third_page_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirstPageViewModel()),
        ChangeNotifierProvider(create: (_) => SecondPageViewModel()),
        ChangeNotifierProvider(create: (_) => ThirdPageViewModel()),
      ],
      child: MaterialApp(
        title: 'Suitmedia Flutter Test',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const FirstPage(),
          '/second': (context) => const SecondPage(),
          '/users': (context) => const ThirdPage(),
        },
      ),
    );
  }
}
