import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panell/main.dart';

class tutorialPage extends StatefulWidget {
  const tutorialPage({super.key});

  @override
  State<tutorialPage> createState() => _tutorialPageState();
}

class _tutorialPageState extends State<tutorialPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hey!",
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 1, 1, 1),
                fontSize: 70 * scaleFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
              child: Divider(thickness: 2),
            ),

            Text(
              "Welcome to Panell!",
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 1, 1, 1),
                fontSize: 40 * scaleFactor,
                fontWeight: FontWeight.w500,
              ),
            ),

            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              width: 100 * scaleFactor,
              height: 50 * scaleFactor,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 128, 135, 222),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pageTwo()),
                  );
                },
                child: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
              ),
            ),
            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              width: 150 * scaleFactor,
              height: 50 * scaleFactor,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 128, 135, 222),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settingsPage()),
                  );
                },
                child: Text(
                  "Skip Tutorial",
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15 * scaleFactor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class pageTwo extends StatefulWidget {
  const pageTwo({super.key});

  @override
  State<pageTwo> createState() => _pageTwoState();
}

class _pageTwoState extends State<pageTwo> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Navigating:",
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 1, 1, 1),
                fontSize: 70 * scaleFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
              child: Divider(thickness: 2),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 200 * scaleFactor,
              ),
              child: Text(
                "To configure settings, including country, press the settings icon!",
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 1, 1, 1),
                  fontSize: 40 * scaleFactor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              width: 100 * scaleFactor,
              height: 50 * scaleFactor,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 128, 135, 222),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pageThree()),
                  );
                },
                child: Icon(Icons.settings, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class pageThree extends StatefulWidget {
  const pageThree({super.key});

  @override
  State<pageThree> createState() => _pageThreeState();
}

class _pageThreeState extends State<pageThree> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Great Job!",
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 1, 1, 1),
                fontSize: 70 * scaleFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
              child: Divider(thickness: 2),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 200 * scaleFactor,
              ),
              child: Text(
                "To hide the mouse cursor when in the app, hover over the left info-widget!",
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 1, 1, 1),
                  fontSize: 40 * scaleFactor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              width: 100 * scaleFactor,
              height: 50 * scaleFactor,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 128, 135, 222),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pageFour()),
                  );
                },
                child: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class pageFour extends StatefulWidget {
  const pageFour({super.key});

  @override
  State<pageFour> createState() => _pageFour();
}

class _pageFour extends State<pageFour> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Well Done!",
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 1, 1, 1),
                fontSize: 70 * scaleFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
              child: Divider(thickness: 2),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 200 * scaleFactor,
              ),
              child: Text(
                "You've got it now! Now you can try out your new skills!",
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 1, 1, 1),
                  fontSize: 40 * scaleFactor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(padding: EdgeInsets.all(20)),
            SizedBox(
              width: 100 * scaleFactor,
              height: 50 * scaleFactor,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 128, 135, 222),
                  ),
                ),
                onPressed: () {
                  save.write('tutorial', true);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => settingsPage()),
                  );
                },
                child: Icon(Icons.check, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
