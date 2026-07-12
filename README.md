# Cap Standalone — Dokploy deploy

Self-hosted [Cap](https://trycap.dev) CAPTCHA backend, packaged for one-click deploy on Dokploy.
Docs: <https://trycap.dev/guide/standalone/>

## What is here

- `docker-compose.yml` — Cap + Valkey (Redis-compatible). The image `tiago2/cap:latest` is the official one used in the upstream guide.
- `Dockerfile` — optional: only needed if you want to build Cap from source (`CapSoftware/Cap`) instead of pulling the prebuilt image.

## Deploy on Dokploy

1. **Create Service → Application → From GitHub** and pick this repo.
2. Pick a build method:
   - **Recommended:** *Image* → `tiago2/cap:latest`. Skip the Dockerfile.
   - *Custom:* *Dockerfile* (this repo's `Dockerfile` clones and builds `CapSoftware/Cap`).
3. **Port:** `3000`.
4. **Environment variables** (Dokploy → Environment / Secrets):
   - `ADMIN_KEY` — your dashboard login. Make it 32+ random chars.
   - `REDIS_URL=redis://valkey:6379`.
5. **Domain:** attach a public domain (e.g. `cap.example.com`) → port `3000`. The widget must reach the instance from the public internet.
6. **Deploy.** Open `https://cap.example.com`, log in with `ADMIN_KEY`, create a *Site Key*.

## Use on your sites

Widget:

```html
<script src="https://cdn.jsdelivr.net/npm/@cap.js/widget"></script>
<cap-widget data-cap-api-endpoint="https://cap.example.com/<site_key>/"></cap-widget>
```

Server-side verify (reCAPTCHA-compatible):

```bash
curl "https://cap.example.com/<site_key>/siteverify" \
  -X POST -H "Content-Type: application/json" \
  -d '{ "secret": "<key_secret>", "response": "<captcha_token>" }'
```

## Run locally

```bash
cp .env.example .env  # then edit ADMIN_KEY
docker compose up -d
# http://localhost:3000
```
