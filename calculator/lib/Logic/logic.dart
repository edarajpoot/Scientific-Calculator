import 'dart:math';

class CalculatorLogic {
  String display = "0";

  // Handle input for buttons
String handleInput(String input) {
  if (input == 'C') {
    display = "0";
    return display;
  }

  // Regex to find last number in expression
  RegExp reg = RegExp(r'(\d+\.?\d*)$');
  var match = reg.firstMatch(display);

  if (match != null && (input == 'x²' || input == 'x³' || input == '√' || input == '%')) {
    double val = double.tryParse(match.group(0)!) ?? 0;
    double newVal = val;

    switch (input) {
      case 'x²':
        newVal = val * val;
        break;
      case 'x³':
        newVal = val * val * val;
        break;
      case '√':
        newVal = val >= 0 ? sqrt(val) : 0;
        break;
      case '%':
        newVal = val / 100;
        break;
      case 'sin':
    display = display.replaceRange(match.start, match.end, (sin(val * pi / 180)).toStringAsFixed(4));
    return display;
  case 'cos':
    display = display.replaceRange(match.start, match.end, (cos(val * pi / 180)).toStringAsFixed(4));
    return display;
  case 'tan':
    display = display.replaceRange(match.start, match.end, (tan(val * pi / 180)).toStringAsFixed(4));
    return display;
  case 'log':
    if (val > 0) {
      display = display.replaceRange(match.start, match.end, (log(val)/ln10).toStringAsFixed(4));
    } else {
      display = "Error";
    }
    return display;

    }

    // Replace last number in display with newVal
    display = display.replaceRange(match.start, match.end, newVal.toString());
    return display;
  }

  // Normal number / operator
  if (display == "0") {
    display = input;
  } else {
    display += input;
  }
  return display;
}

// Call this function separately from UI when these buttons are pressed
String handleTrigLog(String input) {
  RegExp reg = RegExp(r'(\d+\.?\d*)$');
  var match = reg.firstMatch(display);

  if (match != null) {
    double val = double.tryParse(match.group(0)!) ?? 0;
    switch (input) {
      case 'sin':
        display = display.replaceRange(match.start, match.end, sin(val * pi / 180).toStringAsFixed(4));
        break;
      case 'cos':
        display = display.replaceRange(match.start, match.end, cos(val * pi / 180).toStringAsFixed(4));
        break;
      case 'tan':
        display = display.replaceRange(match.start, match.end, tan(val * pi / 180).toStringAsFixed(4));
        break;
      case 'log':
        if (val > 0) {
          display = display.replaceRange(match.start, match.end, (log(val)/ln10).toStringAsFixed(4));
        } else {
          display = "Error";
        }
        break;
    }
  }
  return display;
}


  // "=" button: calculate full expression
  String calculateResult() {
    try {
      // Replace ×, ÷ with *, /
      String expr = display.replaceAll('×', '*').replaceAll('÷', '/');

      // Evaluate expression
      double result = _evalExpression(expr);
      display = _formatResult(result);
    } catch (e) {
      display = "Error";
    }
    return display;
  }

  // 🔹 Evaluate simple math expression using recursion (supports +,-,*,/, parentheses)
  double _evalExpression(String expr) {
    expr = expr.replaceAll(' ', '');
    return _parseExpression(expr);
  }

  double _parseExpression(String expr) {
    List<String> tokens = _tokenize(expr);
    return _evaluateTokens(tokens);
  }

  List<String> _tokenize(String expr) {
    List<String> tokens = [];
    String number = '';

    for (int i = 0; i < expr.length; i++) {
      String ch = expr[i];
      if ('0123456789.'.contains(ch)) {
        number += ch;
      } else {
        if (number.isNotEmpty) {
          tokens.add(number);
          number = '';
        }
        tokens.add(ch);
      }
    }
    if (number.isNotEmpty) tokens.add(number);
    return tokens;
  }

  double _evaluateTokens(List<String> tokens) {
    // Handle parentheses recursively
    while (tokens.contains('(')) {
      int open = tokens.lastIndexOf('(');
      int close = tokens.indexOf(')', open);
      List<String> sub = tokens.sublist(open + 1, close);
      double val = _evaluateTokens(sub);
      tokens.replaceRange(open, close + 1, [val.toString()]);
    }

    // Handle * and /
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double res = tokens[i] == '*' ? left * right : left / right;
        tokens.replaceRange(i - 1, i + 2, [res.toString()]);
        i--;
      }
    }

    // Handle + and -
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double val = double.parse(tokens[i + 1]);
      if (op == '+') result += val;
      if (op == '-') result -= val;
    }

    return result;
  }

  String _formatResult(double val) {
    if (val == val.roundToDouble()) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(4);
  }
}
