import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String _baseUrl =
      'http://yourapi.com/api'; // Cambia esto por la URL de tu API

  // Método para obtener los detalles de un usuario por ID
  static Future<User?> getUserById(String userId) async {
    try {
      var response = await http.get(Uri.parse('$_baseUrl/users/$userId'));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Error al cargar el usuario');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Método para actualizar un usuario
  static Future<bool> updateUser(User user) async {
    try {
      var response = await http.put(
        Uri.parse('$_baseUrl/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error al actualizar el usuario, código: $e');
      return false;
    }
  }

  // Método para crear un nuevo usuario
  static Future<User?> createUser(User user) async {
    try {
      var response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Fallo al crear el usuario');
        return null;
      }
    } catch (e) {
      print('Error creando al usuario, código: $e');
      return null;
    }
  }

  static Future<bool> deleteUser(String userId) async {
    try {
      var response = await http.delete(Uri.parse('$_baseUrl/users/$userId'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error mientras se borraba el usuarios, código: $e');
      return false;
    }
  }
}
