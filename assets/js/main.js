document.addEventListener('DOMContentLoaded', () => {
    
// Smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    window.addEventListener("scroll", function () {
        const navbar = document.querySelector(".navbar");

        if (window.scrollY > 50) {
            navbar.classList.add("scrolled");
        } else {
            navbar.classList.remove("scrolled");
        }
    });

    // Intersection Observer for animations
    const sections = document.querySelectorAll('.section');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate');
            }
        });

    }, { threshold: 0.1 });
    sections.forEach(section => observer.observe(section));

document.addEventListener('DOMContentLoaded', () => {
    const protectedLinks = document.querySelectorAll('.video-link, .personal-equipment');

    protectedLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            const isLoggedIn = sessionStorage.getItem('isLoggedIn');
            
            if (isLoggedIn !== 'true') {
                e.preventDefault();
                showNotification("Access Denied: Please log in to view tutorials.", true);
            }
            // If logged in, the default anchor behavior will open the link
        });
    });
});

    // Handle Download Button Click
    const downloadBtn = document.querySelector('.download-btn');
    if (downloadBtn) {
        downloadBtn.addEventListener('click', function(event) {
            event.preventDefault();

            // 1. Check Portal Status (Session Storage)
            const isLoggedIn = sessionStorage.getItem('isLoggedIn');

            if (isLoggedIn !== 'true') {
                // SCENARIO: Guest trying to download
                showNotification("Please login first before you can access this!", true);
                
                // Auto-redirect to login after a brief delay
                setTimeout(() => {
                    window.location.href = "assets/portfolio/profile-login.html";
                }, 2500);
                
            } else {
                // SCENARIO: Logged in user trying to download
                // We notify them that the app is still in development
                showNotification("App is not released yet. Please wait for the update.", true);
            }
        });
    }

    // Ensure notification ONLY runs when called, not on script load
    function showNotification(message, isError = false) {
    let container = document.getElementById('notification-container');
    
    if (!container) {
        container = document.createElement('div');
        container.id = 'notification-container';
        container.className = 'notification-container';
        document.body.appendChild(container);
    }

    // Clear container to prevent old notifications from stacking on refresh
    container.innerHTML = ''; 

    const toast = document.createElement('div');
    toast.className = `toast ${isError ? 'error' : ''}`;
    
    const icon = message.includes("not released") ? "fa-hourglass-half" : "fa-lock";
    
    toast.innerHTML = `
        <i class="fas ${icon}"></i>
        <span>${message}</span>
    `;
    
    container.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 500);
    }, 3000);
}

    // Particle animation
    function createParticles() {
        const particlesContainer = document.getElementById('particles');
        for (let i = 0; i < 50; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 10 + 's';
            particle.style.width = Math.random() * 5 + 2 + 'px';
            particle.style.height = particle.style.width;
            particlesContainer.appendChild(particle);
        }
    }
    createParticles();
});