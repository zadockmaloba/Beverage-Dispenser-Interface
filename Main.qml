import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Window {
    width: 640
    height: 480
    visible: true
    visibility: "FullScreen"
    title: qsTr("Beverage Dispenser Interface")

    Item {
        id: watermark_container
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        Text {
            id: watermark
            anchors.fill: parent
            font.bold: true
            font.pixelSize: 24
            color: "grey"
            text: qsTr("Biverage Dispenser Interface | Zadock")
        }
    }

    component CButton: AbstractButton {
        id: btn
        property string color: "light grey"

        background: Rectangle {
            id: bg
            radius: mainWidg.radius * 0.6
            color: parent.pressed ? "grey" : parent.color
            Text {
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 14
                text: btn.text
            }
        }
    }

    component LevelIndicator: Rectangle {
        color: "grey"
        radius: mainWidg.radius * 0.6
    }

    component StationControl: Item {
        id: stationControl
        signal expand
        signal collapse
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            LevelIndicator {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: parent.height - 42
            }

            RowLayout {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                CButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "light green"
                    text: qsTr("Start")
                }
                CButton {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.2
                }
                CButton {
                    property bool expand: false
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.2
                    icon.name: "cut-edi"
                    onClicked: {
                        expand = !expand
                        expand ? stationControl.expand(
                                     ) : stationControl.collapse()
                    }
                }
            }
        }
    }

    Rectangle {
        id: mainWidg
        width: parent.width * 0.8
        height: parent.height * 0.8
        radius: width * 0.02
        anchors.centerIn: parent
        border.width: 2
        border.color: "grey"
        clip: true
        RowLayout {
            anchors.fill: parent
            spacing: 5
            Repeater {
                model: 4
                delegate: StationControl {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onExpand: Layout.minimumWidth = parent.width * 0.6
                    onCollapse: Layout.minimumWidth = 0
                    Behavior on Layout.minimumWidth {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.InOutSine
                        }
                    }
                }
            }
        }
    }

    MultiEffect {
        source: mainWidg
        shadowEnabled: true
    }
}
