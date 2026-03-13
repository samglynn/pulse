// ═══════════════════════════════════════════════════════════
// PULSE — Configuration
// Edit this file with your Supabase credentials
// ═══════════════════════════════════════════════════════════

const PULSE_CONFIG = {
  // Get these from: supabase.com → your project → Settings → API
  supabaseUrl:  'YOUR_SUPABASE_URL',
  supabaseAnon: 'YOUR_SUPABASE_ANON_KEY',

  // Branding
  appName:    'Pulse',
  brandLine:  'by Water Street Advisors',
  brandUrl:   'https://hirewaterstreet.com',

  // Default targets (used before per-location targets are loaded)
  defaultTargets: {
    labor_pct:      26,
    splh:           55,
    ppa:            30,
    starter_attach: 40,
    drink_attach:   85,
    dessert_attach: 20,
    food_cost:      28,
    gplh:           2.2
  }
};
