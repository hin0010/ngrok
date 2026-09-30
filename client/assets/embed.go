package assets

import (
	"embed"
	"io/fs"
)

//go:embed assets
var FS embed.FS

// Asset 兼容原 go-bindata 的调用方式
func Asset(name string) ([]byte, error) {
	return fs.ReadFile(FS, name)
}
