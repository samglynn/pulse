-- ═══════════════════════════════════════════════════════════
-- PULSE — Supabase Schema
-- Run this once in your Supabase SQL Editor
-- supabase.com → your project → SQL Editor → New Query
-- ═══════════════════════════════════════════════════════════

-- ─── PROFILES ────────────────────────────────────────────────
-- One row per operator (restaurant owner / client)
create table if not exists profiles (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid references auth.users(id) on delete cascade not null unique,
  restaurant_name text,
  owner_name    text,
  email         text,
  is_admin      boolean default false,
  created_at    timestamptz default now()
);

alter table profiles enable row level security;

create policy "Users can view their own profile"
  on profiles for select using (auth.uid() = user_id);

create policy "Users can insert their own profile"
  on profiles for insert with check (auth.uid() = user_id);

create policy "Users can update their own profile"
  on profiles for update using (auth.uid() = user_id);

-- Admins can see all profiles
create policy "Admins can view all profiles"
  on profiles for select using (
    exists (select 1 from profiles where user_id = auth.uid() and is_admin = true)
  );

-- ─── LOCATIONS ───────────────────────────────────────────────
-- Per-location KPI targets (one row per location per operator)
create table if not exists locations (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid references auth.users(id) on delete cascade not null,
  name            text not null,           -- e.g. "Warren", "Providence"
  slug            text not null,           -- e.g. "warren", "providence"
  -- Targets
  target_labor_pct      numeric(5,2) default 26,
  target_splh           numeric(7,2) default 55,
  target_ppa            numeric(7,2) default 30,
  target_starter_attach numeric(5,2) default 40,
  target_drink_attach   numeric(5,2) default 85,
  target_dessert_attach numeric(5,2) default 20,
  target_food_cost      numeric(5,2) default 28,
  target_gplh           numeric(5,2) default 2.2,
  created_at      timestamptz default now(),
  unique(user_id, slug)
);

alter table locations enable row level security;

create policy "Users manage their own locations"
  on locations for all using (auth.uid() = user_id);

create policy "Admins can view all locations"
  on locations for select using (
    exists (select 1 from profiles where user_id = auth.uid() and is_admin = true)
  );

-- ─── WEEKS ───────────────────────────────────────────────────
-- Weekly KPI snapshots — the core data table
create table if not exists weeks (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid references auth.users(id) on delete cascade not null,
  date              date not null,
  location          text not null,
  -- Revenue
  net_sales         numeric(10,2),
  guests            integer,
  ppa               numeric(7,2),
  -- Labor
  labor_pct         numeric(5,2),
  labor_hrs         numeric(7,2),
  splh              numeric(7,2),
  gplh              numeric(5,2),
  schedule_variance numeric(5,1),
  -- Attach Rates (stored as whole numbers, e.g. 32 = 32%)
  starter_attach    numeric(5,2),
  drink_attach      numeric(5,2),
  dessert_attach    numeric(5,2),
  -- Cost
  food_cost         numeric(5,2),
  -- Computed health score (cached for trend charts)
  health_score      integer,
  -- Meta
  notes             text,
  created_at        timestamptz default now(),
  unique(user_id, date, location)
);

alter table weeks enable row level security;

create policy "Users manage their own weeks"
  on weeks for all using (auth.uid() = user_id);

create policy "Admins can view all weeks"
  on weeks for select using (
    exists (select 1 from profiles where user_id = auth.uid() and is_admin = true)
  );

-- ─── INDEXES ─────────────────────────────────────────────────
create index if not exists weeks_user_date on weeks(user_id, date desc);
create index if not exists weeks_user_location on weeks(user_id, location);

-- ─── SEED: Chomp locations (for Sam's account) ───────────────
-- Run this AFTER you create Sam's account in the app,
-- then replace 'YOUR_USER_ID' with Sam's actual user_id
-- (find it in Supabase → Authentication → Users)

-- insert into profiles (user_id, restaurant_name, owner_name, email, is_admin)
-- values ('YOUR_USER_ID', 'Chomp Kitchen & Drinks', 'Sam Glynn', 'sam@hirewaterstreet.com', true);

-- insert into locations (user_id, name, slug, target_labor_pct, target_splh, target_ppa, target_starter_attach, target_drink_attach, target_dessert_attach, target_food_cost)
-- values
--   ('YOUR_USER_ID', 'Warren',     'warren',     22, 70, 35, 35, 80, 18, 28),
--   ('YOUR_USER_ID', 'Providence', 'providence', 26, 55, 30, 40, 85, 20, 27),
--   ('YOUR_USER_ID', 'Newport',    'newport',    26, 55, 29, 40, 85, 20, 27);
