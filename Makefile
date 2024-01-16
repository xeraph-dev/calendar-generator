build:
	swift build

build-release:
	swift build -c release

dev:
	swift package --disable-sandbox vercel dev --product api

deploy-preview:
	swift package --disable-sandbox vercel --deploy --product api

deploy:
	swift package --disable-sandbox vercel --deploy --prod --product api

docker-start:
	colima start

docker-stop:
	colima stop

install:
	install .build/release/cg ~/.local/bin/cg