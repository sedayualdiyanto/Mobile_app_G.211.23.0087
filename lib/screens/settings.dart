import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSettingItem(
              icon: Icons.palette,
              title: 'Theme',
              subtitle: 'Dark',
            ),
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Enabled',
            ),
            _buildSettingItem(
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English',
            ),
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: 'Privacy',
              subtitle: 'Manage your data',
            ),
            _buildSettingItem(
              icon: Icons.help,
              title: 'Help & Support',
              subtitle: 'FAQ, Contact us',
            ),
            _buildSettingItem(
              icon: Icons.info,
              title: 'About',
              subtitle: 'Version 1.0.0',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.grey[800],
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}