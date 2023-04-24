package jitsi

import (
	"encoding/json"
	"github.com/therecipe/qt/core"
	"jitsi-client/files"
	"jitsi-client/global"
	"os"
	"strings"
)

type DataContext struct {
	LastServer string
}

const (
	dataContextFileName string = "dataContext.json"
)

type QClient struct {
	core.QObject
	_ func() `constructor:"init"`

	_ string `property:"webviewUrl"`

	_ func(webviewUrl string) `slot:"setUrl"`
	_ func() string           `slot:"getLastServer"`
}

func (m *QClient) init() {
	m.ConnectSetUrl(m.setUrl)
	m.ConnectGetLastServer(m.getLastServer)
}

func (m *QClient) setUrl(webviewUrl string) {
	if webviewUrl == "" {
		return
	}
	if !strings.Contains(webviewUrl, "https://") {
		webviewUrl = "https://" + webviewUrl
	}
	m.SetWebviewUrl(webviewUrl)
	m.WebviewUrlChanged(webviewUrl)
	dataContext := &DataContext{webviewUrl}
	fileContent, _ := json.MarshalIndent(dataContext, "", " ")
	files.CreateFile(global.ConfigFileDir, dataContextFileName, fileContent)
}

func (m *QClient) getLastServer() string {
	fileName := global.ConfigFileDir + dataContextFileName
	exists := files.FileExists(fileName)
	if exists {
		fileBytes, err := os.ReadFile(fileName)
		if err != nil {
			return ""
		}
		dataContext := &DataContext{}
		err = json.Unmarshal(fileBytes, dataContext)
		if err != nil || dataContext.LastServer == "" {
			return "https://meet.jit.si"
		}
		return dataContext.LastServer
	}
	return "https://meet.jit.si"
}

func GetQClient() (*QClient, error) {
	qClient := NewQClient(nil)

	return qClient, nil
}
