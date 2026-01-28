import 'package:flutter/material.dart';

class DetailGame extends StatelessWidget {
  final Map d;
  DetailGame(this.d);

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          d['name'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🎮 ICON GAME
            Center(
              child: Icon(
                Icons.videogame_asset,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),

            SizedBox(height: 16),

            // 🎯 NAMA GAME
            Center(
              child: Text(
                d['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 24),

            // 🧱 CARD INFO
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Icon(Icons.category, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "Genre",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(d['genre']),
                    Divider(height: 24),

                    Row(
                      children: [
                        Icon(Icons.devices, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Platform",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(d['platform']),
                    Divider(height: 24),

                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          "Tahun Rilis",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(d['year'].toString()),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // 📝 DESKRIPSI
            Text(
              "Deskripsi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  d['description'],
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
