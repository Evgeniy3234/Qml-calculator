import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Window {
    id: root

    width: 1000
    height: 1000
    visible: true
    title: qsTr("Hello World")

    signal clicked ()

    property string valueTemp: "" // промежуточное невидемое значение
    property string valueString: "" // значение числа видимое пользователю


    function addNumber(value){ // добавляем число
        if (valueString.length > 9) return

        if(value !== "=" && value !== "Del" && value !== "C"){
            valueString += value
            valueTemp += value
        }

        if(value === "="){
            valueString = eval(valueTemp)
            valueTemp = valueString
        }
        if(value === "Del"){
            valueString = ""
            valueTemp = ""
        }
        if(value === "C"){
           valueString = valueString.slice(0,-1)
           valueTemp = valueTemp.slice(0,-1)
        }
        console.log("Видемое значение", valueString)
        console.log("Невидемое значение", valueTemp)
    }

   ColumnLayout{
       id: columnLayout

       spacing: 10
       anchors.fill: parent

       Rectangle{
           id: display

           Layout.fillWidth: true
           Layout.minimumHeight: 150
           color: "black"

           Text{
             id: displayText

             font.pixelSize: 100
             color: "white"
             text: root.valueString
           }
       }


       GridLayout {
         id: gridLayout

         columns: 4
         rows: 4
         rowSpacing: 10
         columnSpacing: 10
         Layout.fillHeight: true
         Layout.fillWidth: true

             Repeater{
                 id: operations

                 model:[
                     {color:"orange", value:"+", type: 'operation'},
                     {color:"orange", value:"-", type: 'operation'},
                     {color:"orange", value:"*", type: 'operation'},
                     {color:"orange", value:"/", type: 'operation'},
                     {color:"red", value:"Del", type: 'cancel'},
                     {color:"red", value:"C", type: 'cancel'},
                     {color:"grey", value:"(", type: 'operation'},
                     {color:"grey", value:")", type: 'operation'},
                     {color:"grey", value:"9", type: 'number'},
                     {color:"grey", value:"8", type: 'number'},
                     {color:"grey", value:"7", type: 'number'},
                     {color:"grey", value:"0", type: 'number'},
                     {color:"grey", value:"6", type: 'number'},
                     {color:"grey", value:"5", type: 'number'},
                     {color:"grey", value:"4", type: 'number'},
                     {color:"grey", value:".", type: 'symbol'},
                     {color:"grey", value:"3", type: 'number'},
                     {color:"grey", value:"2", type: 'number'},
                     {color:"grey", value:"1", type: 'number'},
                     {color:"grey", value:"=", type: 'calculation'},

                 ]

                 Rectangle{
                     id: button

                     color: modelData.color
                     opacity: tapHandler.pressed ? 0.5 : 1
                     Layout.fillHeight: true
                     Layout.fillWidth: true

                     TapHandler {
                            id: tapHandler

                            onTapped: {

                                if (modelData.type === 'number' || 'symbol' || 'operation') {
                                    root.addNumber(modelData.value)
                                }
                            }
                     }

                     Text {
                         text: modelData.value.toString()
                         font.pixelSize: parent.width/2
                         anchors.centerIn: parent
                     }
                 }
             }
       }
   }
}
