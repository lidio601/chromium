FROM public.ecr.aws/docker/library/node:20

WORKDIR /asset

RUN apt-get update && apt-get install -y zip && apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p nodejs/node_modules/@lidio601/chromium/

COPY bin nodejs/node_modules/@lidio601/chromium/bin/ \
      build nodejs/node_modules/@lidio601/chromium/build/ \
      package.json nodejs/node_modules/@lidio601/chromium/

RUN npm install --prefix nodejs/ tar-fs@3.0.5 follow-redirects@1.15.6 --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false \
   && zip -9 --filesync --move --recurse-paths aws-lambda-layer.zip nodejs