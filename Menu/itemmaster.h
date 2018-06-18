#ifndef ITEMMASTER_H
#define ITEMMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class ItemMaster:public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)
    Q_PROPERTY(QString subGroupCode READ subGroupCode WRITE setSubGroupCode NOTIFY subGroupCodeChanged)
    Q_PROPERTY(QString itemCodeDel READ itemCodeDel WRITE setItemCodeDel NOTIFY itemCodeDelChanged)

    Q_PROPERTY(qreal itemPrice READ itemPrice WRITE setItemPrice NOTIFY itemPriceChanged)

public:

    int rowValue = 0;

    explicit ItemMaster(QObject *parent=0);

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;

    QString groupCode();
    void setGroupCode(const QString &groupCode);

    QString subGroupCode();
    void setSubGroupCode(const QString &subGroupCode);

    QString itemCodeDel();
    void setItemCodeDel(const QString &itemCodeDel);

    qreal itemPrice();
    void setItemPrice(qreal itemPrice);

signals:

    void groupCodeChanged();
    void subGroupCodeChanged();
    void itemCodeDelChanged();
    void itemPriceChanged();

private slots:
    void onGroupCodeChanged();
    void onSubGroupCodeChanged();

protected:

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

public slots:
   Q_INVOKABLE void refresh2();
   Q_INVOKABLE bool saveItem(const QString &ItemCode, const QString &ItemName,const qreal &Price);
   Q_INVOKABLE bool saveItemUnits(const QString &ItemCode,const QString &ItemUnitCode,const QString &ItemUnitName,const int &Price);
   Q_INVOKABLE bool saveItemUnits(const QString &ItemCode,const int &Price);
   Q_INVOKABLE bool saveItemImage(QString ImageUrl, const QString &ItemCode);
   Q_INVOKABLE bool openItemImage();
   Q_INVOKABLE bool deleteItem();
   Q_INVOKABLE bool getItem(QString itemCode);
   Q_INVOKABLE bool updateItem(QString itemCode, QString itemNewName, qreal itemNewPrice);

private:

    QString m_groupCode;
    QString m_subGroupCode;
    QString m_itemCodeDel;
    qreal m_itemPrice;
};

#endif // ITEMMASTER_H
