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
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [

            // Display
            Container(
              height: 130,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              alignment: Alignment.bottomRight,
              child: Text(
                displayText,
                style: const TextStyle(
                  fontSize: 38,
                  color: Colors.white,
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
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  String button = topButtons[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (['sin', 'cos', 'tan', 'log'].contains(button)) {
                          displayText = logic.handleTrigLog(button); // alag function call
                        } else {
                          displayText = logic.handleInput(button); // normal buttons
                        }
                      });
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          button,
                          style: const TextStyle(fontSize: 22, color: Colors.white),
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
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "0",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            ".",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "=",
                            style: TextStyle(fontSize: 22, color: Colors.white),
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
