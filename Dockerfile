# Use the official Cap Standalone image and run it as-is.
# Redis/Valkey must be provided as a separate service (see docker-compose.yml
# or run it next to this application in Dokploy).
FROM tiago2/cap:latest
EXPOSE 3000
