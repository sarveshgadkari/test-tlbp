$dir = $PSScriptRoot
$imgBase = "https://tlbps.warnerklein.com/images/"
$fontLink = @'
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400;1,600&family=Inter:wght@300;400;500;600;700&family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="tlbps.css">
'@

$tokens = @'
/* TLBPS — TLBISBIG design tokens + layout */
:root {
  --c-bg:          #07080F;
  --c-bg-2:        #0B0D1A;
  --c-bg-3:        #0F1220;
  --c-surface:     rgba(255, 255, 255, 0.04);
  --c-surface-2:   rgba(255, 255, 255, 0.07);
  --c-surface-3:   rgba(255, 255, 255, 0.10);
  --c-gold:        #F0B429;
  --c-gold-2:      #FFCA4A;
  --c-gold-dim:    rgba(240, 180, 41, 0.65);
  --c-gold-glow:   rgba(240, 180, 41, 0.14);
  --c-gold-border: rgba(240, 180, 41, 0.28);
  --c-blue:        #4F9CF9;
  --c-blue-2:      #82BCFF;
  --c-white:       #FFFFFF;
  --c-text:        #C8D3E8;
  --c-text-muted:  rgba(200, 211, 232, 0.55);
  --c-text-faint:  rgba(200, 211, 232, 0.32);
  --c-border:      rgba(255, 255, 255, 0.07);
  --c-border-2:    rgba(255, 255, 255, 0.12);
  --c-green:       #34D399;
  --g-gold:        linear-gradient(135deg, #F0B429 0%, #FFCA4A 100%);
  --font-head:     'Poppins', -apple-system, sans-serif;
  --font-body:     'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-display:  'Cormorant Garamond', Georgia, serif;
  --section-py:    110px;
  --container-max: 1240px;
  --container-px:  clamp(16px, 4vw, 40px);
  --radius-sm:     8px;
  --radius-md:     14px;
  --radius-lg:     20px;
  --radius-full:   100px;
  --t-fast:   0.18s ease;
  --t-base:   0.32s ease;
  --nav-h: 76px;
  --gold: var(--c-gold);
  --gold-light: var(--c-gold-2);
  --gold-dark: #c8941f;
  --champagne: var(--c-bg-3);
  --cream: var(--c-bg-2);
  --warm-white: var(--c-bg);
  --pearl: var(--c-bg-3);
  --sand: var(--c-bg-3);
  --text-primary: var(--c-white);
  --text-secondary: var(--c-text-muted);
  --text-light: var(--c-text-faint);
  --text-on-gold: #07080F;
  --emerald: var(--c-green);
  --emerald-light: var(--c-green);
  --glass-bg: var(--c-surface);
  --glass-border: var(--c-gold-border);
  --glass-shadow: rgba(0,0,0,0.35);
  --glass-bg-hover: var(--c-surface-2);
  --font-heading: var(--font-head);
  --font-accent: var(--font-display);
  --section-padding: var(--section-py);
  --container-max: var(--container-max);
  --container-padding: var(--container-px);
  --transition-smooth: var(--t-base);
  --transition-luxury: var(--t-base);
}
'@

$overrides = @'

body { padding-top: var(--nav-h); background: var(--c-bg) !important; color: var(--c-text) !important; font-family: var(--font-body) !important; }
h1,h2,h3,h4,h5,h6 { font-family: var(--font-head) !important; color: var(--c-white) !important; }
.accent-font { font-family: var(--font-display) !important; color: var(--c-gold) !important; }
.tlbps-nav { top: 0 !important; padding: 0 !important; height: var(--nav-h); background: transparent; border-bottom: 1px solid transparent; transition: background 0.4s ease, border-color 0.4s ease; }
.tlbps-nav.scrolled { background: rgba(7,8,15,0.92) !important; backdrop-filter: blur(24px); border-bottom-color: var(--c-border) !important; box-shadow: 0 4px 28px rgba(0,0,0,0.35); }
.nav-container { height: var(--nav-h); }
.logo-text { font-family: var(--font-head) !important; color: var(--c-gold) !important; font-size: 1.25rem !important; font-weight: 800 !important; letter-spacing: 0.08em !important; }
.logo-tagline { font-family: var(--font-body) !important; color: var(--c-text-muted) !important; font-size: 0.5rem !important; }
.logo-sub { font-family: var(--font-body) !important; font-size: 0.48rem !important; letter-spacing: 0.12em !important; text-transform: uppercase !important; color: var(--c-gold-dim) !important; display: block; margin-top: 2px; }
.hamburger-line { background: var(--c-gold) !important; }
.nav-link { font-family: var(--font-body) !important; color: rgba(255,255,255,0.65) !important; }
.nav-link:hover, .nav-link.active { color: var(--c-gold) !important; }
.nav-link::after { background: var(--g-gold) !important; }
.nav-cta { background: var(--c-gold-glow) !important; border: 1px solid var(--c-gold-border) !important; color: var(--c-gold) !important; border-radius: var(--radius-full) !important; }
@media (max-width: 1023px) {
  .nav-menu-bg, .nav-menu-bg::after { background: var(--c-bg) !important; opacity: 1 !important; }
  .nav-menu-inner { background: rgba(7,8,15,0.98) !important; }
}
@media (min-width: 1024px) {
  .nav-menu { background: transparent !important; }
  .nav-menu-bg, .nav-menu-bg::after { display: none !important; }
  .nav-menu-inner { background: transparent !important; padding: 0 !important; flex-direction: row !important; }
}
.glass-card { background: var(--c-surface) !important; border-color: var(--c-border) !important; backdrop-filter: blur(12px); }
.glass-card:hover { border-color: var(--c-gold-border) !important; box-shadow: 0 24px 60px rgba(0,0,0,0.45), 0 0 50px rgba(240,180,41,0.07) !important; }
.glass-card p, .glass-card h3 { color: var(--c-text-muted) !important; }
.glass-card h3 { color: var(--c-white) !important; }
.btn-primary { background: var(--g-gold) !important; color: #07080F !important; border-radius: var(--radius-sm) !important; font-family: var(--font-head) !important; }
.btn-secondary { background: transparent !important; color: var(--c-white) !important; border: 1px solid var(--c-border-2) !important; border-radius: var(--radius-sm) !important; padding: 16px 40px !important; font-family: var(--font-head) !important; font-weight: 600 !important; }
.btn-secondary:hover { border-color: var(--c-gold-border) !important; color: var(--c-gold) !important; background: var(--c-gold-glow) !important; }
.hero-overlay { background: linear-gradient(180deg, rgba(7,8,15,0.35) 0%, rgba(7,8,15,0.55) 50%, rgba(7,8,15,0.88) 100%) !important; }
.hero-content h1 { font-family: var(--font-display) !important; color: var(--c-white) !important; }
.hero-content p { color: var(--c-text-muted) !important; }
.section-label { color: var(--c-gold) !important; background: var(--c-gold-glow) !important; border: 1px solid var(--c-gold-border) !important; padding: 6px 16px !important; border-radius: var(--radius-full) !important; }
.section-label::before { background: var(--c-gold) !important; }
.stat-number { color: var(--c-gold-2) !important; font-family: var(--font-head) !important; }
.stat-label { color: var(--c-text-faint) !important; }
.luxury-quote blockquote { color: var(--c-text) !important; font-family: var(--font-display) !important; }
.luxury-quote cite { color: var(--c-gold) !important; }
.site-footer { background: #040609 !important; border-top: 1px solid var(--c-border) !important; padding: 80px 0 30px !important; }
.site-footer .footer-bg { display: none; }
.footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 48px; }
.footer-col h4, .footer-col-title { font-size: 10px; font-weight: 700; letter-spacing: 0.26em; text-transform: uppercase; color: var(--c-gold); margin-bottom: 22px; padding-bottom: 10px; border-bottom: 1px solid var(--c-gold-border); font-family: var(--font-body); }
.footer-col p, .footer-col ul li a { color: var(--c-text-faint) !important; font-size: 13px; }
.footer-links { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 11px; }
.footer-col ul li a:hover { color: var(--c-gold) !important; }
.footer-tagline-tlbps { font-family: var(--font-head); font-size: 17px; font-weight: 600; font-style: italic; color: var(--c-gold-2); margin: 14px 0; }
.footer-bottom { border-top: 1px solid var(--c-border); padding-top: 22px; text-align: center; color: var(--c-text-faint); font-size: 11px; }
.footer-bottom a { color: var(--c-gold) !important; }
.scroll-progress { background: var(--g-gold) !important; }
.page-loader { background: var(--c-bg) !important; }
.loader-logo { color: var(--c-gold) !important; font-family: var(--font-head) !important; }
.loader-bar { background: var(--g-gold) !important; }
.form-group input, .form-group select, .form-group textarea { background: rgba(255,255,255,0.05) !important; border-color: var(--c-border-2) !important; color: var(--c-white) !important; }
.form-group label { color: var(--c-text-muted) !important; }
.back-to-top { background: var(--g-gold) !important; color: #07080F !important; }
.cursor-glow { background: radial-gradient(circle, rgba(240,180,41,0.12) 0%, transparent 70%); }
.dropdown { background: var(--c-bg-3) !important; border: 1px solid var(--c-border) !important; }
.dropdown a { color: var(--c-text-muted) !important; }
.dropdown a:hover { color: var(--c-gold) !important; }
@media (max-width: 1080px) { .footer-grid { grid-template-columns: 1fr 1fr; } }
@media (max-width: 768px) {
  :root { --nav-h: 64px; --section-py: 64px; }
  .footer-grid { grid-template-columns: 1fr; }
  body { padding-top: var(--nav-h); }
}
'@

$orig = Get-Content "$dir\_orig-style.css" -Raw
$orig = $orig -replace '(?s)/\* ---------- CSS CUSTOM PROPERTIES ---------- \*/\s*:root\s*\{[^}]+\}', ''
$css = '/* TLBPS site - styled with TLBISBIG tokens */' + "`n" + $tokens + "`n" + $orig + $overrides
Set-Content "$dir\tlbps.css" $css -Encoding UTF8

$nav = @'
<nav class="tlbps-nav" id="mainNav">
  <div class="nav-container">
    <a href="index.html" class="nav-logo">
      <span class="logo-text">TLBPS</span>
      <span class="logo-tagline">Infratech Developers</span>
      <span class="logo-sub">A TLBISBIG Company</span>
    </a>
    <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation menu">
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
    </button>
    <div class="nav-menu" id="navMenu">
      <div class="nav-menu-inner">
        <div class="nav-menu-bg"></div>
        <ul class="nav-links">
          <li><a href="index.html" class="nav-link">Home</a></li>
          <li class="has-dropdown">
            <a href="about.html" class="nav-link">About Us</a>
            <ul class="dropdown">
              <li><a href="about.html">Our Story</a></li>
              <li><a href="leadership.html">Leadership</a></li>
            </ul>
          </li>
          <li><a href="projects.html" class="nav-link">Projects</a></li>
          <li><a href="advisory.html" class="nav-link">Advisory</a></li>
          <li><a href="sustainability.html" class="nav-link">Sustainability</a></li>
          <li><a href="funding.html" class="nav-link">Funding Relations</a></li>
          <li><a href="media.html" class="nav-link">Media</a></li>
          <li><a href="careers.html" class="nav-link">Careers</a></li>
          <li><a href="insights.html" class="nav-link">Insights</a></li>
          <li><a href="contact.html" class="nav-link nav-cta">Connect With Us</a></li>
        </ul>
        <div class="nav-mobile-footer">
          <p class="nav-mobile-tagline">Transforming Spaces. Enriching Lives.</p>
          <div class="nav-mobile-contact"><a href="mailto:info@tlbps.com">info@tlbps.com</a></div>
        </div>
      </div>
    </div>
  </div>
</nav>
'@
Set-Content "$dir\nav.html" $nav -Encoding UTF8

$footer = @'
  <footer class="site-footer footer">
    <div class="container">
      <div class="footer-grid">
        <div class="footer-col footer-brand">
          <h4 class="footer-col-title">TLBPS</h4>
          <p>Infratech Developers Pvt. Ltd.</p>
          <p class="footer-tagline-tlbps">Transforming Spaces. Enriching Lives. Building Sustainably.</p>
          <p style="margin-top:12px;font-size:13px;color:var(--c-text-faint);">Central and South India - Mysore | Bangalore | Indore</p>
        </div>
        <div class="footer-col">
          <h4 class="footer-col-title">Explore</h4>
          <ul class="footer-links">
            <li><a href="about.html">About Us</a></li>
            <li><a href="projects.html">Projects</a></li>
            <li><a href="advisory.html">Advisory</a></li>
            <li><a href="sustainability.html">Sustainability</a></li>
            <li><a href="leadership.html">Leadership</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-col-title">Engage</h4>
          <ul class="footer-links">
            <li><a href="funding.html">Funding Relations &amp; Financing Support for Construction and Building Projects</a></li>
            <li><a href="media.html">Media</a></li>
            <li><a href="careers.html">Careers</a></li>
            <li><a href="insights.html">Insights</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-col-title">Connect</h4>
          <p>For partnership inquiries and investment discussions, we welcome your correspondence.</p>
          <p style="margin-top:10px;"><a href="contact.html">Business Enquiry &rarr;</a></p>
          <p style="margin-top:5px;"><a href="mailto:info@tlbps.com">info@tlbps.com</a></p>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 TLBPS Infratech Developers Pvt. Ltd. All rights reserved. | <a href="#">Privacy Policy</a> | <a href="#">Terms</a></p>
      </div>
    </div>
  </footer>
'@

$pages = @{
  'index' = 'index.html'
  'about' = 'about.html'
  'projects' = 'projects.html'
  'advisory' = 'advisory.html'
  'sustainability' = 'sustainability.html'
  'funding' = 'funding.html'
  'leadership' = 'leadership.html'
  'media' = 'media.html'
  'careers' = 'careers.html'
  'insights' = 'insights.html'
  'contact' = 'contact.html'
}

foreach ($key in $pages.Keys) {
  $src = "$dir\_source-$key.html"
  $out = "$dir\$($pages[$key])"
  if (-not (Test-Path $src)) { Write-Warning "Missing $src"; continue }
  $html = Get-Content $src -Raw -Encoding UTF8

  $html = $html -replace '<link rel="stylesheet" href="css/style\.css">', '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"><link rel="stylesheet" href="tlbps.css">'
  $html = $html -replace 'family=Playfair\+Display[^"]+', 'family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400;1,600&amp;family=Inter:wght@300;400;500;600;700&amp;family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700'
  $html = $html -replace 'poster="images/', "poster=`"$imgBase"

  $html = $html -replace 'src="images/', "src=`"$imgBase"
  $html = $html -replace "url\('images/", "url('$imgBase"
  $html = $html -replace 'content="images/', "content=`"$imgBase"

  $html = $html -replace 'rgba\(255,\s*248,\s*240,\s*[^)]+\)', 'rgba(7,8,15,0.82)'
  $html = $html -replace 'background:\s*var\(--cream\)', 'background: var(--c-bg-2)'
  $html = $html -replace 'background:\s*var\(--warm-white\)', 'background: var(--c-bg)'
  $html = $html -replace 'background:\s*linear-gradient\(180deg,\s*var\(--cream\)[^;]+\)', 'background: var(--c-bg-2)'
  $html = $html -replace 'background:\s*background:\s*', 'background: '
  $html = $html -replace 'var\(--text-secondary\)', 'var(--c-text)'
  $html = $html -replace 'style="color:var\(--gold\)', 'style="color:var(--c-gold)'
  $html = $html -replace 'color:var\(--gold\)', 'color:var(--c-gold)'
  $html = $html -replace 'color:var\(--text-secondary\)', 'color:var(--c-text-muted)'

  $html = $html -replace '(?s)\s*<div class="parent-brand-bar">.*?</div>\s*', "`n"
  $html = $html -replace '<div id="nav-placeholder"></div>', $nav
  $html = $html -replace '(?s)<!-- Navigation Placeholder -->\s*', ''

  $html = $html -replace '(?s)<!-- ===== FOOTER ===== -->.*?</footer>', $footer.Trim()
  $html = $html -replace '(?s)<!-- Footer -->.*?</footer>', $footer.Trim()
  $html = $html -replace '(?s)<footer class="site-footer">.*?</footer>', $footer.Trim()

  Set-Content $out $html -Encoding UTF8 -NoNewline
  Write-Host "Built $out"
}

Write-Host "Done. Open index.html in tlbps.warnerklein.com"
