#include "sannyocomics.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QCoreApplication>
#include <QRegularExpression>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

SannyoComics::SannyoComics(QObject *parent) : QObject(parent) {
    NetworkManager = new QNetworkAccessManager;
}
SannyoComics::~SannyoComics() {
    delete NetworkManager;
}

QVariantList SannyoComics::getComicList(QString keywords) {
    if (keywords == "") return QVariantList();
    QNetworkRequest req;
    QNetworkReply *rep;
    req.setHeader(QNetworkRequest::UserAgentHeader,
                  "Mozilla/5.0 (X11; Linux x86_64; rv:90.0) Gecko/20100101 Firefox/90.0");
    req.setUrl(QUrl("https://www.manbaifen.com/search/?keywords=" + keywords));
    rep = NetworkManager->get(req);
    while (!rep->isFinished())
        QCoreApplication::processEvents();
    QString rawHTML = rep->readAll();
    QRegularExpression reg1(
                "<ul[^>]*id='contList'[^>]*>[\\s\\S]*?<\\/ul>",
                QRegularExpression::CaseInsensitiveOption |
                QRegularExpression::MultilineOption
    ), reg2("<li[\\s\\S]*?<p class=\"ell\">"
                "<a href=\"(?'url'[^\"]+)\">(?'name'[^<]+)<\\/a><\\/p>[\\s\\S]*?<\\/li>",
            QRegularExpression::CaseInsensitiveOption |
            QRegularExpression::MultilineOption);
    QRegularExpressionMatchIterator matchIt = reg2.globalMatch(reg1.match(rawHTML).captured(0));
    QJsonArray comicListArray;

    while (matchIt.hasNext()) {
        QRegularExpressionMatch match = matchIt.next();
        QJsonObject comicListElement;
        comicListElement.insert("name", match.captured("name"));
        comicListElement.insert("url", "https://www.manbaifen.com" + match.captured("url"));
        comicListArray.append(comicListElement);
    }
    return comicListArray.toVariantList();
}
