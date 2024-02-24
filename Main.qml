import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Beverage Dispenser Interface")

    component CButton: AbstractButton {
        property string color: "light grey"

        background: Rectangle {
            id: bg
            radius: mainWidg.radius * 0.6
            color: parent.pressed ? "light grey" : parent.color
        }
    }

    component LevelIndicator: Rectangle {
        color: "grey"
        radius: mainWidg.radius * 0.6
    }

    component StationControl: Item {
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
                }
                CButton {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.2
                }
                CButton {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.2
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
        RowLayout {
            anchors.fill: parent
            spacing: 5
            Repeater {
                model: 4
                delegate: StationControl {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
    }

    MultiEffect {
        source: mainWidg
        shadowEnabled: true
    }
}
