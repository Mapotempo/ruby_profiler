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

# Set environment variables
ENV LANG=C.UTF-8 \
    BUNDLE_PATH=/gems \
    GEM_HOME=/gems \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Set the working directory
WORKDIR /app

# Copy the rest of the application code into the image
COPY . .