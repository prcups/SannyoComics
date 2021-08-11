import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import SannyoComics 1.0
import Qt.labs.platform 1.0

Page {
    width: window.width
    height: window.height

    title: qsTr("搜索")
    SannyoComics {
        id: comicsBase
    }

    RowLayout {
        id: searchBar
        width: parent.width
        TextField {
            id: searchField
            placeholderText: qsTr("输入漫画名")
            Layout.fillWidth: true
            Layout.leftMargin: 10
        }
        Button {
            text: qsTr("搜索")
            flat: true
            onClicked: {
                if (isBusy.running)
                    return
                if (searchField.text == "") {
                    messageDialog.open()
                }
                isBusy.running = true
                comicListView.model = comicsBase.getComicList(searchField.text)
                isBusy.running = false
            }
        }
    }

    MessageDialog {
        id: messageDialog
        text: "请输入内容"
        buttons: MessageDialog.Ok
    }

    ListView {
        id: comicListView
        width: parent.width
        anchors.top: searchBar.bottom
        anchors.bottom: parent.bottom

        delegate: Button {
            width: comicListView.width
            flat: true
            Text {
                height: parent.height
                width: parent.width
                text: comicListView.model[index]["name"]
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }
    BusyIndicator {
        id: isBusy
        running: false
        anchors.centerIn: parent
    }
}
