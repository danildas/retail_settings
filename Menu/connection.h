#ifndef CONNECTION_H
#define CONNECTION_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QFile>
#include <QDebug>

#define DB_PATH "F:/WorkSpace/Qt/work/3-2-18/Menu/POS.db"

static bool createConnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(DB_PATH);

    QFile file(DB_PATH);

    if (file.exists())
    {
        if (db.open())
        {
            return true;
            qDebug() << Q_FUNC_INFO << "connection success";
        }
    }

    return false;
}

#endif // CONNECTION_H
