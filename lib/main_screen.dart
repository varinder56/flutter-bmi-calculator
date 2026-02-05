import 'package:bmi_var/hero_screen.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

enum HeightUnit { cm, feetInch, meter }

enum WeightUnit { kg, lb }

class BmiMainPage extends StatefulWidget {
  const BmiMainPage({super.key});

  @override
  State<BmiMainPage> createState() => _BmiMainPageState();
}

class _BmiMainPageState extends State<BmiMainPage> {
  HeightUnit _heightUnit = HeightUnit.cm;
  WeightUnit _weightUnit = WeightUnit.kg;
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
      double hi = double.parse(_heightController.text);
      double h;
      if (_heightUnit == HeightUnit.cm) {
        h = hi / 100;
      } else if (_heightUnit == HeightUnit.feetInch) {
        h = hi * 0.3048;
      } else {
        h = hi;
      }
      double wi = double.parse(_weightController.text);
      double w;
      if (_weightUnit == WeightUnit.lb) {
        w = wi * 0.453592;
      } else {
        w = wi;
      }
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
      if (_heightController.text.isEmpty) {
        _heightNode.requestFocus();
      } else {
        _weightNode.requestFocus();
      }
      return;
    }
    String msg = '''📊 Just checked my BMI today!

My BMI: 23.4  
Health status: Normal weight  

I used a simple and clean BMI Calculator by  
🌿 Sunshine Foundations  

It really helped me understand my health better.




🔗
https://github.com/varinder56/flutter-bmi-calculator
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

        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = MediaQuery.of(context).size.width > 600;
            Widget titleBloc = Text(
              "BMI Calculator",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            );
            Widget calculationBloc = Column(
              children: [
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
                        labelText: "Height ",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: DropdownButtonHideUnderline(
                          child: DropdownButton<HeightUnit>(
                            value: _heightUnit,
                            items: [
                              DropdownMenuItem(
                                value: HeightUnit.cm,
                                child: Text("cm"),
                              ),
                              DropdownMenuItem(
                                value: HeightUnit.feetInch,
                                child: Text("ft"),
                              ),
                              DropdownMenuItem(
                                value: HeightUnit.meter,
                                child: Text("m"),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                _heightUnit = v!;
                              });
                            },
                          ),
                        ),
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
                        labelText: "Weight ",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: DropdownButtonHideUnderline(
                          child: DropdownButton<WeightUnit>(
                            value: _weightUnit,
                            items: [
                              DropdownMenuItem(
                                value: WeightUnit.kg,
                                child: Text("Kg"),
                              ),
                              DropdownMenuItem(
                                value: WeightUnit.lb,
                                child: Text("lb"),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                _weightUnit = v!;
                              });
                            },
                          ),
                        ),
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
              ],
            );
            Widget resultBloc = Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: isAppStartfirstTime == true
                      ? InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BannerPage(),
                            ),
                          ),
                          child: Hero(
                            tag: 'sun',
                            child: Container(
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
              ],
            );

            if (isWide) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: calculationBloc,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [titleBloc, resultBloc],
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80, bottom: 40),
                      child: titleBloc,
                    ),
                    calculationBloc,
                    Padding(
                      padding: EdgeInsets.only(top: 45),
                      child: resultBloc,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),

      /* 
      
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(label: "Reset", icon: Icon(Icons.refresh)),
          BottomNavigationBarItem(label: "Share", icon: Icon(Icons.share)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
        ],
      ),
      
      
       */
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
