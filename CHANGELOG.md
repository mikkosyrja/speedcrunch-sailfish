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
- New application icon.
- Submitted to Jolla Store

### 0.4.1 (2018-09-xx)

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
	- Follows One Click Insert setting
- Compiled with SDK version 1807 for Sailfish 2.2.1
- Added 108x108 and 128x128 size icons.
- Initial localization support:
	- Function and constant translations from desktop version.
	- Currently english and finnish translations.
