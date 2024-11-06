import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  final List<Map<String, String>> _organizations = [];
  final Map<String, Map<String, String>> _patients = {};
  int _tokenCounter = 1;

  Map<String, Map<String, String>> get patients => _patients;

  List<Map<String, String>> get organizations => _organizations;

  void addOrganization(Map<String, String> organization) {
    _organizations.add(organization);
    notifyListeners();
  }

  // Method to add a patient and generate a token
  void addPatientWithToken(Map<String, String> patientDetails) {
    final token = 'T$_tokenCounter'; // Generate token
    _tokenCounter++; // Increment token counter
    patientDetails['token'] = token; // Assign token to patient details
    _patients[token] = patientDetails; // Add patient details with token
    notifyListeners();
  }

  Map<String, String>? getPatientByToken(String token) {
    return _patients[token];
  }

  void updatePatientDetails(String token, Map<String, String> updatedDetails) {
    _patients[token] = updatedDetails;
    notifyListeners();
  }


}