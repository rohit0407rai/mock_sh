class UserSignupModel {
  final String username;
  final String email;
  final String password;

  UserSignupModel({required this.username,required this.email, required this.password});


  factory UserSignupModel.fromMap(Map<String, dynamic> map) {
    return UserSignupModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
