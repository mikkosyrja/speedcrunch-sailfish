TARGET = harbour-speedcrunch

CONFIG += sailfishapp

QT += quick qml dbus

DEFINES += SAILFISH
DEFINES += SPEEDCRUNCH_VERSION=\\\"master\\\"

SOURCES += \
	math/floatcommon.c \
	math/floatconst.c \
	math/floatconvert.c \
	math/floaterf.c \
	math/floatexp.c \
	math/floatgamma.c \
	math/floathmath.c \
	math/floatincgamma.c \
	math/floatio.c \
	math/floatipower.c \
	math/floatlog.c \
	math/floatlogic.c \
	math/floatlong.c \
	math/floatnum.c \
	math/floatpower.c \
	math/floatseries.c \
	math/floattrig.c \
	math/hmath.cpp \
	math/number.c \
	core/constants.cpp \
	core/evaluator.cpp \
	core/functions.cpp \
	core/settings.cpp \
	src/manager.cpp \
	src/harbour-speedcrunch.cpp \
	math/rational.cpp \
	math/units.cpp \
	core/numberformatter.cpp \
	math/quantity.cpp \
	math/cmath.cpp \
	core/opcode.cpp \
	core/variable.cpp \
	core/userfunction.cpp \
	core/session.cpp \
	core/sessionhistory.cpp \
	math/cnumberparser.cpp

HEADERS += \
	math/floatcommon.h \
	math/floatconfig.h \
	math/floatconst.h \
	math/floatconvert.h \
	math/floaterf.h \
	math/floatexp.h \
	math/floatgamma.h \
	math/floathmath.h \
	math/floatincgamma.h \
	math/floatio.h \
	math/floatipower.h \
	math/floatlog.h \
	math/floatlogic.h \
	math/floatlong.h \
	math/floatnum.h \
	math/floatpower.h \
	math/floatseries.h \
	math/floattrig.h \
	math/hmath.h \
	math/number.h \
	core/constants.h \
	core/errors.h \
	core/evaluator.h \
	core/functions.h \
	core/settings.h \
	src/manager.h \
	math/rational.h \
	math/units.h \
	core/numberformatter.h \
	math/quantity.h \
	math/cmath.h \
	core/opcode.h \
	core/variable.h \
	core/userfunction.h \
	core/session.h \
	core/sessionhistory.h \
	math/cnumberparser.h

OTHER_FILES += \
	qml/cover/CoverPage.qml \
	harbour-speedcrunch.desktop \
	qml/pages/Pager.qml \
	qml/pages/Panorama.qml \
	qml/pages/CalcButton.qml \
	qml/pages/Backspace.qml \
	qml/pages/Keyboard.qml \
	qml/pages/Settings.qml \
	qml/pages/erase_to_the_left.svg \
	qml/harbour-speedcrunch.qml \
	rpm/harbour-speedcrunch.yaml

DISTFILES += qml/harbour-speedcrunch.qml \
	qml/cover/CoverPage.qml \
	qml/pages/Backspace.qml \
	qml/pages/CalcButton.qml \
	qml/pages/Keyboard.qml \
	qml/pages/Pager.qml \
	qml/pages/Panorama.qml \
	qml/pages/Settings.qml \
	rpm/harbour-speedcrunch.spec \
	rpm/harbour-speedcrunch.yaml \
	harbour-speedcrunch.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128

