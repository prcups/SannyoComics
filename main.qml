import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    width: 320
    height: 480
    visible: true
    title: qsTr("Stack")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("搜索")
                width: parent.width
                onClicked: {
                    stackView.push("SearchForm.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("我的收藏")
                width: parent.width
                onClicked: {
                    stackView.push("MyFavorite.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("设置")
                width: parent.width
                onClicked: {
                    stackView.push("Settings.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomePage.qml"
        anchors.fill: parent
    }
}
