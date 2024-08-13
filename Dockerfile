# base image
FROM node:20-alpine as base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /usr/src/app

FROM base as install

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm i

# stage for development
FROM install as dev
COPY . .
CMD [ "pnpm", "dev" ]

# stage for building the app
FROM install as build
COPY . .
RUN pnpm build

# prod image for running in prod env
FROM base as prod

ENV NODE_ENV=production

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm i --prod --frozen-lockfile

COPY --from=build /usr/src/app/dist ./dist

CMD [ "node", "dist/index.js" ]

