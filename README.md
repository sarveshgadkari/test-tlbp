# TLBPS Infratech Developers

Static site rebuilt with **TLBISBIG** colours, fonts, and footer structure. Content matches [tlbps.warnerklein.com](https://tlbps.warnerklein.com/).

## Pages

- `index.html`, `about.html`, `projects.html`, `advisory.html`, `sustainability.html`
- `investor.html`, `leadership.html`, `media.html`, `careers.html`, `insights.html`, `contact.html`

## Assets

- Styles: `tlbps.css` (TLBISBIG design tokens)
- Scripts: `js/main.js`
- Images: loaded from `https://tlbps.warnerklein.com/images/` (as on the live site)

## Local preview

Serve the folder over HTTP (recommended):

```bash
npx serve .
```

Or open `index.html` in a browser (navigation and scripts work without a server).

## Vercel deploy

This repository is ready to deploy to Vercel as a static site.

1. Import the repository into Vercel.
2. Keep the root directory as the project root.
3. Leave the build command empty or use the default static deployment.
4. Deploy.

The included `vercel.json` enables clean URLs, so pages such as `/about` and `/contact` resolve to the matching HTML files.

## Rebuild from live source

If you re-download pages from warnerklein, save them as `_source-{page}.html` and run:

```powershell
.\build.ps1
```
# test-tlbp
