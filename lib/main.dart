import 'package:flutter/material.dart';
import 'package:flutter_apis/screens/screens.dart';
import 'package:flutter_apis/services/services.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [  
        ChangeNotifierProvider(create: ( _ ) => ProdcutosServicios())
      ],
      child: MyApp(),
    );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'home' : ( _ ) => HomeScreen(),
        'product' : (_) => ProductoEdit(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme : const AppBarTheme(
          elevation : 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}