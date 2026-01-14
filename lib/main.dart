import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[50]!),
      ),
      home: const BmiMainPage(title: 'BMI Calculator'),
    );
  }
}

class BmiMainPage extends StatefulWidget {
  const BmiMainPage({super.key, required this.title});

  final String title;

  @override
  State<BmiMainPage> createState() => _BmiMainPageState();
}

class _BmiMainPageState extends State<BmiMainPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _heightNode = FocusNode();
  final FocusNode _weightNode = FocusNode();
  double result = 0.0;
  String bmiStatus = "";
  bool isAppStartfirstTime = true;
  void calc() {
    if (_heightController.text.isEmpty) {
      _heightNode.requestFocus();
    } else if (_weightController.text.isEmpty) {
      _weightNode.requestFocus();
    }

    setState(() {
      double h = double.parse(_heightController.text) / 100;
      double w = double.parse(_weightController.text);
      result = w / (h * h);
      bmiStatus = result < 18.5
          ? "Underweight"
          : result < 24.9
          ? "Normal weight"
          : result < 29.9
          ? "Overweight"
          : "Obesity";
    });
  }

  void reset() {
    setState(() {
      _heightController.clear();
      _weightController.clear();
      _heightNode.unfocus();
      _weightNode.unfocus();
      result = 0.0;
    });
  }

  void share() {
    if (isAppStartfirstTime || result == 0) {
      _heightNode.requestFocus();
      return;
    }
    String msg = '''📊 Just checked my BMI today!

My BMI: 23.4  
Health status: Normal weight  

I used a simple and clean BMI Calculator by  
🌿 Sunshine Foundations  

It really helped me understand my health better.
 ''';
    Share.share(msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 211, 254, 246), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 40),
                child: Text(
                  "BMI Calculator",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: SizedBox(
                  width: 300,

                  child: TextField(
                    controller: _heightController,
                    focusNode: _heightNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Height (cm)",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Card(
                child: SizedBox(
                  width: 300,

                  child: TextField(
                    controller: _weightController,
                    focusNode: _weightNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Weight (Kg)",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: SizedBox(
                  width: 220,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      calc();
                      FocusScope.of(context).unfocus();
                      isAppStartfirstTime = false;
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 3,
                      /* shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), */
                    ),
                    child: Text(
                      "Calculate BMI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: isAppStartfirstTime == true
                      ? Container(
                          width: 300,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/sunshineLogo.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 300,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                result.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 65,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                result == 0 ? "_ _ _" : bmiStatus,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*  bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(label: "Reset", icon: Icon(Icons.refresh)),
          BottomNavigationBarItem(label: "Share", icon: Icon(Icons.share)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
        ],
      ), */
      bottomNavigationBar: Card(
        margin: EdgeInsets.all(0),
        elevation: 50,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.7),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  reset();
                },
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  share();
                },
                child: Row(
                  children: [
                    Icon(Icons.share, size: 20, color: Colors.grey.shade600),
                    SizedBox(width: 6),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _heightNode.dispose();
    _weightNode.dispose();
    super.dispose();
  }
}
