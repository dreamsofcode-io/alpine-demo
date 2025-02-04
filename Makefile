# run air to detect any go file changes to re-build and re-run the server.
live/server:
	go run github.com/cosmtrek/air@v1.51.0
	--build.full_bin "go build -o tmp/bin/main" \
	--build.bin "tmp/bin/main" \
	--build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_ext "go" \
	--build.stop_on_error "false" \
	--misc.clean_on_exit true

# run tailwindcss to generate the styles.css bundle in watch mode.
live/tailwind:
	bunx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/style.css --minify --watch=always

dev:
	make -j2 live/server live/tailwind
