import QtQuick 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    id: root

    signal startGame(string name)

    property alias startButton: startButton

    ColumnLayout {
        id: colLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        GameLabel {
            Layout.fillWidth: true
            text: "Gib deinen Namen ein:"
        }

        Rectangle {
            Layout.fillWidth: true
            height: 78
            color: "#FFFFFF"
            clip: true
            radius: 5

            TextInput {
                id: nameInput
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 28
                font.pointSize: 33
                font.capitalization: Font.AllUppercase
                color: "#656565"
                onAccepted: root.startGame(text)
            }
        }

        Button {
            id: startButton
            Layout.fillWidth: true
            text: "Am Spiel teilnehmen"
            onClicked: root.startGame(nameInput.text)
        }
    }
}
