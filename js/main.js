/* ============================================
   TLBPS INFRATECH DEVELOPERS - MAIN JAVASCRIPT
   Navigation, Animations, Parallax, Interactions
   ============================================ */

document.addEventListener('DOMContentLoaded', function() {

  // ---------- NAVIGATION ----------
  const navPlaceholder = document.getElementById('nav-placeholder');
  if (document.getElementById('mainNav')) {
    initNavigation();
    highlightCurrentPage();
  } else if (navPlaceholder) {
    fetch('nav.html')
      .then(r => r.text())
      .then(html => {
        navPlaceholder.innerHTML = html;
        initNavigation();
        highlightCurrentPage();
      })
      .catch(() => {
        fetch('../nav.html')
          .then(r => r.text())
          .then(html => {
            navPlaceholder.innerHTML = html;
            initNavigation();
            highlightCurrentPage();
          });
      });
  }

  // ---------- PAGE LOADER ----------
  const loader = document.querySelector('.page-loader');
  if (loader) {
    window.addEventListener('load', function() {
      setTimeout(() => loader.classList.add('loaded'), 600);
    });
    // Fallback
    setTimeout(() => loader.classList.add('loaded'), 3000);
  }

  // ---------- SCROLL PROGRESS BAR ----------
  const progressBar = document.querySelector('.scroll-progress');
  if (progressBar) {
    window.addEventListener('scroll', function() {
      const scrollTop = window.scrollY;
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      const progress = (scrollTop / docHeight) * 100;
      progressBar.style.width = progress + '%';
    });
  }

  // ---------- BACK TO TOP ----------
  const backToTop = document.querySelector('.back-to-top');
  if (backToTop) {
    window.addEventListener('scroll', function() {
      if (window.scrollY > 500) {
        backToTop.classList.add('visible');
      } else {
        backToTop.classList.remove('visible');
      }
    });
    backToTop.addEventListener('click', function() {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ---------- SCROLL REVEAL ANIMATIONS ----------
  initScrollReveal();

  // ---------- PARALLAX EFFECT ----------
  initParallax();

  // ---------- IMAGE DISSOLVE SCROLLER ----------
  initImageScrollers();

  // ---------- CURSOR GLOW ----------
  initCursorGlow();

  // ---------- COUNTER ANIMATION ----------
  initCounters();

  // ---------- FORM INTERACTIONS ----------
  initForms();
});

// ===== NAVIGATION =====
function initNavigation() {
  const toggle = document.getElementById('navToggle');
  const menu = document.getElementById('navMenu');
  const nav = document.getElementById('mainNav');
  
  if (!toggle || !menu) return;

  // Toggle mobile menu
  toggle.addEventListener('click', function(e) {
    e.stopPropagation();
    toggle.classList.toggle('active');
    menu.classList.toggle('active');
    document.body.style.overflow = menu.classList.contains('active') ? 'hidden' : '';
  });

  // Close menu on link click
  menu.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', function() {
      toggle.classList.remove('active');
      menu.classList.remove('active');
      document.body.style.overflow = '';
    });
  });

  // Close on outside click
  document.addEventListener('click', function(e) {
    if (menu.classList.contains('active') && !menu.contains(e.target) && !toggle.contains(e.target)) {
      toggle.classList.remove('active');
      menu.classList.remove('active');
      document.body.style.overflow = '';
    }
  });

  // Dropdown toggle for mobile
  document.querySelectorAll('.has-dropdown').forEach(item => {
    const mainLink = item.querySelector('.nav-link');
    if (mainLink) {
      mainLink.addEventListener('click', function(e) {
        if (window.innerWidth < 1024) {
          if (!item.classList.contains('open')) {
            e.preventDefault();
            // Close other dropdowns
            document.querySelectorAll('.has-dropdown.open').forEach(d => {
              if (d !== item) d.classList.remove('open');
            });
            item.classList.toggle('open');
          }
          // Second tap navigates normally
        }
      });
    }
    // Close menu when clicking dropdown sub-links
    item.querySelectorAll('.dropdown a').forEach(subLink => {
      subLink.addEventListener('click', function() {
        toggle.classList.remove('active');
        menu.classList.remove('active');
        document.body.style.overflow = '';
      });
    });
  });

  // Nav scroll effect
  if (nav) {
    window.addEventListener('scroll', function() {
      if (window.scrollY > 80) {
        nav.classList.add('scrolled');
      } else {
        nav.classList.remove('scrolled');
      }
    });
  }
}

function highlightCurrentPage() {
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-link').forEach(link => {
    const href = link.getAttribute('href');
    if (href === currentPage || (currentPage === '' && href === 'index.html')) {
      link.classList.add('active');
    }
  });
}

// ===== SCROLL REVEAL =====
function initScrollReveal() {
  const revealElements = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale, .stagger-children');
  
  if (!revealElements.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  });

  revealElements.forEach(el => observer.observe(el));
}

