import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: window.width
    height: window.height

    title: qsTr("我的收藏")

    Label {
        text: qsTr("You are on Page 1.")
        anchors.centerIn: parent
    }
}
