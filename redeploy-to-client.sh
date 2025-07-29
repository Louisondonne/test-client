#!/bin/bash

# Configuration
SOURCE_APP="source-app"
TARGET_APP="target-app"
SOURCE_IMAGE="registry.heroku.com/${SOURCE_APP}/web"
TARGET_IMAGE="registry.heroku.com/${TARGET_APP}/web"
TAR_FILE="${SOURCE_APP}.tar"

echo "Logging into Heroku Container Registry..."
heroku container:login || { echo "Login failed";  }

echo "Pulling image from source app (${SOURCE_APP})..."
docker pull $SOURCE_IMAGE || { echo "Failed to pull image"; }

echo "Saving image to TAR file (${TAR_FILE})..."
docker save $SOURCE_IMAGE -o $TAR_FILE || { echo "Failed to save image";  }

echo "Loading image from TAR file..."
docker load -i $TAR_FILE || { echo "Failed to load image"; }

echo "Tagging image for target app (${TARGET_APP})..."
docker tag $SOURCE_IMAGE $TARGET_IMAGE || { echo "Failed to tag image"; }

echo "Pushing image to target app (${TARGET_APP})..."
docker push $TARGET_IMAGE || { echo "Failed to push image";  }

echo "Releasing image on target Heroku app..."
heroku container:release web --app $TARGET_APP || { echo "Failed to release app"; }

echo "Deployment completed successfully."
echo "App URL: https://${TARGET_APP}.herokuapp.com"
