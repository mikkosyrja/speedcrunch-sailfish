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

UI is little bit cramped in Jolla 1, because standard Sailfish buttons seem to have fixed height
regardless of screen size. Should still be usable.

Translations in [Transifex](https://www.transifex.com/mikkosyrja/speedcrunch-mobile)

### Download

Download is available at [https://openrepos.net/content/syrja/speedcrunch](https://openrepos.net/content/syrja/speedcrunch).

### Usage

User interface consists three pages. Leftmost page has function list, initial central page is the
calculator itself and rightmost page contains some settings. Sideways swiping switches between
pages.

In portrait mode sideways swiping within keyboard swithces also between two keyboard panes. Left
pane has number keys and common calculation operations. Right pane has some function keys and
additional operators.

In Landscape mode there is only one three-row keyboard. Trigonometric and logarithmic functions are
not available as keys, but can be found from function list. Cubic root and generic exponent are
available as long press secondary options. Bitwise operators are currently not available.

#### Function and settings pages

Leftmost page has function list containing all SpeedCrunch engine functions, units, constants and
user defined items. Topmost filter list selection can be used to show only built-in functions,
units, constants or user defined variables and functions. Search field below it performs additional
filtering by name.

Long press on list item opens context menu with options. First menu item displays list item
content. For functions it is usage with parameter names. For constants and variables it is value
and for units it is just unit name. Selecting it inserts item to the expression editing field and
activates the main calculator page.

Used items are collected to recent item stack and displayed at the top of the list with bold font.
Newly created user variables and functions are automatically considered recently used. Other items
come after them in alphabetical order. Recent item stack size is not currently limited, but recent
menu items has additional context menu item for removing them from the recent stack. Also, user
defined functions and variables have context menu item for deleting them.

Rightmost page contains some settings. These are mostly same as desktop version settings and more
or less self-explanatory. If the Direct Insert from Lists setting is turned on, pointing item in
function or history list inserts it directly to the expression edit field. Note that user defined
variables and functions are saved with the history list.

At the bottom of the settings page is pull-up menu with items for opening Sailfish Speedcrunch and
Desktop Speedcrunch home pages in browser.

#### Expression editing and history list

At the top of the main calculator page is history list. All calculated expressions and their
results are stored there. Latest result is displayed with bold font.

Long press on list item opens context menu with three options. First item inserts result to the
expression editing and second item recalls the whole expression for editing. Third item allows item
removing from history list.

Below the history list is expression editing field. It can be edited either by calculator key panes
or system virtual keyboard. Enter key on the virtual keyboard just closes it. Because the edit
field is always active, it must be pointed twice to activate virtual keyboard.

Below the expression editor is label field used for function usage parameters and autocalc results.

#### Keyboard and pulley menu

Most keys are familiar to anyone ever used handheld calculator. Key 0x is for entering hexadecimal
values (0xFF). Key x is for variable name x and key X= is for user variable or function definition
(x=42). Big arrow on the right side of second pane is for unit conversion (1 inch -> foot). Bottom
row arrow keys and backspace are for expression field editing.

Some keys have secondary function available with long press:
- Key 0 produces degree sign °
- Keys 1-6 produce hexadecimal values A-F
- Key 9 produces j for complex number imaginary part
- Key . produces apostrophe ' for minutes
- Key ; produces colon : for time values
- Key x² produces generic exponent ^
- Key √ produces cubic root function
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
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
[GNU General Public License](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html) for more
details.

