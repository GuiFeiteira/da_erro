class User{

  int id;
  String nome;
  String email;
  String password;

  User(
      this.id,
      this.nome,
      this.email,
      this.password
      );

  factory User.fromJson(Map<String, dynamic>json) => User(
      int.parse(json["id"]),
      json["nome"],
      json["email"],
      json["password"],
  );

  Map<String, dynamic> toJson() =>{
    'id': id.toString(),
    'nome': nome,
    'email': email,
    'password': password,
  };
}

