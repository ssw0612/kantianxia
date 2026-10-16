# 看天下政治社 · 社团作品网站

> Astro 4.x 静态站 · 骨架首版（2026-10-15）
> 一所中学里学生社团的作品集网站 —— 6 届学生作品，文稿 + 美术混合陈列。
> 风格：**暖深灰（#1a1a1c）+ 印章红（#a83232）+ 思源宋体类**（政治社气质，出版物感）。

---

## 0. 一句话总结

```
6 届 × N 期 × 多件作品
文稿（可点开展开）+ 美术（SVG 占位）
数据全在 src/data/works.js 一个文件里
```

---

## 1. 项目位置

```
E:\代码成品\网站项目\看天下政治社\
```

---

## 2. 一台新电脑怎么跑起来（零基础向）

> 已默认：本机已装 **Node 22.22.2-6**（路径见 §6）；已默认 npm 缓存指向 E 盘。
> 如果没有 Node，照着 §6 先装。

### 2.1 第一次安装依赖（5 ~ 10 分钟，看网速）

> **必须把缓存和临时目录改到 E 盘**，否则会污染 C 盘。

打开 Git Bash（或 PowerShell），执行：

```bash
# 1) 让 npm 缓存与临时文件全部落到 E 盘
export npm_config_cache="E:\\代码成品\\.npm-cache"
export TMP="E:\\代码成品\\.tmp"
export TEMP="E:\\代码成品\\.tmp"

# 2) 进入项目目录
cd "E:/代码成品/网站项目/看天下政治社/"

# 3) 安装（Astro 是唯一依赖）
npm install
```

> `npm install` 会下载约 330 个包，体积约 100~150 MB，落地后会有一份 `node_modules/` 目录。

### 2.2 启动开发服务器（写东西时用）

仍在该目录下：

```bash
npx astro dev --host 127.0.0.1 --port 4322
```

看到这一行就说明起来了：

```
┃ Local    http://127.0.0.1:4322/
```

打开浏览器访问 `http://127.0.0.1:4322/` 即可看到首页。

- 改任何 `.astro` / `works.js` / `global.css` 后浏览器会自动刷新（HMR）。
- 默认端口 4322 与本机个人作品集站（4321）错开，可同时跑。

> 想停掉服务器：在终端按 `Ctrl + C`。

### 2.3 打包发布版本（往服务器丢之前）

```bash
npx astro build
```

成功后目录下会多一个 `dist/` 文件夹，内容就是可以直接放到 Nginx / GitHub Pages / workbuddy 托管 的静态文件：

```
dist/
├── index.html              ← 首页
├── about/index.html        ← 关于页
├── g/
│   ├── 2021/index.html        ← 2021 届页
│   ├── 2021/issue-1/index.html ← 第 1 期页
│   ├── 2022/index.html
│   ├── 2022/issue-1/index.html
│   ├── 2022/issue-2/index.html
│   ├── ...                    ← 一共 18 个 HTML
│
├── favicon.svg
└── _astro/                  ← 编译后的 CSS/JS（同站所有页面共用一份）
```

可以双击 `dist/index.html` 在本地打开看效果（不需要起服务器）。

### 2.4 测试打包后的版本（preview）

```bash
npx astro preview --host 127.0.0.1 --port 4322
```

等价于把 `dist/` 当作静态目录开 Web 服务器。

---

## 3. 文件结构

```
看天下政治社/
├── README.md              ← 本文件
├── package.json           ← Astro 4.16.18 唯一依赖
├── astro.config.mjs       ← Astro 配置
├── tsconfig.json
├── .gitignore
├── public/
│   └── favicon.svg        ← 社徽（"政"字印章红方框）
└── src/
    ├── data/
    │   └── works.js       ← ★★ 全站唯一需要修改的文件（作品/届/期 数据）
    ├── styles/
    │   └── global.css     ← 全局 CSS（颜色变量、字体、间距）
    ├── layouts/
    │   └── Base.astro     ← 所有页面外壳（head、NavBar、Footer、展开/关闭 JS）
    ├── components/
    │   ├── NavBar.astro     ← 顶部导航
    │   ├── SiteFooter.astro ← 底部
    │   ├── Hero.astro       ← 首页顶部大字区
    │   ├── About.astro      ← 首页关于段
    │   ├── GradeCard.astro  ← 届卡片
    │   ├── IssueCard.astro  ← 期卡片
    │   ├── WorkCard.astro   ← 单件作品卡片（文稿 + 美术共用）
    │   └── ArtPlaceholder.astro  ← 美术占位 SVG（6 种基本形）
    └── pages/
        ├── index.astro     ← 首页 /
        ├── about.astro     ← 关于 /about
        └── g/
            ├── [grade].astro           ← 届页 /g/<2021|2022|...|2026>
            └── [grade]/[issue].astro   ← 期页 /g/<2021>/<issue-1|...>
```

