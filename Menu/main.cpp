#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "connection.h"
#include "groupmaster.h"
#include "subgroupmaster.h"
#include "itemmaster.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    if (!createConnection())
    {
        qDebug() << Q_FUNC_INFO << "Unable to connect to database. Please close application ...";
    }

    GroupMaster groupM;
    SubgroupMaster subgroupM;
    ItemMaster itemM;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("_groupMaster", &groupM);
    engine.rootContext()->setContextProperty("_subGroupMaster", &subgroupM);
    engine.rootContext()->setContextProperty("_itemMaster",&itemM);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
