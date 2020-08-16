import 'package:app_cards/database/mockdata.dart';

class LoginService {
  Future<bool> signIn({String email, String password}) async {
    MockData.logedUser = null;
    await Future.delayed(Duration(milliseconds: 500), () {
      MockData.logedUser = MockData.users.firstWhere(
          (element) => element.email == email && element.password == password,
          orElse: () => null);
    });
    return MockData.logedUser != null;
  }

  Future<void> signOut() async {
    await Future.delayed(
      Duration(milliseconds: 500),
      () => MockData.logedUser = null,
    );
  }
}
