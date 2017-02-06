import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480

    Button{
        id: start
        anchors.horizontalCenter: mainWindow.horizontalCenter
        anchors.verticalCenter: mainWindow.verticalCenter
        onClicked: {
            generate(30, 30)
        }
    }

    property var nodes: []

    function generate(num, rr){   // circle number and circle radius range
        var newCompi = Qt.createComponent("Circle.qml")
        var newNodei = newCompi.createObject(mainWindow)
        var rTmpi = Math.floor(Math.random() * rr)
        var xPi = Math.floor(Math.random() * 400)
        var yPi = Math.floor(Math.random() * 300)
        newNodei.r = rTmpi
        newNodei.x = xPi
        newNodei.y = yPi
        nodes.push(newNodei)
        for(var i = 1; i < num; ++i){
            var rTmp = Math.floor(Math.random() * rr)
            var xP = Math.floor(Math.random() * 400) + 100
            var yP = Math.floor(Math.random() * 300) + 50
            console.log(rTmp, xP, yP)
            if(!_generateCheck(rTmp, xP, yP)){
                i--; console.log("Continue~"); continue
            }else{
                var newComp = Qt.createComponent("Circle.qml")
                var newNode = newComp.createObject(mainWindow)
                newNode.r = rTmp
                newNode.x = xP - rTmp
                newNode.y = yP - rTmp
                nodes.push(newNode)
                console.log(newNode.r, newNode.x, newNode.y)
            }
        }
    }

    function _generateCheck(r, x, y){
        for(var i in nodes){
            var rTmp = Math.floor(Math.sqrt((x - (nodes[i].x + nodes[i].r)) * (x - (nodes[i].x + nodes[i].r)) + (y - (nodes[i].y + nodes[i].r)) * (y - (nodes[i].y + nodes[i].r))))
            console.log("Debug", rTmp, nodes[i].r, r)
            if((r + nodes[i].r) > rTmp) return false
        }
        return true
    }
    function converge(x, y){
           // nodes sort
           var dist = [], distDef = []
           for(var i in nodes){
               var dTmp = Math.floor(Math.sqrt(((nodes[i].x + nodes[i].r) - x) * ((nodes[i].x + nodes[i].r) - x) + ((nodes[i].y + nodes[i].r) - y) * ((nodes[i].y + nodes[i].r) - y)))
               dist.push(dTmp)
               distDef.push(dTmp)
           }
           for(var ii = 0; ii < dist.length; ++ii){
               for(var j = ii + 1; j < dist.length; ++j){
                   if(dist[j] < dist[ii]){
                       var temp = dist[j]
                       dist[j] = dist[ii]
                       dist[ii] = temp
                   }
               }
           }

           var nodes2 = []
           for(var iii in dist){
               for(var iiii in distDef){
                   if(dist[iii] === distDef[iiii]){
                       nodes2.push(nodes[iiii])
                   }
               }
           }
           for(var all in nodes){
               nodes[all] = nodes2[all]
           }

           //test
           var distFinal = []
           for(var jj in nodes){
               var dTmp2 = Math.floor(Math.sqrt(((nodes[jj].x + nodes[jj].r) - x) * ((nodes[jj].x + nodes[jj].r) - x) + ((nodes[jj].y + nodes[jj].r) - y) * ((nodes[jj].y + nodes[jj].r) - y)))
               distFinal.push(dTmp2)
           }
           // sort end

           for(var each = 1; each < nodes.length; ++each){
               var xOri = nodes[each].x + nodes[each].r
               var xx, yy, each2, tmpDist
               if(xOri > nodes[0].x + nodes[0].r){
                   for(xx = xOri; xx >= nodes[0].x + nodes[0].r; --xx){
                       yy = parseInt(((nodes[0].y + nodes[0].r) - (nodes[each].y + nodes[each].r)) * (xx - (nodes[0].x + nodes[0].r))/((nodes[0].x + nodes[0].r)-(nodes[each].x + nodes[each].r)) + nodes[0].y + nodes[0].r)
                       for(each2 = each - 1; each2 >= 0; each2--){
                           tmpDist = Math.sqrt((xx - (nodes[each2].x + nodes[each2].r)) * (xx - (nodes[each2].x + nodes[each2].r)) + (yy - (nodes[each2].y + nodes[each2].r)) * (yy - (nodes[each2].y + nodes[each2].r)) )
                           if(Math.abs( tmpDist - (nodes[each].r + nodes[each2].r)) < 3)
                               break
                       }
                   }
                   nodes[each].x = xx - nodes[each].r
                   nodes[each].y = yy - nodes[each].r
               }else{
                   for(xx = xOri; xx <= nodes[0].x + nodes[0].r; ++xx){
                       yy = parseInt(((nodes[0].y + nodes[0].r) - (nodes[each].y + nodes[each].r)) * (xx - (nodes[0].x + nodes[0].r))/((nodes[0].x + nodes[0].r)-(nodes[each].x + nodes[each].r)) + nodes[0].y + nodes[0].r)
                       for(each2 = each - 1; each2 >= 0; each2--){
                           tmpDist = Math.sqrt((xx - (nodes[each2].x + nodes[each2].r)) * (xx - (nodes[each2].x + nodes[each2].r)) + (yy - (nodes[each2].y + nodes[each2].r)) * (yy - (nodes[each2].y + nodes[each2].r)) )
                           if(Math.abs( tmpDist - (nodes[each].r + nodes[each2].r)) < 3)
                               break
                       }
                   }
                   nodes[each].x = xx - nodes[each].r
                   nodes[each].y = yy - nodes[each].r
               }
           }

           console.log(dist, distDef, distFinal)
       }
   }

//    function getYInBeeline(x1, y1, x2, y2, x){
//        var k = parseInt((y1 - y2) / (x1 - x2))
//        return k * (x - x1) + y1
//    }

//    function getTwoPointDistance(x1, y1, x2, y2){
//        return Math.floor(Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)))
//    }


