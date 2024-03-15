import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunchx_customer/canteen_menu_page.dart';

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

List<Map<String, dynamic>> canteens = [
  {
    'name': 'Canteen 1',
    'location': 'Building A, Ground Floor',
    'timings': '8:00 AM - 8:00 PM',
    'photo': 'assets/hrh.png',
  },
  {
    'name': 'Canteen 2',
    'location': 'Building B, First Floor',
    'timings': '9:00 AM - 9:00 PM',
    'photo': 'assets/freezland.png',
  },
  {
    'name': 'Canteen 3',
    'location': 'Building C, Ground Floor',
    'timings': '8:30 AM - 7:30 PM',
    'photo': 'assets/hrh.png',
  },
];
List<Map<String, dynamic>> topPicks = [
  {
    'name': 'Burger',
    'photo': 'assets/burger.png',
    'canteen': 'H.R.H Canteen',
  },
  {
    'name': 'Cheese Burger',
    'photo': 'assets/burger.png',
    'canteen': 'PDEU Canteen',
  },
  {
    'name': 'Lettuce',
    'photo': 'assets/burger.png',
    'canteen': 'Freez Land',
  },
  {
    'name': 'Veg Burger',
    'photo': 'assets/burger.png',
    'canteen': 'H.R.H Canteen',
  },
];

class _BodySectionState extends State<BodySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 25),
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
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          // Top Dishes Heading with Arrow
          Container(
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Dishes',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 102, 102, 102),
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 70.0),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Horizontal Scrolling Cards
          Container(
            height: 130.0,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topPicks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // redirect to next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CanteenMenuPage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '${topPicks[index]['photo']}', // Replace with your image asset path
                            height: 70, // Adjust the height as needed
                            width: 70, // Adjust the width as needed
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '${topPicks[index]['name']}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${topPicks[index]['canteen']}',
                            style: GoogleFonts.outfit(
                              fontSize: 9,
                              color: const Color(0xFF6552FE),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Canteens Heading with Arrow
          Container(
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Canteens / Shops',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 102, 102, 102),
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 70.0),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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

          // Vertical Scrolling Cards
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: canteens.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // redirect to next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CanteenMenuPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: const Color.fromARGB(
                            255, 255, 255, 255), //lor to white
                        elevation: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    50,
                                color: Colors
                                    .white, // Set the background color of the Row to white
                                child: Image.asset(
                                  canteens[index]['photo'],
                                  height: 120, // Adjust the height as needed
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Text on the left side aligned to the right
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10), // Add top margin
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${canteens[index]['location']}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.0,
                                          color: const Color(0xFF6552FE),
                                        ),
                                      ),
                                      Text(
                                        '${canteens[index]['name']}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        '${canteens[index]['timings']}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
