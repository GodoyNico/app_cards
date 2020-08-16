import 'dart:convert';
import 'package:app_cards/entities/cards.dart';
import 'package:app_cards/entities/state.dart';
import 'package:app_cards/utils/network_helper.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio _dio;
  UserService({AppState appState})
      : _dio = NetworkHelper.getDioInstance(appState: appState);

  Future<List<Cards>> cards({int id}) async {
    var response = await _dio.get('/cards',
        queryParameters: id != null ? {'id': id} : null);
    var receive = List<Cards>();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List list = response.data;
      list.forEach((element) {
        receive.add(Cards.fromMap(element));
      });
    } else {
      print('Erro');
    }
    return receive;
  }

  Future<Cards> porId(int id) async {
    var response = await _dio.get('/cards/$id');
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);
        if (receive.id == null) {
          print('Erro');
        } else {
          print(receive);
        }
      }
    } catch (e) {
      print('Erro: $e');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
    } else {
      print('Erro');
    }
    return receive;
  }

  Future<Cards> save(Cards card) async {
    var dataCard = jsonEncode(card.toMap());
    var response = await _dio.post('/cards', data: dataCard);
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);
        print('Card salvo com sucesso');
      }
    } catch (e) {
      print('Erro: $e');
    }
    return receive;
  }

  Future<Cards> update(Cards card) async {
    var dataCard = jsonEncode(card.toMap());
    var response = await _dio.put('/cards/${card.id}', data: dataCard);
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);

        print('Alterado com sucesso');
      }
    } catch (e) {
      print('Algo deu errado. $e');
    }
    return receive;
  }

  //TODO: Implementar
  Future<void> delete(int id) async {
    var response = await _dio.delete('/cards/$id');
    if (response.statusCode >= 300 && response.statusCode < 200) {
      print('Algo deu errado tente novamente');
    } else {
      print('Deletado com sucesso');
    }
  }
}
