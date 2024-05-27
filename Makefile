.PHONY: clean

clean:
	rm -rf layer/chromium-layer.zip _/amazon/code/nodejs _/amazon/handlers/node_modules lidio601-chromium-*.tgz nodejs build

pretest:
	unzip chromium.zip -d _/amazon/code
	npm install --prefix _/amazon/handlers puppeteer-core@latest --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false

test:
	sam local invoke --template _/amazon/template.yml --event _/amazon/events/example.com.json node20

test16:
	sam local invoke --template _/amazon/template.yml --event _/amazon/events/example.com.json node16

test18:
	sam local invoke --template _/amazon/template.yml --event _/amazon/events/example.com.json node18

%.zip:
	npm install --fund=false --package-lock=false
	npx tsc -p tsconfig.json
	mkdir -p nodejs
	npm install --prefix nodejs/ tar-fs@3.0.5 follow-redirects@1.15.6 --bin-links=false --fund=false --omit=optional --omit=dev --package-lock=false --save=false
	mkdir -p nodejs/node_modules/@lidio601/chromium/
	# npm pack
	# tar --directory nodejs/node_modules/@lidio601/chromium/ --extract --file lidio601-chromium-*.tgz --strip-components=1
	cp -Rfvp bin build LICENSE package.json Dockerfile README.md nodejs/node_modules/@lidio601/chromium/
	npx clean-modules --directory nodejs "**/*.d.ts" "**/@types/**" "**/*.@(yaml|yml)" --yes
	mkdir -p $(dir $@)
	zip -9 --filesync --move --recurse-paths $@ nodejs

.DEFAULT_GOAL := chromium.zip
