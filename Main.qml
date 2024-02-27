import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import libgui

Window {
    visible: true
    visibility: "FullScreen"
    width: 600
    height: 450
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
            text: qsTr("Beverage Dispenser Interface | Zadock")
        }
    }

    AbstractButton {
        id: powerBtn
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        width: parent.width * 0.05
        height: width
        background: Rectangle {
            anchors.fill: parent
            radius: width * 0.5
            border.width: 2
            border.color: "grey"
            color: parent.pressed ? "grey" : "white"
            Image {
                id: powerIcon
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dev.naisys.net/libgui/icons/power_icon.png"
            }
            MultiEffect {
                source: powerIcon
                anchors.fill: powerIcon
                colorization: 1
                colorizationColor: "grey"
            }
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
        property string station_name
        signal expand
        signal collapse
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            anchors.topMargin: 15
            anchors.bottomMargin: 15

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: parent.height - 42
                Layout.minimumWidth: parent.width * 0.4
                LevelIndicator {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Layout.maximumWidth: configBtn.expand ? parent.width * 0.3 : parent.width
                }
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    visible: configBtn.expand
                    NaiSysInputForm {
                        anchors.fill: parent
                        anchors.leftMargin: 5
                        anchors.rightMargin: 5
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        form_title_text: stationControl.station_name
                    }
                }
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
                    id: configBtn
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
                    station_name: "Station " + (index + 1)
                    //visible: width > 40
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
}
