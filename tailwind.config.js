/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./layouts/**/*.html",
    "./content/**/*.md",
    "./content/**/*.html",
    "./themes/careercanvas/layouts/**/*.html",
    "./themes/careercanvas/assets/js/**/*.js",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // Semantic variables handled via CSS
        primary: 'var(--color-primary)',
        second: 'var(--color-second)',
        third: 'var(--color-third)',
        bg: 'var(--color-bg)',
      },
    },
  },
  plugins: [],
}
