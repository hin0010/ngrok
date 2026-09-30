package assets

import (
	"embed"
	"io/fs"
)

//go:embed assets
var FS embed.FS

func Asset(name string) ([]byte, error) {
	return fs.ReadFile(FS, name)
}
