// ═══════════════════════════════════════════════════════════
// PULSE — Configuration
// Edit this file with your Supabase credentials
// ═══════════════════════════════════════════════════════════

const PULSE_CONFIG = {
  // Get these from: supabase.com → your project → Settings → API
  supabaseUrl:  'https://wogtyrgckqoopzoziwbr.supabase.co',
  supabaseAnon: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZ3R5cmdja3Fvb3B6b3ppd2JyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM0MTAxNTgsImV4cCI6MjA4ODk4NjE1OH0.9VQHHo9NX7Jf3cUpnljsXBI0jBQxjVzjPuqfQ8vGczI',

  // Branding
  appName:    'RestOS',
  brandLine:  'by Water Street Advisors',
  brandUrl:   'https://hirewaterstreet.com',

  // Default targets (used before per-location targets are loaded)
  defaultTargets: {
    labor_pct:      28,
    splh:           55,
    ppa:            30,
    starter_attach: 40,
    drink_attach:   85,
    beer_attach:    75,
    food_cost:      28,
    gplh:           2.2
  }
};
