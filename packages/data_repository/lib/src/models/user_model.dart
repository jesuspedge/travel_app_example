class UserModel {
  final String name;
  final String profilePicture;

  UserModel({required this.name, required this.profilePicture});
}

List<UserModel> users = <UserModel>[
  UserModel(name: 'Allen Daniel', profilePicture: 'assets/images/person1.png'),
  UserModel(name: 'Myla Moreen', profilePicture: 'assets/images/person2.png'),
  UserModel(name: 'Sela Gillian', profilePicture: 'assets/images/person3.png'),
  UserModel(name: 'Lucinda Eva', profilePicture: 'assets/images/person4.png'),
  UserModel(name: 'Erik Brooks', profilePicture: 'assets/images/person5.png'),
  UserModel(name: 'Dave Bevan', profilePicture: 'assets/images/person6.png'),
];
