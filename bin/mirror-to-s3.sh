#!/bin/bash -e
cd ${CI_PROJECT_DIR}
./bin/mirror.sh 

aws s3 sync ./_site ${BUCKET_PATH} \
    --acl public-read \
    --cache-control "max-age=315360000, public, immutable"  \
    --delete 

aws s3 sync ./_site/listings/index.html ${BUCKET_PATH}/listings/index.html \
    --acl public-read \
    --cache-control "max-age=1800, public"  \
    --delete 

curl ${DMS}
