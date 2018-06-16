import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    id:idRoot
    width: 600
    height: 400

    signal backClicked()

    Rectangle{
        id: idRectangle1
        width: idRoot.width/1.5
        height: idRoot.height

        Text {
            id: idtxtCode
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            text: qsTr("Smallest Currency Unit")
            font.family: "Courier"
            font.pixelSize: 15
            anchors{
                top:idRectangle1.top
                left: idRectangle1.left
                topMargin: 8
                leftMargin: 5
                 }
             }

        TextField{
            id: idTxtFieldCashUnit
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            font.family: "Courier"
            //placeholderText: "Currency Unit"
            text: _groupMaster.currencyCost;
            anchors{
                 top: idRectangle1.top
                 left: idtxtCode.right
                 right: idRectangle1.right
                 topMargin: 8
                 leftMargin: 5
                 rightMargin: 2
                 }
             }

        Button {
            id: idButtonSave
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            text: "Save"
            anchors {
                top: idtxtCode.bottom
                left: idRectangle1.left
                leftMargin: 5
                topMargin: 30
            }
            onClicked: {
                if(idTxtFieldCashUnit.text =="" ) {
                    console.log("Text field empty")
                }
                else if(idTxtFieldCashUnit.text == '0') {
                    console.log("Text field value is zero")
                }
                else {
                    console.log("Save")
                    console.log(_groupMaster.saveCurrencyUnit(idTxtFieldCashUnit.text))
                }
            }

        }

        Button {
            id: idButtonBack
            width: idRectangle1.width/2
            height: idRectangle1.height/15
            text: "Back"
            anchors {
                top: idTxtFieldCashUnit.bottom
                left: idButtonSave.right
                leftMargin: 5
                topMargin: 30
            }
            onClicked: idRoot.backClicked()
        }
    }
}
