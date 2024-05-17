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
            '$_baseUrl/login'), // Asegúrate de que esta ruta coincida con tu backend
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
  static Future<bool> register(
      String name, String email, String rfc, String password) async {
    try {
      var response = await http.post(
        Uri.parse(
            '$_baseUrl/register'), // Asegúrate de que esta ruta coincida con tu backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'rfc': rfc,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Aquí podrías manejar la respuesta después del registro, como iniciar sesión automáticamente
        return true;
      }
      return false;
    } catch (e) {
      // Manejar excepciones
      print(e);
      return false;
    }
  }
}
