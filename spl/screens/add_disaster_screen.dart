import 'package:flutter/material.dart';
import '../../models/disaster_model.dart';
import '../../services/api_service.dart';
import '../../main.dart';

class AddDisasterScreen extends StatefulWidget {
  @override
  _AddDisasterScreenState createState() => _AddDisasterScreenState();
}

class _AddDisasterScreenState extends State<AddDisasterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:80');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${_selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    Disaster newDisaster = Disaster(
      id: 0,
      name: _nameController.text,
      description: _descriptionController.text,
      date: _dateController.text,
      location: _locationController.text,
    );

    apiService.addDisaster(newDisaster).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Disaster added successfully'),
        backgroundColor: Colors.green,
      ));

      // Redirect to the main screen (DisasterListScreen) after adding
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print("Failed to add disaster: $error"); // Logging the error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add disaster: $error'),
        backgroundColor: Colors.red,
      ));
    });
  }
}


  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Disaster'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
