import 'package:calculator/Logic/logic.dart';
import 'package:flutter/material.dart';

class CalculatorUI extends StatefulWidget {
  const CalculatorUI({super.key});

  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  final CalculatorLogic logic = CalculatorLogic();
  String displayText = "0";

  final List<String> topButtons = const [
    'sin', 'cos', 'tan', 'log',
    'x²', 'x³', '√', '%',
    '(', ')', 'C', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [

            // Display
            Container(
              height: 162,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              alignment: Alignment.bottomRight,
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Top Grid Buttons
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(4),
                itemCount: topButtons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  String button = topButtons[index];

                  // Determine button style
                  Color? bgColor;
                  Color? textColor;
                  FontWeight fontWeight;
                  List<Shadow> textShadow;
                  Color shadowColor;

                  // Last column (÷, ×, -, +)
                  if (index % 4 == 3) {
                    bgColor = Colors.indigo[200];
                    textColor = Colors.white;
                    fontWeight = FontWeight.bold;
                    shadowColor = Colors.black26;
                    textShadow = [];
                  } 
                  // Numbers & point
                  else if ('0123456789.'.contains(button)) {
                    bgColor = Colors.white;
                    textColor = Colors.blueGrey[700];
                    fontWeight = FontWeight.bold;
                    shadowColor = Colors.black26;
                    textShadow = [
                      const Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      )
                    ];
                  } 
                  // Special function buttons
                  else {
                    bgColor = Colors.grey[300]!;
                    textColor = Colors.black87;
                    fontWeight = FontWeight.normal;
                    shadowColor = Colors.black12;
                    textShadow = [];
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (['sin', 'cos', 'tan', 'log'].contains(button)) {
                          displayText = logic.handleTrigLog(button);
                        } else {
                          displayText = logic.handleInput(button);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: '0123456789.'.contains(button)
                            ? Border.all(color: Colors.black12, width: 1.5)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          button,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: fontWeight,
                            color: textColor,
                            shadows: textShadow,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Last Row: 0, ., =
            Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  // 0 button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          displayText = logic.handleInput("0");
                        });
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12, width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "0",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // . button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          displayText = logic.handleInput(".");
                        });
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12, width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            ".",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // = button (double width)
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          displayText = logic.calculateResult();
                        });
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.indigo[200],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "=",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
