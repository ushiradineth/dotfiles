# Flake Outputs

## Is such a complex and fine-grained structure necessary?

There is no need to do this when you have a small number of machines.

But when you have a large number of machines, it is necessary to manage them in a fine-grained way,
otherwise, it will be difficult to manage and maintain them.

The number of my machines has grown to more than 20, and the increase in scale has shown signs of
getting out of control of complexity, so it is a natural and reasonable choice to use this
fine-grained architecture to manage.

Related projects & docs:

- [haumea](https://github.com/nix-community/haumea): Filesystem-based module system for Nix

## Overview

All the outputs of this flake are defined here.

```bash
› tree
.
├── default.nix       # The entry point, all the outputs are composed here.
├── README.md
├── aarch64-darwin    # All outputs for macOS Apple Silicon
│   ├── default.nix
│   └── src           # every host has its own file in this directory
│       └── shu.nix
└── x86_64-linux      # All outputs for Linux x86_64
    ├── default.nix
    └── src           # every host has its own file in this directory
        └── shulab.nix

```
