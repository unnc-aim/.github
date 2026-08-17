# Go 工程代码规范

## 1. 格式化（gofmt）

- **gofmt 是唯一格式标准**：`gofmt` / `go fmt` 的输出即最终格式，不手动调整缩进与空格
- 缩进使用 tab（由 gofmt 决定，Go 不适用 2 空格规则）
- import 分组与排序使用 `goimports`（`golang.org/x/tools/cmd/goimports`）
- VS Code 安装 Go 扩展（`golang.go`），保存时自动格式化

## 2. 命名

- 遵循 Effective Go 惯例：导出标识符 `PascalCase`，非导出 `camelCase`，标识符内不使用下划线

**请务必在提交代码前确认 `gofmt` / `goimports` 无差异**

> 编辑器集成与命令行用法见 skill：[`go-formatting.md`](https://github.com/unnc-aim/aim-common-agentic-skills/blob/main/.agent/skills/aim-common-rules/references/go-formatting.md)。
