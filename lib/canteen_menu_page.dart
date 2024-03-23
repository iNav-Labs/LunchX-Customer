// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'order_billing.dart';

// class CanteenMenuPage extends StatefulWidget {
//   const CanteenMenuPage({super.key, required String userEmail});

//   @override
//   _CanteenMenuPageState createState() => _CanteenMenuPageState();
// }

// class _CanteenMenuPageState extends State<CanteenMenuPage> {
//   TextEditingController headingController = TextEditingController();
//   TextEditingController subHeadingController = TextEditingController();
//   int itemCount = 0;
//   bool availabilityStatus = true;

//   // Dummy data for the scrolling cards
//   List<Map<String, dynamic>> menuItems = [
//     {
//       'name': 'Veg Burger',
//       'description':
//           'Veggie Burger in Every Bite: Crunchy Garden-fresh Goodness with our Signature Veg Burger!',
//       'price': 79,
//       'image': 'assets/burger.png',
//       'availibity': true,
//     },
//     {
//       'name': 'Cheese Burger',
//       'description':
//           'Savor the Taste of our Juicy Cheese Burger: Made with 100% Pure Beef and Topped with Melted Cheese!',
//       'price': 99,
//       'image': 'assets/burger.png',
//       'availibity': false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               headingController.text.isNotEmpty
//                   ? headingController.text
//                   : 'High Rise Hostel\n Mess',
//               style:
//                   GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),

//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: 100,
//                     padding: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2,
//                       ),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         '30-35 min',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 100,
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.green,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Open',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Vertical Scrolling Cards

//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
//                 color: Colors.white, // Set the background color to white
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics:
//                             NeverScrollableScrollPhysics(), // Disable scrolling for the nested ListView
//                         scrollDirection: Axis.vertical,
//                         itemCount: menuItems.length,
//                         itemBuilder: (context, index) {
//                           final menuItem = menuItems[index];
//                           return Card(
//                             color: Colors
//                                 .white, // Set the card background color to white
//                             elevation: 0, // Remove the box shadow
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             // Navigate to ManageItemScreen on tap
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(builder: (context) => ManageItemScreen()),
//                                             // );
//                                           },
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 menuItem['name'],
//                                                 style: GoogleFonts.outfit(
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 8),
//                                               Text(
//                                                 menuItem['description'],
//                                                 style: GoogleFonts.outfit(
//                                                   fontSize: 14.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   height: 1.15,
//                                                   color: Color(0xFF858585),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 16),
//                                         Row(
//                                           children: [
//                                             Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 0.0,
//                                                   horizontal: 10.0),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12.0),
//                                                 border: Border.all(
//                                                   color: Colors.black,
//                                                   width: 2.0,
//                                                 ),
//                                               ),
//                                               child: Text(
//                                                 'Rs. ${menuItem['price']}',
//                                                 style: GoogleFonts.outfit(
//                                                   fontSize: 14.0,
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(width: 10),
//                                             // Counter Buttons
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15.0),
//                                                 color: Color(0xFF6552FE),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         // Decrement button tapped
//                                                         if (itemCount > 0) {
//                                                           itemCount--;
//                                                           // Add your logic for decreasing quantity
//                                                         }
//                                                       });
//                                                     },
//                                                     child: Container(
//                                                       padding:
//                                                           EdgeInsets.all(8.0),
//                                                       decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0xFF6552FE),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(12.0),
//                                                       ),
//                                                       child: Icon(
//                                                         Icons.remove,
//                                                         size: 20,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     color: Color(0xFF6552FE),
//                                                     child: Text(
//                                                       itemCount
//                                                           .toString(), // Display the current count
//                                                       style: GoogleFonts.outfit(
//                                                           fontSize: 14.0,
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         // Increment button tapped
//                                                         itemCount++;
//                                                         // Add your logic for increasing quantity
//                                                       });
//                                                     },
//                                                     child: Container(
//                                                       padding:
//                                                           EdgeInsets.all(8.0),
//                                                       decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0xFF6552FE),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(12.0),
//                                                       ),
//                                                       child: Icon(
//                                                         Icons.add,
//                                                         size: 20,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 8),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                       width:
//                                           16), // Adjust as needed for spacing
//                                   Image.asset(
//                                     menuItem['image'],
//                                     width: 150,
//                                     height: 150,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             Container(
//               height: 80.0,
//               decoration: BoxDecoration(
//                 color: Color(0xFF6552FE),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color:
//                         const Color.fromARGB(255, 49, 49, 49).withOpacity(0.5),
//                     spreadRadius: 7,
//                     blurRadius: 10,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: 10),
//                     padding: EdgeInsets.only(left: 139, bottom: 20),
//                     child: Row(
//                       children: [
//                         // Arrow forward icon
//                         Icon(
//                           Icons.arrow_forward,
//                           color: Colors.white,
//                           size: 24.0,
//                         ),
//                         SizedBox(
//                             width:
//                                 10), // Add some space between the icon and text

//                         // Text widget
//                         Text(
//                           'Cart is Hungry!',
//                           style: GoogleFonts.outfit(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => OrderBillingScreen()),
//                       );
//                     },
//                     child: Container(
//                       height: 80,
//                       padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Image.asset(
//                         'assets/cart.gif', // Replace with the path to your logo image
//                         width: 45, // Adjust the width as needed
//                         height: 45, // Adjust the height as needed
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CanteenMenuPage extends StatefulWidget {
  const CanteenMenuPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  _CanteenMenuPageState createState() => _CanteenMenuPageState();
}

class _CanteenMenuPageState extends State<CanteenMenuPage> {
  TextEditingController headingController = TextEditingController();
  TextEditingController subHeadingController = TextEditingController();
  int itemCount = 0;
  bool availabilityStatus = true;

  List<Map<String, dynamic>> menuItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
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
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No data found.');
                }

                // Clear previous menu items
                menuItems.clear();

                // Populate menuItems list with data from Firestore
                for (var document in snapshot.data!.docs) {
                  menuItems.add({
                    'name': document['name'],
                    'description': document['description'],
                    'price': document['price'],
                    'image': document['image'],
                    // 'availability': document['availability'],
                  });
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                          item['image'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item['name']),
                        subtitle: Text(item['description']),
                        trailing: Text('\$${item['price']}'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
