-- WORDSTORM global leaderboard. Run in Supabase SQL Editor.
-- Public nicknames and scores only; no login required.
-- Browser-submitted scores are not cheat-proof.
create table if not exists public.wordstorm_scores (
  id bigint generated always as identity primary key,
  player_name text not null check (player_name ~ '^[A-Za-z0-9 _-]{2,20}$'),
  score integer not null check (score between 0 and 2000000),
  wpm integer not null check (wpm between 0 and 300),
  accuracy integer not null check (accuracy between 0 and 100),
  level integer not null check (level between 1 and 100),
  difficulty text not null check (difficulty in ('easy','normal','hard')),
  word_pack text not null check (word_pack in ('classic','goofy')),
  created_at timestamptz not null default now()
);
alter table public.wordstorm_scores enable row level security;
revoke all on public.wordstorm_scores from anon, authenticated;
grant select on public.wordstorm_scores to anon, authenticated;
drop policy if exists "Everyone can read scores" on public.wordstorm_scores;
create policy "Everyone can read scores"
  on public.wordstorm_scores for select to anon, authenticated using (true);

create or replace function public.submit_wordstorm_score(
  p_player_name text, p_score integer, p_wpm integer, p_accuracy integer,
  p_level integer, p_difficulty text, p_word_pack text
) returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  new_id bigint;
  clean_name text := btrim(p_player_name);
begin
  if clean_name is null or clean_name !~ '^[A-Za-z0-9 _-]{2,20}$'
    or p_score is null or p_score not between 0 and 2000000
    or p_wpm is null or p_wpm not between 0 and 300
    or p_accuracy is null or p_accuracy not between 0 and 100
    or p_level is null or p_level not between 1 and 100
    or p_difficulty is null or p_difficulty not in ('easy','normal','hard')
    or p_word_pack is null or p_word_pack not in ('classic','goofy')
  then
    raise exception 'Invalid game result or nickname';
  end if;
  if exists (
    select 1 from public.wordstorm_scores
    where lower(player_name) = lower(clean_name)
      and created_at > now() - interval '30 seconds'
  ) then
    raise exception 'Please wait 30 seconds before posting again with this nickname';
  end if;
  insert into public.wordstorm_scores
    (player_name, score, wpm, accuracy, level, difficulty, word_pack)
  values
    (clean_name, p_score, p_wpm, p_accuracy, p_level, p_difficulty, p_word_pack)
  returning id into new_id;
  return new_id;
end;
$$;
revoke all on function public.submit_wordstorm_score(text,integer,integer,integer,integer,text,text) from public;
grant execute on function public.submit_wordstorm_score(text,integer,integer,integer,integer,text,text) to anon,authenticated;
