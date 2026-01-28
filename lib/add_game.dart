import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class AddGame extends StatefulWidget {
  final Function reload;
  AddGame(this.reload);

  @override
  _AddGameState createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  TextEditingController n = TextEditingController();
  TextEditingController g = TextEditingController();
  TextEditingController p = TextEditingController();
  TextEditingController y = TextEditingController();
  TextEditingController d = TextEditingController();

  save() async {
    var body = {
      "name": n.text,
      "genre": g.text,
      "platform": p.text,
      "year": y.text,
      "description": d.text
    };

    var res = await http.post(
      Uri.parse("$baseUrl?action=add_game"),
      body: body,
    );

    if (res.statusCode == 200) {
      widget.reload();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("🎉 Game berhasil ditambahkan"))
      );
      n.clear(); g.clear(); p.clear(); y.clear(); d.clear();
    }
  }

  Widget input(String label, IconData icon, TextEditingController c) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text("➕ Tambah Game",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        input("Nama Game", Icons.games, n),
        input("Genre", Icons.category, g),
        input("Platform", Icons.devices, p),
        input("Tahun", Icons.calendar_today, y),
        input("Deskripsi", Icons.description, d),
        SizedBox(height: 10),
        ElevatedButton.icon(
          icon: Icon(Icons.save),
          label: Text("Simpan"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 24, 179, 57),
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: save,
        ),
      ],
    );
  }
}
