import 'package:flutter/material.dart';

// Kita buat class kecil untuk menyimpan detail item di keranjang
class CartItem {
  final String name;
  final int price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

class CartProvider extends ChangeNotifier {
  // Sekarang kita simpan Map dengan key: Nama Produk, value: Objek CartItem
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  // Fungsi update quantity yang juga menerima harga (hanya digunakan saat pertama tambah)
  void updateQuantity(String itemName, int price, int delta) {
    if (_items.containsKey(itemName)) {
      _items[itemName]!.quantity += delta;
      if (_items[itemName]!.quantity <= 0) {
        _items.remove(itemName);
      }
    } else {
      if (delta > 0) {
        _items[itemName] = CartItem(
          name: itemName,
          price: price,
          quantity: delta,
        );
      }
    }
    notifyListeners();
  }

  // Perhitungan subtotal sekarang menggunakan harga asli per item
  int get subtotal {
    int total = 0;
    _items.forEach((key, item) {
      total += (item.price * item.quantity);
    });
    return total;
  }

  // Getter untuk mendukung UI lama (jika ada yang memakai .order)
  Map<String, int> get order {
    return _items.map((key, item) => MapEntry(key, item.quantity));
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}
