/*
* Copyright (C) 2022  Development@bendingtherules.nl
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 3.
*
* first is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page {
    id: page
    width: parent.width
    height: parent.height
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('App Title')
        visible: false
    }

    Rectangle {
        anchors.fill: parent
        color: "#333333"
    }
    ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 24

        anchors {
            left: parent.left
            right: parent.right

            leftMargin: 40
            rightMargin: 40
        }

        TextInput {
            id: textEdit1
            font.pointSize: 12
            text: QClient.getLastServer()
            color: "#000000"
            font.weight: Font.Medium
            width: parent.width
            Layout.fillWidth: true
            Layout.maximumWidth: 600
            topPadding: 16
            bottomPadding: 16
            rightPadding: 20
            leftPadding: 20
            layer.enabled: true

            Label {
                color: "#3e3e42"
                text: "Enter the server URL"
                font.weight: Font.Medium
                font.pointSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !textEdit1.text && !textEdit1.activeFocus
            }

            Rectangle {
                z: -1
                anchors.fill: parent
                color: "#FFFFFF"
                radius: 8
                anchors.right: parent.right
                anchors.left: parent.left
            }
        }

        Button {
            width: parent.width
            Layout.fillWidth: true
            Layout.maximumWidth: 600
            Layout.preferredHeight: serverLabel.paintedHeight + 24
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            color: "#1D76BA"

            onClicked: {
                QClient.setUrl(textEdit1.text)
                pageStack.push(Qt.resolvedUrl("Webview.qml"))
            }
            Label {
                id: serverLabel
                text: "Continue"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fontSize: "medium"
                font.weight: Font.Medium
                color: "#ffffff"
            }
        }
    }
}
