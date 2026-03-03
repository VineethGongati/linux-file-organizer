#!/bin/bash

# ============================================
#   Linux File Organizer
#   Author: VineethGongati
#   Description: Automatically sorts files
#   into folders based on their file type
# ============================================

# --- Color Codes ---
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# --- Check if folder is provided ---
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./organizer.sh <folder_path>${RESET}"
    echo "Example: ./organizer.sh messy-folder"
    exit 1
fi

# --- Check if folder exists ---
TARGET_FOLDER="$1"
if [ ! -d "$TARGET_FOLDER" ]; then
    echo -e "${YELLOW}Error: Folder '$TARGET_FOLDER' not found!${RESET}"
    exit 1
fi

# --- Report File ---
REPORT="organizer_report_$(date +%Y%m%d_%H%M%S).txt"

# --- Counters ---
IMAGES=0
DOCUMENTS=0
MUSIC=0
VIDEOS=0
ARCHIVES=0
CODE=0
OTHERS=0

# --- Divider ---
divider() {
    echo -e "${BLUE}============================================${RESET}"
}

# ============================================
# CREATE DESTINATION FOLDERS
# ============================================
mkdir -p "$TARGET_FOLDER/Images"
mkdir -p "$TARGET_FOLDER/Documents"
mkdir -p "$TARGET_FOLDER/Music"
mkdir -p "$TARGET_FOLDER/Videos"
mkdir -p "$TARGET_FOLDER/Archives"
mkdir -p "$TARGET_FOLDER/Code"
mkdir -p "$TARGET_FOLDER/Others"

echo ""
divider
echo -e "${BOLD}         LINUX FILE ORGANIZER${RESET}"
divider
echo -e "  Organizing folder: ${BLUE}$TARGET_FOLDER${RESET}"
echo -e "  Started at: $(date '+%Y-%m-%d %H:%M:%S')"
divider
echo ""

# ============================================
# SORT FILES BY EXTENSION
# ============================================

for FILE in "$TARGET_FOLDER"/*; do

    # Skip if it is a directory
    if [ -d "$FILE" ]; then
        continue
    fi

    # Get the file extension (lowercase)
    FILENAME=$(basename "$FILE")
    EXT=$(echo "${FILENAME##*.}" | tr '[:upper:]' '[:lower:]')

    # Sort based on extension
    case "$EXT" in

        # Images
        jpg|jpeg|png|gif|bmp|svg|webp|ico)
            mv "$FILE" "$TARGET_FOLDER/Images/"
            echo -e "  ${GREEN}📷 Image    ${RESET}→ $FILENAME"
            IMAGES=$((IMAGES + 1))
            ;;

        # Documents
        pdf|doc|docx|txt|xls|xlsx|ppt|pptx|odt|csv)
            mv "$FILE" "$TARGET_FOLDER/Documents/"
            echo -e "  ${GREEN}📄 Document ${RESET}→ $FILENAME"
            DOCUMENTS=$((DOCUMENTS + 1))
            ;;

        # Music
        mp3|wav|flac|aac|ogg|wma|m4a)
            mv "$FILE" "$TARGET_FOLDER/Music/"
            echo -e "  ${GREEN}🎵 Music    ${RESET}→ $FILENAME"
            MUSIC=$((MUSIC + 1))
            ;;

        # Videos
        mp4|mkv|avi|mov|wmv|flv|webm|m4v)
            mv "$FILE" "$TARGET_FOLDER/Videos/"
            echo -e "  ${GREEN}🎬 Video    ${RESET}→ $FILENAME"
            VIDEOS=$((VIDEOS + 1))
            ;;

        # Archives
        zip|tar|gz|rar|7z|bz2|xz)
            mv "$FILE" "$TARGET_FOLDER/Archives/"
            echo -e "  ${GREEN}📦 Archive  ${RESET}→ $FILENAME"
            ARCHIVES=$((ARCHIVES + 1))
            ;;

        # Code files
        sh|py|js|html|css|java|cpp|c|php|rb|go)
            mv "$FILE" "$TARGET_FOLDER/Code/"
            echo -e "  ${GREEN}💻 Code     ${RESET}→ $FILENAME"
            CODE=$((CODE + 1))
            ;;

        # Everything else
        *)
            mv "$FILE" "$TARGET_FOLDER/Others/"
            echo -e "  ${YELLOW}📁 Other    ${RESET}→ $FILENAME"
            OTHERS=$((OTHERS + 1))
            ;;
    esac

done

# ============================================
# PRINT SUMMARY REPORT
# ============================================

TOTAL=$((IMAGES + DOCUMENTS + MUSIC + VIDEOS + ARCHIVES + CODE + OTHERS))

echo ""
divider
echo -e "${BOLD}            ORGANIZATION SUMMARY${RESET}"
divider
echo -e "  📷 Images      : ${GREEN}$IMAGES files${RESET}"
echo -e "  📄 Documents   : ${GREEN}$DOCUMENTS files${RESET}"
echo -e "  🎵 Music       : ${GREEN}$MUSIC files${RESET}"
echo -e "  🎬 Videos      : ${GREEN}$VIDEOS files${RESET}"
echo -e "  📦 Archives    : ${GREEN}$ARCHIVES files${RESET}"
echo -e "  💻 Code        : ${GREEN}$CODE files${RESET}"
echo -e "  📁 Others      : ${YELLOW}$OTHERS files${RESET}"
divider
echo -e "  ${BOLD}Total Organized: $TOTAL files ✅${RESET}"
divider
echo -e "  Report saved to: $REPORT"
divider
echo ""
