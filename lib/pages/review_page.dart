import 'dart:ui';
import 'package:flutter/material.dart';

// Model Data Review
class Review {
  final String name;
  final String message;
  final int foodRating;
  final int placeRating;

  Review({
    required this.name,
    required this.message,
    required this.foodRating,
    required this.placeRating,
  });
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // Data dummy sesuai dengan yang ada di Review.html
  final List<Review> _allReviews = [
    Review(
      name: "Andi Saputra",
      message: "Kopinya mantap, suasana sangat nyaman untuk kerja.",
      foodRating: 5,
      placeRating: 5,
    ),
    Review(
      name: "Siti Aminah",
      message: "Waffle-nya enak sekali! Pelayanan sangat ramah.",
      foodRating: 5,
      placeRating: 4,
    ),
  ];

  List<Review> _filteredReviews = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredReviews = _allReviews;
  }

  void _filterReviews(String query) {
    setState(() {
      _filteredReviews = _allReviews
          .where(
            (r) =>
                r.name.toLowerCase().contains(query.toLowerCase()) ||
                r.message.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  // Fungsi untuk merender bintang (Sesuai renderStars di JS)
  Widget _buildStars(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < count ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Ending.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Overlay
          Container(color: Colors.black.withOpacity(0.75)),

          // 3. Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Customer Experience",
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC107),
                  ),
                ),
                const Text(
                  "Apa kata mereka tentang layanan kami",
                  style: TextStyle(color: Colors.white70),
                ),

                // Search Bar (Sesuai search-container di HTML)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterReviews,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cari nama atau isi review...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Colors.amber),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFC107),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFC107),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Review List
                Expanded(
                  child: _filteredReviews.isEmpty
                      ? const Center(
                          child: Text(
                            "Review tidak ditemukan...",
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: _filteredReviews.length,
                          itemBuilder: (context, index) {
                            final review = _filteredReviews[index];
                            return _buildReviewCard(review);
                          },
                        ),
                ),

                // Floating Action Button Style (Tulis Review Baru)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Navigasi ke halaman Contact.html (Tulis Review)
                      Navigator.pushNamed(context, '/contact');
                    },
                    icon: const Icon(Icons.edit, color: Colors.black),
                    label: const Text(
                      "Tulis Review Baru",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar (Menggunakan UI Avatars seperti di JS)
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.amber,
              child: Text(
                review.name[0].toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 15),

            // Detail Review
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Baru saja",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Food: ",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      _buildStars(review.foodRating),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Place: ",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      _buildStars(review.placeRating),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\"${review.message}\"",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
