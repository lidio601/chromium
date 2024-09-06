FROM public.ecr.aws/docker/library/node:20

WORKDIR /asset

RUN npm install --prefix nodejs/ tar-fs@3.0.5 follow-redirects@1.15.6 --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false

RUN mkdir -p nodejs/node_modules/@lidio601/chromium/

COPY bin nodejs/node_modules/@lidio601/chromium/bin/
COPY build nodejs/node_modules/@lidio601/chromium/build/
COPY package.json nodejs/node_modules/@lidio601/chromium/

RUN cd nodejs/node_modules/@lidio601/chromium/bin/ \
  && curl https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz -o ffmpeg.tar.xz \
	&& tar xvf ffmpeg.tar.xz -C ./ --strip-components=1 \
  && rm -fv ffmpeg.tar.xz
