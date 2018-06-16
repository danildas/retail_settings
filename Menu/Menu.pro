TEMPLATE = app

QT += qml quick sql widgets
CONFIG += c++11

SOURCES += main.cpp \
    groupmaster.cpp \
    subgroupmaster.cpp \
    itemmaster.cpp

RESOURCES += qml.qrc \
    image.qrc \
    fonts.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES +=

HEADERS += \
    connection.h \
    groupmaster.h \
    subgroupmaster.h \
    itemmaster.h
