-- TP Jet · banco de roteiros compartilhado pela equipe JetBov
-- Rode este arquivo inteiro no Supabase: SQL Editor → New query → colar → Run.

-- 1) Tabela de roteiros
create table if not exists public.scripts (
  id          text primary key default gen_random_uuid()::text,
  title       text not null default '',
  body        text not null default '',
  created_by  text default (auth.jwt() ->> 'email'),
  updated_by  text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- 2) Só quem entrou com e-mail @jetbov.com lê e escreve
create or replace function public.is_jetbov() returns boolean
language sql stable as $$
  select coalesce(lower(auth.jwt() ->> 'email') like '%@jetbov.com', false)
$$;

alter table public.scripts enable row level security;

drop policy if exists "equipe le"      on public.scripts;
drop policy if exists "equipe cria"    on public.scripts;
drop policy if exists "equipe edita"   on public.scripts;
drop policy if exists "equipe exclui"  on public.scripts;

create policy "equipe le"     on public.scripts for select to authenticated using (public.is_jetbov());
create policy "equipe cria"   on public.scripts for insert to authenticated with check (public.is_jetbov());
create policy "equipe edita"  on public.scripts for update to authenticated using (public.is_jetbov()) with check (public.is_jetbov());
create policy "equipe exclui" on public.scripts for delete to authenticated using (public.is_jetbov());

-- 3) Bloqueia cadastro de qualquer e-mail que não seja @jetbov.com
create or replace function public.only_jetbov_signup() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  if new.email is null or lower(new.email) not like '%@jetbov.com' then
    raise exception 'Apenas e-mails @jetbov.com podem entrar no TP Jet';
  end if;
  return new;
end
$$;

drop trigger if exists only_jetbov_signup on auth.users;
create trigger only_jetbov_signup
  before insert on auth.users
  for each row execute function public.only_jetbov_signup();
