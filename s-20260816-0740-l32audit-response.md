# #32 prompt-log audit

Scope: current local working tree. `docs/CODEX_PROMPTS.md` is modified (` M docs/CODEX_PROMPTS.md`). `git diff -- docs/CODEX_PROMPTS.md` reports one document diff from `84d7e0e` to `59b3203`, containing 659 added lines and no deletions; it consists of #32 operational-prompt blocks, including the newly appended audit block. No game code was changed for this audit.

## Pre-existing #32 prompt-log blocks, in file order

| Location | Status / distinctive line | Logging mark | Completeness |
| --- | --- | --- | --- |
| 3688 | Reference heading: `#32 Chapter 1 L3 — Tea Time` | Otherwise (table of contents) | Partial/reference only; not an operational prompt |
| 4595–4654 | **PRESENT** — unheaded: `Continue Phase 2 #32 from the CURRENT working tree.`; browser body-vs-rendered-sprite alignment diagnosis | Otherwise; its footer instructs a verbatim append, but the block has no `VERBATIM` label | Appears full, but its original heading is absent |
| 4656–4728 | **PRESENT** — `# Codex correction prompt — #32 initial marble fall` | Otherwise; footer instructs verbatim append | Full |
| 4730–4795 | **PRESENT** — `# Codex diagnostic prompt — #32 marble moves right` | Otherwise; footer instructs verbatim append | Full |
| 4797–4888 | **PRESENT** — `# Codex correction prompt — #32 browser physics failure` | Otherwise; footer instructs verbatim append | Full. Covers generic Ball–Teapot contact and `collision-start/contact dispatch`; literal `collisionstart` is not present |
| 5773–5878 | **PRESENT** — `# Codex prompt — Phase 2 #32 L3 “Tea Time”` | Otherwise; footer instructs verbatim append | Full initial implementation prompt |
| 5880–5970 | **PRESENT** — `# Codex correction prompt — Phase 2 #32 L3 “Tea Time”` | Otherwise; footer instructs verbatim append | Full Teapot/layout/reference-route correction |
| 5972–6040 | **PRESENT** — `# Codex diagnostic prompt — #32 tabletop physics vs visible art` | Otherwise; footer instructs verbatim append | Full invisible-geometry / `tabletop-left-geometry` diagnosis |
| 6041–6128 | **PRESENT** — `# Codex correction prompt — #32 align tabletop physics to visible table` | Otherwise; footer instructs verbatim append | Full latest tabletop-alignment correction |

## Expected-topic result

- Initial #32 / Tea Time implementation: **PRESENT**, lines 5773–5878.
- Teapot redirect/contact corrections: **PRESENT**, lines 4797–4888 and 5880–5970.
- Browser Matter collision handling / generic Ball–Teapot contact: **PRESENT**, lines 4797–4888. It says `collision-start/contact dispatch`, not the exact camel-case token `collisionstart`.
- Marble unexpectedly moving right: **PRESENT**, lines 4730–4795.
- Fix only the initial marble fall: **PRESENT**, lines 4656–4728.
- Matter body vs rendered sprite alignment diagnosis: **PRESENT**, lines 4595–4654; heading missing.
- Invisible tabletop geometry / `tabletop-left-geometry`: **PRESENT**, lines 5972–6040.
- Latest tabletop-alignment correction: **PRESENT**, lines 6041–6128.

No #32 operational block is duplicated by heading or distinctive first line. The only duplicate-like material is the table-of-contents reference at line 3688, which is not a prompt block. No block is explicitly marked `VERBATIM` or `RECONSTRUCTED`; each full operational block instead contains an instruction to append the original prompt verbatim.

## Newly appended by this audit

`# Codex diagnostic — audit #32 prompt logging` begins at line 6130. It is not included in the pre-existing inventory above and is the sole content added by this audit.

Commands observed:

```text
git status --short docs/CODEX_PROMPTS.md
 M docs/CODEX_PROMPTS.md
```

```text
git diff -- docs/CODEX_PROMPTS.md
diff --git a/docs/CODEX_PROMPTS.md b/docs/CODEX_PROMPTS.md
index 84d7e0e..59b3203 100644
--- a/docs/CODEX_PROMPTS.md
+++ b/docs/CODEX_PROMPTS.md
```

The remainder of that diff is 659 additive prompt-log lines; it contains the blocks listed above and this audit prompt. Contraption Lab was not committed or pushed.
