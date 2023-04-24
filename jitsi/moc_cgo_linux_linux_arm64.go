//go:build !ubports
// +build !ubports

package jitsi

/*
#cgo CFLAGS: -pipe -O2 -Wall -W -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_WIDGETS_LIB -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB
#cgo CXXFLAGS: -pipe -O2 -Wall -W -D_REENTRANT -fPIC -DQT_NO_DEBUG -DQT_WIDGETS_LIB -DQT_QUICK_LIB -DQT_GUI_LIB -DQT_QML_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB
#cgo CXXFLAGS: -I../../jitsi-client -I. -isystem /usr/include/aarch64-linux-gnu/qt5 -isystem /usr/include/aarch64-linux-gnu/qt5/QtWidgets -isystem /usr/include/aarch64-linux-gnu/qt5/QtQuick -isystem /usr/include/aarch64-linux-gnu/qt5/QtGui -isystem /usr/include/aarch64-linux-gnu/qt5/QtQml -isystem /usr/include/aarch64-linux-gnu/qt5/QtNetwork -isystem /usr/include/aarch64-linux-gnu/qt5/QtCore -I. -I/usr/lib/aarch64-linux-gnu/qt5/mkspecs/linux-g++
#cgo LDFLAGS: -O1
#cgo LDFLAGS:  /usr/lib/aarch64-linux-gnu/libQt5Widgets.so /usr/lib/aarch64-linux-gnu/libQt5Quick.so /usr/lib/aarch64-linux-gnu/libQt5Gui.so /usr/lib/aarch64-linux-gnu/libQt5Qml.so /usr/lib/aarch64-linux-gnu/libQt5Network.so /usr/lib/aarch64-linux-gnu/libQt5Core.so /usr/lib/aarch64-linux-gnu/libGL.so -lpthread
#cgo CFLAGS: -Wno-unused-parameter -Wno-unused-variable -Wno-return-type
#cgo CXXFLAGS: -Wno-unused-parameter -Wno-unused-variable -Wno-return-type
*/
import "C"
