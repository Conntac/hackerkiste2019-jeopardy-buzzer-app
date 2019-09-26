import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import net.conntac.jeopardy 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 375
    height: 812
    title: qsTr("Conntac Buzzer")

    Rectangle {
        anchors.fill: parent
        color: "white"

        // Background
        Rectangle {
            anchors.fill: parent
            color: "#64B4D4"
            opacity: 0.67

            Image {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                source: "images/background-tiles.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        // Footer
        ColumnLayout {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            GameLabel {
                Layout.fillWidth: true
                text: "Hackerkiste 2019"
                font.pointSize: 14
            }

            GameLabel {
                Layout.fillWidth: true
                text: "Jeopardy!"
                font.pointSize: 40
            }

            Image {
                Layout.fillWidth: true
                Layout.topMargin: 25
                fillMode: Image.PreserveAspectFit
                source: "images/conntac-logo.png"
            }
        }

        BuzzerEngine {
            id: buzzerEngine

            onStateChanged: {
                switch(state) {
                case BuzzerEngine.Unavailable:
                    break;
                case BuzzerEngine.Registered:
                    var properties = {
                        "name": buzzerEngine.name
                    }

                    stackView.replace(Qt.resolvedUrl("BuzzerPage.qml"), properties);
                    break;
                }
            }
        }

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: NamePage {
                onStartGame: {
                    buzzerEngine.name = name;
                    buzzerEngine.connect(Qt.resolvedUrl("ws://localhost:31337/jeopardy"))
                }
            }
        }
    }
}
