import 'package:actividad_independiente/actividad_independiente.dart'
    as actividad_independiente;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

void main(List<String> arguments) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  final response = await http.get(url);

  print(response);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);

    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    users.forEach((user) {
      print('ID: ${user.id}');
      print('Name: ${user.name}');
      print('Name Usuario: ${user.username}');
      print('Correo: ${user.email}');
      print('---');
    });

    print('Usuarios con nombre de usuario mayor a 6 caracteres:');
    filterAndPrintUsersByUsernameLength(users);

    int bizDomainCount = countUsersWithBizDomain(users);
    print('Cantidad de usuarios con email en dominio ".biz": $bizDomainCount');
  } else {
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

void filterAndPrintUsersByUsernameLength(List<User> users) {
  List<User> filteredUsers =
      users.where((user) => user.username.length > 6).toList();
  filteredUsers.forEach((user) {
    print('ID: ${user.id}');
    print('Nombre Usuario: ${user.username}');
    print('---');
  });
}

int countUsersWithBizDomain(List<User> users) {
  return users.where((user) => user.email.endsWith('.biz')).length;
}
