// ignore_for_file: library_private_types_in_public_api, avoid_print, dead_code, unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lunchx_customer/payment_done.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderBillingScreen extends StatefulWidget {
  const OrderBillingScreen({super.key});

  @override
  _OrderBillingScreenState createState() => _OrderBillingScreenState();
}

class _OrderBillingScreenState extends State<OrderBillingScreen> {
  List<Map<String, dynamic>> order = [];
  late User _currentUser;
  bool isDineSelected = true; // Initial selection is DINE

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    fetchOrderData();
  }

  double calculateTotalPrice(List<Map<String, dynamic>> order) {
    double totalPrice = 0.0;
    for (var item in order) {
      totalPrice += item['price'] * item['count'];
    }
    return totalPrice;
  }

  double calculateParcelCost(List<Map<String, dynamic>> order) {
    double parcelCost = 0.0;
    for (var item in order) {
      if (item['service'] == 'PARCEL') {
        parcelCost += 10 * item['count'];
      }
    }
    return parcelCost;
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        void userEmail = _currentUser.email;
        print(_currentUser.email);
      });
      // await _loadUserData();
    }
  }

  // Fetch order data from Firestore
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

  // Increment item count and update Firestore
  void incrementItemCount(int index) async {
    setState(() {
      order[index]['count']++;
    });
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;
    if (userEmail != null) {
      FirebaseFirestore.instance
          .collection('LunchX')
          .doc('customers')
          .collection('users')
          .doc(userEmail)
          .collection('cart')
          .doc(order[index]['name']) // Use 'name' as the unique identifier
          .set({'count': order[index]['count']}, SetOptions(merge: true))
          .then((value) => print("Item count updated in Firestore"))
          .catchError((error) => print("Failed to update item count: $error"));
    }
  }

  // Decrement item count and update Firestore, remove item if count is 0
  void decrementItemCount(int index, BuildContext context) async {
    setState(() {
      if (order[index]['count'] > 0) {
        order[index]['count']--;
      } else {
        order.removeAt(index);
      }
    });

    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    if (userEmail != null) {
      if (order[index]['count'] != 0) {
        FirebaseFirestore.instance
            .collection('LunchX')
            .doc('customers')
            .collection('users')
            .doc(userEmail)
            .collection('cart')
            .doc(order[index]['name']) // Use 'name' as the unique identifier
            .set({'count': order[index]['count']}, SetOptions(merge: true))
            .then((value) => print("Item count updated in Firestore"))
            .catchError(
                (error) => print("Failed to update item count: $error"));
      } else {
        FirebaseFirestore.instance
            .collection('LunchX')
            .doc('customers')
            .collection('users')
            .doc(userEmail)
            .collection('cart')
            .doc(order[index]['name']) // Use 'name' as the unique identifier
            .delete()
            .then((value) => print("Item removed from Firestore"))
            .catchError((error) => print("Failed to remove item: $error"));
      }
    }

    // Calculate total count of items
    int totalCount = 0;
    for (var item in order) {
      totalCount += item['count'] as int;
    }

    // If total count is zero, navigate back to previous screen
    if (totalCount == 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width - 20.0; // Full width of the card
    bool isDineSelected = true;

    return Scaffold(
      appBar: AppBar(
          // Your app bar content goes here
          ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Cart',
                          style: GoogleFonts.outfit(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Confirm Your Items',
                          style: GoogleFonts.outfit(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6552FE),
                          ),
                        ),
                        const SizedBox(height: 10.0), // Add some spacing

                        // Dynamically build containers based on order list
                        for (int i = 0; i < order.length; i++)
                          if (order[i]['count'] > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: cardWidth / 2 +
                                      15, // Half of the card's width
                                  height: 35.0,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        order[i]['name'],
                                        style: GoogleFonts.outfit(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: cardWidth / 4 - 40,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Rs. ${order[i]['price']}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.outfit(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10.0), // Add some spacing
                                Container(
                                  width: cardWidth / 3 -
                                      60.0, // One-third of the card's width
                                  height: 25.0,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6552FE),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          decrementItemCount(i, context);
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          '${order[i]['count']}',
                                          style: GoogleFonts.outfit(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          incrementItemCount(i);
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Bill',
                          style: GoogleFonts.outfit(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Almost zero platform fees applied.',
                          style: GoogleFonts.outfit(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6552FE),
                          ),
                        ),
                        const SizedBox(height: 10.0), // Add some spacing

                        // Dynamically build containers based on order list
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Order Pricing + Tax 18% GST',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Rs. ${calculateTotalPrice(order).toStringAsFixed(2)} /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Packaging Cost',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Rs. ${calculateParcelCost(order).toStringAsFixed(2)} /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Convinence Fee',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Rs. 0 /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: cardWidth / 2 +
                                  25, // Half of the card's width
                              height: 35.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Total Amount',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth / 3 - 10,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'Rs. ${(calculateTotalPrice(order) + calculateParcelCost(order)).toStringAsFixed(2)} /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10.0), // Add some spacing
                          ],
                        ),

                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PaymentSuccess()),
                            );
                          },
                          child: Center(
                            child: Container(
                              height: 40.0,
                              width: 150,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6552FE),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Confirm Order',
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Terms & Conditions*',
                  style: GoogleFonts.outfit(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600], // Light grey color
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  'Cancellation will not be permitted',
                  style: GoogleFonts.outfit(
                    fontSize: 9.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Order Might Get Delayed due to many uncertainties',
                  style: GoogleFonts.outfit(
                    fontSize: 9.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Expected Time is not the exact time of order preparation.',
                  style: GoogleFonts.outfit(
                    fontSize: 9.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Do not change in the code
