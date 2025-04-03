// Select the theme toggle button
const themeToggleBtn = document.getElementById('themeToggleBtn');

// Function to apply the theme
function applyTheme(theme) {
    document.body.className = theme; // Set the theme class on the body
    themeToggleBtn.textContent = theme === 'dark-theme' ? 'Light' : 'Dark'; // Update button text
    localStorage.setItem('theme', theme); // Save the theme in localStorage
}

// Event listener for the theme toggle button
themeToggleBtn.addEventListener('click', () => {
    const currentTheme = document.body.className;
    const newTheme = currentTheme === 'dark-theme' ? 'light-theme' : 'dark-theme';
    applyTheme(newTheme);
});

// Apply the saved theme on page load
const savedTheme = localStorage.getItem('theme') || 'dark-theme'; // Default to dark theme
applyTheme(savedTheme);

// Footer loading logic
document.addEventListener("DOMContentLoaded", function () {
    // Path to footer.html (always in the same directory)
    const footerPath = "footer.html";

    // Fetch and insert the footer
    fetch(footerPath)
        .then(response => response.text())
        .then(data => {
            const footerPlaceholder = document.getElementById("footer-placeholder");
            if (footerPlaceholder) {
                footerPlaceholder.innerHTML = data;
            }
        })
        .catch(error => console.error("Error loading footer:", error));
});
