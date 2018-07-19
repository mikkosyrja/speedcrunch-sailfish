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

#include "manager.h"

#include <QFile>
#include <QDir>
#include <QGuiApplication>
#include <QJsonDocument>

#include "core/session.h"
#include "core/functions.h"
#include "core/constants.h"
#include "core/numberformatter.h"
#include "math/units.h"

//! Default constructor.
Manager::Manager()
{
	session = new Session;

	evaluator = Evaluator::instance();
	evaluator->setSession(session);

	settings = Settings::instance();
	settings->load();

	evaluator->initializeBuiltInVariables();
	DMath::complexMode = settings->complexNumbers;

	QString path = Settings::getConfigPath();
	QDir directory;
	directory.mkpath(path);
	path.append("/history.json");

	QFile file(path);
	if ( file.open(QIODevice::ReadOnly) )
	{
		QByteArray data = file.readAll();
		QJsonDocument doc(QJsonDocument::fromJson(data));
		session->deSerialize(doc.object(), true);
		file.close();
	}

	path = Settings::getConfigPath();
	path.append("/recent.json");
	// load recent

	clipboard = QGuiApplication::clipboard();
}

//! Save session on exit.
void Manager::saveSession()
{
	QString path = Settings::getConfigPath();
	path.append("/history.json");

	QFile historyfile(path);
	if ( historyfile.open(QIODevice::WriteOnly) )
	{
		QJsonObject json;
		session->serialize(json);
		QJsonDocument document(json);
		historyfile.write(document.toJson());
		historyfile.close();
	}

	path = Settings::getConfigPath();
	path.append("/recent.json");

	QFile recentfile(path);
	if ( recentfile.open(QIODevice::WriteOnly) )
	{
		QJsonObject json;
//		session->serialize(json);
		QJsonDocument document(json);
		recentfile.write(document.toJson());
		recentfile.close();
	}
}

//! Auto calculate expression.
/*!
	\param input		Expression.
	\return				Result string.
*/
QString Manager::autoCalc(const QString& input)
{
	const QString expression = evaluator->autoFix(input);
	evaluator->setExpression(expression);
	Quantity quantity = evaluator->evalNoAssign();
	if ( quantity.isNan() )
		return "NaN";
	return NumberFormatter::format(quantity);
}

//! Auto fix expression.
/*!
	\param input		Initial expression.
	\return				Fixed expression.
*/
QString Manager::autoFix(const QString& input)
{
	return evaluator->autoFix(input);
}

//! Calculate expression.
/*!
	\param input		Expression.
	\return				Result string.
*/
QString Manager::calculate(const QString& input)
{
	const QString expression = evaluator->autoFix(input);
	evaluator->setExpression(expression);
	Quantity quantity = evaluator->evalUpdateAns();
	if ( quantity.isNan() )
	{
//		notification.setBody("foo");
//		notification.publish();
		return "NaN";
	}
	session->addHistoryEntry(HistoryEntry(expression, quantity));
	return NumberFormatter::format(quantity);
}

//
QString Manager::getError()
{
	QString error = evaluator->error();
	error.remove("<b>").remove("</b>");
	return error;
}

//! Get history list.
/*!
	\return				History list in JavaScript format.

	Last integer parameter is just for triggering update in QML.
*/
QString Manager::getHistory(int)
{
	QString result = "[";
	for ( const auto& entry : session->historyToList() )
		result += "{expression:\"" + entry.expr() + "\",value:\"" + NumberFormatter::format(entry.result()) + "\"},";
	return result += "]";
}

//! Get functions, constants and units.
/*!
	\param filter		Filter string.
	\param type			Function type (a, f, u, c, v).
	\return				Function list in JavaScript format.

	Last integer parameter is just for triggering update in QML.
*/
QString Manager::getFunctions(const QString& filter, const QString& type, int)
{
	QString result = "[";
	if ( type == "a" || type == "f" )	// functions
	{
		for ( const auto& item : recent )	// recent functions
		{
			if ( const Function* function = FunctionRepo::instance()->find(item) )
			{
				if ( filter == "" || function->name().contains(filter, Qt::CaseInsensitive)
					|| function->identifier().contains(filter, Qt::CaseInsensitive))
				{
					QString usage = function->identifier() + "(" + function->usage() + ")";
					usage.remove("<sub>").remove("</sub>");
					result += "{value:\"" + function->identifier() + "\",name:\""
						+ function->name() + "\",usage:\"" + usage + "\",user:false,recent:true},";
				}
			}
		}
		QStringList functions = FunctionRepo::instance()->getIdentifiers();
//		functions.sort(Qt::CaseInsensitive);
		for ( int index = 0; index < functions.count(); ++index )
		{
			if ( const Function* function = FunctionRepo::instance()->find(functions.at(index)) )
			{
				if ( filter == "" || function->name().contains(filter, Qt::CaseInsensitive)
					|| function->identifier().contains(filter, Qt::CaseInsensitive))
				{
					if ( !checkRecent(function->identifier()) )
					{
						QString usage = function->identifier() + "(" + function->usage() + ")";
						usage.remove("<sub>").remove("</sub>");
						result += "{value:\"" + function->identifier() + "\",name:\""
							+ function->name() + "\",usage:\"" + usage + "\",user:false,recent:false},";
					}
				}
			}
		}
	}
	if ( type == "a" || type == "u" )	// units
	{
		for ( const auto& unit : Units::getList() )
		{
			if ( filter == "" || unit.name.contains(filter, Qt::CaseInsensitive))
				result += "{value:\"" + unit.name + "\", name:\""
					+ unit.name + "\",usage:\"\",user:false,recent:false},";
		}
	}
	if ( type == "a" || type == "c" )	// constants
	{
		for ( const auto& constant : Constants::instance()->list() )
		{
			if ( filter == "" || constant.value.contains(filter, Qt::CaseInsensitive)
				|| constant.name.contains(filter, Qt::CaseInsensitive))
				result += "{value:\"" + constant.value + "\",name:\""
					+ constant.name + "\",usage:\"\",user:false,recent:false},";
		}
	}
	if ( type == "a" || type == "v" )	// variables and user functions
	{
		for ( const auto& variable : evaluator->getVariables() )
		{
			if ( variable.type() == Variable::UserDefined )
			{
				if ( filter == "" || variable.identifier().contains(filter, Qt::CaseInsensitive) )
					result += "{value:\"" + variable.identifier() + "\",name:\""
						+ variable.identifier() + "\",usage:\"\",user:true,recent:false},";
			}
		}
		for ( const auto& function : evaluator->getUserFunctions() )
		{
			QString usage = function.name() + "(";
			for ( const auto& argument : function.arguments() )
				usage += argument + ";";
			if ( usage.at(usage.size() - 1) == ';')
				usage.chop(1);
			usage += ")";
			if ( filter == "" || function.name().contains(filter, Qt::CaseInsensitive) )
				result += "{value:\"" + function.name() + "\",name:\""
					+ usage + "\",usage:\"" + usage + "\",user:true,recent:false},";
		}
	}
	return result += "]";
}

