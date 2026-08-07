# 欢迎回到 UNNC AIM Robotics 战队

**本组织开放给所有 AIM 战队内成员使用，所有成员需遵守以下规范：**

## **1. 仓库使用规范**

### 1.1 仓库命名规范

本组织的仓库创建规范分为 `3` 种情况：

#### 1.1.1. `[2位数年份][比赛大写简写]_[机器人名(如有)]_[包名]` - 针对 某年、某比赛、某机器人 的一次性仓库

样例：

- `26RC_R2_ws` - 2026年 Robocon 主赛 R2 机器人主 Workspace 仓库
- `26RC_R2_kfs_tracker` - 2026年 Robocon 主赛 R2 机器人 KFS 视觉跟踪仓库，注意如果是 ROS Package 的话，`package.xml` 中的 `<name>` 标签需要与仓库中包名部分保持一致，包名单词间也使用下划线 `_` 分隔
- `26RC_R1_arm_controller` - 2026年 Robocon 主赛 R1 机械臂控制器仓库，包名同理
- `26RC_interfaces` - 2026年 Robocon 主赛通用接口仓库，如果是同场比赛跨机器人使用的仓库，命名可以省略机器人部分
- `25RM_raw_rm_vision` - 2025年 RoboMaster 联盟赛 RM 视觉主仓库，包名同理

#### 1.1.2. `aim-[4位学年名]-[包名]` - 针对 AIM 战队内部的 非赛用、单学年/长期 仓库

样例：

- `aim-2526-py-coursework` - 2025-2026 学年 AIM 战队 Python 国庆考核仓库，包名单词间分隔使用 dash `-`，注意与赛用仓库不同
- `aim-2526-navigation-final-assessment` - 2025-2026 学年 AIM 导航组期末考核仓库，包名单词间分隔同理使用 dash `-`
- `aim-rookie-courses` - Lectures designed for RM rookies & freshmen @ unnc-aim，主要用于存放新生课程资料，长期使用的仓库可以省略学年部分

#### 1.1.3. `BrandingRepo`/`package_name` - 对外开放/万能/可复用的 完整项目/轮子仓库/lib

样例：

- `RoboMark` - 单独包含 Branding 成分的仓库可以省略 `aim-xxxx` 前缀，直接使用仓库名即可
- `Camera2Topic` - An ROS2 package that converts usb camera/realsense to topics
- `ros2_hik_camera` - 海康相机 ROS2 驱动仓库

#### 1.1.4. 赛用 Workspace 内组织子模块时去掉比赛前缀

比赛 **Workspace** 仓库（后缀 `_ws`，如 `26RC_R2_ws`）会把多个比赛仓库作为 **git submodule** 放在 `src/` 下。当被添加的仓库带比赛前缀（`26RC_` / `26RC_R2_` 等）时，子模块目录名要 **去掉前缀**——前缀在工作区名中已体现，无需重复：

```bash
# 在 26RC_R2_ws/ 内
git submodule add https://github.com/unnc-aim/26RC_R2_arm_controller.git src/arm_controller
# 而不是 src/26RC_R2_arm_controller
```

- 去掉前缀后的目录名必须与 ROS 包 `package.xml` 中的 `<name>` 一致；比赛前缀只出现在 GitHub 仓库名里。
- 无比赛前缀的可复用包（如 `Camera2Topic`、`ros2_hik_camera`）保持原名直接放入 `src/`。
- 完整规则、示例表与已知反例见 skill：[`.agent/skills/aim-common-rules/references/workspace-organization.md`](../.agent/skills/aim-common-rules/references/workspace-organization.md)。

> 仓库命名完整规范（三种模式、决策树、大小写 / 分隔符对照、已知反例）见 skill：[`.agent/skills/aim-common-rules/references/repo-naming.md`](../.agent/skills/aim-common-rules/references/repo-naming.md)。

### 1.2 仓库内容规范

- 所有仓库内 **不允许** 出现任何编译文件，请妥善使用 `.gitignore` 文件来排除项目下所有潜在的编译文件
- 所有仓库主分支统一命名为 `main`，禁止使用 `master` 命名主分支

### 1.3 仓库进度管理

所有已经处于稳态的仓库禁止直接向 `main` 分支直接提交修改，请创建分支并使用 `Pull request` 来提交修改。

分支命名规范需要符合以下要求：

- 分支名统一使用小写字母，单词间使用下划线 `_` 分隔
- 如果是修复 `bug` 的分支，使用 `fix/[开启用户名]` 开头，，按照 `bug` 的名字命名，如 `fix/vision_tracking`，`fix/arm_control_error` 等
- 新增功能按照功能的名字命名，如 `feature/vision_tracking`，`feature/arm_control` 等
- 阶段性成果没有显著问题的按照版本号命名
- 保证所有功能稳定可靠的才可 merge 到 `main` 分支

### 1.4 Git Message Regulation

1. 推荐的 Git 提交信息格式

   基础格式：

   ```text
   <type>(<scope>): <subject>
   <BLANK LINE>
   <body>
   <BLANK LINE>
   <footer>
   ```

   示例：

   ```text
   feat(user-auth): add login functionality

   Implemented a login system with JWT authentication.
   Updated the user model and added necessary endpoints.

   BREAKING CHANGE: Updated the user model to include an additional "authToken" field.
   ```

