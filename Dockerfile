FROM thelounge/thelounge:4.4.3

# Create a directory for default config that can be copied if /var/opt/thelounge is empty
RUN mkdir -p /defaults

# Copy default config to /defaults
COPY config.js /defaults/config.js

# Copy config.js to the lounge config directory
COPY config.js /var/opt/thelounge/config.js

# Copy our custom theme directly to The Lounge's built-in themes directory
# This is the simplest and most reliable way to add a theme
COPY themes/matrix-dracula/theme.css /usr/local/share/.config/yarn/global/node_modules/thelounge/public/themes/matrix-dracula.css

# Copy custom entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:9000/ || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
