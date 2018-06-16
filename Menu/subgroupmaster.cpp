#include "subgroupmaster.h"
#include <QSqlQuery>
#include <QDebug>

SubgroupMaster::SubgroupMaster(QObject *parent): QSqlQueryModel (parent)
{
    this->refresh1();
    connect(this,SIGNAL(groupCodeChanged()),this,SLOT(onGroupCodeChanged()));
}

QHash<int, QByteArray>SubgroupMaster::roleNames() const
{
    QHash<int ,QByteArray> roles;
    roles[Qt::UserRole + 1] = "Code";
    roles[Qt::UserRole + 2] = "Name";
    return roles;
}

QVariant SubgroupMaster::data(const QModelIndex &index, int role) const
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

void SubgroupMaster::refresh1()
{
    QString query = "SELECT Code,Name FROM 'SUBGROUP' WHERE GroupCode = '" + m_groupCode + "' ";
    this->setQuery(query);
    qDebug() << "refresh1 invoked"<<m_groupCode;
}

bool SubgroupMaster::saveSubgroup(const QString &SubGroupCode, const QString &SubGroupName)
{

    QSqlQuery query;
    query.prepare("INSERT INTO 'SUBGROUP' (Code,Name,GroupCode) VALUES (:code, :name, :groupCode)");
                   query.bindValue(":code",SubGroupCode);
                   query.bindValue(":name",SubGroupName);
                   query.bindValue(":groupCode",m_groupCode);

     if(!query.exec())
     {
         qDebug() << "error insert into " ;
         qDebug() << query.lastError().text();
         return false;
     } else {
         return true;
     }
     return false;
}

bool SubgroupMaster::updateSubgroup(const QString &SubGroupCode, const QString &SubGroupName)
{
    qDebug()<<"Mgroup code"<<m_groupCodeDel;
    qDebug()<<"group code"<<SubGroupCode;
    qDebug()<<"group name"<<SubGroupName;
    QString query =("UPDATE 'SUBGROUP' SET Name='" +SubGroupName+ "' WHERE Code= '" + m_groupCodeDel + "'");
    this->setQuery(query);
}

bool SubgroupMaster::deleteSubGroup()
{
    qDebug()<<"group code(sub)"<< m_groupCodeDel;
    QString query0 = ("DELETE FROM 'SUBGROUP' WHERE Code= '" + m_groupCodeDel + "'");
    this->setQuery(query0);

    QString query1 = ("DELETE FROM 'ITEM' WHERE SubGroupCode= '" + m_groupCodeDel + "'");
    this->setQuery(query1);

    QString query2 = ("DELETE FROM 'ITEM_UNITS' WHERE ItemCode=(SELECT Code FROM 'ITEM' WHERE SubGroupCode='" + m_groupCodeDel + "')");
    this->setQuery(query2);
}

QString SubgroupMaster::groupCode()
{
    return m_groupCode;
}

void SubgroupMaster::setGroupCode(const QString &groupCode)
{
    if (groupCode != m_groupCode)
    {
        m_groupCode = groupCode;
        emit groupCodeChanged();
    }
}

void SubgroupMaster::onGroupCodeChanged()
{
    refresh1();
}

QString SubgroupMaster::groupCodeDel()
{
    return m_groupCodeDel;
}

void SubgroupMaster::setGroupCodeDel(const QString &groupCodeDel)
{
    if(groupCodeDel != m_groupCodeDel)
    {
        m_groupCodeDel = groupCodeDel;
        emit groupCodeDelChanged();
    }
}
