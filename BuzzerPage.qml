import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    id: root

    property string name: "Dein Name"

    function buzz() {
        buzzerEngine.buzz();

        buzzer.down = true;

        state = "too_slow";
    }

    ColumnLayout {
        id: colLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        spacing: 5

        GameLabel {
            Layout.fillWidth: true
            Layout.topMargin: 47
            text: "Angemeldet als:"
        }

        GameLabel {
            Layout.fillWidth: true
            Layout.topMargin: 17
            font.pointSize: 24
            font.capitalization: Font.AllUppercase
            text: root.name
        }
    }

    Buzzer {
        id: buzzer

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: 47
        }

        height: width / 1.0727969349
        onClicked: root.buzz()
    }

    states: [
        State {
            name: "too_slow"

            PropertyChanges {
                target: buzzer
                text: "Zu langsam!"
                color: "#A0A0A0"
            }
        },

        State {
            name: "first"

            PropertyChanges {
                target: buzzer
                text: "Erster!"
                color: "#86BB00"
            }
        }
    ]
}
