import 'package:flutter/material.dart';
import '../../models/disaster_model.dart';
import '../../services/api_service.dart';
import 'disaster_detail_screen.dart';

class DisasterListScreen extends StatefulWidget {
  @override
  _DisasterListScreenState createState() => _DisasterListScreenState();
}

class _DisasterListScreenState extends State<DisasterListScreen> {
  late Future<List<Disaster>> futureDisasters;
  ApiService apiService = ApiService(baseUrl: 'http://127.0.0.1:80');

  @override
  void initState() {
    super.initState();
    _fetchDisasters();
  }

  void _fetchDisasters() {
    setState(() {
      futureDisasters = apiService.fetchDisasters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Response'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: FutureBuilder<List<Disaster>>(
        future: futureDisasters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Disaster disaster = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.warning,
                      color: Colors.red.shade700,
                      size: 40,
                    ),
                    title: Text(
                      disaster.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Date: ${disaster.date}\nLocation: ${disaster.location}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue.shade700,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisasterDetailScreen(disaster: disaster),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
