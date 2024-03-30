// ignore_for_file: deprecated_member_use

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            // Canteens Heading with Arrow
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // Wrap with Expanded
                    child: Text(
                      'Canteens / Shops',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        color: const Color(0xFF666666),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 70.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded moved inside Column
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('LunchX')
                    .doc('canteens')
                    .collection('users')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display loading indicator while data is being fetched
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    // Display error message if data retrieval fails
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
                        final isOpen = document.data().containsKey('shopOpen')
                            ? document['shopOpen']
                            : false;

                        // Show the card only if the canteen is open
                        if (isOpen) {
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
                            child: Card(
                              margin: const EdgeInsets.all(20),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Leading Image
                                  SizedBox(
                                    width: double.infinity, // Take full width
                                    height: 120, // Set desired height
                                    child: FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('LunchX')
                                          .doc('canteens')
                                          .collection('users')
                                          .doc(document.id)
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        if (snapshot.hasData) {
                                          final canteenData =
                                              snapshot.data!.data();
                                          final imagePath = canteenData != null
                                              ? canteenData['imagePath'] ??
                                                  'assets/default_image.png'
                                              : 'assets/default_image.png';
                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              imagePath,
                                              fit: BoxFit
                                                  .cover, // Ensure the image is fully visible without distortion
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title
                                        Text(
                                          document['canteenName'] ?? 'N/A',
                                          style: GoogleFonts.outfit(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Description
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Do not change in the code
