// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, avoid_print, dead_code

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_done.dart';

class OrderBillingScreen extends StatefulWidget {
  const OrderBillingScreen({super.key});

  @override
  _OrderBillingScreenState createState() => _OrderBillingScreenState();
}

class _OrderBillingScreenState extends State<OrderBillingScreen> {
  List<Map<String, dynamic>> order = [
    {
      'name': 'Veg Burger',
      'quantity': 3,
      'price': 79,
    },
    {
      'name': 'Chicken Burger',
      'quantity': 1,
      'price': 89,
    },
    {
      'name': 'Pizza',
      'quantity': 2,
      'price': 129,
    },
  ];

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
                                  color: const Color.fromARGB(255, 255, 255, 255),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6552FE),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (order[i]['quantity'] > 1) {
                                            order[i]['quantity']--;
                                          }
                                        });
                                      },
                                      child: Container(
                                        child: const Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        '${order[i]['quantity']}',
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          order[i]['quantity']++;
                                        });
                                      },
                                      child: Container(
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDineSelected = true;
                              print('DINE choosed');
                            });
                          },
                          child: Center(
                            child: Container(
                              height: 30.0,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFF6552FE),
                                  width: 2.0,
                                ),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDineSelected = true;
                                          print('DINE choosed');
                                        });
                                      },
                                      child: Container(
                                        width: 70,
                                        padding:
                                            const EdgeInsets.only(top: 2, bottom: 2),
                                        decoration: BoxDecoration(
                                          color: isDineSelected
                                              ? Colors.white
                                              : const Color(0xFF6552FE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          'DINE',
                                          style: GoogleFonts.outfit(
                                            color: isDineSelected
                                                ? const Color(0xFF6552FE)
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDineSelected = false;
                                          print('PARCEL choosed');
                                        });
                                      },
                                      child: Container(
                                        width: 70,
                                        padding:
                                            const EdgeInsets.only(top: 2, bottom: 2),
                                        decoration: BoxDecoration(
                                          color: isDineSelected
                                              ? const Color(0xFF6552FE)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          'PARCEL',
                                          style: GoogleFonts.outfit(
                                            color: isDineSelected
                                                ? Colors.white
                                                : const Color(0xFF6552FE),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
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
              height: 20,
            ),
            Text.rich(
              TextSpan(
                text: 'Unlock ',
                style: GoogleFonts.outfit(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: '32 mins',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  TextSpan(
                    text: ' of saved time now!',
                    style: GoogleFonts.outfit(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
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
                                  'Rs. 120 /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                  'Rs. 10 /-',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    color: Colors.black,
                                    fontSize: 18,
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

// **************************************************************************************************
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