//! Set angle unit.
/*!
	\param unit			Angle unit (d, r, g).
*/
void Manager::setAngleUnit(const QString& unit)
{
	if ( !unit.isEmpty() && unit.at(0) != settings->angleUnit )
	{
		settings->angleUnit = unit.at(0).toLatin1();
		evaluator->initializeAngleUnits();
		settings->save();
	}
}

//! Get angle unit.
/*!
	\return				Angle unit (d, r, g).
*/
QString Manager::getAngleUnit() const
{
	return QString(settings->angleUnit);
}

//! Set result format.
/*!
	\param format		Result format (g, f, n, e, b, o, h).
*/
void Manager::setResultFormat(const QString& format)
{
	if ( !format.isEmpty() && format.at(0) != settings->resultFormat )
	{
		settings->resultFormat = format.at(0).toLatin1();
		settings->save();
	}
}

//! Get result format.
/*!
	\return				Result format (g, f, n, e, b, o, h).
*/
QString Manager::getResultFormat() const
{
	return QString(settings->resultFormat);
}

//! Set precision.
/*!
	\param precision	Decimal precision.
*/
void Manager::setPrecision(const QString& precision)
{
	settings->resultPrecision = (precision.isEmpty() ? -1 : precision.toInt());
	settings->save();
}

//! Get precision.
/*!
	\return				Decimal precision.
*/
QString Manager::getPrecision() const
{
	return (settings->resultPrecision < 0 ? QString() : QString::number(settings->resultPrecision));
}

//! Set complex number mode.
/*!
	\param complex		Complex number mode (d, c, p).
*/
void Manager::setComplexNumber(const QString& complex)
{
	if ( complex == "d" )
		settings->complexNumbers = false;
	else
	{
		settings->complexNumbers = true;
		settings->resultFormatComplex = complex.at(0).toLatin1();
	}
	evaluator->initializeBuiltInVariables();
	DMath::complexMode = settings->complexNumbers;
	settings->save();
}

//! Get complex number mode.
/*!
	\return				Complex number mode (d, c, p).
*/
QString Manager::getComplexNumber() const
{
	if ( settings->complexNumbers )
		return QString(settings->resultFormatComplex);
	return "d";
}

//! Set session save setting.
/*!
	\param save			Session save setting.
*/
void Manager::setSessionSave(bool save)
{
	settings->sessionSave = save;
	settings->save();
}

//! Get session save setting.
/*!
	\return				Session save setting.
*/
bool Manager::getSessionSave() const
{
	return settings->sessionSave;
}

//! Clear whole history.
void Manager::clearHistory()
{
	session->clearHistory();
}

//! Clear user variable.
/*!
	\param variable		Variable name.
*/
void Manager::clearVariable(const QString& variable)
{
	evaluator->unsetVariable(variable);
}

//! Clear user function.
/*!
	\param function		Function name.
*/
void Manager::clearFunction(const QString& function)
{
	evaluator->unsetUserFunction(function);
}

//! Update recent list.
/*!
	\param name			Item name.
	\return				True if list needs update.
*/
bool Manager::updateRecent(const QString& name)
{
	for ( auto iterator = recent.begin(); iterator != recent.end(); ++iterator )
	{
		if ( *iterator == name )
		{
			if ( iterator == recent.begin() )	// already first
				return false;
			recent.erase(iterator);
			break;
		}
	}
	recent.insert(recent.begin(), name);
	return true;
}

//! Remove item from recent list.
/*!
	\param name			Item name.
	\return				True if list needs update.
*/
bool Manager::removeRecent(const QString& name)
{
	for ( auto iterator = recent.begin(); iterator != recent.end(); ++iterator )
	{
		if ( *iterator == name )
		{
			recent.erase(iterator);
			return true;
		}
	}
	return false;
}

//! Set clipboard text.
/*!
	\param text			Clipboard text.
*/
void Manager::setClipboard(const QString& text) const
{
	clipboard->setText(text);
}

//! Get clipboard text.
/*!
	\return				Clipboard text.
*/
QString Manager::getClipboard() const
{
	return clipboard->text();
}

//
bool Manager::checkRecent(const QString& name) const
{
	for ( auto iterator = recent.begin(); iterator != recent.end(); ++iterator )
	{
		if ( *iterator == name )
			return true;
	}
	return false;
}

