import QtQuick 2.7

Rectangle {
    id: circle
    property int r
    width: 2 * r; height: 2 * r
    radius: r
    color: "red"
    border.color: "black"
    border.width: 1
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log(r, circle.x, circle.y)
        }
    }
}
