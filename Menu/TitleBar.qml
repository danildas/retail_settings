import QtQuick 2.0

Item {
    id: idRoot
    width: 500
    height: 200

    Image {
        id: idBackground
        anchors.fill: parent
        source: "file:///F:/WorkSpace/Qt/work/3-2-18/Menu/Menu/titleImage/titlebar_background.png"
        fillMode: Image.TileHorizontally
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#35507c" } //47494c
            GradientStop { position: 1.0; color: "#97b8ed" } //c7c9cc
        }
    }
}
