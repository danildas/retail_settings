import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Window {
    id:idRoot
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    FontLoader {
        id: idFontThin
        source: "qrc:/fonts/aileron/Aileron-Thin.otf"
    }

    Item {
        id: idItem
        width: idRoot.width
        height: idRoot.height
        state: "view"

        TitleBar{
            id: idTitleBar
            width: idItem.width
            height: idItem.height / 10

           /* POS_FunctionButton {
                text: "Prev"
                anchors.right: idnext.left
                anchors.rightMargin: 10
            }

            POS_FunctionButton {
                id: idnext
                text: "Next"
                anchors.right: idTitleBar.right
                anchors.rightMargin: 10
            }*/
        }

        StatusBar {
            id:idStatusBar
            width: idItem.width
            height: idItem.height/100
            anchors {
                bottom: idItem.bottom
            }
        }

        GroupWindow {
            id:idGroupWindow
            width: idRoot.width
            height: idRoot.width
            anchors.top:idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            visible: false
        }

        SubgroupWindow {
            id: idSubgroupWindow
            width: idRoot.width
            height: idRoot.width
            anchors.top:idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            visible: false
        }

        ItemWindow {
            id: idItemWindow
            width: idRoot.width
            height: idRoot.width
            anchors.top:idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            visible: false

        }

        MessageBox {
            id: idMessageBox
            width: idRoot.width
            height: idRoot.width
            anchors.top:idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            visible: false
        }

        CashWindow {
            id: idCashWindow
            width: idRoot.width
            height: idRoot.width
            anchors.top:idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            visible: false
            onBackClicked: {
                idItem.state = "view"
            }
        }

        states: [
            State { name: "groupWindow"
                PropertyChanges { target: idGroupWindow; visible : true }
            },
            State { name: "subGroupWindow";
                PropertyChanges { target: idSubgroupWindow; visible : true }
            },

            State { name: "itemWindow"
                PropertyChanges { target: idItemWindow; visible: true }
            },
            State { name: "messageBox"
                PropertyChanges { target: idMessageBox; visible: true }
            },
            State { name: "cashWindow"
                PropertyChanges { target: idCashWindow; visible: true }
                PropertyChanges { target: button1; visible:false }
                PropertyChanges { target: idtext; visible:false }
                PropertyChanges { target: idbutton; visible:false }
                //PropertyChanges { target: idbutton2; visible:false }
                PropertyChanges { target: idTxtCash; visible:false }
                PropertyChanges { target: idButtonCash; visible:false }
            }
        ]

        transitions: [
            Transition {
                from: "view"
                to: "groupWindow"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idItem; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idGroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            },
            Transition {
                from: "groupWindow"
                to: "view"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idGroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idItem; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            },
            Transition {
                from: "groupWindow"
                to: "subGroupWindow"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idGroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idSubgroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            },
            Transition {
                from: "subGroupWindow"
                to: "groupWindow"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idSubgroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idGroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            },
            Transition {
                from: "subGroupWindow"
                to: "itemWindow"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idSubgroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idItemWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            },
            Transition {
                from: "itemWindow"
                to: "subGroupWindow"

                ParallelAnimation {
                   /* NumberAnimation {
                        target: idItem; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }*/

                    NumberAnimation {
                        target: idSubgroupWindow; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }
                }
            }
        ]


        Button{ id:idbutton; x: 154; y: 387;width: 72; height: 28; text: "Next"
        enabled: true
        onClicked: {
            console.log("Next Clicked")
                 button1.visible=false
                 idtext.visible=false
                 idTxtCash.visible=false
                 idButtonCash.visible=false

                if (idItem.state == "view")
                    idItem.state = "groupWindow"
                else if(idItem.state == "groupWindow")
                    idItem.state = "subGroupWindow"
                else if(idItem.state == "subGroupWindow")
                    idItem.state = "itemWindow"
                }
    }

       /* Image {
            id: idbutton
            x: 154; y: 387
            source: "file:///C:/Users/Danil/Pictures/next.png"
            width: 35
            height: 35
            MouseArea {
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                onClicked:  {
                    console.log("Next Clicked")
                    button1.visible=false
                    idtext.visible=false
                    idTxtCash.visible=false
                    idButtonCash.visible=false

                    if (idItem.state == "view")
                        idItem.state = "groupWindow"
                    else if(idItem.state == "groupWindow")
                        idItem.state = "subGroupWindow"
                    else if(idItem.state == "subGroupWindow")
                        idItem.state = "itemWindow"
                }
            }
        }*/

       Button{ x: 66; y: 387; width: 72; height: 28; text: "Prev"
        onClicked: {
                console.log("Prev Clicked")
                if (idItem.state == "groupWindow")
                {
                    idItem.state = "view"
                    button1.visible=true
                    idtext.visible=true
                    idTxtCash.visible=true
                    idButtonCash.visible=true
                }
                else if(idItem.state == "subGroupWindow")
                    idItem.state = "groupWindow"
                else if(idItem.state == "itemWindow")
                    idItem.state = "subGroupWindow"
                }
    }

       /* Image {
            id: idbutton2
            x: 66; y: 387
            source: "file:///C:/Users/Danil/Pictures/prev.png"
            width: 35
            height: 35
            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    console.log("Prev Clicked")
                    if (idItem.state == "groupWindow")
                    {
                        idItem.state = "view"
                        button1.visible=true
                        idtext.visible=true
                        idTxtCash.visible=true
                        idButtonCash.visible=true
                    }
                    else if(idItem.state == "subGroupWindow")
                        idItem.state = "groupWindow"
                    else if(idItem.state == "itemWindow")
                        idItem.state = "subGroupWindow"
                }
            }
        }*/

        Text {
            id: idtext
            x: 380
            y: 345
            text: qsTr("Clear Your Database")
        }

        Image {
            id: button1
            x: 486
            y: 338
            width: 40
            height: 35
            source: "file:///C:/Users/Danil/Pictures/ok.png"
            //text: qsTr("OK")
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Ok Clicked")
                    if (idItem.state == "view")
                        idItem.state = "messageBox"
                }
            }
        }

        Text {
            id: idTxtCash
            x: 380
            y: 402
            width: 100
            height: 42
            text: qsTr("Add Currency Unit")
        }

        Button {
            id: idButtonCash
            x: 486
            y: 387
            width: 40
            height: 35
            text: "Click"
            onClicked: {
                console.log("Click clicked")
                if(idItem.state == "view")
                    idItem.state ="cashWindow"
            }
        }
    }
}
