-- Desk Journal: run this once in Supabase (SQL Editor -> New query -> paste -> Run).
-- It creates one table that holds every row of the app (trades, journal notes,
-- macro readings, geopolitics events) and locks it so each signed-in person can
-- only read and change their own rows.

create table if not exists public.docs (
  user_id    uuid        not null default auth.uid() references auth.users (id) on delete cascade,
  collection text        not null,
  id         text        not null,
  data       jsonb       not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, collection, id)
);

alter table public.docs enable row level security;

drop policy if exists "docs select own" on public.docs;
drop policy if exists "docs insert own" on public.docs;
drop policy if exists "docs update own" on public.docs;
drop policy if exists "docs delete own" on public.docs;

create policy "docs select own" on public.docs for select using (auth.uid() = user_id);
create policy "docs insert own" on public.docs for insert with check (auth.uid() = user_id);
create policy "docs update own" on public.docs for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "docs delete own" on public.docs for delete using (auth.uid() = user_id);
