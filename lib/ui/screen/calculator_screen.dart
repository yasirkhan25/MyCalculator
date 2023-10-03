import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _onDigitPressed(String digit) {
    setState(() {
      if (_currentInput.length < 9) {
        if (digit == "." && _currentInput.contains(".")) return;
        if (_currentInput == "0" && digit != ".") {
          _currentInput = digit;
        } else {
          _currentInput += digit;
        }
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_currentInput.isNotEmpty) {
        if (_num1 == 0) {
          _num1 = double.parse(_currentInput);
          _currentInput = "";
          _operator = operator;
        } else {
          _num2 = double.parse(_currentInput);
          _currentInput = "";
          _num1 = _performOperation(_operator);
          _operator = operator;
        }
      }
    });
  }

  double _performOperation(String operator) {
    switch (operator) {
      case "+":
        return _num1 + _num2;
      case "-":
        return _num1 - _num2;
      case "*":
        return _num1 * _num2;
      case "/":
        return _num1 / _num2;
      default:
        return 0;
    }
  }

  void _onClearPressed() {
    setState(() {
      _currentInput = "";
      _num1 = 0;
      _num2 = 0;
      _operator = "";
      _output = "0";
    });
  }

  void _onEqualsPressed() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _num2 = double.parse(_currentInput);
        _currentInput = "";
        _num1 = _performOperation(_operator);
        _operator = "";
        _output = _num1.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text('Calculator')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                _currentInput.isEmpty ? _output : _currentInput,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("0"),
              _buildButton("."),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("C"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    Color buttonColor = Colors.pink;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (text == "C") {
            _onClearPressed();
          } else if (text == "=") {
            _onEqualsPressed();
          } else if (text == "+" || text == "-" || text == "*" || text == "/") {
            _onOperatorPressed(text);
          } else {
            _onDigitPressed(text);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

}
