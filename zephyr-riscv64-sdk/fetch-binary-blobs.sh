#!/bin/bash

set -eu

PREFIX="${PREFIX:-}"

# Check if HAL_ESPRESSIF_COMMIT is set
if [ -z "$HAL_ESPRESSIF_COMMIT" ]; then
  echo "Error: HAL_ESPRESSIF_COMMIT environment variable is not set"
  exit 1
fi

# Check required commands
for cmd in wget sha256sum yq; do
  if ! command -v $cmd &>/dev/null; then
    echo "Error: $cmd is required but not installed"
    exit 1
  fi
done

# Construct the URL
YAML_URL="https://raw.githubusercontent.com/zephyrproject-rtos/hal_espressif/$HAL_ESPRESSIF_COMMIT/zephyr/module.yml"

echo "Fetching module.yml from: $YAML_URL"

# Download the YAML file to current directory
YAML_FILE="module_${HAL_ESPRESSIF_COMMIT}.yml"
trap 'rm -f $YAML_FILE' EXIT

if ! wget -q "$YAML_URL" -O "$YAML_FILE"; then
  echo "Error: Failed to download YAML file"
  exit 1
fi

echo -e "YAML file downloaded successfully\n"

# Get the number of blobs
BLOB_COUNT=$(yq '.blobs | length' "$YAML_FILE")

if [ "$BLOB_COUNT" -eq 0 ]; then
  echo "No blobs found in the YAML file"
  exit 0
fi

echo -e "Found $BLOB_COUNT blobs to process\n"

# Process each blob
for i in $(seq 0 $((BLOB_COUNT - 1))); do
  echo "Processing blob $((i + 1))/$BLOB_COUNT..."

  # Extract blob information
  URL=$(yq ".blobs[$i].url" "$YAML_FILE")
  SHA256=$(yq ".blobs[$i].sha256" "$YAML_FILE")
  LIB_PATH=$PREFIX/$(yq ".blobs[$i].path" "$YAML_FILE")

  # Remove quotes if present using parameter expansion
  URL="${URL//\"/}"
  SHA256="${SHA256//\"/}"
  LIB_PATH="${LIB_PATH//\"/}"

  echo "  URL: $URL"
  echo "  Expected SHA256: $SHA256"
  echo "  Destination: $LIB_PATH"

  # Create a temporary file for download in current directory
  TEMP_FILE=".blob_download_${i}.tmp"

  # Download the file
  echo "  Downloading..."
  if ! wget -q "$URL" -O "$TEMP_FILE"; then
    echo "  Error: Failed to download $URL"
    rm -f "$TEMP_FILE"
    exit 1
  fi

  # Verify SHA256
  echo "  Verifying checksum..."
  ACTUAL_SHA256=$(sha256sum "$TEMP_FILE" | awk '{print $1}')

  if [ "$ACTUAL_SHA256" != "$SHA256" ]; then
    echo "  Error: SHA256 mismatch!"
    echo "    Expected: $SHA256"
    echo "    Got:      $ACTUAL_SHA256"
    rm -f "$TEMP_FILE"
    exit 1
  fi
  echo "  Checksum verified ✓"

  # Create destination directory if it doesn't exist
  DEST_DIR=$(dirname $LIB_PATH)
  if [ ! -d "$DEST_DIR" ]; then
    echo "  Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
  fi

  # Move file to destination
  echo "  Moving to destination..."
  mv "$TEMP_FILE" "$LIB_PATH"

  echo -e "  Done ✓\n"
done

echo "All blobs processed successfully!"
