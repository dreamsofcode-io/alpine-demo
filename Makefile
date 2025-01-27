# run air to detect any go file changes to re-build and re-run the server.
live/server:
	go run github.com/cosmtrek/air@v1.51.0
	--build.full_bin "BUILD_MODE=develop go build -o tmp/bin/main" \
	--build.bin "tmp/bin/main" \
	--build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_ext "go" \
	--build.stop_on_error "false" \
	--misc.clean_on_exit true

# run tailwindcss to generate the styles.css bundle in watch mode.
live/tailwind:
	bunx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/style.css --minify --watch=always

# watch for any js or css change in the assets/ folder, then reload the browser via templ proxy.
live/sync_assets:
	go run github.com/cosmtrek/air@v1.51.0 \
	--build.cmd "templ generate --notify-proxy" \
	--build.bin "true" \
	--build.delay "100" \
	--build.exclude_dir "" \
	--build.include_dir "static" \
	--build.include_ext "css"

dev:
	make -j4 live/server live/sync_assets live/tailwind

queries:
	sqlc generate
