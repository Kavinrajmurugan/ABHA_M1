import 'package:http/http.dart' as http;
import 'dart:convert';

class AbhaRepository {
  final Uri baseUrl;

  AbhaRepository({required this.baseUrl});

  Future<void> generateAadhaarOtp(String aadhaarNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/generate-aadhaar-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'aadhaarNumber': aadhaarNumber}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to generate Aadhaar OTP: ${response.body}');
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-phonenumber'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to verify phone number: ${response.body}');
    }
  }

  Future<void> generatePhoneOtp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
    if (phoneNumber.length != 10) {
      throw Exception("Invalid Phone Number");
    }
  }

  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    return otp == "123456"; // Simulated valid OTP
  }
}
