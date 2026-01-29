import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _bayarController = TextEditingController();
  bool diskonAktif = false;
  String metodePembayaran = 'Cash';
  double kembalian = 0;

  void hitungKembalian(String value, double totalTagihan) {
    setState(() {
      double bayar = double.tryParse(value.replaceAll('.', '')) ?? 0;
      kembalian = bayar - totalTagihan;
    });
  }

  void resetOrder(BuildContext context) {
    setState(() {
      context.read<CartProvider>().reset();
      _bayarController.clear();
      diskonAktif = false;
      kembalian = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    int subtotal = cartProvider.subtotal;
    double totalSetelahDiskon = diskonAktif
        ? subtotal * 0.98
        : subtotal.toDouble();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Max Cafe - Checkout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 1. BACKGROUND DENGAN GRAY BLUR
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Thirth.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.grey.withOpacity(0.2)),
          ),

          // 2. KONTEN TENAH (CENTERED SUMMARY)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ), // Membatasi lebar agar tidak melar
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'RINGKASAN PESANAN',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.amber,
                      thickness: 2,
                      height: 30,
                    ),

                    // DAFTAR ITEMS (NAMA MENU & JUMLAH)
                    const Text(
                      'Detail Menu:',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...cartItems.values
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        currencyFormatter.format(item.price),
                                        style: const TextStyle(
                                          color: Colors.amber,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // FITUR TAMBAH/KURANG JUMLAH DI RINGKASAN
                                Row(
                                  children: [
                                    _qtyBtn(Icons.remove_circle, () {
                                      context
                                          .read<CartProvider>()
                                          .updateQuantity(
                                            item.name,
                                            item.price,
                                            -1,
                                          );
                                      hitungKembalian(
                                        _bayarController.text,
                                        totalSetelahDiskon,
                                      );
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        '${item.quantity}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    _qtyBtn(Icons.add_circle, () {
                                      context
                                          .read<CartProvider>()
                                          .updateQuantity(
                                            item.name,
                                            item.price,
                                            1,
                                          );
                                      hitungKembalian(
                                        _bayarController.text,
                                        totalSetelahDiskon,
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Divider(color: Colors.white24, thickness: 1),
                    ),

                    // TOTALAN
                    _summaryRow('Subtotal', currencyFormatter.format(subtotal)),
                    _summaryRow(
                      'Diskon Khusus',
                      diskonAktif ? '2%' : '0%',
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(height: 10),
                    _summaryRow(
                      'TOTAL BAYAR',
                      currencyFormatter.format(totalSetelahDiskon),
                      isBold: true,
                      fontSize: 20,
                      color: Colors.amber,
                    ),

                    const SizedBox(height: 30),

                    // PEMBAYARAN
                    const Text(
                      'Input Pembayaran',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _bayarController,
                      onChanged: (val) =>
                          hitungKembalian(val, totalSetelahDiskon),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(color: Colors.white24),
                        prefixText: 'Rp ',
                        prefixStyle: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _summaryRow(
                      'Kembalian',
                      currencyFormatter.format(kembalian < 0 ? 0 : kembalian),
                      color: kembalian >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                    const SizedBox(height: 20),

                    // METODE & ACTIONS
                    DropdownButtonFormField<String>(
                      value: metodePembayaran,
                      dropdownColor: const Color(0xFF2C2C2C),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Metode Pembayaran',
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white24),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: ['Cash', 'Qris']
                          .map(
                            (val) =>
                                DropdownMenuItem(value: val, child: Text(val)),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => metodePembayaran = val!),
                    ),

                    if (metodePembayaran == 'Qris') ...[
                      const SizedBox(height: 20),
                      const Center(
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Scan QR untuk membayar",
                          style: TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ),
                    ],

                    const SizedBox(height: 25),
                    _actionBtn('Gunakan Diskon 2%', Colors.green, () {
                      setState(() => diskonAktif = true);
                      hitungKembalian(_bayarController.text, subtotal * 0.98);
                    }),
                    _actionBtn('Konfirmasi & Cetak Struk', Colors.amber, () {
                      if (subtotal == 0) {
                        _showDialog('Pilih menu terlebih dahulu!');
                      } else if (kembalian < 0 && metodePembayaran == 'Cash') {
                        _showDialog('Uang tidak mencukupi!');
                      } else {
                        _showDialog(
                          'Transaksi Sukses! Silakan ambil struk Anda.',
                        );
                        resetOrder(context);
                      }
                    }),
                    _actionBtn(
                      'Batalkan Pesanan',
                      Colors.redAccent,
                      () => resetOrder(context),
                      isOutline: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    double fontSize = 15,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onPressed) => IconButton(
    icon: Icon(icon, size: 28, color: Colors.amber),
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
  );

  Widget _actionBtn(
    String label,
    Color color,
    VoidCallback onPressed, {
    bool isOutline = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutline ? Colors.transparent : color,
          side: isOutline ? BorderSide(color: color) : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isOutline ? 0 : 5,
        ),
        onPressed: onPressed,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isOutline ? color : Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'MENGERTI',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
