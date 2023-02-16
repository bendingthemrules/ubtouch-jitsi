/*
 * Copyright (C) 2022  Development@bendingtherules.nl
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * matrix is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import QtQuick.Layouts 1.3
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import QtWebEngine 1.7

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'nl.btr.jitsi'

    WebEngineView {
        id: webEngineView
        width: parent.width
        height: parent.height
        visible: false
        zoomFactor: 1
        anchors.fill: parent
        url: "https://meet.jit.si/"
        userScripts:  WebEngineScript {
            injectionPoint: WebEngineScript.DocumentReady
            sourceUrl: "qrc:/assets/bundle.js"
        }
        onFeaturePermissionRequested: {
            console.log("freature permission request", feature, securityOrigin);

            var mediaAccessDialog = PopupUtils.open(Qt.resolvedUrl("MediaAccessDialog.qml"), this);
            mediaAccessDialog.accept.connect(() => { console.log("accept"); grantFeaturePermission(securityOrigin, feature, true) })
            mediaAccessDialog.reject.connect(() => { console.log("reject"); grantFeaturePermission(securityOrigin, feature, false) })
            mediaAccessDialog.origin = securityOrigin;
            mediaAccessDialog.feature = feature;

            // grantFeaturePermission(securityOrigin, feature, true);
        }
        onNavigationRequested: (navigationRequest) => {
            console.log('Navigation requested ' + navigationRequest.url)
            const navUrl = navigationRequest.url.toString() 
            if(navUrl.includes("/static") && navUrl.includes('/close')){
                navigationRequest.action = WebEngineNavigationRequest.IgnoreRequest
                webEngineView.url = "https://meet.jit.si/"
            }
        }
        onNewViewRequested: (request) => {
            Qt.openUrlExternally(request.requestedUrl);
        }
        onLoadProgressChanged: {
            progressBar.value = loadProgress
            if (loadProgress === 100) {
                visible = true;
            }
        }
    }

    Connections {
        target: Qt.inputMethod

        onKeyboardRectangleChanged: {
            var newRect = Qt.inputMethod.keyboardRectangle
            var scale = (newRect.y + newRect.height) / root.height

            webEngineView.height = newRect.height == 0 
                ? root.height + 1
                : Math.ceil(newRect.y / scale);
        }
    }

    Rectangle {
        visible: !webEngineView.visible
        color: "#1D76BA"
        anchors.fill: parent
    }

    Column {
        anchors.fill: parent
        visible: !webEngineView.visible
           Image {
              id: image
              width: 150
              height: 150 
              anchors.centerIn: parent
              Layout.alignment: Qt.AlignLeft | Qt.AlignTop
              source: "qrc:/assets/loader.svg"
           }
            ProgressBar {
                id: progressBar
                value: 0
                minimumValue: 0
                maximumValue: 100
                anchors.top: image.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 30
            }
      }
}