### 3.1 路由说明

| URL                        | 文件                          | 说明                |
| -------------------------- | --------------------------- | ----------------- |
| `/`                        | `src/pages/index.astro`     | 首页（Hero + 6 届卡片 + 关于） |
| `/about`                   | `src/pages/about.astro`     | 关于社团的独立页面                |
| `/g/2021` 等                | `src/pages/g/[grade].astro`        | 届页，显示该届所有期     |
| `/g/2021/issue-1` 等        | `src/pages/g/[grade]/[issue].astro` | 期页，显示该期所有作品   |

> 路由是 Astro 自动生成的（file-based routing）。**改 `works.js` 后**，
> 不需要新增任何 `.astro` 文件，新增 1 届 / 1 期 / 1 件作品都是数据的事。

---

## 4. 想加作品 / 改标题 —— 只动一个文件

> ★ **全站唯一需要修改的文件**：`src/data/works.js`

### 4.1 加一届

在 `grades = [ ... ]` 里加一行：

```js
export const grades = [
  { id: 2021, label: '2021 届', tagline: '...', issueCount: 1, worksCount: 3 },
  { id: 2027, label: '2027 届', tagline: '...', issueCount: 1, worksCount: 2 },  // ← 新加
];
```

并在 `issues = { ... }` 里加上：

```js
export const issues = {
  // ... 既有
  2027: [
    { id: 'issue-1', label: '第 1 期', date: '2027 春', summary: '...' },
  ],
};
```

并在 `works = { ... }` 里加：

```js
export const works = {
  // ...
  '2027-issue-1': [
    // 作品占位 array
  ],
};
```

### 4.2 加一期

找到对应届，在 `issues[2024]`（举例）里 push 一个对象；然后在 `works` 里加一个 `'2024-issue-3'` 键。

### 4.3 加一件作品

照着 `works.js` 文件最末尾的"作品条目示例"抄：

```js
// 文稿
{
  type: 'text',
  slug: 'my-essay',                  // 用拼音/英文简短代号
  title: '我的一篇稿子',
  author: '某某同学',
  date: '2026.05',
  excerpt: '一句话简介',
  body: '第一段正文\n\n第二段正文',
}

// 美术
{
  type: 'art',
  slug: 'my-poster',
  title: '我的一张海报',
  author: '某某同学',
  date: '2026.05',
  svgName: 'wave',                   // 可选：wave / tiger-eye / mountain / grid / stamp / default
  caption: '一句话说明',
}
```

`body` 里用 `\n\n` 表示分段（中间空一行）。正文样式：首段首字放大成印章红色，出版物感。

### 4.4 想换一处 站点文案

整站文案（首页 Hero、关于段、footer 版权行...）全在 `site = { ... }` 对象里。

### 4.5 美术"占位"换成真实图

当前美术都用代码生成的 SVG（占位）。等用户给真图后：

- 推荐做法 A：把图放到 `public/art/2021-issue-1/my-poster.jpg`，然后改 `works`：
  ```js
  {
    type: 'art',
    ...
    src: '/art/2021-issue-1/my-poster.jpg',   // 取代 svgName
  }
  ```
- 同步修改 `src/components/WorkCard.astro` 的 `work.type === 'art'` 分支，把 `<ArtPlaceholder>` 换成 `<img src={work.src} ... />`。
- 后续若要更丰富的美术/视频也按此模式扩展。

---

## 5. 风格系统（CSS 变量）

所有颜色和间距都集中在 `src/styles/global.css` 的 `:root` 里：

| 变量 | 当前值 | 用途 |
| --- | --- | --- |
| `--bg` | `#1a1a1c` | 页面底色：暖深灰（不是纯黑） |
| `--bg-soft` | `#222220` | 卡片底色 |
| `--bg-softer` | `#282826` | 卡片悬停 |
| `--text` | `#e8e3d8` | 主文字：米白 |
| `--text-soft` | `#a8a39a` | 次要文字：中米色 |
| `--accent` | `#a83232` | **印章红**（唯一强调色） |
| `--border` | `#3a3733` | 暗米色边线 |
| `--font-serif` | `Source Han Serif SC, ...` | 标题字体 |
| `--font-sans` | 系统无衬线 | 正文字体 |
| `--space-section` | `112px` | section 之间的大间距 |

