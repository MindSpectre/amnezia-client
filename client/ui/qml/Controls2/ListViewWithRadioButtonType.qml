import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "TextTypes"

ListView {
    id: root

    property var rootWidth

    property var selectedText

    property int textMaximumLineCount: 2
    property int textElide: Qt.ElideRight

    property string imageSource: "qrc:/images/controls/check.svg"

    property var clickedFunction

    currentIndex: 0

    width: rootWidth
    height: root.contentItem.height

    clip: true
    interactive: false

    ButtonGroup {
        id: buttonGroup
    }

    function triggerCurrentItem() {
        var item = root.itemAtIndex(currentIndex)
        var radioButton = item.children[0].children[0]
        radioButton.clicked()
    }

    delegate: Item {
        implicitWidth: rootWidth
        implicitHeight: content.implicitHeight

        ColumnLayout {
            id: content

            anchors.fill: parent

            RadioButton {
                id: radioButton

                implicitWidth: parent.width
                implicitHeight: radioButtonContent.implicitHeight

                hoverEnabled: true

                indicator: Rectangle {
                    anchors.fill: parent
                    color: radioButton.hovered ? "#2C2D30" : "#1C1D21"

                    Behavior on color {
                        PropertyAnimation { duration: 200 }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        enabled: false
                    }
                }

                RowLayout {
                    id: radioButtonContent
                    anchors.fill: parent

                    anchors.rightMargin: 16
                    anchors.leftMargin: 16

                    z: 1

                    ParagraphTextType {
                        Layout.fillWidth: true
                        Layout.topMargin: 20
                        Layout.bottomMargin: 20

                        text: name
                        maximumLineCount: root.textMaximumLineCount
                        elide: root.textElide

                    }

                    Image {
                        source: imageSource
                        visible: radioButton.checked

                        width: 24
                        height: 24

                        Layout.rightMargin: 8
                    }
                }

                ButtonGroup.group: buttonGroup
                checked: root.currentIndex === index

                onClicked: {
                    root.currentIndex = index
                    root.selectedText = name
                    if (clickedFunction && typeof clickedFunction === "function") {
                        clickedFunction()
                    }
                }
            }
        }

        Component.onCompleted: {
            if (root.currentIndex === index) {
                root.selectedText = name
            }
        }
    }
}