2. 格式详解
   1. `<type>` (提交类型)：
      - 用于标识提交的目的，常见类型包括：
         - **feat**：新增功能。
         - **fix**：修复 Bug。
         - **docs**：仅文档变更。
         - **style**：代码格式调整（不影响功能，例如空格、格式化）。
         - **refactor**：代码重构（不包括 Bug 修复或功能添加）。
         - **test**：添加或修改测试。
         - **chore**：其他杂项，例如更新构建工具、配置文件。
         - **perf**：性能优化。
         - **ci**：持续集成相关修改。
         - **build**：构建系统或外部依赖的变更。
   2. `<scope>` (影响范围)：
      - 可选，用于说明变更的模块或范围，例如：
         - **user-auth**
         - **api**
         - **ui**
      - 如果不需要特别说明，可以省略。
   3. `<subject>` (简短描述)：
      - 对提交的简要描述，不超过 50 字符。
      - 使用 祈使句（如“Add” 而不是“Added”）。
      - 第一个字母小写，结尾不要加标点。
   4. `<body>` (详细描述)：
      - 可选，用于解释提交的详细内容。
      - 换行适当控制在 72 字符以内，保持易读性。
      - 包含原因、实现方式、以及与上下文相关的信息。
   5. `<footer>` (备注信息)：
      - BREAKING CHANGE：如果变更会导致不兼容，说明影响范围和解决方案。
      - Issues：引用相关问题或任务编号，例如 Closes #123 或 Refs #456。

> 分支命名与 commit message 完整规范（字段说明、`type` 取值、PR 流程）见 skill：[`.agent/skills/aim-common-rules/references/git-workflow.md`](../.agent/skills/aim-common-rules/references/git-workflow.md)。

### 1.5 代码规范

***请务必在提交代码前对代码进行格式化，具体规范请参考以下文档***

- [C++](standard.cpp.md) — 完整命名规则、`.clang-format` / `.clang-tidy` 模板与已知反例见 skill：[`.agent/skills/aim-common-rules/references/cpp-formatting.md`](../.agent/skills/aim-common-rules/references/cpp-formatting.md)
- [Python](standard.py.md) — autopep8 配置、CI 用法与 PEP 8 命名表见 skill：[`.agent/skills/aim-common-rules/references/python-formatting.md`](../.agent/skills/aim-common-rules/references/python-formatting.md)

## **2. Agentic Skill (aim-common-rules)**

上述全部规范已封装为一个 agentic skill：`aim-common-rules`，位于本仓库 `.agent/skills/aim-common-rules/`。安装后，Agent 会在**创建 / 命名仓库、核对 ROS2 包名、新建分支、撰写 commit message、格式化 Python / C++ 代码**等场景自动调用本规范。

### 2.1 安装（交互式，可选目标位置）

在任意目录执行：

```bash
curl -fsSL https://raw.githubusercontent.com/unnc-aim/.github/main/.agent/skills/aim-common-rules/install.sh | bash
```

在终端里运行会弹出交互菜单选择安装位置（`curl | bash` 或 CI 等非交互环境默认走选项 1；在终端本地运行可选择其他位置）：

| 选项 | 安装位置 | 适用场景 |
| --- | --- | --- |
| 1 | `~/.claude/skills/`（全局） | Claude Code 用户，所有项目默认可用 |
| 2 | `./.claude/skills/`（本项目） | Claude Code 用户，随仓库提交共享给全队 |
| 3 | `~/.agent/skills/`（全局）或 `./.agent/skills/`（本项目） | Cursor / Cline 等其他 agent 工具或自定义 |
| 4 | 自定义路径 | 你指定任意目录 |

> 本地也可直接 `bash .agent/skills/aim-common-rules/install.sh`。

### 2.2 在 Claude Code 中使用

全局安装后**无需任何额外配置**：skill 会根据其描述在相关场景**自动触发**；也可在对话中手动调用 `/aim-common-rules`。

### 2.3 更新

规范更新后，**重新执行 2.1 的同一行命令**即可覆盖更新。

### 2.4 在 Cursor / Cline 等其他工具中使用

用上面的脚本把 skill 安装到对应工具读取的位置（如选项 3 `~/.agent/skills/` 全局或 `./.agent/skills/` 本项目、或选项 4 自定义路径）即可。格式化规则文件位于 `<安装目录>/aim-common-rules/assets/`（`.clang-format` / `.clang-tidy` / `setup.cfg`），把它们拷贝到你的仓库根目录，编辑器 / `clang-format` / `autopep8` / CI 就会自动读取；若仓库已有同名文件（如 ROS 的 `setup.cfg`），请手动合并而非覆盖。

规范全文也可直接在 GitHub 阅读：[`.agent/skills/aim-common-rules/references`](https://github.com/unnc-aim/.github/tree/main/.agent/skills/aim-common-rules/references)（仓库命名 / Git 流程 / Python / C++ 格式化）。
