FROM thelounge/thelounge:4.4.3

# The Lounge stores config in /var/opt/thelounge
# We'll use a volume for persistence

# Copy custom config if needed
COPY config.js /var/opt/thelounge/config.js

# Expose The Lounge web interface
EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:9000/ || exit 1

