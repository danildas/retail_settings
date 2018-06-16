import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    id:idRoot
    width: 600
    height: 400

    Rectangle {
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
                    id:idComboBoxListModel1
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    model: _groupMaster
                    textRole: "Name"
                    onActivated:  console.log(_subGroupMaster.groupCode=model.data(model.index(idComboBoxListModel1.currentIndex,0),model.Code)),
                    console.log("groupcode", _itemMaster.groupCode=(model.data(model.index(idComboBoxListModel1.currentIndex,0),257)))
                    anchors{
                         top: idRectangle1.top
                         left: idtxtGname.right
                         right: idRectangle1.right
                         topMargin: 10
                         rightMargin: 5
                         }
                }

                Text {
                    id: idtxtSGname
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text: qsTr("Sub-Group Name")
                    font.family: "Courier"
                    font.pixelSize: 15
                    anchors{
                        top:idtxtGname.bottom
                        left: idRectangle1.left
                        topMargin: 10
                        leftMargin: 10
                         }
                }
                 ComboBox {
                      id:idComboBoxListModelSub1
                      width: idRectangle1.width/2
                      height: idRectangle1.height/15
                      model: _subGroupMaster
                      textRole: "Name"
                      onActivated: {
                          console.log("Subgroupcode", _itemMaster.subGroupCode=(model.data(model.index(idComboBoxListModelSub1.currentIndex,0),257)))
                      }
                      anchors{
                           top: idComboBoxListModel1.bottom
                           left: idtxtSGname.right
                           right: idRectangle1.right
                           topMargin: 10
                           rightMargin: 5
                           }
                  }

                Text {
                    id: idtxtItemCode
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text: qsTr("Item Code")
                    font.family: "Courier"
                    font.pixelSize: 15
                    anchors{
                        top:idtxtSGname.bottom
                        left: idRectangle1.left
                        topMargin: 10
                        leftMargin: 10
                    }
                }
                TextField{
                    id:idTxtFieldItemCode
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    font.family: "Courier"
                    placeholderText: "Item Code"
                    readOnly: true
                    anchors{
                         top: idComboBoxListModelSub1.bottom
                         left: idtxtItemCode.right
                         right: idRectangle1.right
                         topMargin: 10
                         rightMargin: 5
                         }
                }

                Text {
                    id: idtxtItemName
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text: qsTr("Item Name")
                    font.family: "Courier"
                    font.pixelSize: 15
                    anchors{
                        top:idtxtItemCode.bottom
                        left: idRectangle1.left
                        topMargin: 10
                        leftMargin: 10
                    }
                }
                TextField{
                    id: idTxtFieldItemName
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    font.family: "Courier"
                    placeholderText: "Item Name"
                    readOnly: true
                    anchors{
                         top: idTxtFieldItemCode.bottom
                         left: idtxtItemName.right
                         right: idRectangle1.right
                         topMargin: 10
                         rightMargin: 5
                         }
                }

                Text {
                    id: idtxtItemPrice
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    text: qsTr("Item Price")
                    font.family: "Courier"
                    font.pixelSize: 15
                    anchors{
                        top:idtxtItemName.bottom
                        left: idRectangle1.left
                        topMargin: 10
                        leftMargin: 10
                    }
                }
                TextField{
                    id: idTxtFieldItemPrice
                    width: idRectangle1.width/2
                    height: idRectangle1.height/15
                    font.family: "Courier"
                    placeholderText: "Item Price"
                    readOnly: true
                    anchors{
                         top: idTxtFieldItemName.bottom
                         left: idtxtItemPrice.right
                         right: idRectangle1.right
                         topMargin: 10
                         rightMargin: 5
                         }
                }
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
            model: _itemMaster
            delegate: itemDelegate
            snapMode: ListView.SnapToItem
            headerPositioning: ListView.OverlayHeader
            highlight: Rectangle { color: "white" ; radius: 5 }
            focus: true
            clip: true

            ScrollBar.vertical: ScrollBar { active: true }

            header: Rectangle {
                id: idHeaderRectangle
                width: idlistView1.width
                height: idlistView1.height/10
                z: 2
                color: "#719add"
                Text {
                    id: idHeadTxt
                    text: "Item Code"
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
                    text: "Item Name"
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
            onCurrentIndexChanged: { console.log(_itemMaster.itemCodeDel =model.data(model.index(idlistView1.currentIndex,0),257))
            _itemMaster.getItem(model.data(model.index(idlistView1.currentIndex,0),257))
            }
        }

        Component {
            id: itemDelegate
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
                    _itemMaster.refresh2();
                    idUpdateButton.visible = false
                    idSaveButton.visible = true
                    idTxtFieldItemCode.text = ""
                    idTxtFieldItemName.text = ""
                    idTxtFieldItemPrice.text = ""
                    idTxtFieldItemCode.readOnly = false
                    idTxtFieldItemName.readOnly = false
                    idTxtFieldItemPrice.readOnly = false
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
                onClicked: idMessageBox.visible=true
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

                    idTxtFieldItemName.readOnly = false
                    idTxtFieldItemPrice.readOnly = false

                    idTxtFieldItemCode.text =  _itemMaster.data(_itemMaster.index(idlistView1.currentIndex,0),257)
                    idTxtFieldItemName.text =  _itemMaster.data(_itemMaster.index(idlistView1.currentIndex,0),258)
                    idTxtFieldItemPrice.text = _itemMaster.itemPrice
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
                    if(idTxtFieldItemCode.text!="" && idTxtFieldItemName.text!="") {
                    console.log("Save")
                    console.log(_itemMaster.saveItem(idTxtFieldItemCode.text,idTxtFieldItemName.text,idTxtFieldItemPrice.text));

                   /* if (idComboBoxDetails.currentText == "Yes")
                    {
                       console.log(_itemMaster.saveItemImage(idImageDialog.fileUrls,idTxtFieldItemCode.text));
                       console.log(_itemMaster.saveItemUnits(idTxtFieldItemCode.text,idTxtFieldItemUnitCode.text,idTxtFieldItemUnits.text,idTxtFieldItemPrice.text));
                    }
                    else
                    {
                        console.log(_itemMaster.saveItemUnits(idTxtFieldItemCode.text,idTxtFieldItemPrice.text));
                    }*/
                    _itemMaster.refresh2()

                    idTxtFieldItemCode.readOnly = true
                    idTxtFieldItemName.readOnly = true
                    idTxtFieldItemPrice.readOnly = true

                    idTxtFieldItemCode.text = ""
                    idTxtFieldItemName.text = ""
                    idTxtFieldItemPrice.text = ""
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
                    idTxtFieldItemCode.text = ""
                    idTxtFieldItemName.text = ""
                    idTxtFieldItemPrice.text = ""
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
                anchors{
                    top: idEditButton.bottom
                    right: idRectangle3.right
                    rightMargin: idRectangle3.width / 20
                    topMargin: 10
                }
                onClicked: {
                    console.log("Update")

                    _itemMaster.updateItem(idTxtFieldItemCode.text,idTxtFieldItemName.text,idTxtFieldItemPrice.text)
                    _itemMaster.refresh2()
                    idTxtFieldItemCode.readOnly = true
                    idTxtFieldItemName.readOnly = true
                    idTxtFieldItemPrice.readOnly = true
                    idSaveButton.visible = true
                    idUpdateButton.visible = false
                    idTxtFieldItemCode.text = ""
                    idTxtFieldItemName.text = ""
                    idTxtFieldItemPrice.text = ""
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
            text: qsTr("If you want to delete the 'Item',The entire data will delete under the Item")
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
                _itemMaster.deleteItem();
                _itemMaster.refresh2();
                idMessageBox.visible=false;
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
