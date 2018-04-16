## SpeedCrunch Sailfish

SpeedCrunch is a high-precision scientific calculator supporting expression editing, history stack,
unit conversions, radix systems, complex numbers and user defined variables.

Sailfish port of [SpeedCrunch](http://speedcrunch.org) calculator.

Based on the original port by @qwazix. Updated to the latest SpeenCrunch engine and fixed UI for
Sailfish X. Currently tested in Jolla 1 and Sony Xperia.

Features:
- Calculations with up to 50 digits of precision
- History stack with value or expression recall
- Expression editing with system virtual keyboard
- Fixed decimal, scientific or engineering formats
- Decimal, binary, octal and hexadecimal bases
- Built-in functions, constants and units with search
- User defined variables and functions

UI is generally quite cramped in Jolla 1, because standard Sailfish buttons seem to have fixed
height regardless of screen size. Will not fix it, but try to keep it somehow usable for now.

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

#### Keyboard and pulley menu

Most keys are familiar to anyone ever used handheld calculator. Key 0x is for entering hexadecimal
values (0xFF). Key x is for variable name x and key X= is for user variable or function definition
(x=42). Big arrow on the right side of second pane is for unit conversion (1 inch -> foot). Bottom
row arrow keys and backspace are for expression field editing.

Some keys have secondary function available with long press:
- Keys 1-6 produce hexadecimal values A-F
- Key 9 produces j for complex number imaginary part
- Key 0x produces 0b for binary values (0b1010)
- Key x produces character y for another variable name
- Key X= produces (x)= for function definition (foo(x)=)
- Keys ← and → move cursor to start or end of expression

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
