import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  login(BuildContext c) async {
    var res = await http.post(
      Uri.parse("$baseUrl?action=login"),
      body: {
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

    // ✅ LOGIN BERHASIL
    if (data["status"] == "success") {
      ScaffoldMessenger.of(c).showSnackBar(
        SnackBar(
          content: Text("✅ Login berhasil"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        c,
        MaterialPageRoute(builder: (_) => Home()),
      );
    }
    // ❌ LOGIN GAGAL
    else {
      ScaffoldMessenger.of(c).showSnackBar(
        SnackBar(
          content: Text(
            data["msg"] ?? "Email atau password tidak terdaftar",
          ),
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
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
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
                      Icons.videogame_asset,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Aplikasi Daftar Game 🎮",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

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
                        icon: Icon(Icons.login),
                        label: Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => login(c),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          c,
                          MaterialPageRoute(builder: (_) => Register()),
                        );
                      },
                      child: Text(
                        "Belum punya akun? Register",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
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
