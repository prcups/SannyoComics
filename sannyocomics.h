#ifndef SANNYOCOMICS_H
#define SANNYOCOMICS_H
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

#include <QObject>

class SannyoComics : public QObject
{
    Q_OBJECT
    QNetworkAccessManager *NetworkManager;
public:
    explicit SannyoComics(QObject *parent = nullptr);
    ~SannyoComics();
    Q_INVOKABLE QVariantList getComicList(QString keywords);
signals:

};

#endif // SANNYOCOMICS_H
