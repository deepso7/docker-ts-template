# base image
FROM node:20-alpine as base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /usr/src/app

# dev image for building the app
FROM base as dev

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm i

COPY . .

CMD [ "pnpm", "build" ]

# prod image for running in prod env
FROM base as prod

ENV NODE_ENV=production

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm i --prod --frozen-lockfile

COPY --from=dev /usr/src/app/dist ./dist

CMD [ "node", "dist/index.js" ]

