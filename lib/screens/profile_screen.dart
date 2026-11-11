
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color olive = Color(0xFF526400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF5),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF0EFF5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFE2E5D5),
              child: Icon(
                Icons.person,
                size: 55,
                color: olive,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Flight Traveller',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              'traveller@example.com',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _profileOption(
                    Icons.person_outline,
                    'Personal Information',
                  ),

                  const Divider(height: 1, indent: 55),

                  _profileOption(
                    Icons.flight_takeoff,
                    'My Bookings',
                  ),

                  const Divider(height: 1, indent: 55),

                  _profileOption(
                    Icons.settings_outlined,
                    'Settings',
                  ),

                  const Divider(height: 1, indent: 55),

                  _profileOption(
                    Icons.help_outline,
                    'Help & Support',
                  ),
                ],
              ),
            ),

            const Spacer(),

            const Text(
              'Flight Ticket App • Version 1.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  static Widget _profileOption(
      IconData icon,
      String title,
      ) {
    return ListTile(
      leading: Icon(icon, color: olive),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.grey,
      ),
      onTap: () {},
    );
  }
}

