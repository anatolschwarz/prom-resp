# ChatGPT ↔ Codex Coworking Setup

## Coworking Repository

Repository:

`https://github.com/anatolschwarz/prom-resp`

Local checkout:

`~/code/prom-resp`

Purpose: provide a simple handoff channel from local Codex to ChatGPT through GitHub.

For each ChatGPT ↔ Codex session, use one fixed session token.

Response filename:

`<session-token>-response.md`

Current session example:

`s-20260812-0955-c7d4-response.md`

Codex writes its complete final response to that file. ChatGPT then fetches the file from GitHub.

## Git / SSH Setup

`prom-resp` uses a dedicated write-enabled GitHub deploy key.

Private key:

`~/.ssh/prom_resp_deploy`

Relevant `~/.ssh/config` entry:

```sshconfig
Host github-prom-resp
    HostName github.com
    User git
    IdentityFile ~/.ssh/prom_resp_deploy
    IdentitiesOnly yes
```

Repository remote:

```text
git@github-prom-resp:anatolschwarz/prom-resp.git
```

Verification:

```bash
ssh -T git@github-prom-resp
git -C ~/code/prom-resp remote -v
```

Do not commit or copy the private SSH key into any repository.

## Codex Access to `prom-resp`

Contraption Lab project config:

`~/code/contraption-lab/.codex/config.toml`

```toml
approval_policy = "on-request"
sandbox_mode = "workspace-write"

[sandbox_workspace_write]
writable_roots = ["/home/anatolschwartz/code/prom-resp"]
```

After changing this file, restart Codex.

Expected `/status` permissions:

```text
Workspace [/home/anatolschwartz/code/prom-resp] (Ask for approval)
```

This lets Codex write response files directly into `~/code/prom-resp`. Git operations that require access to `.git` or network access can request approval.

## Manual Push Helper

Helper script:

`~/code/prom-resp/push-response.sh`

Usage:

```bash
~/code/prom-resp/push-response.sh <session-token>
```

Current-session example:

```bash
~/code/prom-resp/push-response.sh s-20260812-0955-c7d4
```

The helper stages the response file, commits it if changed, pulls/rebases `origin main`, and pushes.

This remains the manual fallback when direct Codex Git delivery is not used.

## Direct Codex Git Delivery

Operational Codex prompts should instruct Codex to:

1. Print its complete final response normally in the terminal.
2. Write the exact same final response to:
   `~/code/prom-resp/<session-token>-response.md`
3. In `~/code/prom-resp`:
   - stage the response file;
   - commit it;
   - pull/rebase from `origin main`;
   - push to `origin main`;
   - request approval when required.
4. Claim delivery success only after the Git push succeeds.

ChatGPT can then fetch:

`<session-token>-response.md`

from `anatolschwarz/prom-resp`.

## Operational Convention

- One fixed session token per ChatGPT ↔ Codex session.
- Response file: `<session-token>-response.md`.
- Preferred path: Codex writes, commits, and pushes the response directly.
- Fallback path: Codex writes the response; user runs `push-response.sh <session-token>`.
- Secrets and private SSH keys are never stored in either repository.
