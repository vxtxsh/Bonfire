import 'package:flutter/material.dart';
import 'package:mhealth2/diary/screens/medi.dart';

class VRRoomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VR Rooms',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoomButton(
              context,
              label: 'Rage Room',
              onPressed: () {
                // Navigate to Rage Room page (you can implement this later)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Rage Room selected')),
                );
              },
            ),
            SizedBox(height: 20),
            _buildRoomButton(
              context,
              label: 'Meditation Room',
              onPressed: () {
                // Navigate to Meditation Room page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationRoomPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}