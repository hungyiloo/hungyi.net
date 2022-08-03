// Remember theme inversion
document.querySelector('#inverter').addEventListener(
  'change',
  e => localStorage.setItem('themeInverted', String(e.target.checked))
)

// Google analytics
// window.dataLayer = window.dataLayer || [];
// function gtag() { dataLayer.push(arguments); }
// gtag('js', new Date());
// gtag('config', 'UA-180663322-1');
