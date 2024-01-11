Prototype x86 Yocto Build (yocto-x86-proto)
======================================
This repository contains the scripts to download all the source code required and build a working Linux image on an x86 platform.

The target hardware is an [UP Squared 6000](https://up-board.org/up-squared-6000/) development board.

To build the project:
--------------------------------------
Firstly get all the source code:

```
./scripts/get-sources.sh
```

Then perform the build:

```
./scripts/build.sh
```

**Note: When building for the first time, there will be an error encountered. Running the build script again should resolve the error.**

When build is complete, the generated image can be found in `artifacts/upboard-image-base-up-squared-6000.hddimg`. This image can then be written into a bootable USB using the `dd` command or a graphical writing application like [balenaEtcher](https://etcher.balena.io/).


Adding source code
--------------------------------------

To include additional meta layers and source code into the project:

1. Copy all the required source code into the `sources` folder.
2. Edit `build.sh`
    * In the section under `Set Up Config`, add configuration lines that will be written into *local.conf*
    * In the section under `Set Up Meta Layers`, add `BBLAYERS` and `BBMASK` lines that will be written into *bblayers.conf*
3. Run the build script again to test the build.