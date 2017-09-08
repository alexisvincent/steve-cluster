docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app -e PKG_CACHE_PATH=/usr/src/app/.cache node:8 npm run docker-build
cp build/index-linux ../steve
cp build/index-macos ../steve-macos