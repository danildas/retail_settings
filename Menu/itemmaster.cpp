#include "itemmaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QImage>
#include <QBuffer>
#include <QPixmap>
#include <QLabel>
#include <QApplication>
#include <QWidget>
#include <QFile>

ItemMaster::ItemMaster(QObject *parent): QSqlQueryModel (parent)
{
    connect(this,SIGNAL(groupCodeChanged()),this,SLOT(onGroupCodeChanged()));
    connect(this,SIGNAL(subGroupCodeChanged()),this,SLOT(onSubGroupCodeChanged()));
    this->refresh2();
}

QHash<int, QByteArray> ItemMaster::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "Code";
    roles[Qt::UserRole + 2] = "Name";
    return roles;
}

QVariant ItemMaster::data(const QModelIndex &index, int role) const
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

void ItemMaster::refresh2()
{
    QString query = "SELECT Code,Name FROM 'ITEM' WHERE GroupCode = '" + m_groupCode + "' and SubGroupCode =  '" + m_subGroupCode + "'";
    this->setQuery(query);

    qDebug() << "refresh2 invoked";

    qDebug() <<"refresh2 group code " << m_groupCode;
    qDebug() <<"refresh2 subgroup code" << m_subGroupCode;
}

bool ItemMaster::saveItem(const QString &ItemCode, const QString &ItemName,const int &Price)
{
    int cost;
    qDebug() << "saveItemUnits invoked" ;
    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost = query1.value(0).toInt();
    qDebug() << cost;
    cost = cost * Price;
    qDebug() << cost;

    QSqlQuery query;
    query.prepare("INSERT INTO 'ITEM' (Code,Name,GroupCode,SubGroupCode,Price) VALUES (:code, :name, :groupCode, :subGroupCode, :price)");
                   query.bindValue(":code",ItemCode);
                   query.bindValue(":name",ItemName);
                   query.bindValue(":groupCode",m_groupCode);
                   query.bindValue(":subGroupCode",m_subGroupCode);
                   query.bindValue(":price",cost);

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

bool ItemMaster::saveItemUnits(const QString &ItemCode,const QString &ItemUnitCode,const QString &ItemUnitName,const int &Price)
{
    int cost;
    qDebug() << "saveItemUnits invoked" ;
    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost =query1.value(0).toInt();
    qDebug() << cost;
    cost=cost*Price;
    qDebug() << cost;

    QSqlQuery query;
    query.prepare("INSERT INTO 'ITEM_UNITS' (ItemCode,UnitCode,Name,Price) VALUES(:itemCode,:unitCode,:name,:price)");
                    query.bindValue(":itemCode",ItemCode);
                    query.bindValue(":unitCode",ItemUnitCode);
                    query.bindValue(":name",ItemUnitName);
                    query.bindValue(":price",cost);

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

bool ItemMaster::saveItemUnits(const QString &ItemCode,const int &Price)
{
    int cost;
    qDebug() << "saveItemUnits invoked1" ;
    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost =query1.value(0).toInt();
    qDebug() << cost;
    cost=cost*Price;
    qDebug() << cost;
    QSqlQuery query;

    query.prepare("INSERT INTO 'ITEM_UNITS' (ItemCode,UnitCode,Name,Price) VALUES(:itemCode,'2','Full',:price)");
                    query.bindValue(":itemCode",ItemCode);
                    query.bindValue(":price",cost);

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

bool ItemMaster::saveItemImage(QString ImageUrl, const QString &ItemCode)
{
    qDebug()<<"saveImage invoked"<<ImageUrl;

    QString img =ImageUrl.replace("file:///","");
    qDebug()<<img;

    QImage image(img);
    qDebug() << image.size();
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    image.save(&buffer, "jpg");
    QSqlQuery query;
    query.prepare("INSERT INTO 'ITEM_IMAGE' (ImageUrl,ItemCode) VALUES (?, ?)");
    query.addBindValue(byteArray);
    query.addBindValue(ItemCode);
    qDebug() << query.exec();

}

bool ItemMaster::openItemImage()
{
     qDebug()<<"Open Image Invoked";

     QSqlQuery query;
     qDebug() << query.exec("SELECT ImageUrl FROM 'ITEM_IMAGE' WHERE ItemCode =89");
     qDebug() << query.next();

     QByteArray byteArray;
     byteArray= query.value(0).toByteArray();
     QPixmap pixmap = QPixmap::fromImage(QImage::fromData(byteArray, "jpg"));
     qDebug() <<"pixmap"<<pixmap.size();

     QImage image =QImage::fromData(byteArray,"jpg");

     QFile outFile("C:\\Users\\Danil\\Music\\a.jpg");
     outFile.open (QIODevice::WriteOnly);
     image.save(&outFile,"jpg");

}

bool ItemMaster::deleteItem()
{
    qDebug()<<"Item code"<< m_itemCodeDel;
    QString query0 = ("DELETE FROM 'ITEM' WHERE Code= '" + m_itemCodeDel + "'");
    this->setQuery(query0);

//    QString query1 = ("DELETE FROM 'ITEM_UNITS' WHERE ItemCode= '" + m_itemCodeDel + "' ");
//    this->setQuery(query1);

//    QString query2 = ("DELETE FROM 'ITEM_IMAGE' WHERE ItemCode='" + m_itemCodeDel + "' ");
//    this->setQuery(query2);
}

bool ItemMaster::getItem(QString itemCode)
{
    int cost,itemPrice;
    QSqlQuery query;
   // qDebug() << query.exec("SELECT Price FROM 'ITEM_UNITS' WHERE ItemCode = '"+itemCode+"'");
    qDebug() << query.exec("SELECT Price FROM 'ITEM' WHERE Code = '"+ itemCode +"'");
    qDebug() << query.next();
    itemPrice = query.value(0).toInt();

    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost =query1.value(0).toInt();
    qDebug() << cost;

    setItemPrice( QString::number(itemPrice/cost) );

    qDebug() << m_itemPrice;
}

bool ItemMaster::updateItem(QString itemCode,QString itemNewName, int itemNewPrice)
{
    qDebug() <<itemCode <<itemNewName <<itemNewPrice;

    int cost;
    qDebug() << "saveItemUnits invoked" ;
    QSqlQuery query1;
    qDebug() << query1.exec("SELECT CashUnit FROM 'CASHCENTRE'");
    qDebug() << query1.next();
    cost = query1.value(0).toInt();
    qDebug() << cost;
    cost = cost * itemNewPrice;
    qDebug() << cost;

    QString query =("UPDATE 'ITEM' SET Name = '" + itemNewName + "',Price ='"+ QString::number(cost) +"' WHERE Code = '" + itemCode + "'");
    this->setQuery(query);

}

QString ItemMaster:: itemPrice()
{
   return m_itemPrice;
}
void ItemMaster:: setItemPrice(QString itemPrice)
{
    if( itemPrice!= m_itemPrice )
    {
        m_itemPrice = itemPrice;
        emit itemPriceChanged();
    }
}


QString ItemMaster::groupCode()
{
    return m_groupCode;
}

void ItemMaster:: setGroupCode(const QString &groupCode)
{
    if(groupCode != m_groupCode)
    {
        m_groupCode = groupCode;
        emit groupCodeChanged();
    }
}

QString ItemMaster::subGroupCode()
{
    return m_subGroupCode;
}

void ItemMaster:: setSubGroupCode(const QString &subGroupCode)
{
    if(subGroupCode != m_subGroupCode)
    {
        m_subGroupCode= subGroupCode;
        emit subGroupCodeChanged();
    }
}

void ItemMaster::onGroupCodeChanged()
{
    refresh2();
}

void ItemMaster::onSubGroupCodeChanged()
{
    refresh2();
}

QString ItemMaster::itemCodeDel()
{
    return m_itemCodeDel;
}

void ItemMaster::setItemCodeDel(const QString &itemCodeDel)
{
    if(itemCodeDel != m_itemCodeDel)
    {
        m_itemCodeDel = itemCodeDel;
        emit itemCodeDelChanged();
    }
}
