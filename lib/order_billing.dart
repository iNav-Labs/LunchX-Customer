// ignore_for_file: library_private_types_in_public_api, avoid_print, dead_code, unused_local_variable, use_build_context_synchronously, sized_box_for_whitespace

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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    fetchOrderData();
  }

  double calculateTotalPrice(List<Map<String, dynamic>> order) {
    double totalPrice = 0.0;
    for (var item in order) {
      totalPrice += (item['price'] + item['packageprice']) * item['count'];
    }
    return totalPrice;
  }

  double calculateParcelCost(List<Map<String, dynamic>> order) {
    double parcelCost = 0.0;
    for (var item in order) {
      parcelCost += item['packageprice'] * item['count'];
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

  Future<String?> getUserNameFromEmail(String? userEmail) async {
    if (userEmail == null) return null;

    try {
      // Query Firestore to find the user's name using the provided email
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('LunchX')
              .doc('customers')
              .collection('users')
              .where('email', isEqualTo: userEmail)
              .limit(1)
              .get();

      // If user with provided email is found, return their name
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['name'] as String?;
      }
    } catch (e) {
      print("Error retrieving user's name: $e");
    }

    // Return null if user's name is not found
    return null;
  }

  Future<String?> getCanteenOwnerEmail(String canteenName) async {
    try {
      // Get the reference to the 'users' collection under 'canteens' in 'LunchX'
      CollectionReference usersCollectionRef = FirebaseFirestore.instance
          .collection('LunchX')
          .doc('canteens')
          .collection('users');

      // Fetch all documents from the 'users' collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await usersCollectionRef.get() as QuerySnapshot<Map<String, dynamic>>;

      // Iterate through each document to find a match for canteenName
      for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc
          in querySnapshot.docs) {
        // Get the canteen name from the current document
        String? canteenDocName = userDoc.data()['canteenName'] as String?;

        // If the canteen name matches the provided canteenName, return the owner's email
        if (canteenDocName == canteenName) {
          return userDoc.data()['email'] as String?;
        }
      }
    } catch (e) {
      print("Error retrieving canteen owner's email: $e");
    }

    // Return null if canteen owner's email is not found
    return null;
  }

  void confirmOrder(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    String? userEmail = user?.email;
    setState(() {
      isLoading = true;
    });

    if (userEmail != null) {
      String? userName = await getUserNameFromEmail(userEmail);

      if (userName != null) {
        try {
          // Get the latest order number from Firestore
          int latestOrderNumber = await getLatestOrderNumber();
          print('$latestOrderNumber is the latest order number.');

          // Increment the order number for the new order
          int orderNumber = latestOrderNumber + 1;
          print('$orderNumber is the new order number.');

          // Map to store cart items
          List<Map<String, dynamic>> cartItemsList = [];

          // Add each item from the cart to the cartItemsList
          for (int i = 0; i < order.length; i++) {
            cartItemsList.add({
              'canteen': order[i]['canteen'],
              'count': order[i]['count'],
              'name': order[i]['name'],
              'price': order[i]['price'],
            });
          }

          // Set the order details
          Map<String, dynamic> orderDetails = {
            'orderNumber': orderNumber,
            'userName': userName,
            'cartItems': cartItemsList,
            'totalPrice': calculateTotalPrice(order),
            'accept?': 'pending',
            'cooking': true,
            'dispatch': false,
            'ready': false,
            'time': 4,
            'email': userEmail,
          };

          // Store order details in the "canteen_orders_queue" collection in Firestore
          CollectionReference canteenOrdersRef = FirebaseFirestore.instance
              .collection('LunchX')
              .doc('customers')
              .collection('canteen_orders_queue');

          // Store order details in the "canteen_orders_queue" collection
          await canteenOrdersRef.doc('Order #$orderNumber').set(orderDetails);

          // Store order details in the "current_order" collection in Firestore for the user
          CollectionReference currentUserOrdersRef = FirebaseFirestore.instance
              .collection('LunchX')
              .doc('customers')
              .collection('users')
              .doc(userEmail)
              .collection('current_orders');

// Store order details in the "current_order" collection
          await currentUserOrdersRef
              .doc('Order #$orderNumber')
              .set(orderDetails);

          // Send order details to canteen owner's folder based on canteen name
          for (var cartItem in cartItemsList) {
            print('canteen name is ${cartItem['canteen']}');
            String? canteenOwnerEmail =
                await getCanteenOwnerEmail(cartItem['canteen']);

            print('canteen owner email $canteenOwnerEmail');

            if (canteenOwnerEmail != null) {
              try {
                CollectionReference canteenOwnerOrdersRef = FirebaseFirestore
                    .instance
                    .collection('LunchX')
                    .doc('canteens')
                    .collection('users')
                    .doc(canteenOwnerEmail)
                    .collection('present_orders');

                // Store order details in canteen owner's folder
                await canteenOwnerOrdersRef
                    .doc('Order #$orderNumber')
                    .set(orderDetails);
              } catch (e) {
                print(
                    "Error storing order details in canteen owner's folder: $e");
              }
            }
          }
          // Clear the cart collection after moving items to "Current Orders"
          await FirebaseFirestore.instance
              .collection('LunchX')
              .doc('customers')
              .collection('users')
              .doc(userEmail)
              .collection('cart')
              .get()
              .then((querySnapshot) {
            for (QueryDocumentSnapshot doc in querySnapshot.docs) {
              doc.reference.delete();
            }
          });

          // Navigate to the payment success screen or any other screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccess()),
          );
        } catch (e) {
          // Handle any errors that occur
          print("Error confirming order: $e");
        }
      } else {
        print("Error: User name not found for email: $userEmail");
      }
    }
  }

// Function to retrieve the latest order number
  Future<int> getLatestOrderNumber() async {
    int latestOrderNumber = 0;

    try {
      // Retrieve the latest order number from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('LunchX')
          .doc('customers')
          .collection('canteen_orders_queue')
          .orderBy('orderNumber', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        latestOrderNumber = querySnapshot.docs.first['orderNumber'] as int;
      }
    } catch (e) {
      print("Error getting latest order number: $e");
    }

    return latestOrderNumber;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth - 20.0;
    bool isDineSelected = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Billing'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
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
                        const SizedBox(height: 10.0),
                        for (int i = 0; i < order.length; i++)
                          if (order[i]['count'] > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: cardWidth / 2 - 70,
                                  height: 25,
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
                                const SizedBox(width: 40.0),
                                Container(
                                  width: cardWidth / 4 - 20,
                                  height: 20.0,
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
                                const SizedBox(width: 10.0),
                                Container(
                                  width: MediaQuery.of(context).size.width / 3 -
                                      60.0,
                                  height: 20.0,
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
                                            size: 14.0,
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
                                            size: 14.0,
                                          ),
                                        ),
                                      ),

                                      // Add a spacer to distribute remaining space
                                      // Spacer(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
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
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: cardWidth / 2 + 25,
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
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: cardWidth / 2 + 25,
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
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: cardWidth / 2 + 25,
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
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: cardWidth / 2 + 25,
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
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            confirmOrder(context);
                          },
                          child: Center(
                            child: Container(
                              height: 40.0,
                              width: screenWidth * 0.5,
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
                                child: SizedBox(
                                  height: 40.0,
                                  child: Stack(
                                    children: [
                                      isLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'Confirm Order',
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                    ],
                                  ),
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
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Terms & Conditions*',
                    style: GoogleFonts.outfit(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[600],
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
      ),
    );
  }
}
