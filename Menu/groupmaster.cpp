#include "groupmaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QTableView>
#include <QSqlRecord>


GroupMaster::GroupMaster(QObject *parent): QSqlQueryModel (parent)
{
   this->refresh();
   this ->loadCurrencyUnit();
}

QHash<int, QByteArray> GroupMaster::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "Code";
    roles[Qt::UserRole + 2] = "Name";
    return roles;
}

QVariant GroupMaster::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

void GroupMaster::refresh()
{
    QString query = "SELECT Code,Name FROM 'GROUP'";
    this->setQuery(query);
    qDebug() << "refresh invoked" ;
}

bool GroupMaster::save(const QString &GroupCode, const QString &GroupName)
{
   QSqlQuery query;
    query.prepare("INSERT INTO 'GROUP' (Code, Name) VALUES (:GroupCode,:GroupName)");
            query.bindValue(":GroupCode",GroupCode);
            query.bindValue(":GroupName",GroupName);

    if(!query.exec()){
        qDebug() << "error insert into " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool GroupMaster::saveCurrencyUnit(const QString &CurrencyUnit)
{
    qDebug()<<"CurrencyUnit"<<CurrencyUnit;
    QSqlQuery query;
    query.prepare("INSERT INTO 'CASHCENTRE' (CashUnit) VALUES (:currencyUnit)");
            query.bindValue(":currencyUnit",CurrencyUnit);


    if(!query.exec()){
        qDebug() << "error insert into " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool GroupMaster::updateGroup(const QString &GroupCode, const QString &GroupName)
{
    qDebug()<<"Mgroup code"<<m_groupCode;
    qDebug()<<"group code"<<GroupCode;
    qDebug()<<"group name"<<GroupName;
    QString query =("UPDATE 'GROUP' SET Name='" +GroupName+ "' WHERE Code= '" + m_groupCode + "'"); //Code='" +GroupCode+ "',
    this->setQuery(query);

 /*   QString query1 = ("UPDATE 'SUBGROUP' SET GroupCode ='" +GroupCode+ "' WHERE GroupCode = " + m_groupCode + "'");
    this->setQuery(query1);

    QString query2 = ("UPDATE 'ITEM' SET GroupCode ='" +GroupCode+ "' WHERE GroupCode ='" + m_groupCode + "'");
    this->setQuery(query2);*/

}

bool GroupMaster::deleteGroup()
{
    qDebug()<<"group code"<<m_groupCode;
    QString query1 = ("DELETE FROM 'GROUP' WHERE Code='" + m_groupCode + "' ");
    this->setQuery(query1);

    QString query2 = ("DELETE FROM 'SUBGROUP' WHERE GroupCode= '" + m_groupCode + "'");
    this->setQuery(query2);

    QString query3 = ("DELETE FROM 'ITEM' WHERE GroupCode= '" + m_groupCode + "'");
    this->setQuery(query3);

    QString query4 = ("DELETE FROM 'ITEM_UNITS' WHERE ItemCode=(SELECT Code FROM 'ITEM' WHERE GroupCode='" + m_groupCode + "')");
    this->setQuery(query4);

    QString query5 = ("DELETE FROM 'ITEM_IMAGE' WHERE ItemCode=(SELECT Code FROM 'ITEM' WHERE GroupCode='" + m_groupCode + "')");
    this->setQuery(query5);
}

bool GroupMaster::clearDB()
{
    qDebug()<<"clear db";
/*    QString query1 = ("DELETE FROM 'GROUP'");
    this->setQuery(query1);

    QString query2 = ("DELETE FROM 'SUBGROUP'");
    this->setQuery(query2);

    QString query3 = ("DELETE FROM 'ITEM'");
    this->setQuery(query3);

    QString query4 = ("DELETE FROM 'ITEM_UNITS'");
    this->setQuery(query4);

    QString query5 = ("DELETE FROM 'ITEM_IMAGE'");
    this->setQuery(query5);*/
}

bool GroupMaster::loadCurrencyUnit()
{
    int cost;
    qDebug() << "loadCurrencyUnit invoked" ;
    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost =query1.value(0).toInt();
    qDebug() << cost;
    m_currencyCost=cost;
}

QString GroupMaster::groupCode()
{
    return m_groupCode;
}

void GroupMaster::setGroupCode(const QString &groupCode)
{
    if (groupCode != m_groupCode)
    {
        m_groupCode = groupCode;
        emit groupCodeChanged();
    }
}

int GroupMaster::currencyCost()
{
    return m_currencyCost;
}

void GroupMaster::setCurrencyCost(int &currencyCost)
{
    if(currencyCost != m_currencyCost)
    {
        m_currencyCost = currencyCost;
        emit currencyCostChanged();
    }
}
