import 'package:flutter/material.dart';
import 'package:smart_parking/widgets/custom_app_bar.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Find Parking'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Parking Spots',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // You can replace this with a map or list of available parking spots
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // For now, we're just showing 5 example spots
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    leading: Icon(Icons.local_parking),
                    title: Text('Spot ${index + 1}'),
                    subtitle: Text('Location: Campus XYZ'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle parking spot selection logic
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Reserve Spot ${index + 1}'),
                              content: Text('Do you want to reserve this parking spot?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle reservation logic here
                                    Navigator.pop(context);
                                    // Show confirmation or update UI as needed
                                  },
                                  child: const Text('Reserve'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Reserve'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