// ===== PARALLAX =====
function initParallax() {
  const parallaxElements = document.querySelectorAll('.parallax-bg img');
  
  if (!parallaxElements.length || window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  // Only on desktop
  if (window.innerWidth < 768) return;

  window.addEventListener('scroll', function() {
    requestAnimationFrame(() => {
      parallaxElements.forEach(el => {
        const section = el.closest('.parallax-section');
        if (!section) return;
        const rect = section.getBoundingClientRect();
        const speed = 0.3;
        const yPos = rect.top * speed;
        el.style.transform = `translateY(${yPos}px)`;
      });
    });
  });
}

// ===== IMAGE DISSOLVE SCROLLER =====
function initImageScrollers() {
  document.querySelectorAll('.image-scroller').forEach(scroller => {
    const slides = scroller.querySelectorAll('.slide');
    const dots = scroller.querySelectorAll('.scroller-dot');
    if (slides.length < 2) return;

    const isHero = scroller.classList.contains('hero-slideshow');
    const autoInterval = parseInt(scroller.getAttribute('data-interval')) || (isHero ? 6500 : 4000);

    // For hero: external dots (.hero-dots) sit outside hero-media so they clear the overlay
    const heroSection = isHero ? scroller.closest('.hero') : null;
    const externalDots = heroSection ? heroSection.querySelectorAll('.hero-dots .scroller-dot') : [];
    const captions = heroSection ? heroSection.querySelectorAll('.hero-slide-caption span') : [];

    let current = 0;
    let interval;

    function showSlide(index) {
      slides.forEach(s => {
        s.classList.remove('active');
        // Reset Ken Burns so animation replays cleanly on each slide
        if (isHero) {
          const img = s.querySelector('img');
          if (img) { img.style.animation = 'none'; img.offsetHeight; img.style.animation = ''; }
        }
      });
      dots.forEach(d => d.classList.remove('active'));
      externalDots.forEach(d => d.classList.remove('active'));
      captions.forEach(c => c.classList.remove('active'));

      slides[index].classList.add('active');
      if (dots[index]) dots[index].classList.add('active');
      if (externalDots[index]) externalDots[index].classList.add('active');
      if (captions[index]) captions[index].classList.add('active');
      current = index;
    }

    function nextSlide() {
      showSlide((current + 1) % slides.length);
    }

    function startAutoplay() {
      interval = setInterval(nextSlide, autoInterval);
    }

    dots.forEach((dot, i) => {
      dot.addEventListener('click', () => {
        clearInterval(interval);
        showSlide(i);
        startAutoplay();
      });
    });
    // External (hero) dots also control slides
    externalDots.forEach((dot, i) => {
      dot.addEventListener('click', () => {
        clearInterval(interval);
        showSlide(i);
        startAutoplay();
      });
    });

    // Touch/swipe support
    let touchStartX = 0;
    scroller.addEventListener('touchstart', e => {
      touchStartX = e.touches[0].clientX;
    }, { passive: true });

    scroller.addEventListener('touchend', e => {
      const diff = touchStartX - e.changedTouches[0].clientX;
      if (Math.abs(diff) > 50) {
        clearInterval(interval);
        if (diff > 0) {
          showSlide((current + 1) % slides.length);
        } else {
          showSlide((current - 1 + slides.length) % slides.length);
        }
        startAutoplay();
      }
    }, { passive: true });

    showSlide(0);
    startAutoplay();
  });
}

// ===== CURSOR GLOW =====
function initCursorGlow() {
  const glow = document.querySelector('.cursor-glow');
  if (!glow || window.innerWidth < 1024) return;

  document.addEventListener('mousemove', function(e) {
    requestAnimationFrame(() => {
      glow.style.left = e.clientX + 'px';
      glow.style.top = e.clientY + 'px';
    });
  });
}

// ===== COUNTER ANIMATION =====
function initCounters() {
  const counters = document.querySelectorAll('[data-count]');
  if (!counters.length) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const el = entry.target;
        const target = parseInt(el.getAttribute('data-count'));
        const suffix = el.getAttribute('data-suffix') || '';
        const prefix = el.getAttribute('data-prefix') || '';
        const duration = 2000;
        const start = 0;
        const startTime = performance.now();

        function animate(currentTime) {
          const elapsed = currentTime - startTime;
          const progress = Math.min(elapsed / duration, 1);
          // Ease out cubic
          const eased = 1 - Math.pow(1 - progress, 3);
          const current = Math.floor(start + (target - start) * eased);
          el.textContent = prefix + current.toLocaleString() + suffix;
          if (progress < 1) {
            requestAnimationFrame(animate);
          }
        }

        requestAnimationFrame(animate);
        observer.unobserve(el);
      }
    });
  }, { threshold: 0.5 });

  counters.forEach(c => observer.observe(c));
}

// ===== FORMS =====
function initForms() {
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      const btn = form.querySelector('button[type="submit"]');
      const originalText = btn ? btn.textContent : '';
      
      if (btn) {
        btn.textContent = 'Submitting...';
        btn.disabled = true;
      }

      // Simulate submission
      setTimeout(() => {
        if (btn) {
          btn.textContent = 'Thank You!';
          btn.style.background = 'linear-gradient(135deg, #2E8B57, #3CB371)';
        }
        
        // Show success message
        const msg = document.createElement('div');
        msg.className = 'form-success';
        msg.innerHTML = '<p style="color: var(--emerald); font-family: var(--font-accent); font-size: 1.1rem; text-align: center; padding: 20px;">Thank you for your interest. Our team will connect with you shortly.</p>';
        form.appendChild(msg);

        setTimeout(() => {
          form.reset();
          if (btn) {
            btn.textContent = originalText;
            btn.disabled = false;
            btn.style.background = '';
          }
          if (msg) msg.remove();
        }, 4000);
      }, 1500);
    });
  });
}

// ===== SMOOTH SCROLL FOR ANCHOR LINKS =====
document.addEventListener('click', function(e) {
  const anchor = e.target.closest('a[href^="#"]');
  if (anchor) {
    const target = document.querySelector(anchor.getAttribute('href'));
    if (target) {
      e.preventDefault();
      const offset = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--nav-h')) || 76;
      const top = target.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top, behavior: 'smooth' });
    }
  }
});
