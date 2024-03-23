// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/Body%20section/body.dart';
import 'package:lunchx_customer/order_tracking.dart';
import 'package:lunchx_customer/order_history.dart';
import 'package:lunchx_customer/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YourDrawer extends StatefulWidget {
  final Function(bool) onShopStatusChanged;

  const YourDrawer({super.key, required this.onShopStatusChanged});

  @override
  _YourDrawerState createState() => _YourDrawerState();
}

class _YourDrawerState extends State<YourDrawer> {
  late Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {});
      await _loadUserData(user.email!); // Pass the user's email here
    }
  }

  Future<void> _loadUserData(String email) async {
    final userData = await FirebaseFirestore.instance
        .collection('LunchX')
        .doc('customers')
        .collection('users')
        .doc(email)
        .get();
    setState(() {
      _userData = userData.data() as Map<String, dynamic>;
    });
  }

  Widget _buildDrawerItem(
      BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _userData['name'] ?? 'N/A',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    'Address',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _userData['address'] ?? 'N/A',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    'Email ID',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _userData['email'] ?? 'N/A',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    'Phone No.',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    _userData['phoneNumber'] ?? 'N/A',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Saved',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '1 hr 31 mins',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6552FE),
                    ),
                  ),
                  Text(
                    'till today!',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDrawerItem(context, 'Order History', () {
            Navigator.pop(context); // Close the drawer

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
            );
          }),
          _buildDrawerItem(context, 'Logout', () {
            // Perform logout
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Login()), // Navigate to login screen
              (route) => false, // Remove all routes until login screen
            );
          }),
          Container(
            margin: const EdgeInsets.only(top: 200.0),
            child: Image.asset(
              'assets/logo2.png', // Adjust the path accordingly
              height: 50.0,
              width: 40.0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Text(
            'Customer Support',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          // "graby.go" text
          Text(
            '+91 9408393005',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isShopOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    'assets/logo2.png',
                    width: 110.0,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderTracker()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6552FE),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    child: Image.asset(
                      'assets/notify.gif',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: YourDrawer(
        onShopStatusChanged: (status) {
          // NULL
        },
      ),
      body: const BodySection(),
    );
  }
}
// No changes in the code