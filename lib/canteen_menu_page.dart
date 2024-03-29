// ignore_for_file: library_private_types_in_public_api, avoid_print, avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/Item%20Count/item_count.dart';
import 'package:lunchx_customer/order_billing.dart';

class CanteenMenuPage extends StatefulWidget {
  const CanteenMenuPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  _CanteenMenuPageState createState() => _CanteenMenuPageState();
}

class _CanteenMenuPageState extends State<CanteenMenuPage> {
  late User _currentUser;
  List<Map<String, dynamic>> menuItems = [];
  Map<String, int> itemCountMap = {};
  Map<String, int> localItemCountMap = {}; // Track local changes
  List<Map<String, dynamic>> order = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    fetchOrderData();
    _loadUserData();

    localItemCountMap = Map.from(itemCountMap); // Initialize with existing data
  }

  Future<void> fetchOrderData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userEmail = user?.email;

      if (userEmail != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('LunchX')
            .doc('customers')
            .collection('users')
            .doc(userEmail)
            .collection('cart')
            .get();

        List<Map<String, dynamic>> fetchedOrderList = [];
        for (var doc in querySnapshot.docs) {
          fetchedOrderList.add(doc.data() as Map<String, dynamic>);
        }

        setState(() {
          order = fetchedOrderList;
        });
      }
    } catch (e) {
      // Handle any errors that occur
    }
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        print(_currentUser.email);
        print(widget.userEmail);
      });
      await _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('LunchX')
                .doc('canteens')
                .collection('users')
                .doc(widget.userEmail)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.data() == null) {
                return Text(
                  'PDEU Canteen',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              }

              final canteenData =
                  snapshot.data!.data() as Map<String, dynamic>?;
              final canteenName = canteenData?['canteenName'] ?? 'N/A';
              final shopStatus = canteenData?['shopStatus'] ?? 'open';
              final Color statusColor =
                  shopStatus == 'open' ? Colors.green : Colors.red;

              return Column(
                children: [
                  Text(
                    canteenName,
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: statusColor,
                    ),
                    child: Center(
                      child: Text(
                        shopStatus,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('LunchX')
                  .doc('canteens')
                  .collection('users')
                  .doc(widget.userEmail)
                  .collection('items')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    color: Colors.white,
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    color: Colors.white,
                    child: const Center(
                      child: Text('No data found.'),
                    ),
                  );
                }

                menuItems =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: menuItems.map((item) {
                        // Check availability status of the item
                        bool isAvailable = item['availability'] ?? false;

                        return isAvailable
                            ? Card(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Navigate to ManageItemScreen on tap
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['name'],
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    item['description'],
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.15,
                                                      color: Color(0xFF858585),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 10.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Rs.${item['price']}',
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                // Counter Buttons
                                                ItemCountWidget(
                                                  itemName: item['name'],
                                                  initialCount: itemCountMap[
                                                          item['name']] ??
                                                      0,
                                                  onChanged: (count) async {
                                                    setState(() {
                                                      itemCountMap[
                                                          item['name']] = count;
                                                    });

                                                    if (count > 0) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('LunchX')
                                                          .doc('customers')
                                                          .collection('users')
                                                          .doc(_currentUser
                                                              .email)
                                                          .collection('cart')
                                                          .doc(item[
                                                              'name']) // Use the item name as the document ID
                                                          .set({
                                                            'name': item[
                                                                'name'], // Add other item details if needed
                                                            'count': count,
                                                            'price':
                                                                item['price'],
                                                            // 'canteen':
                                                            //     canteenName,
                                                          })
                                                          .then((_) => print(
                                                              'Item stored in database'))
                                                          .catchError((error) =>
                                                              print(
                                                                  'Failed to store item: $error'));
                                                    } else {
                                                      // If count is zero, remove the item from the cart collection
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('LunchX')
                                                          .doc('customers')
                                                          .collection('users')
                                                          .doc(_currentUser
                                                              .email)
                                                          .collection('cart')
                                                          .doc(item[
                                                              'name']) // Use the item name as the document ID
                                                          .delete()
                                                          .then((_) => print(
                                                              'Item removed from database'))
                                                          .catchError((error) =>
                                                              print(
                                                                  'Failed to remove item: $error'));
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ), // Adjust the radius value as needed
                                        child: Image.network(
                                          item['image'],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(); // If not available, return an empty container
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer

          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0), // Adjust horizontal padding
            decoration: BoxDecoration(
              color: const Color(0xFF6552FE),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 49, 49, 49).withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 80, right: 10), // Adjust left margin
                  child: Row(
                    children: [
                      // Arrow forward icon
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ), // Add some space between the icon and text

                      // Text widget
                      itemCountMap.isEmpty ||
                              itemCountMap.values.every((count) => count == 0)
                          ? Text(
                              'Cart is Hungry!',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              'Proceed to Billing',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ),
                const Spacer(), // Added Spacer to occupy remaining space
                GestureDetector(
                  onTap: () {
                    if (itemCountMap.isNotEmpty &&
                        itemCountMap.values.any((count) => count > 0)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderBillingScreen(),
                        ),
                      );
                    } else {
                      // Handle case when count is not greater than 0
                      // For example, you can show a snackbar or display a message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'No items added to cart!',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20), // Adjust padding
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      'assets/cart.gif', // Replace with the path to your logo image
                      width: 45, // Adjust the width as needed
                      height: 45, // Adjust the height as needed
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
}
// Do not change in the code
