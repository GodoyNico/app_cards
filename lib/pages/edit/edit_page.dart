import 'package:app_cards/controllers/card/card_controller.dart';
import 'package:app_cards/entities/cards.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  static String routeName = 'edit_page';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _editCard = false;
  String _title = '';

  Cards _cards = Cards();
  CardController _cardController;
  TextEditingController _titleController;
  TextEditingController _contentController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final card = ModalRoute.of(context).settings.arguments as Cards;
    if (card != null) {
      _editCard = true;
      _cards.id = card?.id ?? '';
    }

    _titleController = TextEditingController(text: card?.title ?? '');
    _contentController = TextEditingController(text: card?.content ?? '');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_editCard) {
      _title = 'Editando';
    } else {
      _title = 'Novo';
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Card: $_title '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Titulo'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Titulo Vazio';
                          }
                          if (value.length <= 3) {
                            return 'Titulo muito curto';
                          }
                          if (value.length >= 30) {
                            return 'Titulo muito longo';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cards.title = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _contentController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Descrição',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira uma descrição';
                          }
                          if (value.length <= 3) {
                            return 'A descrição é muito curta';
                          }
                          if (value.length >= 120) {
                            return 'A descrição é muito longa';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cards.content = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 320,
              child: RaisedButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  if (_editCard) {
                    await _cardController.updateCard(_cards);
                    Navigator.of(context).pop();
                  } else {
                    await _cardController.saveCard(_cards);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
