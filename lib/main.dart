import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:panell/API/APIKey.dart';
import 'package:provider/provider.dart';
import 'darkTheme.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:get_storage/get_storage.dart';
import 'tutorial.dart';

double celsius = 0.0;
String cityName = "";
var validThing = false;
final save = GetStorage();

String errText = 'Please enter a valid city name in settings.';

final TextEditingController textController = TextEditingController();
final now = DateTime.now();

void main() async {
  await GetStorage.init();

  runApp(
    ChangeNotifierProvider(create: (context) => darkTheme(), child: MyApp()),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await FullScreen.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<darkTheme>(
      builder: (context, theme, child) => MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          brightness: theme.darkMode ? Brightness.dark : Brightness.light,
          scaffoldBackgroundColor: theme.darkMode
              ? Color.fromARGB(255, 44, 44, 44)
              : Color(0xFFEFEFEF),
        ),
        home: tutorialPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? weatherTimer;
  Timer? clockTimer;
  final formattedDate = '';
  final formattedTime = '';

  var celsius = 0.0;
  String precip = "Fetching Weather";
  var humidity = 0.0;
  var weatherID = 0;

  void fetchWeather() async {
    final apiKey = api_Key;
    final apiUrl = Uri.parse(
      'https://corsproxy.io/?url=https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Temperature: ${data['main']['temp'] - 273.15}°C');
        print('Conditions: ${data['weather'][0]["description"]}');
        print('Humidity: ${data['main']['humidity']}%');
        celsius = data['main']['temp'] - 273.15;
        //Add precipitation here too!
        humidity = data['main']['humidity'];

        precip = data['weather'][0]["description"];
      } else {
        print('Failed to load data: ${response.statusCode}');

        celsius = 0.0;
        //Add precipitation here too!
        humidity = 0.0;

        precip = "Please enter a valid city name in settings.";
      }
    } catch (e) {
      print('Error during API call: $e');
    }

    setState(() {});
  }

  String clothingRecommendation() {
    if (celsius < 10) {
      return "Recommendation: Long sleeves, hoodie/jacket, closed shoes.";
    } else if (10 < celsius && celsius <= 15) {
      return "Recommendation: Long sleeves, closed shoes.";
    } else if (15 < celsius && celsius <= 20) {
      return "Recommendation: No jersey, open shoes.";
    } else if (20 < celsius && celsius <= 25) {
      return "Recommendation: Short sleeves, open shoes.";
    } else if (25 < celsius && celsius <= 30) {
      return "Recommendation: Short sleeves, short pants, open shoes.";
    } else if (celsius > 30) {
      return "Recommendation: Short sleeves, short pants, open shoes, breathable clothing.";
    } else {
      return "How is there an edge case here? :O";
    }
  }

  String _currentTime = DateFormat('jm').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchWeather();

    weatherTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      fetchWeather();
      setState(() {});
    });

    void startTimer() {
      clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _currentTime = DateFormat('jm').format(DateTime.now());
        });
      });
    }

    @override
    void dispose() {
      clockTimer?.cancel();
      super.dispose();
    }

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,

              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),

                //Below are the box parts. They make it look a certain way.
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 128, 135, 222),
                      Color.fromARGB(255, 89, 79, 160),
                    ],
                  ),
                ),
                child: MouseRegion(
                  cursor: SystemMouseCursors.none,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                            cityName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 60 * scaleFactor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Padding(padding: EdgeInsets.all(20)),
                          Text(
                            "${celsius.toStringAsFixed(1)}ºc",

                            style: GoogleFonts.quicksand(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 50 * scaleFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Divider(
                            color: Color.fromARGB(255, 109, 101, 170),
                            thickness: 2,
                          ),

                          Text(
                            "${humidity.toStringAsFixed(1)}%",

                            style: GoogleFonts.quicksand(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 50 * scaleFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Divider(
                            color: Color.fromARGB(255, 109, 101, 170),
                            thickness: 2,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                precip.replaceFirst(
                                  precip[0],
                                  precip[0].toUpperCase(),
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 50 * scaleFactor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          Divider(
                            color: Color.fromARGB(255, 109, 101, 170),
                            thickness: 2,
                            height: 0,
                          ),

                          Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              clothingRecommendation(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30 * scaleFactor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      //Here I put the container's attributes!
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 200,
                      //Below are the box parts. They make it look a certain way.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),

                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 128, 135, 222),
                            Color.fromARGB(255, 89, 79, 160),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _currentTime,
                          style: GoogleFonts.quicksand(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 70 * scaleFactor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(255, 128, 135, 222),
                      ),
                      shape: WidgetStateProperty.all(CircleBorder()),
                      minimumSize: WidgetStateProperty.all(Size(60, 60)),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => settingsPage()),
                      );

                      if (result == true) {
                        fetchWeather();
                      }
                    },
                    child: Icon(
                      Icons.settings,
                      size: 40 * scaleFactor,
                      color: Colors.white,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      //Here I put the container's attributes!
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10.0),

                      //Below are the box parts. They make it look a certain way.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),

                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 128, 135, 222),
                            Color.fromARGB(255, 89, 79, 160),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: GoogleFonts.quicksand(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 70 * scaleFactor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1200;
    return Consumer<darkTheme>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10 * scaleFactor)),

                Text(
                  "Dark Mode",
                  style: GoogleFonts.quicksand(
                    fontSize: 50 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: value.darkMode ? Colors.white : Colors.black,
                  ),
                ),

                Switch(
                  value: value.darkMode,
                  onChanged: (bool newValue) {
                    setState(() {
                      value.toggle();
                    });
                  },
                ),

                Padding(padding: EdgeInsets.all(20 * scaleFactor)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
                  child: Divider(
                    color: value.darkMode
                        ? Color.fromARGB(255, 97, 97, 97)
                        : Color.fromARGB(255, 112, 112, 112),
                    thickness: 2,
                  ),
                ),

                Text(
                  "Full Screen",
                  style: GoogleFonts.quicksand(
                    fontSize: 50 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: value.darkMode ? Colors.white : Colors.black,
                  ),
                ),

                Switch(
                  value: FullScreen.isFullScreen,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      FullScreen.setFullScreen(value);
                    });
                  },
                ),

                Padding(padding: EdgeInsets.all(20 * scaleFactor)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 500 * scaleFactor),
                  child: Divider(
                    color: value.darkMode
                        ? Color.fromARGB(255, 97, 97, 97)
                        : Color.fromARGB(255, 112, 112, 112),
                    thickness: 2,
                  ),
                ),

                Text(
                  "Enter Location",
                  style: GoogleFonts.quicksand(
                    fontSize: 50 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: value.darkMode ? Colors.white : Colors.black,
                  ),
                ),

                Padding(padding: EdgeInsets.all(5 * scaleFactor)),
                SizedBox(
                  width: 400 * scaleFactor,
                  height: 50 * scaleFactor,
                  child: TextField(
                    style: TextStyle(
                      color: value.darkMode ? Colors.white : Colors.black,
                      fontSize: 16, // Optional: change font size
                    ),
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      labelText: 'Enter Location',
                      hintText: 'E.g. London',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30 * scaleFactor)),
                SizedBox(
                  width: 400 * scaleFactor,
                  height: 50 * scaleFactor,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(255, 128, 135, 222),
                      ),
                    ),
                    onPressed: () {
                      if (textController.text != "") {
                        cityName = textController.text;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {}
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.quicksand(
                        fontSize: 30 * scaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
