import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

Page {
    width: window.width
    height: window.height

    title: qsTr("首页")
    Row {}

    RowLayout {
        id: searchBar
        width: parent.width
        TextField {
            id: searchField
            placeholderText: qsTr("输入漫画名")
            Layout.fillWidth: true
        }
        Button {
            text: qsTr("搜索")
            flat: true
        }
    }

    Label {
        id: listName
        text: qsTr("<b>搜索结果</b>")
        anchors.top: searchBar.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ListView {
        id: comicListView
        width: parent.width
        anchors.top: listName.bottom
        model: ListModel {
            id: comicList
        }
        delegate: Button {
            width: comicList.width
            flat: true
            Label {
                height: parent.height
                text: name
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }
}
