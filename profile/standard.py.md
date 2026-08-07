# Python 工程代码规范

## 1.Format

**凡 Python 代码均需遵守 [PEP 8](https://peps.python.org/pep-0008/) 规范**

## 具体实现

### Visual Studio Code

请安装 [autopep8 扩展](https://marketplace.visualstudio.com/items?itemName=ms-python.autopep8)，并在设置中启用 `Format On Save` 选项

### PyCharm

请在 `Preferences -> Tools -> Actions on Save` 中启用 `Reformat code` 选项

## 2. Import 排序

使用 **isort** 对 import 排序，组间留空行，顺序为：

1. 标准库（`os`、`sys`、`math` …）
2. 第三方库（`numpy`、`cv2`、`rclpy` …）
3. 本仓库自身模块（first-party / local）

组内按字母序，`import x` 排在 `from x import y` 之前。配置见 `setup.cfg` 的 `[isort]` 段（`line_length = 79`，其余用 isort 默认）；提交前先跑 `isort .`，再跑 autopep8。

> 完整配置、编辑器集成与 CI 用法见 skill：[`python-formatting.md`](../.agent/skills/aim-common-rules/references/python-formatting.md) §5。

## **请务必在提交代码前使用上述工具对代码进行格式化**
