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

#include "keypad.h"

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

//
QString KeyData::GetScript() const
{
	QString script = "CalcButton { ";
	if ( !label.isEmpty() )
		script += "text: \"" + label + "\"; ";
	if ( !value.isEmpty() )
		script += "value: \"" + value + "\"; ";
	if ( !second.isEmpty() )
		script += "second: \"" + second + "\"; ";
	if ( color )
		script += "highlight: true; ";
	script += "}";
	return script;
}

//! Load keyboard from JSON file.
/*!
	\param path			JSON file path.
	\param name			Key panel name.
	\param keyboard		Keyboard object.
	\param error		Error object.
*/
bool LoadKeyboard(const QString& path, const QString& name, Keyboard& keyboard, QJsonParseError& error)
{
	QFile file(path);
	if (file.open(QIODevice::ReadOnly))
	{
		auto json = QJsonDocument::fromJson(file.readAll(), &error);
		if (!json.isNull())
		{
			QJsonValue desktop = json.object().value(name);
			if (desktop != QJsonValue::Undefined)
			{
				QJsonValue rows = desktop.toObject().value("rows");
				if (rows != QJsonValue::Undefined)
				{
					int rowCount = 0;
					for (auto row : rows.toArray())
					{
						keyboard.push_back(KeyRow());
						QJsonValue keys = row.toObject().value("keys");
						if (keys != QJsonValue::Undefined)
						{
							int keyCount = 0;
							for (auto key : keys.toArray())
							{
								QJsonObject object = key.toObject();

								KeyData data;
								data.label = object.value("label").toString();
								data.value = object.value("value").toString();
								data.second = object.value("second").toString();
								data.tooltip = object.value("tooltip").toString();
								data.color = object.value("color").toBool();
								data.bold = object.value("bold").toBool();
								data.row = rowCount;
								data.col = keyCount;

								if (data.value.isEmpty())
									data.value = data.label;
								if (data.second.isEmpty())
									data.second = data.value;
								if (data.tooltip.isEmpty())
									data.tooltip = data.value;

								keyboard.back().push_back(data);
								++keyCount;
							}
						}
						++rowCount;
					}
					return true;
				}
			}
		}
	}
	return false;
}
