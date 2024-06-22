import 'package:flutter/material.dart';
import '../../models/disaster_model.dart';
import '../../services/api_service.dart';

class DisasterDetailScreen extends StatelessWidget {
  final Disaster disaster;

  DisasterDetailScreen({required this.disaster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Details'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              disaster.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Description: ${disaster.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Date: ${disaster.date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Location: ${disaster.location}',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/update',
                  arguments: disaster,
                );
              },
              child: Text('Update Disaster'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                try {
                  final ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1');
                  await apiService.deleteDisaster(disaster.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Disaster deleted successfully'),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context, true); // Return true to indicate successful deletion
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to delete disaster'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text('Delete Disaster'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
