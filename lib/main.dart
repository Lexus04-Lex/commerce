import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:events/firebase_options.dart';
import 'package:events/profile.dart';
import 'package:events/screens/favorite.dart';
import 'package:events/screens/cart.dart';
import 'package:events/screens/home.dart';
import 'package:events/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Events());
}

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
    late List<Widget> _pages;
    int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      FavoritePage(),
      CartPage(),
      SettingsPage(),
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white, // Changed to blue
        color: Colors.orange,
        animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
          },
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu),
              Text('Home', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite),
              Text('Favorites', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.card_travel),
              Text('Cart', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search),
              Text('Search', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('IA STORES'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile()
            )),
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 237, 167, 63),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text('Categories'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('History'),
                    onTap: () => {},
                  ),
                  Divider(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () => FirebaseAuth.instance.signOut(),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    child: Container(
            
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      child: Text('Welcome to IA STORES!'),
    ),
    );
  }
}