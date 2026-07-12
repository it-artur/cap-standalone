# Optional: build Cap Standalone from upstream source.
# In Dokploy, easiest path is to use Image = tiago2/cap:latest instead of this Dockerfile.
FROM oven/bun:1.1 AS base
WORKDIR /app

FROM base AS deps
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 https://github.com/CapSoftware/Cap.git /app
WORKDIR /app
RUN bun install --frozen-lockfile || bun install

FROM base AS build
WORKDIR /app
COPY --from=deps /app /app
RUN bun run build || true

FROM base AS runtime
WORKDIR /app
COPY --from=deps /app /app
ENV NODE_ENV=production
EXPOSE 3000
CMD ["bun", "run", "start"]
