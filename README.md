# 🎮 WORDSTORM — by Bruce

> Type fast. Stay alive. Try not to lose to a flying potato. 🥔

A free, original falling-word typing arcade made with HTML, CSS and JavaScript. No installation or account needed to play. Hosted on GitHub Pages.

## Features
- Cosmic Arcade, Candy Panic, and Cyber City animated themes
- Falling-word typing gameplay with particles, sound and goofy reactions
- Score, levels, WPM, accuracy, combos, lives, and personal best
- Easy, Normal, Hard modes; classic or silly word packs
- Mobile-friendly controls
- Optional global leaderboard via Supabase

## Play
Open `index.html` in your browser or visit the hosted game:
https://ajay-manaithiya.github.io/wordstorm/

## Enable GitHub Pages
Play by this link https://ajay-manaithiya.github.io/wordstorm/ and share with friends.

## Global leaderboard (optional)
GitHub Pages is a static host, so it cannot store scores from all players on its own. To activate the public leaderboard:

1. Create a Supabase project at https://supabase.com.
2. Copy and run `leaderboard.sql` in the Supabase SQL Editor.
3. Get the Supabase **Project URL** and public **publishable key** from its project settings.
4. Update `config.js` with these values. Only use a public `sb_publishable_...` key; **never commit secret keys, service_role keys or passwords**.
5. Commit the configuration and reload the website. Players can submit a nickname and score without creating an account.

The SQL creates a readable leaderboard and validated submissions with a nickname cooldown. **It is not cheat-proof:** browser-submitted scores can be forged. Use a trusted server for high-stakes competitions.

## Customize
Published defaults appear in `index.html` near `PUBLIC_DEFAULTS`. Players' changes to branding and themes are stored only in their own browsers.

## Files
- `index.html` — the complete typing game
- `config.js` — optional global leaderboard configuration
- `leaderboard.sql` — Supabase table, policies, and score function
- `favicon.svg` — original game icon
- `.nojekyll` — static Pages configuration
- `LICENSE` — MIT license

Made by Bruce ⚡
