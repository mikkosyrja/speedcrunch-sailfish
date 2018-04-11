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
#include "core/functions.h"
#include "core/constants.h"
#include "core/numberformatter.h"
#include "math/units.h"

//! Default constructor.
Manager::Manager()
{
	evaluator = Evaluator::instance();
	settings = Settings::instance();
	clipboard = QGuiApplication::clipboard();
}

//
QString Manager::autoCalc(const QString& input)
{
	const QString expression = evaluator->autoFix(input);
	evaluator->setExpression(expression);
	Quantity quantity = evaluator->evalNoAssign();
	if ( evaluator->error().isEmpty() )
		return NumberFormatter::format(quantity);
	return "NaN";
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
	\param input		Initial expression.
	\return				Result string.
*/
QString Manager::calculate(const QString& input)
{
	const QString expression = evaluator->autoFix(input);
	evaluator->setExpression(expression);
//	Quantity quantity = evaluator->eval();
	Quantity quantity = evaluator->evalUpdateAns();
//	Quantity quantity = evaluator->evalNoAssign();

	return NumberFormatter::format(quantity);
}

//! Get functions, constants and units.
/*!
	\param filter		Filter string.
	\return				Function list in JavaScript format.
*/
QString Manager::getFunctions(const QString& filter)
{
	QString result = "[";
	QStringList functions = FunctionRepo::instance()->getIdentifiers();
	for ( int index = 0; index < functions.count(); ++index )
	{
		if ( Function* function = FunctionRepo::instance()->find(functions.at(index)) )
		{
			if ( filter == "" || function->name().toLower().contains(filter.toLower())
				|| function->identifier().toLower().contains(filter.toLower()))
			{
				QString usage = function->identifier() + "(" + function->usage() + ")";
				usage.remove("<sub>").remove("</sub>");
				result += "{value:\"" + function->identifier() + "\",name:\"" + function->name() + "\",usage:\"" + usage + "\"},";
			}
		}
	}
	for ( const auto& unit : Units::getList() )
	{
		if ( filter == "" || unit.name.contains(filter, Qt::CaseInsensitive))
			result += "{value:\"" + unit.name + "\", name:\"" + unit.name + "\",usage:\"\"},";
	}
	for ( const auto& constant : Constants::instance()->list() )
	{
		if ( filter == "" || constant.value.contains(filter, Qt::CaseInsensitive) || constant.name.contains(filter, Qt::CaseInsensitive))
			result += "{value:\"" + constant.value + "\",name:\"" + constant.name + "\",usage:\"\"},";
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
//		qDebug() << "set angle unit: " << settings->angleUnit;
		settings->save();
	}
}

//! Get angle unit.
/*!
	\return				Angle unit (d, r, g).
*/
QString Manager::getAngleUnit() const
{
	settings->load();
//	qDebug() << "get angle unit: " << settings->angleUnit;
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
//		qDebug() << "set result format: " << settings->resultFormat;
		settings->save();
	}
}

//! Get result format.
/*!
	\return				Result format (g, f, n, e, b, o, h).
*/
QString Manager::getResultFormat() const
{
	settings->load();
//	qDebug() << "get result format: " << settings->resultFormat;
	return QString(settings->resultFormat);
}

//! Set precision.
/*!
	\param precision	Decimal precision.
*/
void Manager::setPrecision(const QString& precision)
{
	settings->resultPrecision = (precision.isEmpty() ? -1 : precision.toInt());
//	qDebug() << "set precision: " << settings->resultPrecision;
	settings->save();
}

//! Get precision.
/*!
	\return				Decimal precision.
*/
QString Manager::getPrecision() const
{
	settings->load();
//	qDebug() << "get precision: " << settings->resultPrecision;
	return (settings->resultPrecision < 0 ? QString() : QString::number(settings->resultPrecision));
}

//! Set clipboard text.
/*!
	\param text			Clipboard text.
*/
void Manager::setClipboard(const QString& text) const
{
//	qDebug() << "set clipboard: " << text;
	clipboard->setText(text);
}

//! Get clipboard text.
/*!
	\return				Clipboard text.
*/
QString Manager::getClipboard() const
{
//	qDebug() << "get clipboard: " << clipboard->text();
	return clipboard->text();
}

