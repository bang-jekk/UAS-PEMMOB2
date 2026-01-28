import 'package:flutter/material.dart';
import 'login.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videogame_asset, size: 80, color: Colors.deepPurple),
          SizedBox(height: 12),
          Text(
            "Daftar Game 🎮",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("Versi 1.0", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),

          Text(
            "👥 Tim Pengembang\n\n"
            "Alunggu Simatupang – 23552011211\n"
            "Bangbang Ramadhan – 23552011177\n"
            "Irgi Alyansa Perdana – 23552011210\n"
            "Revalina Putri Artamevia – 23552011135\n"
            "Zainuddin Muhammad Zakiy – 23552011173",
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          ElevatedButton.icon(
            icon: Icon(Icons.logout),
            label: Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                c,
                MaterialPageRoute(builder: (_) => Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
