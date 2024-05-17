import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl =
      'http://localhost:3000'; // Ajusta esto a la URL de tu servidor

  // Método para iniciar sesión
  static Future<bool> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse(
            '$_baseUrl/api/auth/login'), // Asegúrate de que esta ruta coincida con tu backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Aquí podrías guardar el token de sesión si tu API lo devuelve
        return true;
      }
      return false;
    } catch (e) {
      // Manejar excepciones (por ejemplo, problemas de red)
      print(e);
      return false;
    }
  }

  // Método para registrarse
  static Future<bool> register(String name, String email, String rfc, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'rfc': rfc,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
