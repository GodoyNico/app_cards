import 'package:app_cards/entities/cards.dart';
import 'package:app_cards/services/cards_service.dart';
import 'package:mobx/mobx.dart';
part 'card_controller.g.dart';

class CardController = _CardControllerBase with _$CardController;

abstract class _CardControllerBase with Store {
  UserService _cardService;
  @observable
  var cards = ObservableList<Cards>();

  _CardControllerBase({UserService cardService}) : _cardService = cardService;

  @action
  void takeAllCards() {
    _cardService.cards().then((value) {
      cards = value.asObservable();
    });
  }

  @action
  Future<void> updateCard(Cards card) async {
    await _cardService.update(card);
    takeAllCards();
  }

  @action
  Future<void> saveCard(Cards card) async {
    var cardSave = await _cardService.save(card);
    cards.add(cardSave);
  }
}
