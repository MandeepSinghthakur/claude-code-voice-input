# /voice - Speech-to-Text Input

Record audio from your microphone and transcribe it using Whisper.

## Prerequisites

Install dependencies before first use:

```bash
pip install openai-whisper
# Mac:
brew install sox
# Windows:
choco install sox
```

## Usage

Type `/voice` to start recording. Speak your prompt, then pause for 3 seconds (or press Ctrl+C) to stop. The transcription is returned as text.

$COMMAND
bash "$(dirname "$0")/../scripts/voice-input.sh"
