abstract class MockData {
  static UserLog logedUser;

  static List<UserLog> users = [
    UserLog(email: 'growdev@growdev.com', password: 'growdev@2020')
  ];
}

class UserLog {
  String email;
  String password;
  UserLog({
    this.email,
    this.password,
  });
}
