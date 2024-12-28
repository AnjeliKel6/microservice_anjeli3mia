import 'package:flutter/material.dart';
import 'package:product_app/Providers/product_provider.dart';
import 'package:product_app/product_detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.isLoading) {
      productProvider.fetchProducts();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFDDE6ED), // Pale blue background
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color(0xFF27374D), // Dark Navy Blue for AppBar
        title: const Text(
          "Daftar Produk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
        ),
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return Card(
                  elevation: 10.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF526D82), // Muted Blue for elegance
                            const Color(
                                0xFF9DB2BF), // Light Steel Blue for contrast
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        leading: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        title: Text(
                          product['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          "Rp. ${product['price']}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 164, 244, 166),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
