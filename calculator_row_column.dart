import 'package:flutter/material.dart';

class CalculatorRowColumn extends StatelessWidget {
  CalculatorRowColumn({super.key}): _darkGreyBackgroundColor = const Color.fromARGB(255, 51, 51, 51);
  final Color _darkGreyBackgroundColor;

  final _buttonSpecification = [
    ['AC', Icons.exposure, '%', '÷'],
    [7, 8, 9, 'x'],
    [4, 5, 6, '-'],
    [1, 2, 3, '+'],
    [0, '.', '=']
  ];

  @override
  Widget build(BuildContext context) {
    return Container( 
      // Black background color
      color: Colors.black,
      width: 550,
      height: 900,
      child: Column(
          children: [
            Container(
              height: 50,
            ),
            _makeNumberDisplay(),
            _makeInputUIFromData(),
          ],
        ),
    );
  }

  _makeNumberDisplay() {
    return const Align(
      // Put the number on the right side of the screen
      alignment: Alignment.centerRight,
      // Text is the number shown on top of claculator so in this case it's 42
      child: Text("42", style: TextStyle(fontSize: 64, color: Colors.white),)
    );
  }

  _makeInputUIFromData() {
    return Column(
      children: _makeButtonRows(),
    );
  }

 // Part 3: convert 2D array into Column of Rows of Expanded buttons
  _makeButtonRows() {
    // TODO(you): Generate a list of rows of buttons using _buttonSpecification.
    return _buttonSpecification.map((row) {
      return Row(
        // Use List.maps to process the _buttonSpecification
        children: row.map<Widget>((button) {
          // Puts the buttons inside of an expanded button
          return Expanded(
            // If = 0, flex is 2 so it's wider button. Else, flex is 1
            flex: button == 0 ? 2 : 1, 
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: _makeButtonFromSpecificationEntry(button),
            ),
          );
        }).toList(),
      );
    }).toList();
  }

   // Part 3: Customize each button based on its type
  _makeButtonFromSpecificationEntry(entry){
    final rightColumnSymbols = ['÷', 'x', '-', '+', '='];
    final dot = '.';

    if (entry is int) {
      // TODO(you): handle case where the entry is an int
      // For the oblong button number 0
      if (entry == 0) {
        // Wrap each button widget inside an expanded button
        return _makeExpandedButton(
          _makeWideButton(
            // Part 6: Use Align to center the text
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                entry.toString(),
                // Part 6: use TextStyle to change the font and color
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            backgroundColor: _darkGreyBackgroundColor),
          1,
        );

      } else {
        // For integer buttons other than 0
        return _makeExpandedButton(
          _makeCircularButton(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                entry.toString(),
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            backgroundColor: _darkGreyBackgroundColor),
          1,
        );
      }

    } else if (entry is IconData) {
      // TODO(you): handle case where the entry is an IconData
      return _makeCircularButton(
        // Changes the size of the icon button
        child: Icon(entry, size: 44, color: Colors.black),
        // Different background color for top row
        backgroundColor: Colors.grey,
      );

    } else if (entry is String) {
      // TODO(you): handle case where the entry is a String
      // For the operators on the right side of calculator
      if (rightColumnSymbols.contains(entry)) {
        return _makeCircularButton(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              entry,
              // Button size
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          // Orange background for the operators on the right side
          backgroundColor: Colors.orange,
        );

      } else if (entry == dot) { // Case for the period button
        return _makeCircularButton(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              entry,
              // White text
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          // Different background color 
          backgroundColor: _darkGreyBackgroundColor,
        );

      } else {
        // For AC, % buttons
        return _makeCircularButton(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              entry,
              // Black text
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.grey,
        );
      }        
    } else { // This should never be used, but makes sure we always return a widget, even if our _buttonSpecification includes something we didn't anticipate
      return const Placeholder();
    }
  }

  // Part 2: Displays the upper text
  _makeExpandedButton(ElevatedButton button, int flex) {
    return Expanded(
      // Appropriate flex
      flex: flex,
      child: Container(
        // Appropriate margin makes the button's width shorter
        margin: const EdgeInsets.all(3),
        child: button,
      ),
    );
  }

  // Part 1: Create circular buttons
  _makeCircularButton({
    required Widget child,
    required Color backgroundColor,
  }) {
    // Uses ElevatedButton
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        // Sizing of buttons
        padding: const EdgeInsets.all(18),
        // The background color is whichever color is specified for each button
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }

  // Part 4: Make the oblong button for the number 0 
  _makeWideButton({
    required Widget child,
    required Color backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        // Use StadiumBorder to customize a wider button
        shape: const StadiumBorder(),
        // Padding to change it to wide button
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}