import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/Provider/provider.dart';
import 'package:demo/data/questions_doctor.dart';

class DoctorDiagnosisScreen extends StatefulWidget {
  const DoctorDiagnosisScreen({super.key});

  @override
  _DoctorDiagnosisScreenState createState() => _DoctorDiagnosisScreenState();
}

class _DoctorDiagnosisScreenState extends State<DoctorDiagnosisScreen> {
  final _tokenController = TextEditingController();
  Map<String, String>? _patientDetails;
  final Map<String, String> _diagnosis = {}; // To hold answers for each question

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Doctor Diagnosis'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'Enter Patient Token',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.teal.shade400),
                ),
              ),
              onChanged: (value) {
                // Optionally trigger fetching patient details here.
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final token = _tokenController.text;
                if (token.isNotEmpty) {
                  final patientDetails = registrationProvider.patients[token];
                  if (patientDetails != null) {
                    setState(() {
                      _patientDetails = patientDetails;
                    });
                  } else {
                    // Handle case where token is not found
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Patient not found.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Fetch Patient Details'),
            ),
            const SizedBox(height: 20),
            if (_patientDetails != null) ...[
              // Display patient details with teal text style
              _buildPatientDetail('Organization', _patientDetails!['organization']),
              _buildPatientDetail('Name', _patientDetails!['Name:']),
              _buildPatientDetail('Age', _patientDetails!['Age:']),
              _buildPatientDetail('Weight', _patientDetails!['Weight:']),
              _buildPatientDetail('Blood Group', _patientDetails!['Blood Group:']),
              _buildPatientDetail('Gender', _patientDetails!['Gender:']),
              const SizedBox(height: 20),
              // Display the list of questions
              ..._generateQuestionWidgets(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the diagnosis
                  print('Diagnosis: $_diagnosis');
                  // Optional: save to a backend or local storage here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save Diagnosis'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper function to build patient detail widgets
  Widget _buildPatientDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$label: ${value ?? 'Not available'}',
        style: TextStyle(
          fontSize: 16,
          color: Colors.teal.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Generate question widgets
  List<Widget> _generateQuestionWidgets() {
    return questions.map((question) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your answer here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.teal.shade400),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _diagnosis[question.text] = value;
                });
              },
            ),
          ],
        ),
      );
    }).toList();
  }
}
