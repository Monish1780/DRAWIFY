FROM node:23-alpine3.21

WORKDIR /app

COPY . .

RUN npm install -g pnpm@10.5.2

RUN pnpm install

RUN pnpm run generate:db

RUN pnpm --filter @repo/common run build && pnpm --filter @repo/database run build && pnpm --filter ws-backend run build

EXPOSE 3002

ARG DATABASE_URL
ARG WS_PORT
ARG JWT_SECRET
ENV DATABASE_URL=${DATABASE_URL}
ENV WS_PORT=${WS_PORT}
ENV JWT_SECRET=${JWT_SECRET}

CMD [ "pnpm", "run", "start:ws" ]