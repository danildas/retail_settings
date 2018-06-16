#ifndef SUBGROUPMASTER_H
#define SUBGROUPMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>


class SubgroupMaster : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)
    Q_PROPERTY(QString groupCodeDel READ groupCodeDel WRITE setGroupCodeDel NOTIFY groupCodeDelChanged)

public:

    explicit SubgroupMaster( QObject *parent =0 );

    QVariant data(const QModelIndex &index, int role) const;

    QString groupCode();
    void setGroupCode(const QString &groupCode);

    QString groupCodeDel();
    void setGroupCodeDel(const QString &groupCodeDel);

protected:

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void groupCodeChanged();
    void groupCodeDelChanged();

private slots:
    void onGroupCodeChanged();

public slots:
   Q_INVOKABLE void refresh1();
   Q_INVOKABLE bool saveSubgroup(const QString &SubGroupCode, const QString &SubGroupName);
   Q_INVOKABLE bool updateSubgroup(const QString &SubGroupCode, const QString &SubGroupName);
   Q_INVOKABLE bool deleteSubGroup();

private:
    QString m_groupCode;
    QString m_groupCodeDel;
};

#endif // SUBGROUPMASTER_H
