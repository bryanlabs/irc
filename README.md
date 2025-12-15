# IRC - The Lounge

Self-hosted IRC client using [The Lounge](https://thelounge.chat/).

## Features

- Modern web-based IRC client
- Always connected (no need for a separate bouncer)
- Push notifications
- Link previews
- File uploads
- Multi-user support

## Configuration

Pre-configured networks:
- **Libera.Chat** (formerly Freenode) - `irc.libera.chat:6697` (TLS)
- **Undernet** - `us.undernet.org:6667`

## Docker

```bash
# Build locally
docker build -t ghcr.io/bryanlabs/irc:latest .

# Run locally
docker run -d \
  --name irc \
  -p 9000:9000 \
  -v irc-data:/var/opt/thelounge \
  ghcr.io/bryanlabs/irc:latest
```

## User Management

The Lounge runs in private mode. Create users via:

```bash
docker exec -it irc thelounge add <username>
```

## Slack Notifications

To receive Slack notifications when someone mentions your nick, configure the push notification settings in The Lounge's web UI, or use a ZNC-style push module if needed.

