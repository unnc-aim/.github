# Python Formatting

> Source of truth: `.github/profile/standard.py.md`. One-line rule: **all Python code must follow [PEP 8](https://peps.python.org/pep-0008/); format with autopep8 before committing.**

## 1. Tool: autopep8

The team standard explicitly uses **autopep8** (not black / ruff / yapf). autopep8 follows PEP 8 by default, with default `max-line-length = 79`.

### Editor integration

- **VS Code**: install the [autopep8 extension](https://marketplace.visualstudio.com/items?itemName=ms-python.autopep8) (`ms-python.autopep8`) and enable `Format On Save`.

  ```jsonc
  // .vscode/settings.json
  {
    "[python]": {
      "editor.defaultFormatter": "ms-python.autopep8",
      "editor.formatOnSave": true
    },
    "autopep8.args": ["--max-line-length=79"]
  }
  ```

- **PyCharm**: in `Preferences → Tools → Actions on Save`, check `Reformat code`.

### Command line

```bash
# install
pip install autopep8

# format in place, recursively
autopep8 --in-place --recursive --max-line-length 79 .

# show diff only, do not write (CI / gate)
autopep8 --diff --max-line-length 79 src/main.py
```

## 2. Canonical config (copy & use)

Copy the `[flake8]` / `[autopep8]` sections from [assets/setup.cfg](../assets/setup.cfg) into your repo-root `setup.cfg` (line length **79**, matching the `aim-py-2526-courseworks` CI). Key points:

- `max-line-length = 79` (**do not** casually change to 99/100, or the `aim-py-2526-courseworks` CI will fail — it runs bare `autopep8`, i.e. 79).
- Ignore `E203` (whitespace before slice) and `W503` (line break before a binary operator) — consistent with modern tooling / relaxed PEP 8.
- ROS2 `ament_python` repos already have `[develop]` / `[install]` sections in `setup.cfg`: **merge** them in, do not overwrite.

> `flake8` is for checking; `autopep8` is for formatting. Both read `max-line-length` from the `[flake8]` section. flake8 is not enforced by the team, but it is harmless and useful for local self-checks.

## 3. CI (existing reference)

`aim-py-2526-courseworks/.github/workflows/ci.yml` already uses autopep8 to gate unformatted code:

```yaml
- run: pip install autopep8 pytest
- run: autopep8 --diff src/main/__init__.py > autopep8.out || true
- run: if [ -s autopep8.out ]; then echo "::error::code is not formatted"; exit 1; fi
```

New repos can copy this pattern: treat any non-empty `autopep8 --diff` output as a failure.

## 4. PEP 8 naming quick reference (autopep8 does not check naming — review manually)

| Object | Style | Example |
| --- | --- | --- |
| Module / package | `snake_case` / `lowercase` | `vision_utils`, `hik_camera` |
| Class / exception | `PascalCase` | `ImageProcessor`, `CaptureError` |
| Function / variable / method | `snake_case` | `process_frame`, `frame_count` |
| Constant | `UPPER_SNAKE_CASE` | `MAX_FPS`, `DEFAULT_PORT` |
| Private | leading `_` | `_internal_helper` |

## 5. Import sorting (optional)

`aim-rookie-courses`'s Python setup doc recommends **isort**. The team does not enforce it in CI; to enable it, add this to `setup.cfg`:

```ini
[isort]
profile = black
line_length = 79
```

(`profile = black` is just an isort preset name, unrelated to whether you use black; it gives a common, compatible import grouping.)
