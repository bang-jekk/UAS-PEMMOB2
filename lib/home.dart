import 'package:flutter/material.dart';
import 'add_game.dart';
import 'about.dart';
import 'detail_game.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 0;
  List data = [];
  List filterData = [];

  bool isSearching = false;
  TextEditingController search = TextEditingController();

  load() async {
    var res = await http.get(Uri.parse("$baseUrl?action=games"));
    var result = json.decode(res.body);

    setState(() {
      data = result;
      filterData = result;
    });
  }

  searchGame(String text) {
    setState(() {
      filterData = text.isEmpty
          ? data
          : data.where((item) =>
              item['name'].toLowerCase().contains(text.toLowerCase()) ||
              item['genre'].toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext c) {
    var pages = [
      ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: filterData.length,
        itemBuilder: (_, x) => Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.videogame_asset, color: Colors.white),
            ),
            title: Text(
              filterData[x]['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${filterData[x]['genre']} • ${filterData[x]['platform']}",
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                c,
                MaterialPageRoute(
                  builder: (_) => DetailGame(filterData[x]),
                ),
              );
            },
          ),
        ),
      ),
      AddGame(load),
      About(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: isSearching
            ? TextField(
                controller: search,
                autofocus: true,
                onChanged: searchGame,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Cari game...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )
            : Text("🎮 Daftar Game"),
        actions: [
          if (i == 0)
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  search.clear();
                  filterData = data;
                });
              },
            )
        ],
      ),
      body: pages[i],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        selectedItemColor: Colors.deepPurple,
        onTap: (x) {
          setState(() {
            i = x;
            isSearching = false;
            search.clear();
            filterData = data;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Game"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Tambah"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }
}