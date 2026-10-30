# axuse 一键安装指南

> 第三方部署指南 · 非 axuse 官方仓库。官方项目：[ctoldigital/axuse](https://github.com/ctoldigital/axuse)
> 内容来自官方文档（2026-10-30）。项目迭代快，请以[官方文档](https://github.com/ctoldigital/axuse#quick-start)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不再靠截图猜位置：读无障碍快照，按 ref 点元素，每次动作只返回变化的部分。

⚠️ 需要 Node.js 22+ 和 Chrome / Edge / Chromium（会自动查找，也可用 AXUSE_BROWSER 指定）。Windows 桌面驱动已验证；macOS 桌面控制要显式开启并过 TCC 授权；Linux 走 X11 / XWayland，没有图形界面时可用 Xvfb 服务器模式。许可证是 PolyForm Noncommercial 1.0.0，仅限非商业用途，商用需另行取得授权。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/axuse-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会确认 Node 22+，克隆仓库后跑一次环境自检，再把 mcp 子命令注册到当前客户端，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## axuse 是什么？

axuse 是开源的一个零依赖的 MCP server，用无障碍树和 CDP 操作浏览器与桌面，而不是截图循环（协议：PolyForm Noncommercial 1.0.0，<img src="https://img.shields.io/github/stars/ctoldigital/axuse?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把浏览器与桌面操作暴露成 MCP 工具：注入目标页面读 DOM 与无障碍树，用稳定 ref 定位元素，输入走受信任事件，错误有类型，每次调用只回传差异。

- 零 npm 依赖，只用内置模块
- 无障碍优先：读树而不是截图
- 差异返回：每次动作只回变化部分
- 跨客户端：Codex、Claude Code、OpenCode 都能接
- 桌面也管：Windows 已验证，macOS / Linux 可开
- 服务器可用：无显示器时自动起 Xvfb 保持有头

（来源：[官方仓库](https://github.com/ctoldigital/axuse)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 6 | 3 |
| 零 |   |
| 无 | 障 |
| 差 | 异 |
| 多 | 客 |
| 无 | 显 |

| 需要注意 | 说明 |
|---|---|
| 仅 | 限 |
| 桌 | 面 |
| 需 | 要 |
| 项 | 目 |
| 对 | 复 |

> 以上基于官方文档与社区反馈整理（2026-10-30），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/ctoldigital/axuse.git
cd axuse
node src/cli.js doctor
node src/cli.js print-config --harness generic
echo "把配置块里的命令换成 src/cli.js 的绝对路径，再注册到你的客户端"
```

部署步骤来源：[https://github.com/ctoldigital/axuse#quick-start](https://github.com/ctoldigital/axuse#quick-start)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Node 22+、doctor 自检与 print-config 用法 | 已核对 2026-10-30 |
| LICENSE 确认为 PolyForm Noncommercial 1.0.0（非商业） | 已核对 2026-10-30 |
| 未实测 doctor 与 MCP 注册 | 说明 2026-10-30 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-30 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-30 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

axuse 本身就是一个 MCP server（`node src/cli.js mcp`），可用 `print-config --harness` 生成 Codex、OpenCode、Antigravity 或通用配置；本仓库的 MCP 只提供安装步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-30）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\axuse-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 第一次接入

1. 克隆后先跑自检，它会找浏览器、启动一次并抓快照：

```bash
node src/cli.js doctor
```

2. 生成配置块（把 `--harness` 换成 codex / opencode / agy / generic）：

```bash
node src/cli.js print-config --harness generic
```

3. 直接注册到命令行客户端：

```bash
codex mcp add axuse -- node /abs/path/axuse/src/cli.js mcp
claude mcp add --scope user axuse -- node /abs/path/axuse/src/cli.js mcp
```

4. 让 Agent 打开一个页面并读出无障碍快照，确认能拿到 `[ref=e7]` 这类引用

## 想复用日常浏览器的登录态

```bash
node src/cli.js setup --browser chrome --harness codex
node src/cli.js bridge verify
```

按提示在扩展页点一次「加载已解压的扩展程序」，之后就能用已登录的 Chrome / Edge。

## 服务器上没有浏览器

```bash
node src/cli.js install-browser
```

会在 `~/.cache/axuse` 装一个固定版本的 Chrome for Testing，不需要 sudo。

## 常用环境变量

| 变量 | 作用 |
|---|---|
| `AXUSE_BROWSER` | 指定浏览器可执行文件 |
| `AXUSE_SERVER_MODE` | 无显示器时是否起 Xvfb 保持有头（默认 auto） |
| `AXUSE_DISPLAY_SIZE` | 虚拟显示器分辨率，`random` 为每台机器一个固定值 |
| `AXUSE_TIMEZONE` | Chrome 进程的时区 |
| `AXUSE_LANG` | `--accept-lang` 与 `navigator.language` |

## 注意

- 许可为 PolyForm Noncommercial 1.0.0，商业使用需向版权方取得授权
- 注册 MCP 时 `src/cli.js` 必须写绝对路径
- macOS 桌面控制要过系统权限，首次会弹窗
- Linux 桌面控制依赖 X11 / XWayland，纯 Wayland 可能受限

## 常见坑

- doctor 找不到浏览器：装 Chrome / Edge，或设 AXUSE_BROWSER 指向可执行文件
- Node 版本过低：需要 22 及以上
- MCP 连不上：配置文件里必须用 src/cli.js 的绝对路径
- 读不到元素：等页面稳定再抓快照，或改用 ref 重新定位
- macOS 桌面操作被拒：到系统设置里给终端或客户端授权
- Linux 无显示器：设置 AXUSE_SERVER_MODE 让它起 Xvfb
- 商用前先确认许可：PolyForm Noncommercial 不允许商业使用

## 免责声明

本仓库为第三方指南，与 axuse 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-30），项目迭代快，请以[官方文档](https://github.com/ctoldigital/axuse#quick-start)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
