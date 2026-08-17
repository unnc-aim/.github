# CMakeLists 规范

## 1. 风格

- 命令一律**小写**（如 `add_executable` / `target_link_libraries`）
- 缩进统一 **2 空格**
- 变量 / target 名使用 `snake_case`

## 2. Modern CMake 要点

- 依赖与编译选项一律挂 target：`target_link_libraries` / `target_include_directories` / `target_compile_options`
- 避免全局作用域命令：不使用 `include_directories` / `add_definitions` / `link_directories`
- ROS2 的 `ament_cmake` 仓库同样适用上述规则（`ament_target_dependencies` 同样挂在具体 target 上）

> 完整 checklist 与示例见 skill：[`cmake-style.md`](https://github.com/unnc-aim/aim-common-agentic-skills/blob/main/.agent/skills/aim-common-rules/references/cmake-style.md)。
