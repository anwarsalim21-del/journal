# Desk Journal: set up your own website

This folder is a complete website. It has four files and needs no build step:

- `index.html` is the whole app (Trades, Macro and Geopolitics tabs, with a sign-in screen).
- `config.js` holds the two settings that connect it to your database.
- `schema.sql` creates the database table.
- `README.md` is this file.

Your data lives in a free Supabase database that you own. The website itself can sit on any free static host. Total cost: nothing on the free tiers.

## 1. Create the database (about 5 minutes)

1. Go to https://supabase.com, sign up, and click **New project**. Pick any name and region (Mumbai is closest for India) and save the database password somewhere safe.
2. When the project is ready, open **SQL Editor**, click **New query**, paste the whole of `schema.sql`, and click **Run**. You should see "Success".
3. Open **Project Settings, then API**. Copy the **Project URL** and the **anon public** key.
4. Open `config.js` in any text editor and paste them in place of `YOUR-PROJECT-URL` and `YOUR-ANON-KEY`. Save the file.

The anon key is designed to be public. What keeps your data private is the access rule that `schema.sql` set up: each person can only read and change their own rows. Never paste the `service_role` key anywhere.

## 2. Choose how people sign up

Open **Authentication** in Supabase. The menu names can change slightly over time.

- For instant sign-up without an email step, turn **Confirm email** off in the Email provider settings. Otherwise new users get a confirmation email first.
- If only you will use the site, create your own account first, then turn off new sign-ups (look for "Allow new users to sign up"). Nobody else can then create an account.
- Once the site is online, set **Site URL** under URL Configuration to your site's address so confirmation emails link to the right place.

## 3. Put the site online

Pick one. All are free for a site like this.

- **Netlify Drop:** go to https://app.netlify.com/drop and drag this whole folder onto the page. You get a web address straight away. Create a free account to keep the site.
- **Cloudflare Pages:** create a project and upload the folder as a direct upload.
- **GitHub Pages or Vercel:** upload the four files to a repository and switch the host on.

Open the address, click **Create account**, and start using it. Anyone you give the address to can make their own account and gets their own private journal.

## Testing on your own computer first

Opening `index.html` by double-clicking can work, but signing in is more reliable from a local web server. In this folder, run `python3 -m http.server 8000` and open http://localhost:8000.

## How it behaves

- Every person has a private journal. Nobody can see anyone else's trades or notes.
- Data is saved to your database as you type. The page also refreshes from the database when you switch back to the tab, so a second device catches up.
- To back up your data, open the **Table Editor** in Supabase, choose the `docs` table, and export it.

## If something goes wrong

- "This site is not connected to a database yet": `config.js` still has the placeholder text.
- "Could not load your data": `schema.sql` has not been run, or the URL or key in `config.js` is wrong.
- "Could not load the database library": the page could not reach its script on the internet. Check your connection.
- Sign-in says the email is not confirmed: confirm it from the email, or turn off **Confirm email**.
