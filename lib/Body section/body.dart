// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lunchx_customer/canteen_menu_page.dart'; // Import Firestore

// class BodySection extends StatefulWidget {
//   const BodySection({super.key});

//   @override
//   State<BodySection> createState() => _BodySectionState();
// }

// class _BodySectionState extends State<BodySection> {
//   List<Map<String, dynamic>> canteens = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCanteensData();
//   }

//   void fetchCanteensData() {
//     FirebaseFirestore.instance
//         .collection('LunchX')
//         .doc('canteens')
//         .collection('users')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         canteens.clear();
//         for (var document in querySnapshot.docs) {
//           Map<String, dynamic> canteenData = {
//             'name': document['name'] ?? 'N/A',
//             // 'location': document['location'] ?? 'N/A',
//             // 'photo': document['photo'] ?? '',
//             // 'timings': document['timings'] ?? 'N/A',
//           };
//           canteens.add(canteenData);
//         }
//       });
//     }).catchError((error) {
//       // Handle error
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             padding: const EdgeInsets.only(left: 30),
//             decoration: BoxDecoration(
//               color: const Color(0xFF6552FE),
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Text(
//                   'Time Free, \nMess Free \nFood !',
//                   style: GoogleFonts.outfit(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     letterSpacing: -0.4,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 94,
//                 ),
//                 Image.asset(
//                   'assets/thumbnail_burger.png',
//                   height: 200,
//                   width: 180,
//                   fit: BoxFit.cover,
//                 ),
//               ],
//             ),
//           ),

//           // Canteens Heading with Arrow
//           Container(
//             alignment: Alignment.centerLeft,
//             color: const Color(0x00FFFFFF), // Transparent color
//             margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   // Wrap with Expanded
//                   child: Text(
//                     'Canteens / Shops',
//                     style: GoogleFonts.outfit(
//                       fontSize: 18,
//                       color: const Color.fromARGB(255, 102, 102, 102),
//                       backgroundColor:
//                           Colors.transparent, // Transparent background
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 70.0),
//                 Container(
//                   decoration: const BoxDecoration(
//                     color: Color(0x0fffffff), // Transparent color
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(8.0),
//                       bottomRight: Radius.circular(8.0),
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(6.0),
//                   child: const Icon(
//                     Icons.arrow_downward,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Vertical Scrolling Cards
//           Expanded(
//             child: Container(
//               color: const Color.fromARGB(255, 255, 255, 255),
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: canteens.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       // redirect to next page
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CanteenMenuPage()),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Card(
//                         color: const Color.fromARGB(
//                             255, 255, 255, 255), //lor to white
//                         elevation: 2,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             color: Color.fromARGB(255, 255, 255, 255),
//                           ),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width * 0.5 -
//                                     50,
//                                 color: Colors
//                                     .white, // Set the background color of the Row to white
//                                 child: Image.asset(
//                                   canteens[index]['photo'],
//                                   height: 120, // Adjust the height as needed
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               const SizedBox(width: 20),
//                               // Text on the left side aligned to the right
//                               Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10), // Add top margin
//                                   color: Colors.white,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         '${canteens[index]['location']}',
//                                         style: GoogleFonts.outfit(
//                                           fontSize: 12.0,
//                                           color: const Color(0xFF6552FE),
//                                         ),
//                                       ),
//                                       Text(
//                                         '${canteens[index]['name']}',
//                                         style: GoogleFonts.outfit(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 30),
//                                       Text(
//                                         '${canteens[index]['timings']}',
//                                         style: GoogleFonts.outfit(
//                                           fontSize: 14.0,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/canteen_menu_page.dart';

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              color: const Color(0xFF6552FE),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Time Free, \nMess Free \nFood !',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(
                  width: 94,
                ),
                Image.asset(
                  'assets/thumbnail_burger.png',
                  height: 200,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('LunchX')
                  .doc('canteens')
                  .collection('users')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CanteenMenuPage(
                                userEmail: document.id,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Icons.restaurant),
                              title: Text(document['canteenName'] ?? 'N/A'),
                              subtitle: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox(); // Return an empty widget if there's no data
              },
            ),
          ),
        ],
      ),
    );
  }
}
