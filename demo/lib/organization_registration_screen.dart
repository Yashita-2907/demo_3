import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/Provider/provider.dart';

class OrganizationRegistrationScreen extends StatefulWidget {
  const OrganizationRegistrationScreen({super.key});

  @override
  _OrganizationRegistrationScreenState createState() => _OrganizationRegistrationScreenState();
}

class _OrganizationRegistrationScreenState extends State<OrganizationRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _organizationDetails = {};
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Organization Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Organization Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Organization Name',
                  labelStyle: TextStyle(color: Colors.teal.shade800),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade400),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the organization name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _organizationDetails['name'] = value!;
                },
              ),
              const SizedBox(height: 16),

              // Location Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.teal.shade800),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal.shade400),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _organizationDetails['location'] = value!;
                },
              ),
              const SizedBox(height: 16),

              // Date Picker
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  style: TextStyle(color: Colors.teal.shade800),
                ),
                trailing: Icon(Icons.calendar_today, color: Colors.teal.shade800),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                      _organizationDetails['date'] =
                          picked.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Save Organization Checkbox
              CheckboxListTile(
                title: const Text('Save Organization'),
                activeColor: Colors.teal,
                value: _organizationDetails['save'] == 'true',
                onChanged: (value) {
                  setState(() {
                    _organizationDetails['save'] = value.toString();
                  });
                },
              ),
              const SizedBox(height: 16),

              // Save and Register Button
              OutlinedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (_organizationDetails['save'] == 'true') {
                      Provider.of<RegistrationProvider>(context, listen: false)
                          .addOrganization(_organizationDetails);
                    }

                    Navigator.pop(context);
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
                    'Save and Register',
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
      ),
    );
  }
}

