# 🚀 POST-SETUP — Your Brand Name Here

Thank you! This site scaffold is ready for production.
Below are the **human-only tasks** still needed.

---

## 🔴 Before launch

- [ ] **Google Business Profile verification**
      Add `googleVerification` code to `src/data/site.config.ts`
- [ ] **Replace favicon set** — overwrite `public/favicon*`
- [ ] **Replace logo** — overwrite `public/logo.svg`
- [ ] **Real images**
      - Grey placeholders: **3 slot(s)** in `src/data/content/gallery.ts`
      - Unsplash stock to swap: **0 image(s)** with attribution
      Run `npm run optimize-images dir Images/` to process local photos.

## 🟡 Nice-to-have before launch

- [ ] Replace map embed URL in `src/data/site.config.ts` → `SITE.maps`
- [ ] Blog posts: `src/data/content/blog.ts`
- [ ] Real `Lorem` text in pages/components

## 🟢 Launch

1. `npm run build`
2. Upload `dist/` to **Netlify / Vercel / Cloudflare Pages**
3. Submit `sitemap-index.xml` in Google Search Console
4. Add `robots.txt` → `Sitemap: https://yourdomain.com/sitemap-index.xml`

---

_Built with [float-skills](https://github.com/CubeSeven/float-skills)_