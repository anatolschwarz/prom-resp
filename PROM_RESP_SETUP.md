# ChatGPT ↔ Codex Coworking Setup

## Coworking Repository

Repository:

`https://github.com/anatolschwarz/prom-resp`

Local checkout:

`~/code/prom-resp`

Purpose: provide a simple handoff channel from local Codex to ChatGPT through GitHub.

For each ChatGPT ↔ Codex session, use one fixed session token.

Normal handoff artifacts:

- `<session-token>-response.md`
- `<session-token>-diff.patch`

Current session example:

`s-20260812-0955-c7d4-response.md`

`s-20260812-0955-c7d4-diff.patch`

Codex writes its complete final response to the response file and generates the
patch directly. The patch represents all uncommitted Contraption Lab changes:
tracked staged and unstaged changes, new/untracked files, and deletions; it is
binary-safe where practical. ChatGPT then fetches both artifacts from GitHub.

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

The helper stages both artifacts, commits if either changed, pulls/rebases
`origin main`, and pushes. Either artifact may be unchanged; both must exist.

This remains the manual fallback when direct Codex Git delivery is not used.

## Direct Codex Git Delivery

Operational Codex prompts should instruct Codex to:

1. Implement and validate the requested Contraption Lab change.
2. Write the exact same final response to:
   `~/code/prom-resp/<session-token>-response.md`
3. Generate `~/code/prom-resp/<session-token>-diff.patch` directly from all
   current uncommitted Contraption Lab changes. Do not use or add a
   `make-diff.sh` helper.
4. In `~/code/prom-resp`:
   - stage both artifacts;
   - commit it;
   - pull/rebase from `origin main`;
   - push to `origin main`;
   - request approval when required.
5. Claim delivery success only after the Git push succeeds, then print its
   complete final response normally in the terminal.

ChatGPT can then fetch:

`<session-token>-response.md` and `<session-token>-diff.patch`

from `anatolschwarz/prom-resp`.

## Operational Convention

- One fixed session token per ChatGPT ↔ Codex session.
- Normal artifacts: `<session-token>-response.md` and
  `<session-token>-diff.patch`.
- Normal flow: implementation → generate response + diff → push `prom-resp` →
  ChatGPT reviews as needed → only then commit/push `contraption-lab`.
- Preferred path: Codex generates both artifacts, commits, and pushes them
  directly.
- Fallback path: Codex generates both artifacts; user runs
  `push-response.sh <session-token>`.
- A full-code/review branch is exceptional escalation, not the normal handoff.
- Secrets and private SSH keys are never stored in either repository.
