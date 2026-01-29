import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Tambahkan package ini di pubspec.yaml

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _foodRating = "5";
  String _placeRating = "5";

  // Fungsi untuk membuka WhatsApp (Sesuai dengan tag <a href="https://wa.me...">)
  void _openWhatsApp() async {
    const url =
        "https://wa.me/6281234567890?text=Halo%20Max%20Cafe%2C%20saya%20ingin%20bertanya...";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(fontFamily: 'Playfair Display'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Image (Forth.jpg)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/forth.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay Hitam (0.7 opacity)
          Container(color: Colors.black.withOpacity(0.7)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Hubungi Kami",
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 28,
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFFFC107).withOpacity(0.3),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputLabel("Nama Lengkap *"),
                          _buildTextField(_nameController, "Nama Anda"),

                          const SizedBox(height: 15),
                          _buildInputLabel("Alamat Email *"),
                          _buildTextField(
                            _emailController,
                            "email@contoh.com",
                            isEmail: true,
                          ),

                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel("Rating Makanan"),
                                    _buildDropdownRating(
                                      value: _foodRating,
                                      onChanged: (val) =>
                                          setState(() => _foodRating = val!),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel("Rating Tempat"),
                                    _buildDropdownRating(
                                      value: _placeRating,
                                      onChanged: (val) =>
                                          setState(() => _placeRating = val!),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),
                          _buildInputLabel("Pesan Anda *"),
                          _buildTextField(
                            _messageController,
                            "Tulis ulasan...",
                            maxLines: 4,
                          ),

                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Simulasi Simpan Data & Navigasi ke Review
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Pesan Berhasil Dikirim!'),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Kirim Pesan",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.chat, color: Colors.white),
                              label: const Text(
                                "WhatsApp",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFF25D366),
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onPressed: _openWhatsApp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Info Kontak (Bagian Kanan di HTML)
                  const Text(
                    "Informasi Kontak",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFFFC107),
                      fontFamily: 'Playfair Display',
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(Icons.map, "Jl. Pahlawan No. 59, Bandung"),
                  _buildContactItem(Icons.phone, "(021) 123-45678"),
                  _buildContactItem(Icons.email, "info@maxcafe.com"),
                  _buildContactItem(Icons.camera_alt, "@maxcafe.id"),

                  const SizedBox(height: 20),
                  const Text(
                    "Lokasi Kami:",
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Placeholder Map (Karena Iframe tidak bisa langsung di Flutter)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFFFC107),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on,
                        color: Color(0xFFFFC107),
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isEmail = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
    );
  }

  Widget _buildDropdownRating({
    required String value,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: ["5", "4", "3", "2", "1"].map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(
              "★" * int.parse(val),
              style: const TextStyle(color: Colors.orange),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFFC107), size: 20),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
