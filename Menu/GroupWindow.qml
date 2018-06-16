 import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick 2.7

Item {
    id: idRoot
    width: 600
    height: 400

    Rectangle{
        id:idRectangle1
        width: idRoot.width / 2
        height: idRoot.height
        anchors {
            left: idRoot.left
            top: idRoot.top
            bottom: idRoot.bottom
            margins: 10
        }

        Text {
            id: idtxtCode
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            text: qsTr("Group Code")
            font.family: "Courier"
            font.pixelSize: 15
            anchors{
                top:idRectangle1.top
                left: idRectangle1.left
                topMargin: 10
                leftMargin: 10
                 }
             }

        TextField{
            id: idTxtFieldCode
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            font.family: "Courier"
            placeholderText: "Group Code"
            readOnly: true
            anchors{
                 top: idRectangle1.top
                 left: idtxtCode.right
                 right: idRectangle1.right
                 topMargin: 10
                 rightMargin: 5
                 }
             }

        Text {
              id: idtxtName
              width: idRectangle1.width/2
              height: idRectangle1.height/15
              text: qsTr("Group Name")
              font.family: "Courier"
              font.pixelSize: 15
              anchors{
                   top: idtxtCode.bottom
                   left: idRectangle1.left
                   leftMargin: 10
                   topMargin: 10
                    }
                }

        TextField{
               id:idTxtFieldName
               width: idRectangle1.width/2
               height: idRectangle1.height/15
               font.family: "Courier"
               placeholderText: "Group Name"
               readOnly: true
               anchors{
                     top: idTxtFieldCode.bottom
                     left: idtxtName.right
                     right: idRectangle1.right
                     topMargin: 10
                     rightMargin: 5
                    }
                }

         /*   POS_FunctionButton {
                id:idClearButton
                width: idRectangle1.width / 2
                height: idRectangle1.height / 15
                text:"Clear"
                anchors{
                    top: idtxtName.bottom
                    left: idRectangle1.left
                    right: idSaveButton.left
                    leftMargin: 5
                    topMargin: 5
                    rightMargin: 5
                }
                onClicked: {
                        console.log("Clear")
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                    idSaveButton.visible = true
                    idUpdateButton.visible = false
                }
            }

            POS_FunctionButton {
                id:idSaveButton
                width: idRectangle1.width / 2
                height: idRectangle1.height / 15
                text: "Save"
                visible: true
                anchors{
                    top: idTxtFieldName.bottom
                    left: idClearButton.right
                    right: idRectangle1.right
                    rightMargin: 2
                    leftMargin: 5
                    topMargin: 5
                }
                onClicked: {
                    if(idTxtFieldCode.text != "" && idTxtFieldName.text != "") {
                    console.log("Save")
                    console.log(_groupMaster.save(idTxtFieldCode.text,idTxtFieldName.text ));
                        _groupMaster.refresh();
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                    }
                    else {
                        console.log("Text field empty")
                    }
                }
            }


            */
}

    Rectangle {
        id: idRectangle2
        width: idRoot.width / 2
        height: idRoot.height / 1.5
        color: "#97b8ed"
        anchors.left: idRectangle1.right
        anchors.right: idRoot.right
        anchors.top: idRoot.top
        anchors.margins: 10

        ListView {
            id: idlistView1
            width: idRectangle2.width
            height: idRectangle2.height
            model: _groupMaster
            delegate: groupDelegate
            snapMode: ListView.SnapToItem
            headerPositioning: ListView.OverlayHeader
            highlight: Rectangle { color: "white" ; radius: 5 }
            focus: true
            clip: true
            ScrollBar.vertical: ScrollBar { active: true }
            header: Rectangle {
                id: idHeaderRectangle
                width: idlistView1.width
                height: idlistView1.height / 10
                z:2
                color: "#719add"
                Text {
                    id: idHeadTxt
                    text: "Group Code"
                    color: "white"
                    font.family: "Courier"
                    font.pointSize: 15
                    anchors.left: idHeaderRectangle.left
                    anchors.leftMargin: idRectangle2.width / 10
                    anchors.top: idHeaderRectangle.top
                    anchors.topMargin: idHeaderRectangle.height / 5
                }
                Text {
                    id: name
                    text: "Group Name"
                    color: "white"
                    font.family: "Courier"
                    font.pointSize: 15
                    anchors.left: idHeaderRectangle.left
                    anchors.leftMargin: idHeaderRectangle.width / 2
                    anchors.top: idHeaderRectangle.top
                    anchors.topMargin: idHeaderRectangle.height / 5
                }
            }

            spacing: 3
            onCurrentIndexChanged: console.log(_groupMaster.groupCode= model.data(model.index(idlistView1.currentIndex,0),257))
        }

        Component {
            id: groupDelegate
            Rectangle {
                id: wrapper
                width: idRectangle2.width
                height: idRectangle2.height / 15
                color: "white"
                opacity: 0.5

                Text {
                    text: model.Code
                    anchors.left: wrapper.left
                    anchors.leftMargin: idRectangle2.width / 5
                    anchors.top: wrapper.top
                    anchors.topMargin: wrapper.height / 5
                }

                Text {
                    text: model.Name
                    anchors.left: wrapper.left
                    anchors.leftMargin: idRectangle2.width / 2
                    anchors.top: wrapper.top
                    anchors.topMargin: wrapper.height / 5
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: idlistView1.currentIndex = index
                   }
            }
        }
    }

    Rectangle {
        id: idRectangle3
        color: "#719add"
        width: idRectangle2.width
        height: idRectangle2.height / 2
        anchors.top:idRectangle2.bottom
        anchors.left: idRectangle1.right
        anchors.bottom: idRoot.bottom
        anchors.right: idRoot.right
        anchors.margins: 10

            POS_FunctionButton {
                id: idRefreshButton
                width: idRectangle1.width / 4
                height: idRectangle1.height / 15
                anchors.top: idRectangle3.top
                anchors.right: idDeleteButton.left
                anchors.rightMargin: 10
                anchors.topMargin: idRectangle3.height / 5
                text: "New"
                onClicked: {
                    _groupMaster.refresh();
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                    idTxtFieldCode.readOnly = false
                    idTxtFieldName.readOnly = false
                    idUpdateButton.visible = false
                    idSaveButton.visible = true
                }
            }

            POS_FunctionButton {
                id: idDeleteButton
                width: idRectangle1.width/4
                height: idRectangle1.height/15
                anchors.top: idRectangle3.top
                anchors.right: idEditButton.left
                anchors.rightMargin: 10
                anchors.topMargin: idRectangle3.height / 5
                text: "Delete"
                onClicked: idMessageBox.visible = true
            }

            POS_FunctionButton {
                id: idEditButton
                width: idRectangle1.width/4
                height: idRectangle1.height/15
                anchors.top: idRectangle3.top
                anchors.right: idRectangle3.right
                anchors.rightMargin: idRectangle3.width / 20
                anchors.topMargin: idRectangle3.height / 5
                text: "Edit"
                onClicked: {
                    console.log("edit clicked")
                    idSaveButton.visible = false
                    idUpdateButton.visible = true
                    idTxtFieldCode.readOnly = true
                    idTxtFieldName.readOnly = false
                    idTxtFieldCode.text =  _groupMaster.data(_groupMaster.index(idlistView1.currentIndex,0),257)
                    idTxtFieldName.text =  _groupMaster.data(_groupMaster.index(idlistView1.currentIndex,0),258)
                }
            }

            POS_FunctionButton {
                id: idSaveButton
                width: idRectangle1.width / 4
                height: idRectangle1.height / 15
                text: "Save"
                visible: true
                anchors.right: idRectangle3.right
                anchors.top: idEditButton.bottom
                anchors.rightMargin: idRectangle3.width / 20
                anchors.topMargin: 10
                onClicked: {
                    if(idTxtFieldCode.text != "" && idTxtFieldName.text != "") {
                    console.log("Save")
                    console.log(_groupMaster.save(idTxtFieldCode.text,idTxtFieldName.text ));
                        _groupMaster.refresh();
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                    idTxtFieldCode.readOnly = true
                    idTxtFieldName.readOnly = true
                    }
                    else {
                        console.log("Text field empty")
                    }
                }
            }

            POS_FunctionButton {
                id:idClearButton
                width: idRectangle1.width / 4
                height: idRectangle1.height / 15
                text:"Clear"
                anchors{
                    top: idDeleteButton.bottom
                    right: idSaveButton.left
                    topMargin: 10
                    rightMargin: 10
                }
                onClicked: {
                    console.log("Clear")
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                    idSaveButton.visible = true
                    idUpdateButton.visible = false
                }
            }

            POS_FunctionButton {
                id:idUpdateButton
                width: idRectangle1.width / 4
                height: idRectangle1.height / 15
                text: "Update"
                visible: false
                anchors.right: idRectangle3.right
                anchors.top: idEditButton.bottom
                anchors.rightMargin: idRectangle3.width / 20
                anchors.topMargin: 10
                onClicked: {
                    console.log("Update")

                    console.log(_groupMaster.updateGroup(idTxtFieldCode.text,idTxtFieldName.text));
                    _groupMaster.refresh();
                    idSaveButton.visible = true
                    idUpdateButton.visible = false
                    idTxtFieldCode.readOnly = true
                    idTxtFieldName.readOnly = true
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                }
            }
    }

    Rectangle {
        id: idMessageBox
        width: idRoot.width/1.6
        height: idRoot.height/3
        visible: false
        z:1
        border.color: "black"
        border.width: 2
        anchors.top:idRoot.top
        anchors.bottom: idRoot.bottom
        anchors.centerIn: idRoot
        anchors.left: idRectangle1.left
        anchors.right: idRectangle2.right

        Text {
            id: idName
            text: qsTr("If you want to delete the 'Group',The entire data will delete under the Group")
            anchors.left: idMessageBox.left
            anchors.right: idMessageBox.right
            anchors.top: idMessageBox.top
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 20
            }
        POS_FunctionButton {
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
                _groupMaster.deleteGroup();
                _groupMaster.refresh();
                idMessageBox.visible=false;
                idTxtFieldCode.readOnly = true
                idTxtFieldName.readOnly = true
        }
        }
        POS_FunctionButton {
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
