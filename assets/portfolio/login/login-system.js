// --- Helper Function for Notifications ---
function showNotification(message, isError = false) {
    const container = document.getElementById('notification-container');
    const toast = document.createElement('div');
    toast.className = `toast ${isError ? 'error' : ''}`;
    toast.innerHTML = `
        <i class="fas ${isError ? 'fa-exclamation-circle' : 'fa-check-circle'}"></i>
        <span>${message}</span>
    `;
    
    container.appendChild(toast);

    // Remove notification after 3 seconds
    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 500);
    }, 3000);
}

// --- PORTAL CHECK: Run immediately on load ---
(function checkPortal() {
    const isLoggedIn = sessionStorage.getItem('isLoggedIn');
    // If user is already logged in, send them to the main webpage automatically
    if (isLoggedIn === 'true') {
        window.location.href = "../../index.html"; 
    }
})();

document.addEventListener('DOMContentLoaded', () => {

    // --- REGISTRATION SYSTEM ---
    const registerForm = document.getElementById('register-form');
    if (registerForm) {
        registerForm.addEventListener('submit', (e) => {
            e.preventDefault();

            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            const email = document.getElementById('email').value.trim();

            // Constraint: Letters only (No numbers/symbols), Max 12
            const lettersOnlyRegex = /^[A-Za-z]+$/;

            if (password.length > 12) {
                showNotification("Password too long! Max 12 characters.", true);
                return;
            }

            if (!lettersOnlyRegex.test(password)) {
                showNotification("Letters only! No numbers or symbols allowed.", true);
                return;
            }

            if (localStorage.getItem(username)) {
                showNotification("Username already exists!", true);
                return;
            }

            // Save User
            const userData = { username, password, email };
            localStorage.setItem(username, JSON.stringify(userData));

            showNotification("Account Created! Redirecting to Login...");

            // Automatic Redirect after 2 seconds
            setTimeout(() => {
                window.location.href = "../portfolio/profile-login.html";
            }, 2000);
        });
    }

    // --- LOGIN SYSTEM ---
    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            e.preventDefault();

            const usernameInput = document.getElementById('username').value.trim();
            const passwordInput = document.getElementById('password').value;

            const storedData = localStorage.getItem(usernameInput);

            if (storedData) {
                const user = JSON.parse(storedData);

                // Check if password matches
                if (user.password === passwordInput) {
                    showNotification("Login Successful! Welcome back.");
                    sessionStorage.setItem('isLoggedIn', 'true');
                    
                    // Redirect to Home/Dashboard
                    setTimeout(() => {
                        window.location.href = "../../main.html";
                    }, 1500);
                } else {
                    // INVALID PASSWORD NOTIFICATION
                    showNotification("Invalid password! Please try again.", true);
                }
            } else {
                // INVALID USERNAME NOTIFICATION
                showNotification("User not found! Please check your username.", true);
            }
        });
    }
});