import 'dart:ui';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/First.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Overlay Gelap
          Container(color: Colors.black.withOpacity(0.85)),

          // 3. Konten Utama
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  // Title
                  const Text(
                    "About Max Cafe App",
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // About App Card (Glassmorphism dengan Border Kuning)
                  _buildAboutAppCard(),

                  const SizedBox(height: 40),

                  // Team Section Header
                  const Text(
                    "Our Development Team",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC107),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Team Grid (Responsive-like)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.9,
                    children: [
                      _buildProfileCard("Mutiara Dewi Lestari", "MD"),
                      _buildProfileCard("Nazwa Naila", "NN"),
                      _buildProfileCard("Radya Anantia Divena", "RA"),
                      _buildProfileCard("Arys Rizki Zhahiral Bilhaq", "AB"),
                      _buildProfileCard("Harsya Vil'ardi", "HV"),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Copyright Section
                  _buildCopyrightSection(context),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Card "About App"
  Widget _buildAboutAppCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: Color(0xFFFFC107), width: 5),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Solusi Digital untuk Pecinta Kopi",
                style: TextStyle(
                  color: Color(0xFFFFC107),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Aplikasi Max Cafe dikembangkan sebagai solusi modern untuk meningkatkan pengalaman pelanggan di kafe kami. Melalui platform ini, pelanggan dapat menjelajahi menu unggulan kami, melakukan pemesanan secara instan tanpa antre, hingga memantau riwayat pesanan dan memberikan feedback langsung.",
                style: TextStyle(color: Colors.white, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Card Profil Tim
  Widget _buildProfileCard(String name, String avatarQuery) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color(0xFFFFC107),
            backgroundImage: NetworkImage(
              "https://ui-avatars.com/api/?name=$avatarQuery&background=ffc107&color=000",
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Copyright Section
  Widget _buildCopyrightSection(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.white24),
        const SizedBox(height: 15),
        const Text(
          "© 2025 Max Cafe. All Rights Reserved.",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Mutiara Dewi Lestari - 23552011348\nNazwa Naila - 23552011389\nRadya Anantia Divena - 23552011415\nArys Rizki Zhahiral Bilhaq - 23552011352\nHarsya Vil'ardi - 23552011037",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.6),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.amber),
            foregroundColor: Colors.amber,
          ),
          child: const Text('Kembali ke Home'),
        ),
      ],
    );
  }
}
