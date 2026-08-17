# TypeScript 工程代码规范

## 1. 格式化（Prettier）

- 缩进统一 **2 空格**（Prettier 默认值），禁止使用 tab
- 仓库根目录放 `.prettierrc`（模板见 skill `assets/.prettierrc`）
- VS Code 安装 Prettier 扩展（`esbenp.prettier-vscode`），启用 `Format On Save`
- 提交前执行 `pnpm exec prettier --write .`

## 2. 包管理器：pnpm

- 所有 TypeScript / JavaScript 项目除特殊场景统一使用 **pnpm**
- 启用 corepack：`corepack enable pnpm`
- `package.json` 中写明 `"packageManager": "pnpm@x.y.z"`（具体版本号）
- 锁文件 `pnpm-lock.yaml` 须提交；

## 3. Lint（typescript-eslint）

- 使用 typescript-eslint（`recommended` 起步），模板见 skill `assets/eslint.config.js`
- 分工：**ESLint 管代码质量，Prettier 管格式**，二者不重复配置
- 提交前执行 `pnpm exec eslint .`

## 4. 命名

- 遵循 TypeScript Handbook 惯例：变量 / 函数 `camelCase`，类型 / 类 / 组件 `PascalCase`，常量 `UPPER_SNAKE_CASE`

请务必在提交代码前使用 Prettier 格式化、并通过 ESLint 检查

> 完整配置模板、编辑器集成与 CI 用法见 skill：[`ts-formatting.md`](https://github.com/unnc-aim/aim-common-agentic-skills/blob/main/.agent/skills/aim-common-rules/references/ts-formatting.md)。
