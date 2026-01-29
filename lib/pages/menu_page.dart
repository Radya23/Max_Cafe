import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

// 1. Model Data Menu
class MenuItem {
  final String title;
  final String img;
  final int price;
  final String desc;
  final String category;

  MenuItem({
    required this.title,
    required this.img,
    required this.price,
    required this.desc,
    required this.category,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // 2. Database Lokal Menu
  final List<MenuItem> _allMenus = [
    // --- MAKANAN ---
    MenuItem(
      title: "Ayam Goreng",
      img: "assets/Image/Ayam Goreng.jpeg",
      price: 10000,
      desc: "Ayam krispi bumbu rempah.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Pizza",
      img: "assets/Image/Pizza.jpeg",
      price: 20000,
      desc: "Pizza Italia topping mozzarella.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Burger",
      img: "assets/Image/Burger.jpeg",
      price: 15000,
      desc: "Daging sapi juicy dengan keju.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Hot Dog",
      img: "assets/Image/Hot Dog.jpeg",
      price: 12000,
      desc: "Sosis premium dengan saus mustard.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Steak",
      img: "assets/Image/Steak.jpg",
      price: 35000,
      desc: "Daging panggang tingkat kematangan sempurna.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Nugget",
      img: "assets/Image/Nugget.jpeg",
      price: 10000,
      desc: "Nugget ayam renyah.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Kentang Goreng",
      img: "assets/Image/Kentang Goreng.jpeg",
      price: 8000,
      desc: "French fries gurih.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Sate",
      img: "assets/Image/Sate.jpg",
      price: 15000,
      desc: "Sate ayam bumbu kacang.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Kebab",
      img: "assets/Image/Kebab.jpg",
      price: 15000,
      desc: "Daging gulung khas Timur Tengah.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Sandwich",
      img: "assets/Image/Sandwich.jpg",
      price: 10000,
      desc: "Roti lapis sehat nan segar.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Omelet",
      img: "assets/Image/Omelet.jpg",
      price: 8000,
      desc: "Telur dadar spesial.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Salad",
      img: "assets/Image/Salad.jpg",
      price: 12000,
      desc: "Sayuran segar saus mayonaise.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Gyoza",
      img: "assets/Image/Gyoza.jpg",
      price: 15000,
      desc: "Pangsit panggang ala Jepang.",
      category: "Makanan",
    ),
    MenuItem(
      title: "Siomay",
      img: "assets/Image/Siomay.jpg",
      price: 10000,
      desc: "Siomay ikan dengan bumbu kacang.",
      category: "Makanan",
    ),

    // --- MINUMAN ---
    MenuItem(
      title: "Air Mineral",
      img: "assets/Image/Air Mineral.jpeg",
      price: 4000,
      desc: "Air mineral dingin.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Coca Cola",
      img: "assets/Image/Coca Cola.jpeg",
      price: 7000,
      desc: "Minuman bersoda segar.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Coffee",
      img: "assets/Image/Coffe.jpeg",
      price: 15000,
      desc: "Kopi robusta pilihan.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Milk Tea",
      img: "assets/Image/Milk Tea.jpeg",
      price: 12000,
      desc: "Teh susu dengan topping pearl.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Lemon Tea",
      img: "assets/Image/Lemon Tea.jpeg",
      price: 10000,
      desc: "Teh lemon segar.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Caramel Hazelnut",
      img: "assets/Image/Caramel Hazelnut.jpg",
      price: 18000,
      desc: "Paduan karamel dan hazelnut.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Strawberry Milk",
      img: "assets/Image/Strawberry Milk.jpg",
      price: 15000,
      desc: "Susu rasa strawberry segar.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Matcha Milk",
      img: "assets/Image/Matcha Milk.jpg",
      price: 20000,
      desc: "Matcha asli dengan susu segar.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Oreo Milk",
      img: "assets/Image/Oreo Milk.jpg",
      price: 18000,
      desc: "Susu dengan taburan oreo.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Fruit Sprite",
      img: "assets/Image/Fruit Sprite.jpg",
      price: 15000,
      desc: "Soda sprite dengan campuran buah.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Rasberry Milk",
      img: "assets/Image/Rasberry Milk.jpg",
      price: 18000,
      desc: "Susu raspberry manis.",
      category: "Minuman",
    ),
    MenuItem(
      title: "Blueberry Sprite",
      img: "assets/Image/Blueberry Sprite.jpg",
      price: 15000,
      desc: "Soda sprite rasa blueberry.",
      category: "Minuman",
    ),

    // --- DESSERT ---
    MenuItem(
      title: "Ice Cream",
      img: "assets/Image/Ice Cream.jpeg",
      price: 10000,
      desc: "Es krim vanila lembut.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Waffle",
      img: "assets/Image/Waffle.jpeg",
      price: 15000,
      desc: "Waffle renyah sirup maple.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Cake",
      img: "assets/Image/Cake.jpeg",
      price: 20000,
      desc: "Kue cokelat manis.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Pudding",
      img: "assets/Image/Pudding.jpeg",
      price: 10000,
      desc: "Puding susu lembut.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Pancake",
      img: "assets/Image/Pancake.jpg",
      price: 15000,
      desc: "Pancake empuk dengan mentega.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Donat",
      img: "assets/Image/Donat.jpg",
      price: 8000,
      desc: "Donat kentang empuk.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Macaron",
      img: "assets/Image/Macaron.jpg",
      price: 20000,
      desc: "Kue kering khas Perancis.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Churros",
      img: "assets/Image/Churros.jpg",
      price: 12000,
      desc: "Churros saus cokelat.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Cromboloni",
      img: "assets/Image/Cromboloni.jpg",
      price: 15000,
      desc: "Pastry viral krim lumer.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Brownies",
      img: "assets/Image/Brownies.jpg",
      price: 15000,
      desc: "Brownies panggang cokelat pekat.",
      category: "Dessert",
    ),
    MenuItem(
      title: "Cookies",
      img: "assets/Image/Cookies.jpg",
      price: 10000,
      desc: "Biskuit cokelat renyah.",
      category: "Dessert",
    ),
  ];

  String _selectedCategory = 'Semua';
  List<MenuItem> _displayMenus = [];

  @override
  void initState() {
    super.initState();
    _displayMenus = _allMenus;
  }

  void _filterMenu(String category) {
    setState(() {
      _selectedCategory = category;
      _displayMenus = category == 'Semua'
          ? _allMenus
          : _allMenus.where((item) => item.category == category).toList();
    });
  }

  void _addItemToCart(MenuItem item) {
    context.read<CartProvider>().updateQuantity(item.title, item.price, 1);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.title} ditambahkan ke keranjang!"),
        backgroundColor: Colors.green.shade800,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "LIHAT",
          textColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/order'),
        ),
      ),
    );
  }

  void _showMenuDetail(BuildContext context, MenuItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          border: Border.all(color: Colors.amber.withOpacity(0.5), width: 1),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                item.img,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade900,
                  height: 250,
                  child: const Icon(Icons.broken_image, color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            Text(
              "Rp ${item.price}",
              style: const TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const Divider(color: Colors.amber, height: 30),
            Text(
              item.desc,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _addItemToCart(item);
                Navigator.pop(context);
              },
              child: const Text(
                "PESAN SEKARANG",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "KEMBALI",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background diputar 180 derajat
          RotatedBox(
            quarterTurns: 2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Secound.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black87,
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          // Konten Utama
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'MAX CAFE MENU',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: ['Semua', 'Makanan', 'Minuman', 'Dessert'].map((
                      cat,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: _selectedCategory == cat,
                          onSelected: (_) => _filterMenu(cat),
                          selectedColor: Colors.amber,
                          backgroundColor: Colors.white10,
                          labelStyle: TextStyle(
                            color: _selectedCategory == cat
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: _displayMenus.length,
                    itemBuilder: (context, index) {
                      final item = _displayMenus[index];
                      return _buildMenuCard(item);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/order'),
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.shopping_cart, color: Colors.black),
        label: Consumer<CartProvider>(
          builder: (context, cart, child) => Text(
            "Checkout (Rp ${cart.subtotal})",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuItem item) {
    return GestureDetector(
      onTap: () => _showMenuDetail(context, item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.asset(
                  item.img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade900,
                    child: const Icon(Icons.broken_image, color: Colors.amber),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Rp ${item.price}",
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () => _addItemToCart(item),
                      child: const Text(
                        "PESAN",
                        style: TextStyle(
                          fontSize: 12,
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
      ),
    );
  }
}
