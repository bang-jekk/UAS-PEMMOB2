import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  TextEditingController name  = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass  = TextEditingController();

  register(BuildContext c) async {
    var res = await http.post(
      Uri.parse("$baseUrl?action=register"),
      body: {
        "name": name.text,
        "email": email.text,
        "password": pass.text,
      },
    );

    if (res.body.isEmpty) {
      ScaffoldMessenger.of(c).showSnackBar(
        SnackBar(
          content: Text("❌ Server tidak merespon"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    var data = json.decode(res.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(c).showSnackBar(
        SnackBar(
          content: Text("✅ Register berhasil"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(c); // balik ke login
    } else {
      ScaffoldMessenger.of(c).showSnackBar(
        SnackBar(
          content: Text(data["msg"] ?? "❌ Register gagal"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2A5298), Color(0xFF1E3C72)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add_alt_1,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Buat akun baru ✨",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.app_registration),
                        label: Text(
                          "Daftar",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => register(c),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () => Navigator.pop(c),
                      child: Text("Sudah punya akun? Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
