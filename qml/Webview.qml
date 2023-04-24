

import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import QtWebEngine 1.10

Page {
    id: webview
    header: PageHeader {
       id: header
       title: i18n.tr('App Title')
       visible: false
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

    WebEngineView {
        id: webEngineView
        width: parent.width
        height: parent.height
        visible: false
        zoomFactor: 1
        anchors.fill: parent
        url: QClient.webviewUrl
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