> 改色 → 改 `:root`；改间距 → 改对应的 `--space-*`。
> 不要在组件里写死颜色 —— 一律用变量。

---

## 6. 依赖与运行环境

- **Node**：`22.22.2-6`（路径 `C:\Users\30489\.workbuddy\binaries\node\versions\22.22.2-6\`）
- **Astro**：`^4.16.18`（**唯一**运行时依赖）
- **npm**：`10.9.7`（随 Node 自带）

### 6.1 想换 Node？

如果你想用另一个版本，编辑 `astro.config.mjs` 上方需要先把 PATH 里的 node 调到目标版本，例如：

```bash
export PATH="/d/Programs/node-v20:$PATH"   # 你的目标 node 路径
node -v
```

Astro 4.x 要求 Node ≥ 18.17.1。

### 6.2 缓存 & 临时目录都放 E 盘

```bash
export npm_config_cache="E:\\代码成品\\.npm-cache"
export TMP="E:\\代码成品\\.tmp"
export TEMP="E:\\代码成品\\.tmp"
```

---

## 7. 部署

`npx astro build` 完后，把 `dist/` 目录扔到任何静态托管：
- workbuddy 静态站点托管（推荐，5 分钟出公网 https 地址）
- Vercel / Netlify / GitHub Pages / 任意 Nginx

本项目的 `dist/` 一共约 145 MB（含 Astro 自带的少量 chunk；实际页面里 inline 占大头）。

---

## 8. 不在范围（"骨架首版"明确不做）

按任务单 §6「不做」列出：

- 不做真实作品（美术先用 SVG 占位、文稿先用中文 lorem ipsum）
- 不做后台 / 登录
- 不做留言
- 不做"旧站那种光晕 / 光点 / 噪点"动效（动效只有 hover 颜色变化 + 0.4s 缓慢）
- 不出方案文档

---

## 9. 与个人作品集站（`仰韶`）的关键区别

| 维度 | 个人作品集（仰韶） | 政治社（看天下） |
| --- | --- | --- |
| 底色 | `#0a0a0c` 冷近黑 | `#1a1a1c` **暖深灰** |
| 强调色 | `#8a94a6` 冷灰蓝 | `#a83232` **印章红** |
| 标题字体 | 无衬线 | **衬线（思源宋体类）** |
| 动效 | 多（背景呼吸 + 鼠标光晕 + 光点 + 噪点） | **极少**（hover 缓慢亮色） |
| 留白 | 中等 | **多**（section 间距 112px） |
| 数据层 | `src/data/works.js` | `src/data/works.js`（**复用习惯**） |
| 框架 | Astro 4.16.x | Astro 4.16.x（**复用版本**） |

---

## 10. 验收清单

> 对应任务单 §5 的硬性约束

- [x] `npm run build` 成功（18 页 14 秒）
- [x] dev 下首页 + 6 个届页 + 至少 1 个期页全部 200
- [x] 数据集中在 `src/data/works.js`
- [x] 风格与个人作品集站**明显不同**
- [x] 底色 `#1a1a1c` 暖深灰（不是纯黑）
- [x] 印章红 `#a83232` 出现在：标题短横 / eyebrow 横线 / 按钮 hover / 选区配色 / 选段首字
- [x] 零外部字体（用系统字体栈：`Source Han Serif SC` + 系统无衬线）
- [x] 零外部图片（美术占位用 `ArtPlaceholder.astro` 内联 SVG）
- [x] 响应式（CSS 在 ≤640/720/760/800/960/1024px 多处断点）
- [ ] 部署到 workbuddy 并给用户网址（下一阶段）

---

## 11. 已知 / 留给下一版

- 真作品图片替换美术占位的迁移路径已写在 §4.5。
- 想做"作品详情页"（独立 `/g/<g>/<i>/<slug>` 路由），照着 `[issue].astro` 的 `getStaticPaths` 加一层动态参数。
- 想做"按作者检索"或"按标签检索"：在 `works.js` 加 `tags: string[]`，然后新做一个 `[tag].astro`。
- 文末"联系"二维码：照搬个人作品集站 `Footer.astro` 那种"点开显示二维码"的小段实现即可。
