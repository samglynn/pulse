# Pulse — Restaurant Intelligence Platform
### by Water Street Advisors

A lightweight, single-file restaurant operations intelligence platform. Tracks health scores, coaching metrics, staffing, and weekly trends across multiple locations — powered by Supabase for persistent, multi-device data storage.

---

## Quick Start

### 1. Fork or clone this repo
```bash
git clone https://github.com/YOUR_USERNAME/pulse.git
cd pulse
```

### 2. Connect your Supabase project

Open `config.js` and paste your Supabase credentials:
```js
const SUPABASE_URL  = 'https://your-project.supabase.co';
const SUPABASE_ANON = 'your-anon-key';
```

Find these at: **supabase.com → your project → Settings → API**

### 3. Run the Supabase schema

In your Supabase dashboard, go to **SQL Editor** and run the contents of `schema.sql`. This creates the 3 tables the app needs.

### 4. Enable GitHub Pages

Go to your repo → **Settings → Pages → Source: main branch / root folder**

Your app will be live at: `https://YOUR_USERNAME.github.io/pulse`

---

## File Structure

```
pulse/
├── index.html        ← The entire app (open this in a browser)
├── config.js         ← Your Supabase credentials (edit this)
├── schema.sql        ← Run once in Supabase SQL Editor
├── README.md         ← This file
└── .gitignore        ← Keeps secrets out of git
```

---

## Supabase Tables

| Table | Purpose |
|-------|---------|
| `profiles` | Operator info, restaurant name, locations |
| `locations` | Per-location KPI targets |
| `weeks` | Weekly metric snapshots (the main data) |

Row Level Security is enabled — each operator only sees their own data.

---

## Adding a New Operator (Client Onboarding)

1. They go to your GitHub Pages URL
2. Click **Create Account** → enter email + password
3. Enter their restaurant name and location targets
4. Upload their first Toast CSV export
5. Done — their data is in Supabase, accessible on any device

---

## Toast CSV Format

Download the template from inside the app, or use this column order:

```
date, location, net_sales, guests, ppa, labor_pct, labor_hrs, splh, gplh, 
starter_attach, drink_attach, dessert_attach, food_cost, schedule_variance
```

---

## Stack

- **Frontend**: Vanilla HTML/CSS/JS — no build step, no Node, no frameworks
- **Database**: Supabase (Postgres with Row Level Security)
- **Auth**: Supabase Auth (email/password)
- **Hosting**: GitHub Pages (free)
- **Dependencies**: Supabase JS client (loaded via CDN)

---

## WSA Admin Access

Sam's account gets admin-level access — can view all operators' data for benchmarking and coaching.

To make an account an admin: in Supabase → Table Editor → `profiles` → set `is_admin = true` for that row.

---

*Built by Water Street Advisors · hirewaterstreet.com*
