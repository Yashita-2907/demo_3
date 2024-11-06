import 'package:flutter/material.dart';
import 'patient_registration_screen.dart';
import 'organization_registration_screen.dart';
import 'doctor_diagnosis_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Logo Image
              Image.asset(
                'assets/images/apala-ghar.png',
                width: 300,
              ),
              const SizedBox(height: 60),

              // Title Text
              const Text(
                'Choose Your Action!',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Organization Registration Button
              GradientOutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationRegistrationScreen(),
                    ),
                  );
                },
                icon: Icons.business,
                label: 'Organization Registration',
              ),
              const SizedBox(height: 16),

              // Patient Registration Button
              GradientOutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientRegistrationScreen(
                        organizationData: {}, // Update if necessary
                      ),
                    ),
                  );
                },
                icon: Icons.person_add,
                label: 'Patient Registration',
              ),
              const SizedBox(height: 16),

              // Doctor Diagnosis Button
              GradientOutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDiagnosisScreen(),
                    ),
                  );
                },
                icon: Icons.health_and_safety,
                label: 'Doctor Diagnosis',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const GradientOutlinedButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.teal.shade400),
        foregroundColor: Colors.teal.shade800,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.teal.withOpacity(0.3),
        elevation: 2,
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
      icon: Icon(icon, color: Colors.teal.shade700),
      label: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.teal.shade600, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
