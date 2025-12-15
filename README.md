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

## Slack Notifications for Mentions

The Lounge has built-in push notifications that work with browser notifications. For Slack integration when someone mentions your nick ("socket"), you have a few options:

### Option 1: Browser Push Notifications → Slack
Enable push notifications in The Lounge settings, then use a service like [Pushover](https://pushover.net/) or [ntfy](https://ntfy.sh/) to bridge to Slack.

### Option 2: IFTTT/Zapier Webhook
1. Create a Slack incoming webhook in your workspace
2. Use a browser extension or service that monitors for notifications and forwards to Slack

### Option 3: Custom Script with IRC Bot
Run a simple bot that monitors for mentions and sends to Slack:

```bash
# Example using webhook
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"You were mentioned on IRC!"}' \
  YOUR_SLACK_WEBHOOK_URL
```

### Highlight Keywords
In The Lounge settings, you can configure highlight words (like "socket") under Settings → Highlight. These will trigger push notifications when matched.

