// @ts-check
import { defineConfig } from 'astro/config';

/**
 * 看天下政治社 —— Astro 配置
 * 骨架首版：纯静态站，零额外依赖（不引 UI 库、不引字体）。
 */
export default defineConfig({
  site: 'https://example.com',
  server: {
    host: true,   // 允许局域网访问，方便手机预览
    port: 4322,   // 默认端口；与个人作品集错开
  },
  build: {
    inlineStylesheets: 'auto',
  },
});
