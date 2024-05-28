FROM public.ecr.aws/docker/library/node:20

WORKDIR /asset

RUN npm install --prefix nodejs/ tar-fs@3.0.5 follow-redirects@1.15.6 --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false

RUN mkdir -p nodejs/node_modules/@lidio601/chromium/

COPY bin nodejs/node_modules/@lidio601/chromium/bin/
COPY build nodejs/node_modules/@lidio601/chromium/build/
COPY package.json nodejs/node_modules/@lidio601/chromium/
