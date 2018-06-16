import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id:idRoot
    width: 600
    height: 400

    Rectangle {
        id: idMessageBox
        width: idRoot.width/1.6
        height: idRoot.height/3
        border.color: "black"
        border.width: 2
        anchors.top:idRoot.top
        anchors.bottom: idRoot.bottom
        anchors.centerIn: idRoot
        //anchors.left: idRectangle1.left
        //anchors.right: idRectangle2.right

        Text {
            id: idName
            text: qsTr("If you want to delete the Database,The entire data will deleted...")
            anchors.left: idMessageBox.left
            anchors.right: idMessageBox.right
            anchors.top: idMessageBox.top
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 20
            }
        Button {
            id: idYesButton
            width: idRoot.width/6
            height: idRoot.height/15
            anchors.top: idName.top
            anchors.left: idMessageBox.left
            anchors.leftMargin: idRoot.width/8
            anchors.topMargin: 50
            text: "Yes"
            onClicked: {
                console.log("yes clicked")
                _groupMaster.clearDB();
                idMessageBox.visible=false;

        }

        }
        Button {
            id: idNoButton
            width: idRoot.width/6
            height: idRoot.height/15
            anchors.top: idName.top
            anchors.left: idYesButton.right
            anchors.leftMargin: 10
            anchors.topMargin: 50
            text: "No"
            onClicked: {
                console.log("no clicked")
                idMessageBox.visible=false
        }
        }
    }
}
