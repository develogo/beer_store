#Install dependencies and build the app in a build environment
FROM ubuntu:latest AS build-env
# Install flutter dependencies
RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed
RUN apt-get clean
# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
# Set flutter path
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"
# Run flutter doctor
RUN flutter doctor -v
# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web
# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
# Futter pub get
RUN flutter pub get
# Build the app
ARG BUILD_VERSION=${VERSION_TAG}
RUN flutter build web --release --build-name=$BUILD_VERSION
# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
