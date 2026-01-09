import 'package:calculator/Logic/logic.dart';
import 'package:calculator/UI/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback onThemeToggle; // toggle callback

  const CalculatorScreen({super.key, required this.onThemeToggle});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";
  String lastExpression = "";
  final CalculatorLogic logic = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 60),
              child: Column(
                children: [
                  // OUTPUT
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (lastExpression.isNotEmpty)
                              Text(
                                lastExpression,
                                style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                  fontSize: 25,),
                              ),
                            Text(
                              displayText,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold,
                                  fontSize: 45,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // BUTTONS
                  Wrap(
                    children: Buttons.buttonValues
                        .map(
                          (value) => SizedBox(
                            width: value == Buttons.calculate
                                ? screenSize.width / 2
                                : screenSize.width / 4,
                            height: screenSize.width / 5,
                            child: buildButton(value),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // TOP ROW: Calculator title (left) + Toggle (right)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Calculator Text
                  Text(
                    "Calculator",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,),
                  ),

                  // Theme Toggle Button
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    elevation: 6,
                    child: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.wb_sunny   // light mode icon
                          : Icons.nightlight_round, // dark mode icon
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 28,
                    ),
                    onPressed: widget.onThemeToggle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 4,
        color: getBtnColor(value, Theme.of(context)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            setState(() {
              if (['sin', 'cos', 'tan', 'log'].contains(value)) {
                displayText = logic.handleTrigLog(value);
              } else if (value == Buttons.calculate) {
                lastExpression = "$displayText =";
                displayText = logic.calculateResult();
              } else if (value == Buttons.clr) {
                displayText = "0";      
                lastExpression = "";    
              } else {
                displayText = logic.handleInput(value);
              }
            });
          },
          child: Center(
            child: Text(
              value,
              style: getBtnTextStyle(value, Theme.of(context)),
            ),
          ),
        ),
      ),
    );
  }

  Color getBtnColor(value, ThemeData theme) {
    if ([
      Buttons.sin,
      Buttons.cos,
      Buttons.tan,
      Buttons.log,
      Buttons.lbrckt,
      Buttons.rbrckt,
      Buttons.sqrt,
      Buttons.square,
      Buttons.cube,
      ].contains(value)) {
      return theme.colorScheme.primary;
    } else if ([
      Buttons.per,
      Buttons.divide,
      Buttons.multiply,
      Buttons.add,
      Buttons.subtract,
      Buttons.calculate,
      ].contains(value)) {
      return theme.colorScheme.secondary;
    } else if ([Buttons.clr].contains(value)) {
      return theme.colorScheme.error;
    } else {
      return theme.colorScheme.surface;
    }
  }

  TextStyle getBtnTextStyle(value, ThemeData theme) {
    final bool isOperator = [
      Buttons.per,
      Buttons.divide,
      Buttons.multiply,
      Buttons.add,
      Buttons.subtract,
      Buttons.calculate,
      Buttons.clr
    ].contains(value);

    return TextStyle(
      fontSize: isOperator ? 24 : 22,
      fontWeight: FontWeight.bold,
      color: isOperator
          ? theme.colorScheme.onPrimary
          : theme.textTheme.bodyLarge!.color,
      shadows: const [
        Shadow(
          offset: Offset(2, 2),
          blurRadius: 4,
          color: Colors.black26,
        )
      ],
    );
  }
}
