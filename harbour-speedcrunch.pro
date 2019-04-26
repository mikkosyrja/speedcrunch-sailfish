TARGET = harbour-speedcrunch

CONFIG += sailfishapp

QT += quick qml dbus

PKGCONFIG += nemonotifications-qt5

DEFINES += SAILFISH
DEFINES += SPEEDCRUNCH_VERSION=\\\"master\\\"

INCLUDEPATH += engine

SOURCES += \
	engine/math/cmath.cpp \
	engine/math/cnumberparser.cpp \
	engine/math/floatcommon.c \
	engine/math/floatconst.c \
	engine/math/floatconvert.c \
	engine/math/floaterf.c \
	engine/math/floatexp.c \
	engine/math/floatgamma.c \
	engine/math/floathmath.c \
	engine/math/floatincgamma.c \
	engine/math/floatio.c \
	engine/math/floatipower.c \
	engine/math/floatlog.c \
	engine/math/floatlogic.c \
	engine/math/floatlong.c \
	engine/math/floatnum.c \
	engine/math/floatpower.c \
	engine/math/floatseries.c \
	engine/math/floattrig.c \
	engine/math/hmath.cpp \
	engine/math/number.c \
	engine/math/quantity.cpp \
	engine/math/rational.cpp \
	engine/math/units.cpp \
	engine/core/constants.cpp \
	engine/core/evaluator.cpp \
	engine/core/functions.cpp \
	engine/core/numberformatter.cpp \
	engine/core/opcode.cpp \
	engine/core/session.cpp \
	engine/core/sessionhistory.cpp \
	engine/core/settings.cpp \
	engine/core/userfunction.cpp \
	engine/core/variable.cpp \
	engine/manager.cpp \
	engine/keypad.cpp \
	src/harbour-speedcrunch.cpp

HEADERS += \
	engine/math/cmath.h \
	engine/math/cnumberparser.h \
	engine/math/floatcommon.h \
	engine/math/floatconfig.h \
	engine/math/floatconst.h \
	engine/math/floatconvert.h \
	engine/math/floaterf.h \
	engine/math/floatexp.h \
	engine/math/floatgamma.h \
	engine/math/floathmath.h \
	engine/math/floatincgamma.h \
	engine/math/floatio.h \
	engine/math/floatipower.h \
	engine/math/floatlog.h \
	engine/math/floatlogic.h \
	engine/math/floatlong.h \
	engine/math/floatnum.h \
	engine/math/floatpower.h \
	engine/math/floatseries.h \
	engine/math/floattrig.h \
	engine/math/hmath.h \
	engine/math/number.h \
	engine/math/quantity.h \
	engine/math/rational.h \
	engine/math/units.h \
	engine/core/constants.h \
	engine/core/errors.h \
	engine/core/evaluator.h \
	engine/core/functions.h \
	engine/core/numberformatter.h \
	engine/core/opcode.h \
	engine/core/session.h \
	engine/core/sessionhistory.h \
	engine/core/settings.h \
	engine/core/userfunction.h \
	engine/core/variable.h \
	engine/manager.h \
	engine/keypad.h

DISTFILES += qml/harbour-speedcrunch.qml \
	qml/cover/CoverPage.qml \
	qml/pages/CalcButton.qml \
	qml/pages/Keyboard.qml \
	qml/pages/Landscape.qml \
	qml/pages/Pager.qml \
	qml/pages/Panorama.qml \
	qml/pages/Settings.qml \
	rpm/harbour-speedcrunch.spec \
	rpm/harbour-speedcrunch.yaml \
	icons/harbour-speedcrunch.svg \
	icons/back.svg \
	icons/clear.svg \
	harbour-speedcrunch.desktop \
	CHANGELOG.md \
	README.md \
	lrelease.sh \
	lupdate.sh \
	locale/mobile.en_GB.ts \
	locale/mobile.fi_FI.ts \
	locale/mobile.de_DE.ts \
	locale/mobile.it_IT.ts \
	locale/mobile.fr_FR.ts \
	locale/mobile.ru_RU.ts \
	locale/mobile.es_ES.ts \
	locale/mobile.sl_SI.ts \
	locale/mobile.sv_SE.ts \
	locale/mobile.pt_PT.ts \
	locale/mobile.ts \
    keyboards/Current.json \
    keyboards/Gemini.json

locale.files = locale/*.qm
locale.path = /usr/share/$${TARGET}/locale
INSTALLS += locale

keyboard.files = keyboards/*.json
keyboard.path = /usr/share/$${TARGET}/keyboards
INSTALLS += keyboard

SAILFISHAPP_ICONS = 86x86 108x108 128x128

