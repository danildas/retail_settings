#ifndef GROUPMASTER_H
#define GROUPMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class GroupMaster: public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)
    Q_PROPERTY(int currencyCost READ currencyCost WRITE setCurrencyCost NOTIFY currencyCostChanged)

public:

    explicit GroupMaster(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role ) const Q_DECL_OVERRIDE;

    QString groupCode();
    void setGroupCode(const QString &groupCode);
    int currencyCost();
    void setCurrencyCost(int &currencyCost);

protected:

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void groupCodeChanged();
    int currencyCostChanged();
public slots:
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool save(const QString &GroupCode, const QString &GroupName);
    Q_INVOKABLE bool updateGroup(const QString &GroupCode, const QString &GroupName);
    Q_INVOKABLE bool deleteGroup();
    Q_INVOKABLE bool clearDB();
    Q_INVOKABLE bool saveCurrencyUnit(const QString &CurrencyUnit);
    Q_INVOKABLE bool loadCurrencyUnit();

private:
    QString m_groupCode;
    int m_currencyCost;
};

#endif // GROUPMASTER_H
