FROM node:22-alpine3.18 as base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

RUN apk --no-cache add curl

FROM base as api-deps
WORKDIR /app/api
ADD api/package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

FROM base as api-production-deps
WORKDIR /app/api
ADD api/package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prod
RUN wget https://gobinaries.com/tj/node-prune --output-document - | /bin/sh && node-prune

FROM base as api
WORKDIR /app/api
COPY --from=api-deps /app/node_modules /app/node_modules
ADD . .
RUN node ace build --production --ignore-ts-errors