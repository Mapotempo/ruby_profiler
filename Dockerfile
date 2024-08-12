# Use a slimmer base image (alpine version)
FROM ruby:2.7-alpine

# Install dependencies
RUN apk add --no-cache --update \
    build-base \
    libpq-dev \
    git \
    tzdata \
    bash \
    cmake

# Set the working directory
WORKDIR /app

# Set environment variables
ENV LANG=C.UTF-8 \
    BUNDLE_PATH=/app/vendor \
    GEM_HOME=/app/vendor \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Copy the rest of the application code into the image
COPY . .