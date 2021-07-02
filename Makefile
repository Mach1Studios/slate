# Mach1 demos page deployment

s3_bucket_name = dev-mach1-public

# getting OS type
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
else
	detected_OS := $(shell uname)
endif

install: 
	# install all deps

build: clean
	bundle exec middleman build --verbose --clean

clean: 
	rm -rf build

deploy: build
	# deploys build to public AWS bucket
	# NOTE: relies on `mach1` keys in `~/.aws/credentials`
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type text/html --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.html" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type text/plain --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.txt" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type text/css --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.css" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type application/xhtml+xml --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.xml" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type application/font-woff --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.woff" --include "*.woff2" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type image/svg+xml --cache-control no-cache --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.svg" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type image/png --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.png" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type image/jpeg --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.jpg" --include "*.jpeg" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --content-type image/tiff --acl public-read --metadata-directive REPLACE --exclude "*" --include "*.tiff" --include "*.tif" --profile mach1
	aws s3 sync ./ s3://$(s3_bucket_name) --cache-control no-cache --acl public-read --metadata-directive REPLACE --include "*" --exclude ".git*" --exclude ".DS_Store" --exclude "Makefile" --exclude "*.html" --exclude "*.woff" --exclude "*.woff2" --exclude "*.txt" --exclude "*.css" --exclude "*.xml" --exclude "*.svg" --exclude "*.jpg" --exclude "*.tiff" --exclude "*.png" --exclude "*.aif" --exclude "*.aiff" --exclude "*.ogg" --exclude "*.mp3" --exclude "*.wav" --exclude "*.DS_Store" --profile mach1
