# 🎙️ Claude Code Voice Input Plugin

> Speak your prompts instead of typing them.

A [Claude Code](https://docs.claude.com/en/docs/claude-code) plugin that adds speech-to-text input. Record from your microphone and have your words transcribed locally using [OpenAI Whisper](https://github.com/openai/whisper) — no API keys, no cloud services.

## Features

- 🎤 Record directly from your microphone
- 🔒 100% local transcription (nothing leaves your machine)
- 🛑 Auto-stops after 3 seconds of silence
- 🌍 Multi-language support
- ⚡ Configurable Whisper model size (tiny → large)

## Prerequisites

| Tool | Install |
|------|---------|
| Python 3.8+ | [python.org](https://python.org) |
| OpenAI Whisper | `pip install openai-whisper` |
| SoX (audio recording) | Mac: `brew install sox` · Windows: `choco install sox` · Linux: `sudo apt install sox` |

## Installation

### Option 1: Install from marketplace (recommended)

```bash
# Inside Claude Code
/plugin marketplace add YOUR_GITHUB_USERNAME/claude-code-voice-input
/plugin install voice-input
```

### Option 2: Install locally

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/claude-code-voice-input.git
claude --plugin-dir ./claude-code-voice-input
```

## Usage

In Claude Code, type:

```
/voice
```

Then speak your prompt. Recording stops automatically after 3 seconds of silence, or press `Ctrl+C` to stop manually.

## Configuration

Set environment variables to customize behavior:

```bash
# Use a larger model for better accuracy
export VOICE_MODEL=medium

# Change language (default: en)
export VOICE_LANG=es
```

### Available Models

| Model | Size | Speed | Accuracy |
|-------|------|-------|----------|
| `tiny` | 39 MB | Fastest | Basic |
| `base` | 74 MB | Fast | Good (default) |
| `small` | 244 MB | Medium | Better |
| `medium` | 769 MB | Slow | Great |
| `large` | 1550 MB | Slowest | Best |

## Microphone Permissions

Your terminal app needs microphone access:

- **Mac**: System Settings → Privacy & Security → Microphone → enable your terminal app
- **Windows**: Settings → Privacy → Microphone → enable for desktop apps
- **Linux**: Usually works out of the box; check PulseAudio/PipeWire if not

## Project Structure

```
claude-code-voice-input/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/
│   └── voice.md             # /voice slash command
├── scripts/
│   └── voice-input.sh       # Recording & transcription logic
├── skills/
│   └── voice-input/
│       └── SKILL.md         # Agent skill definition
├── README.md
├── LICENSE
└── .gitignore
```

## Contributing

Contributions welcome! Ideas for improvement:

- [ ] Use `whisper.cpp` for faster native transcription
- [ ] Add a `/voice-config` command to change settings interactively
- [ ] Support continuous listening mode between prompts
- [ ] Add a hook for auto-listen on session start
- [ ] Windows PowerShell alternative to bash script

## License

MIT License — see [LICENSE](LICENSE) for details.
