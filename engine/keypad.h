// This file is part of the SpeedCrunch project
// Copyright (C) 2014 @qwazix
// Copyright (C) 2018 Mikko Syrjä
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; see the file COPYING.  If not, write to
// the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
// Boston, MA 02110-1301, USA.

#ifndef KEYPAD_H
#define KEYPAD_H

#include <QString>
#include <QJsonParseError>

//! Single key data.
class KeyData
{
public:
	//! Constructor.
	KeyData() : color(false), bold(false ), row(0), col(0) { }

	QString GetScript() const;

	QString label;							//!< Key label.
	QString value;							//!< Key primary value.
	QString second;							//!< Key secondary value.
	QString tooltip;						//!< Key tooltip text.
	bool color;								//!< True for highlight.
	bool bold;								//!< True for bold text.
	int row;								//!< Key row index.
	int col;								//!< Key column index.
};

typedef std::vector<KeyData> KeyRow;		//!< Single key row.
typedef std::vector<KeyRow> Keyboard;		//!< Keyboard rows.

bool LoadKeyboard(const QString& path, const QString& name, Keyboard& keyboard, QJsonParseError& error);

#endif // KEYPAD_H
