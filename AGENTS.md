# irc — AGENTS.md

## What it is

A thin Docker wrapper around [The Lounge](https://thelounge.chat/) (v4.4.3), a self-hosted, always-connected web IRC client. It bundles a custom config and a custom "matrix-dracula" theme on top of the upstream image.

## Where it's used

- **Deployment:** `irc-app` Deployment in the `apps` namespace, image `ghcr.io/bryanlabs/irc`.
- **Relationship to soju:** The Lounge has a built-in persistent IRC connection (always-on bouncer behavior). The `soju` StatefulSet is a separate IRC bouncer in the same namespace; the two are independent services. `irc-app` does not proxy through soju.
- **Port:** 9000 (HTTP, behind a reverse proxy; TLS terminated upstream).

## How it works

1. Container starts via `docker-entrypoint.sh`.
2. If `/var/opt/thelounge/config.js` is absent, it copies `/defaults/config.js` (preserving any user-edited config across redeploys).
3. If no user accounts exist, it bootstraps a default user `socket` with password `test123` (change immediately after first deploy).
4. The Lounge starts in private mode; accounts must be created explicitly.
5. Pre-configured default network: Libera.Chat (`irc.libera.chat:6697`, TLS). Undernet is also documented but not wired into the default join.

## Code map

| File | Purpose |
|---|---|
| `Dockerfile` | Extends `thelounge/thelounge:4.4.3`, bakes in config + theme |
| `config.js` | App config (private mode, port 9000, prefetch, file upload, default network) |
| `docker-entrypoint.sh` | First-run bootstrap (config seeding, default user creation) |
| `themes/matrix-dracula/` | Custom CSS theme (black/green/Dracula palette) |
| `themes/plex-dark.css` | Alternative Plex-style dark theme (not active by default) |
| `.github/workflows/build-and-push.yaml` | CI: build + push to GHCR on `main` merges |

## Build & deploy

```bash
# CI builds automatically on push to main (GitHub Actions -> GHCR)
# Manual local build (amd64):
docker buildx build --builder cloud-bryanlabs-builder --platform linux/amd64 \
  -t ghcr.io/bryanlabs/irc:latest --push .
```

The workflow tags images as `latest`, the branch name, the commit SHA, and PR refs.

No Kubernetes manifests live in this repo; the Deployment is managed in `bare-metal`.

## Gotchas

- The default bootstrap user `socket` has password `test123`. Create a real user and remove it after first deploy: `thelounge add <user>` / `thelounge remove socket`.
- `config.js` is only seeded on first run (when the file is absent). To change config on a running instance, edit the file in the PVC directly or delete it and redeploy.
- The matrix-dracula theme CSS is copied directly into the upstream node_modules path inside the image. If The Lounge is upgraded, verify the destination path still exists.
- `reverseProxy: true` is set; ensure the ingress forwards the real client IP or The Lounge will log proxy addresses.
- CI does not build multi-arch by default (GitHub Actions runner is amd64 only). Local builds should use the cloud builder for consistency.
