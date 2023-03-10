# [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) for CUDA on NixOS

This is literally just a `shell.nix`/`flake.nix` for stable-diffusion-webui using CUDA on NixOS.
This currently doesn't support AMD cards (I don't have one) but feel free to contribute.

## Usage
```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
git clone https://github.com/virchau13/automatic1111-webui-nix
cp automatic1111-webui-nix/*.nix stable-diffusion-webui/
cd stable-diffusion-webui
nix shell # or `nix-shell` if you're not using flakes
# just use `./webui.sh` to run it, it'll install all the rest automatically
# follow the tutorials at the original project for setting up Stable Diffusion / GFPGAN / whatever
```

You might want to switch to high performance mode on battery-powered devices.

## Is this completely pure?

This is just a Nix shell for bootstrapping the web UI, not an actual pure flake; the `./webui.sh` will still install
a bunch of Python packages (into a venv, so not polluting your system) when you run it.

## Credits
- AUTOMATIC1111 for obvious reasons.
- polypoyo for [the original draft of this](https://github.com/AUTOMATIC1111/stable-diffusion-webui/pull/4736).
