# 欢迎回到 UNNC RoboMaster AIM 战队

**本组织开放给所有 AIM 战队内成员使用，所有成员需遵守以下规范：**

## **1. 仓库使用规范**

### 1.1 仓库命名规范

本组织的仓库创建规范为：前缀-使用平台（如果有）-使用软件-仓库名  
其中前缀为：

- Hardware （对应硬件组）
- Embedded （对应软件组）
- Vision （对应视觉组）
- Control （对应控制组）

使用平台只有软件组成员需要填写：

- 软件组为使用硬件平台的名称，如：STM32，ESP32，Arduino 之类

使用软件所有都需要填写：

- 控制组为使用 ROS 版本的名称，如：Noetic，Humble 等
- 视觉组为使用 IDE 的名称，如：VSCode，CLion，PyCharm 等
- 软件组为使用 IDE 的名称，如：Keil，PIO，CubeIDE 等
- 硬件组为使用硬件的名称，如：KiCAD，Cadence，AltiumDesigner 等

样例命名为：  

**Hardware-KiCAD-HyperCap**
**Embedded-STM32-CubeIDE-Balance**
**Control-Noetic-Infantry**
**Vision-VSCode-PowerRune**

### 1.2 仓库内容规范

所有仓库内 **不允许** 出现任何编译文件，请妥善使用.gitignore 文件来排除项目下所有潜在的编译文件

### 1.3 仓库进度管理

所有仓库禁止直接向 main 分支直接提交修改，请创建分支并使用 Push & Pull request 来提交修改，分支命名规范需要符合以下要求：

- 新增功能无论有没有 bug 的按照功能的名字命名

- 阶段性成果没有显著问题的按照版本号命名

- 保证所有功能稳定可靠的才可 merge 到 main 分支

### 1.4 Git Message 规范

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

### 1.5 代码规范

***请务必在提交代码前对代码进行格式化，具体规范请参考以下文档***

- [C++](standard.cpp.md)
- [Python](standard.py.md)
