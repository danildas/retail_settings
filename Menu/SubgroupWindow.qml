import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id: idRoot
    width: 600
    height: 400
    onActiveFocusChanged: _subGroupMaster.refresh1();

    Rectangle{
        id:idRectangle1
        width: idRoot.width/2
        height: idRoot.height
        anchors {
            left: idRoot.left
            top: idRoot.top
            bottom: idRoot.bottom
            margins: 10
        }

        Text {
                 id: idtxtGname
                 width: idRectangle1.width/2
                 height: idRectangle1.height/15
                 text: qsTr("Group Name")
                 font.family: "Courier"
                 font.pixelSize: 15
                 anchors{
                     top:idRectangle1.top
                     left: idRectangle1.left
                     topMargin: 10
                     leftMargin: 10
                      }
             }

             ComboBox {
                 id:idComboBoxListModel
                 width: idRectangle1.width/2
                 height: idRectangle1.height/15
                 model:  _groupMaster
                 textRole: "Name"
                 onActivated: console.log(_subGroupMaster.groupCode=(model.data(model.index(idComboBoxListModel.currentIndex,0),model.Code)))
                 onCurrentTextChanged: {

                     //_subGroupMaster.groupCode=(model.data(model.index(idComboBoxListModel.currentIndex,0),model.Code))

                     _subGroupMaster.refresh1();
                 }
                 anchors{
                      top: idRectangle1.top
                      left: idtxtGname.right
                      right: idRectangle1.right
                      topMargin: 10
                      rightMargin: 5
                      }
             }

             Text {
                 id: idtxtCode
                 width: idRectangle1.width/2
                 height: idRectangle1.height/15
                 text: qsTr("Sub-Group Code")
                 font.family: "Courier"
                 font.pixelSize: 15
                 anchors{
                      top: idtxtGname.bottom
                      left: idRectangle1.left
                      leftMargin: 10
                      topMargin: 10
                       }
             }

             TextField{
                 id: idTxtFieldCode
                 width: idRectangle1.width/2
                 height: idRectangle1.height/15
                 font.family: "Courier"
                 placeholderText: "Sub-Group Code"
                 readOnly: true
                 anchors{
                       top: idComboBoxListModel.bottom
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
                    text: qsTr("Sub-Group Name")
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
                    placeholderText: "Sub-Group Name"
                    readOnly: true
                    anchors{
                        top: idTxtFieldCode.bottom
                        left: idtxtName.right
                        right: idRectangle1.right
                        topMargin: 10
                        rightMargin: 5
                    }
                }

/*                Button {
                    id: idClearButton
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
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
                        idTxtFieldCode.text=""
                        idTxtFieldName.text=""
                        idSaveButton.visible=true
                        idUpdateButton.visible=false
                    }
                }

                Button {
                    id: idSaveButton
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text:"Save"
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
                        if(idTxtFieldCode.text!="" && idTxtFieldName.text!="") {
                        console.log("Save")
                        console.log(_subGroupMaster.saveSubgroup(idTxtFieldCode.text, idTxtFieldName.text));
                        idTxtFieldCode.text=""
                        idTxtFieldName.text=""
                        }
                        else {
                           console.log("Text field empty")
                        }
                    }
                }

                Button {
                    id:idUpdateButton
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text: "Update"
                    visible: false
                    anchors{
                        top: idTxtFieldName.bottom
                        left: idClearButton.right
                        right: idRectangle1.right
                        rightMargin: 2
                        leftMargin: 5
                        topMargin: 5
                    }
                    onClicked: {
                        console.log("Update")

                        console.log(_subGroupMaster.updateSubgroup(idTxtFieldCode.text,idTxtFieldName.text));
                        idSaveButton.visible=true
                        idUpdateButton.visible=false
                        idTxtFieldCode.text=""
                        idTxtFieldName.text=""
                    }
                }
    */
    }

    Rectangle {
        id: idRectangle2
        width: idRoot.width/2
        height: idRoot.height/1.5
        color: "#97b8ed"
        anchors.left: idRectangle1.right
        anchors.right: idRoot.right
        anchors.top: idRoot.top
        anchors.margins: 10

        ListView {
            id: idlistView1
            width: idRectangle2.width
            height: idRectangle2.height
            model: _subGroupMaster
            delegate: subgroupDelegate
            snapMode: ListView.SnapToItem
            headerPositioning: ListView.OverlayHeader
            highlight: Rectangle { color: "white"; radius: 5 }
            focus: true
            clip: true
            ScrollBar.vertical: ScrollBar { active: true }
            header: Rectangle {
                id: idHeaderRectangle
                width: idlistView1.width
                height: idlistView1.height/10
                z:2
                color: "#719add"

                Text {
                    id: idHeadTxt
                    text: "Code"
                    color: "white"
                    font.family: "Courier"
                    font.pointSize: 15
                    anchors.left: idHeaderRectangle.left
                    anchors.leftMargin: idRectangle2.width / 6
                    anchors.top: idHeaderRectangle.top
                    anchors.topMargin: idHeaderRectangle.height / 5
                }
                Text {
                    id: name
                    text: " Name"
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
            onCurrentIndexChanged: console.log(_subGroupMaster.groupCodeDel = model.data(model.index(idlistView1.currentIndex,0),257))
        }

        Component {
            id: subgroupDelegate
            Rectangle {
                id: wrapper
                width: idRectangle2.width
                height: idRectangle2.height / 15
                color: "white"
                opacity: 0.5
                Text {
                    id:idTxt
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
        height: 100
        anchors.top:idRectangle2.bottom
        anchors.left: idRectangle1.right
        anchors.bottom: idRoot.bottom
        anchors.right: idRoot.right
        anchors.margins: 10

            POS_FunctionButton {
                id: idRefreshButton
                width: idRectangle1.width/4
                height: idRectangle1.height/15
                anchors.top:idRectangle3.top
                anchors.right: idDeleteButton.left
                anchors.rightMargin: 10
                anchors.topMargin: idRectangle3.height / 5
                text: "New"
                onClicked: {
                        _subGroupMaster.refresh1();
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
                    idTxtFieldCode.text =  _subGroupMaster.data(_subGroupMaster.index(idlistView1.currentIndex,0),257)
                    idTxtFieldName.text =  _subGroupMaster.data(_subGroupMaster.index(idlistView1.currentIndex,0),258)
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
                    if(idTxtFieldCode.text!="" && idTxtFieldName.text!="") {
                    console.log("Save")
                    console.log(_subGroupMaster.saveSubgroup(idTxtFieldCode.text, idTxtFieldName.text));
                    _subGroupMaster.refresh1()
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
                id: idUpdateButton
                width: idRectangle1.width / 4
                height: idRectangle1.height / 15
                text: "Update"
                visible: false
                anchors{
                    top: idEditButton.bottom
                    right: idRectangle3.right
                    rightMargin:  idRectangle3.width / 20
                    topMargin: 10
                }
                onClicked: {
                    console.log("Update")

                    console.log(_subGroupMaster.updateSubgroup(idTxtFieldCode.text,idTxtFieldName.text));
                    _subGroupMaster.refresh1()
                    idTxtFieldCode.readOnly = true
                    idTxtFieldName.readOnly = true
                    idSaveButton.visible = true
                    idUpdateButton.visible = false
                    idTxtFieldCode.text = ""
                    idTxtFieldName.text = ""
                }
            }
    }

    Rectangle {
        id: idMessageBox
        width: idRoot.width/1.5
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
            text: qsTr("If you want to delete the 'Sub-Group',The entire data will delete under the Sub-Group")
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
                _subGroupMaster.deleteSubGroup();
                _subGroupMaster.refresh1();
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
