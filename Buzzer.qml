import QtQuick 2.13
import QtQuick.Shapes 1.13

MouseArea {
    id: root

    property alias color: topSide.fillColor
    property alias text: buttonText.text

    property bool down: false

    width: 280
    height: 261

    EllipseShape {
        id: ground
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 25
        width: parent.width + 5
        height: parent.height + 5
        fillColor: "#000000"
        strokeColor: "#707070"
        strokeWidth: 5
    }

    EllipseShape {
        id: bottomSide
        y: 20
        width: root.width
        height: root.height
        fillColor: Qt.darker(topSide.fillColor, 1.5)
    }

    EllipseShape {
        id: topSide
        width: root.width
        height: root.height
        fillColor: "#D24750"

        GameLabel {
            id: buttonText
            anchors.centerIn: parent
            font.capitalization: Font.AllUppercase
            font.pointSize: 24
        }
    }

    states: State {
        name: "pressed"
        when: root.down

        PropertyChanges {
            target: topSide
            y: 18
        }
    }

    transitions: Transition {
        NumberAnimation {
            target: topSide
            properties: "y"
            duration: 50
        }
    }
}
