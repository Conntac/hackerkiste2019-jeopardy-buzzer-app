import QtQuick 2.13
import QtQuick.Shapes 1.13

Shape {
    id: shape

    property alias strokeWidth: p.strokeWidth
    property alias strokeColor: p.strokeColor
    property color fillColor: "#D24750"

    layer.enabled: true
    layer.samples: 4
    
    ShapePath {
        id: p
        strokeWidth: 0
        strokeColor: "transparent"
        strokeStyle: ShapePath.SolidLine
        fillColor: shape.fillColor
        
        property real xr: shape.width / 2 * 0.7
        property real yr: shape.height / 2 * 0.7
        startX: shape.width / 2 - xr
        startY: shape.height / 2 - yr
        PathArc {
            x: shape.width / 2 + p.xr
            y: shape.height / 2 + p.yr
            radiusX: p.xr; radiusY: p.yr
            useLargeArc: true
        }
        PathArc {
            x: shape.width / 2 - p.xr
            y: shape.height / 2 - p.yr
            radiusX: p.xr; radiusY: p.yr
            useLargeArc: true
        }
    }
}
