import * as params from '@params';

const posthogConfig = params.analytics.posthog;

// Check if we are running locally
const isLocalhost = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';

// Resolve the host URL
// If host is a relative path (proxy) and we are on localhost, fallback to official PostHog URL
let host = posthogConfig.host;
if (host.startsWith('/') && isLocalhost) {
  host = 'https://eu.i.posthog.com';
} else if (host.startsWith('/')) {
  host = window.location.origin + host;
}

const scriptSrc = host + '/static/array.js';

// Load PostHog script
const script = document.createElement('script');
script.type = 'text/javascript';
script.async = true;
script.src = scriptSrc;

script.onload = function() {
  if (window.posthog) {
    const apiKey = posthogConfig.apiKey || posthogConfig.apikey;
    window.posthog.init(apiKey, {
      api_host: host,
      ui_host: 'https://eu.posthog.com',
      ...posthogConfig.options
    });
  }
};

document.head.appendChild(script);
