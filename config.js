"use strict";

module.exports = {
  // Public mode allows anyone to connect without authentication
  // Set to false for private mode (users must be created via thelounge add)
  public: false,

  // The IP address or hostname to bind to
  host: "0.0.0.0",

  // The port to listen on
  port: 9000,

  // Set to true to enable HTTPS
  https: {
    enable: false,
  },

  // Reverse proxy settings
  reverseProxy: true,

  // Maximum number of history lines per channel
  maxHistory: 10000,

  // Default theme - custom Plex-inspired dark theme
  theme: "plex-dark",

  // Prefetch URLs for link previews
  prefetch: true,
  prefetchStorage: true,
  prefetchMaxImageSize: 2048,

  // File uploads
  fileUpload: {
    enable: true,
    maxFileSize: 10240, // KB
    baseUrl: null,
  },

  // LDAP authentication (disabled)
  ldap: {
    enable: false,
  },

  // Default settings for new users
  defaults: {
    name: "Freenode",
    host: "irc.libera.chat", // Freenode moved to Libera.Chat
    port: 6697,
    password: "",
    tls: true,
    rejectUnauthorized: true,
    nick: "socket",
    username: "socket",
    realname: "The Lounge User",
    join: "#test",
    leaveMessage: "The Lounge - https://thelounge.chat",
  },
};

