import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/Provider/provider.dart';
import 'package:demo/data/questions.dart';

class PatientRegistrationScreen extends StatefulWidget {
  final Map<String, String> organizationData;

  const PatientRegistrationScreen({super.key, required this.organizationData});

  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  String? _selectedOrganization;
  Map<String, String> patientDetails = {};

  String? _selectedBloodGroup;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Patient Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dropdown to select organization
            DropdownButtonFormField<String>(
              value: _selectedOrganization,
              hint: const Text('Select Organization'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.teal.shade400),
                ),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOrganization = newValue;
                });
              },
              items: registrationProvider.organizations
                  .map<DropdownMenuItem<String>>((org) {
                return DropdownMenuItem<String>(
                  value: org['name'],
                  child: Text(org['name'] ?? 'Unknown'),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Loop through questions and display corresponding widgets
            ...questions.map((question) {
              if (question.text == 'Blood Group:') {
                return DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  hint: const Text('Select Blood Group'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.teal.shade400),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBloodGroup = newValue;
                      patientDetails[question.text] = newValue!;
                    });
                  },
                  items: question.answers
                      .map<DropdownMenuItem<String>>((answer) {
                    return DropdownMenuItem<String>(
                      value: answer,
                      child: Text(answer),
                    );
                  }).toList(),
                );
              } else if (question.text == 'Gender:') {
                return DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: const Text('Select Gender'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.teal.shade400),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                      patientDetails[question.text] = newValue!;
                    });
                  },
                  items: question.answers
                      .map<DropdownMenuItem<String>>((answer) {
                    return DropdownMenuItem<String>(
                      value: answer,
                      child: Text(answer),
                    );
                  }).toList(),
                );
              } else if (question.answers.isEmpty) {
                // Text field for questions without predefined answers
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: question.text,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.teal.shade400),
                    ),
                  ),
                  onChanged: (value) {
                    patientDetails[question.text] = value;
                  },
                );
              } else {
                return const SizedBox(); // Placeholder for unexpected cases
              }
            }).toList(),

            const SizedBox(height: 20),
            // Register button
            OutlinedButton.icon(
              onPressed: () {
                if (_selectedOrganization != null) {
                  registrationProvider.addPatientWithToken({
                    'organization': _selectedOrganization!,
                    ...patientDetails, // Merge patient details
                  });
                }
              },
              icon: Icon(Icons.save, color: Colors.teal.shade700),
              label: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.teal.shade600, Colors.teal.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'Register Patient',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.teal.shade400),
                foregroundColor: Colors.teal.shade800,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ).copyWith(
                side: MaterialStateProperty.resolveWith(
                  (states) => BorderSide(
                    color: states.contains(MaterialState.pressed)
                        ? Colors.teal.shade600
                        : Colors.teal.shade400,
                  ),
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.hovered)
                      ? Colors.teal.shade900
                      : Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
