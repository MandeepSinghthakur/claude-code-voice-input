#!/bin/bash

# =============================================
# Claude Code Voice Input
# Records mic audio → transcribes with Whisper
# =============================================

TEMP_DIR=$(mktemp -d)
AUDIO_FILE="$TEMP_DIR/recording.wav"
TRANSCRIPT_FILE="$TEMP_DIR/recording.txt"
WHISPER_MODEL="${VOICE_MODEL:-base}"
LANGUAGE="${VOICE_LANG:-en}"

cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT

# --- Check dependencies ---
check_deps() {
  local missing=0
  if ! command -v rec &>/dev/null && ! command -v sox &>/dev/null; then
    echo "❌ SoX not found."
    echo "   Mac:     brew install sox"
    echo "   Windows: choco install sox"
    echo "   Linux:   sudo apt install sox"
    missing=1
  fi
  if ! command -v whisper &>/dev/null; then
    echo "❌ Whisper not found."
    echo "   Install: pip install openai-whisper"
    missing=1
  fi
  [ $missing -eq 1 ] && exit 1
}

# --- Record audio ---
record() {
  echo ""
  echo "🎙️  Recording... Speak now!"
  echo "   Will stop after 3s of silence, or press Ctrl+C."
  echo ""

  rec "$AUDIO_FILE" \
    rate 16000 \
    channels 1 \
    silence 1 0.1 3% 1 3.0 3% \
    2>/dev/null

  if [ ! -f "$AUDIO_FILE" ] || [ ! -s "$AUDIO_FILE" ]; then
    echo "❌ No audio captured. Check your microphone."
    exit 1
  fi
  echo "✅ Audio captured."
}

# --- Transcribe with Whisper ---
transcribe() {
  echo "📝 Transcribing with Whisper ($WHISPER_MODEL model)..."

  whisper "$AUDIO_FILE" \
    --model "$WHISPER_MODEL" \
    --output_format txt \
    --output_dir "$TEMP_DIR" \
    --language "$LANGUAGE" \
    --fp16 False \
    2>/dev/null

  if [ ! -f "$TRANSCRIPT_FILE" ]; then
    echo "❌ Transcription failed."
    exit 1
  fi

  local text
  text=$(cat "$TRANSCRIPT_FILE" | tr -s '[:space:]' ' ' | sed 's/^ //;s/ $//')

  if [ -z "$text" ]; then
    echo "⚠️  No speech detected. Try again."
    exit 1
  fi

  echo ""
  echo "🗣️  Transcription:"
  echo "   $text"
  echo ""
  echo "$text"
}

# --- Main ---
check_deps
record
transcribe
