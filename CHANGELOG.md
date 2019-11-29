### 0.2.5 (2018-03-22)

- Fixed ui scaling for Sailfish X
- Updated engine to version 0.12
- Added setting for decimals
- Improved expression editing

### 0.2.6 (2018-03-25)

- Fixed cover expression
- Fixed inverse trigonometric functions
- Added units to function list
- Added setting for result format
- New keyboard:
	- Added fifth row for parenthesis and editing
	- Added semicolon for function parameters
	- Added button 0x for entering hexadecimal values
	- Button 0x produces 0b with long press
	- Buttons 1-6 produce letters A-F with long press
	- Hexadecimal result mode displays letters A-F
	- Added buttons for AND, OR and SHIFT operations
	- Long press with x= creates new function
	- Added new button -> for unit conversion
	- Removed home and end buttons
	- Removed deprecated % button

### 0.2.7 (2018-03-28)

- Fixed angle unit setting z-ordering
- Changed some keys to use Unicode characters
- Changed GitHub repository name to speedcrunch-sailfish
- Added bottom pulley menu:
	- Copy result copies just result value to clipboard
	- Copy expression copies whole result line to clipboard
	- Paste gets clipboard contents to cursor position
	- Clear history clears whole history list
- Added clear button for function search field
- Added status texts for result format and angle unit

### 0.3.0 (2018-04-11)

- Added function parameter hints as text field label
- Added autocalc value as text field label
- Some minor keyboard tweaks:
	- Long press with x generates character y
	- Long press with ← goes to the start of expression
	- Long press with → goes to the end of expression
- Submitted to Jolla Store

### 0.3.1 (2018-04-13)

- Added support for complex numbers:
	- Setting for Disabled, Cartesian or Polar mode
	- Long press with 9 generates j for imaginary part
- Changed automatic precision maximum decimals to 12
- Added 16 and 20 decimals to the precision list
- Reordered settings, moved format and precision to top
- Fixed application initialization for Jolla Harbour QA
- Resubmitted to Jolla Store

### 0.3.2 (2018-04-24)

- Function list uses Silica list view with quick scroll
- Function list shows also user variables and functions
- Added setting for filtering function list items:
	- All shows all items
	- Functions shows only built-in functions
	- Units shows only built-in units
	- Constants shows only built-in constants
	- User defined shows only user variables and functions
- Added function list item context menus:
	- Activated normally with long press
	- Insert to expression inserts item to expression
	- Delete user defined deletes user defined item
- History list is now managed by the engine
- Result format change affects to history items
- Added setting for saving session history on exit

### 0.3.3 (2018-07-28)

- Fixed user defined function removing
- Added error message displaying:
	- Autocalc errors as text field label
	- Evaluation errors as notifications
- Function list context menu first item displays content:
	- For functions usage is displayed
	- For constants and variables value is displayed
	- For units unit name is displayed
	- Selecting item inserts it to the expression
- Function list items are sorted alphabetically
- Added support for recently used items:
	- Single string list remembers recently used item names
	- Recently used items are displayed first with bold text
	- Context menu item removes item from the recent list
	- New user functions and variables are automatically recent
	- Recent item list size is not currently limited
- Compiled with SDK version 1804 for Sailfish 2.2.0

### 0.4.0 (2018-09-10)

- Added setting for list font size: small, medium or large
- Latest result in history list is displayed with bold font
- Function list popup shows also user function expression
- Virtual keyboard enter just closes keyboard without evaluation
- Title line is now outside of flickable area
- New application icon
- Submitted to Jolla Store

### 0.4.1 (2018-10-19)

- Improved expression syntax error handling
- History list scrolls to latest item at startup
- Fixed Save History on Exit setting behavior
- New setting Direct Insert from Lists:
	- When on inserts function instantly when clicked
	- When off inserting requires use of context menu
- Added history list popup menu:
	- First item inserts selected result
	- Second item edits selected expression
	- Third item removes line from history list
	- Follows Direct Insert from Lists setting
- Compiled with SDK version 1807 for Sailfish 2.2.1
- Added 108x108 and 128x128 size icons
- Initial localization support:
	- Function and constant translations from desktop version
	- Id based UI translations with english as a backup.
	- https://www.transifex.com/mikkosyrja/speedcrunch-mobile/
	- Currently en_GB (source) and fi_FI translations
	- Added languages de_DE, it_IT, fr_FR, es_ES, ru_RU and sv_SE
- Removed tips from settings page
- Moved system settings to the bottom of settings page

### 0.4.2 (2018-11-13)

- Added spanish UI translations (thanks @carmenfdezb)
- Added support for portuguese language pt_PT
- Initial landscape mode support:
	- Uses single 3x10 button keyboard and hides status bar
	- Decimal and angle modes displayed in title bar
	- System settings at the bottom of settings page are hidden
	- Still some combobox problems with Sailfish 3.0
- Some keyboard modifications:
	- Long press with square (x²) produces generic exponent
	- Long press with square root (√) produces cubic root
- Fixed some text colors to work with SFOS 3 light ambiences
- Added settings page pull-up menu:
	- First item opens SpeedCruch Sailfish home page in browser
	- Second item opens SpeedCruch engine home page in browser

### 0.5.0 (2018-11-27)

- Fixed images to work with SFOS 3.0 light ambiences
- Added some flicking resistance to buttons:
	- Drag within button does not flick keyboard or page
	- Reduces unwanted flicks when pressing buttons
- Added french UI translations (thanks @JeanDeLaMouche)
- Submitted to Jolla Store

### 0.5.1 (2019-06-04)

- Compiled with SDK version 2.1.1 for Sailfish 3.0.3
- Added support for slovenian language pl_SL
- Added slovenian UI translations (thanks @sponka)
- Added swedish UI translations (thanks @ekrogius)
- Initial keyboard configuration:
	- Keyboard layouts are loaded from json files
	- Initially four different layouts:
	- Classic layout will stay as version 0.5 keyboard
	- Current layout will be default keyboard from now on
	- Gemini layout has only two rows in horizontal mode
	- Tablet layout has more rows or columns
	- User defined keyboards are supported
- Modifications to Current keyboard:
	- Long press with equal (=) produces previous result (ans)
	- Long press with backspace clears all
	- Long press with ln produces lg()
	- Long press with exp produces 10^
	- Long press with division (÷) produces integer division (\)
	- Long press with trigonometrics produce hyperbolic versions
- Fixed landscape orientation bug with comboboxes
- Fixed history list handling with backslash (integer division)
- Replaced keyboard backspace image with Unicode character

### 0.5.2 (2019-09-07)

- Compiled with SDK version 2.2.4 for Sailfish 3.1.0
- Updated UI translations
- Added support for chinese language zh_CN
- Added support for dynamic key labels in square brackets:
	- [1H] "1" or "1 A" in hexadecimal mode
	- [2H] "2" or "2 B" in hexadecimal mode
	- [3H] "3" or "3 C" in hexadecimal mode
	- [4H] "4" or "4 D" in hexadecimal mode
	- [5H] "5" or "5 E" in hexadecimal mode
	- [6H] "6" or "6 F" in hexadecimal mode
	- [6C] "9" or "9 j" in complex number mode
	- [XO] "0x" or "0o" in octal number mode
	- Used in new keyboards (Current, Gemini, Tablet)

### 0.5.3 (2019-xx-xx)

- Compiled with SDK version 2.3.15 for Sailfish 3.2.0
- Updated UI translations
- Added haptic feedback for keys and list selections
- Added setting for turning haptic feedback on or off

