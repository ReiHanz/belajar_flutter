import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DeleteDisasterScreen extends StatefulWidget {
  @override
  _DeleteDisasterScreenState createState() => _DeleteDisasterScreenState();
}

class _DeleteDisasterScreenState extends State<DeleteDisasterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1');
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Disaster'),
        backgroundColor: Colors.red.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_idController, 'ID', 'Please enter ID'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int id = int.parse(_idController.text);
                      apiService.deleteDisaster(id).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Disaster deleted successfully'),
                          backgroundColor: Colors.green,
                        ));
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to delete disaster'),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor: Colors.red.shade700,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String errorText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.red.shade50,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
