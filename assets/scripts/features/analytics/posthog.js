import * as params from '@params';

const analyticsParams = params;
const posthogConfig = analyticsParams.analytics.posthog;

// Check if we are running locally
const isLocalhost = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';

// Resolve the host URL
let host = posthogConfig.host;
if (host.startsWith('/') && isLocalhost) {
  host = 'https://eu.i.posthog.com';
} else if (host.startsWith('/')) {
  host = window.location.origin + host;
}

const apiKey = posthogConfig.apiKey || posthogConfig.apikey;

// Official PostHog snippet (modified for our dynamic config)
!function(t,e){var o,n,p,r;e.__SV||(window.posthog=e,e._i=[],e.init=function(i,s,a){function g(t,e){var o=e.split(".");2==o.length&&(t=t[o[0]],e=o[1]),t[e]=function(){t.push([e].concat(Array.prototype.slice.call(arguments,0)))}}(p=t.createElement("script")).type="text/javascript",p.async=!0,p.src=s.api_host+"/static/array.js",(r=t.getElementsByTagName("script")[0]).parentNode.insertBefore(p,r);var u=e;for(void 0!==a?u=e[a]=[]:a="posthog",u.people=u.people||[],u.toString=function(t){var e="posthog";return"posthog"!==a&&(e+="."+a),t||(e+=" (stub)"),e},u.people.toString=function(){return u.toString(1)+".people (stub)"},o="capture identify alias people.set people.set_once set_config register register_once unregister opt_out_capturing has_opted_out_capturing opt_in_capturing set_user_props get_distinct_id getGroups get_session_id get_session_replay_url alias set_group_properties group reset add_event_handler load_toolbar get_property get_bit_flag is_feature_enabled reload_feature_flags update_early_access_feature_enrollment get_early_access_features onFeatureFlags onSessionId get_surveys get_active_feature_flags".split(" "),n=0;n<o.length;n++)g(u,o[n]);e._i.push([i,s,a])},e.__SV=1)}(document,window.posthog||[]);

window.posthog.init(apiKey, {
  api_host: host,
  ui_host: 'https://eu.posthog.com',
  ...posthogConfig.options
});
