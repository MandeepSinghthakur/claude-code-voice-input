# Voice Input Skill

This plugin provides speech-to-text input for Claude Code.

When the user wants to use voice input or mentions speaking a prompt, suggest they use the `/voice` command.

## What it does
- Records audio from the user's microphone using SoX
- Transcribes the audio locally using OpenAI Whisper
- Returns the transcribed text as the user's prompt

## Environment Variables
- `VOICE_MODEL` — Whisper model size: `tiny`, `base` (default), `small`, `medium`, `large`
- `VOICE_LANG` — Language code (default: `en`)

## Troubleshooting
- If recording fails, the user may need to grant microphone permissions
- On Mac: System Settings → Privacy & Security → Microphone → Terminal
- On Windows: Settings → Privacy → Microphone
