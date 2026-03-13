#!/usr/bin/env python3
"""Merge starship.remote.toml with starship.local.toml into starship.toml.

Deep-merges the local file on top of the remote (dotfiles-tracked) config.
Nested tables (e.g. [git_branch]) are merged key-by-key; top-level scalars
and the format string are overridden wholesale.

If no local file exists, copies remote as-is to starship.toml.
"""

import sys
from pathlib import Path

try:
    import tomli
    import tomli_w
except ImportError:
    sys.exit(1)

CONFIG_DIR = Path.home() / ".config"
REMOTE = CONFIG_DIR / "starship.remote.toml"
LOCAL = CONFIG_DIR / "starship.local.toml"
OUTPUT = CONFIG_DIR / "starship.generated.toml"


def deep_merge(base: dict, override: dict) -> dict:
    merged = dict(base)
    for key, value in override.items():
        if key in merged and isinstance(merged[key], dict) and isinstance(value, dict):
            merged[key] = deep_merge(merged[key], value)
        else:
            merged[key] = value
    return merged


def main():
    if not REMOTE.exists():
        sys.exit(1)

    with open(REMOTE, "rb") as f:
        base = tomli.load(f)

    if LOCAL.exists():
        with open(LOCAL, "rb") as f:
            local = tomli.load(f)
        base = deep_merge(base, local)

    with open(OUTPUT, "wb") as f:
        tomli_w.dump(base, f)


if __name__ == "__main__":
    main()
