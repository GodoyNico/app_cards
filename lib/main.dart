import 'package:app_cards/pages/edit/edit_page.dart';
import 'package:app_cards/pages/home/home_page.dart';
import 'package:app_cards/pages/login/login_page.dart';
import 'package:app_cards/repositories/state_repository.dart';
import 'package:app_cards/services/cards_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'controllers/auth/auth_controller.dart';
import 'controllers/card/card_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (_) =>
              AuthController(appStateRepository: AppStateRepository())
                ..getCurrent(),
        ),
        ProxyProvider<AuthController, CardController>(
          update: (context, authController, __) => CardController(
            cardService: UserService(appState: authController.appState),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context);
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Color.fromRGBO(38, 59, 94, 1))),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) {
          return Observer(
            builder: (context) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!controller.isLogedIn) {
                return LoginPage();
              }
              return HomePage();
            },
          );
        },
        EditPage.routeName: (context) => EditPage(),
      },
    );
  }
}
