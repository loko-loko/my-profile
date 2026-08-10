# PicoClaw config for the remote host

PicoClaw (`github.com/sipeed/picoclaw`) config that runs a single gateway with
**two personalities** reached over **Telegram** (PicoClaw has no native Signal
channel; see below).

## What's here

| Path | Purpose |
| --- | --- |
| `config.json` | PicoClaw v3 config: two agents, dispatch routing, Telegram channel |
| `workspace/assistant/` | Personality for the default **Assistant** agent |
| `workspace/african-linguist/` | Personality for the **African Linguist** agent |

Each workspace uses the modern `AGENT.md` + `SOUL.md` layout. `AGENT.md` carries
YAML frontmatter (`name`, `description`, `tools`, `model`) plus the behaviour
prompt.

## Deploy to the host

Copy into place (paths match `~/.picoclaw`):

```bash
mkdir -p ~/.picoclaw/workspaces
cp picoclaw/config.json ~/.picoclaw/config.json
cp -r picoclaw/workspace/assistant ~/.picoclaw/workspaces/assistant
cp -r picoclaw/workspace/african-linguist ~/.picoclaw/workspaces/african-linguist
```

Then run the gateway:

```bash
picoclaw gateway
```

## Fill in before running

All of these are placeholders in `config.json`:

- `channel_list.telegram.settings.token` — your Telegram bot token from @BotFather.
- `agents.dispatch.rules[0].when.sender` — the Telegram numeric user ID whose
  messages go to the African Linguist. Everything else is handled by the default
  Assistant. Routing in PicoClaw matches on channel/sender/chat (no body-text
  matching), so per-personality chat requires distinct sender IDs, chats, or an
  extra rule.
- `model_list[].api_keys` — your provider API keys (Anthropic, DeepSeek).

## About Signal

PicoClaw does **not** have a Signal channel. This config therefore communicates
over Telegram as a close stand-in. Options if you need Signal specifically:

- Track the open request at https://github.com/sipeed/picoclaw/issues/41
  (proposes an HTTP-RPC bridge to `signal-cli`).
- Bridge Signal into the Matrix or the generic `pico` WebSocket channel with a
  small custom shim, then route to the two agents the same way.

The two-agent + dispatch design here is channel-agnostic, so switching the
transport later only means swapping `channel_list`.
