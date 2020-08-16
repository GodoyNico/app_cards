import 'package:app_cards/controllers/auth/auth_controller.dart';
import 'package:app_cards/controllers/card/card_controller.dart';
import 'package:app_cards/entities/user.dart';
import 'package:app_cards/pages/edit/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Provider.of<AuthController>(context);
    CardController _cardController = Provider.of<CardController>(context)
      ..takeAllCards();
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Observer(
              builder: (context) {
                var _user = User(
                  email: _authController.appState.email,
                  name: _authController.appState.email,
                );
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue[900]),
                  accountEmail: Text(_user.email),
                  accountName: Text(_user.name),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.orange[800],
                      size: 50,
                    ),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                _authController.signOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPage.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _cardController?.cards?.length ?? 1,
              itemBuilder: (context, index) {
                return _card(
                  _cardController.cards[index].title,
                  _cardController.cards[index].content,
                  _cardController.cards[index].id,
                  () {
                    Navigator.of(context).pushNamed(EditPage.routeName,
                        arguments: _cardController.cards[index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _card(String title, String content, int index, Function editar) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(width: 2.0, color: Colors.orange[800]),
          left: BorderSide(width: 2.0, color: Colors.orange[800]),
          right: BorderSide(width: 2.0, color: Colors.orange[800]),
          bottom: BorderSide(width: 2.0, color: Colors.orange[800]),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange[800],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                    child: Text(
                  index.toString() ?? '',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              SizedBox(width: 20),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: title ?? '',
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Text(
            content ?? '',
            maxLines: 8,
          ),
          Divider(height: 20),
          FlatButton(
            onPressed: editar,
            child: Text('Editar'),
          ),
        ],
      ),
    );
  }
}
