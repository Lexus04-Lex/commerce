import 'package:events/screens/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Products>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://api.example.com/products'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          List<dynamic> productsJson = data['data'];
          return productsJson.map((json) => Products.fromJson(json)).toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Products product = snapshot.data![index];
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.purple, Colors.white]),
                        ),
                        child: TextSection(
                          
                          description: product.description,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Text(product.createdat.toString()),
                  ),
                ],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Products {
  final String name;
  final int price;
  final String imageUrl;
  final String description;
  final DateTime createdat;

  Products({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.createdat,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      description: json['description'],
      createdat: DateTime.parse(json['created_at']),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: LlmChatView(
        provider: GeminiProvider(
          model: GenerativeModel(
            model: 'gemini-1.5-flash',
            apiKey: 'AIzaSyA5zc5lo4LHEEEDX-SHzsuCBSXvXRXgH0Q',
          ),
        ),
      ),
    );
  }
}