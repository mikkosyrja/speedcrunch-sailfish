## SpeedCrunch Sailfish

SpeedCrunch is a high-precision scientific calculator supporting expression editing, history stack, unit conversions, radix systems and user defined variables.

Sailfish port of [SpeedCrunch](http://speedcrunch.org) calculator.

Features:
- Calculations with up to 50 digits of precision
- History stack with value or expression recall
- Expression editing with system virtual keyboard
- Fixed decimal, scientific or engineering formats
- Decimal, binary, octal and hexadecimal bases
- Built-in functions, constants and units with search
- User defined variables and functions

### Usage

User interface consists three pages and two keyboard panes. Leftmost page has function list,
central page is the calculator itself and rightmost page contains some settings. Sideways swiping
on the upper side of screen switches between pages and swiping on the keyboard switches either
between pages or between keyboard panes.

#### Function and settings pages

Leftmost page has function list containing all SpeedCrunch engine functions, constants and units.
Topmost field can be used to filter names. Pointing function name inserts it to the expression
editing field and activates the main calculator page.

Rightmost page contains some settings. These are same as desktop version settings and mostly
self-explanatory.

#### Expression editing and history list

At the top of the main calculator page is history list. All calculated expressions and their
results are stored there. Pointing history list line inserts result to the expression editing.
Pointing and holding history line recalls the whole expression for editing.

Below the history list is expression editing field. It can be edited either by calculator key panes
or standard Sailfish virtual keyboard. Because the expression field is always active, it must be
pointed twice to activate the Sailfish keyboard.

Below the expression editor is label field used for function syntax hints and autocalc results.

#### Keyboard

Most keys are familiar to anyone ever used handheld calculator. Key 0X is for entering hexadecimal
values (0xFF). Key X is for variable name X and key X= is for user variable or function definition
(X=42). Big arrow on the right side of second pane is for unit conversion (1 inch -> foot). Bottom
row arrow keys and backspace are for expression field editing.

Some keys have secondary function available with long press:
- Keys 1-6 produce hexadecimal values A-F
- Key 0x produces 0b for binary values (0b1010)
- Key X produces character Y for another variable name
- Keys ← and → move cursor to start or end of expression

#### Pulley menu

Bottom pulley menu has functions for copying latest result or expression to clipboard, pasting
clipboard contents to the expression field and clearing the history list.

For more information, see desktop SpeedCrunch [documentation](http://speedcrunch.org/userguide/index.html).


### License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.
