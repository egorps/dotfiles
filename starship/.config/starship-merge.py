#!/usr/bin/env python3
"""Merge starship.toml with starship.local.toml (if present).

Deep-merges the local file on top of the base config. Nested tables
(e.g. [git_branch]) are merged key-by-key; top-level scalars and the
format string are overridden wholesale.

Output goes to starship.generated.toml.
"""

import sys
from pathlib import Path

try:
    import tomli
    import tomli_w
except ImportError:
    sys.exit(1)

CONFIG_DIR = Path.home() / ".config"
BASE = CONFIG_DIR / "starship.toml"
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
    if not BASE.exists():
        sys.exit(1)

    if not LOCAL.exists():
        # No local overrides — point starship at the base config directly
        print(str(BASE))
        return

    with open(BASE, "rb") as f:
        base = tomli.load(f)
    with open(LOCAL, "rb") as f:
        local = tomli.load(f)

    merged = deep_merge(base, local)

    with open(OUTPUT, "wb") as f:
        tomli_w.dump(merged, f)

    print(str(OUTPUT))


if __name__ == "__main__":
    main()
