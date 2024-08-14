### 1. Install dependencies
```sh
xcode-select --install
```
### 2. Install Nix
[Installer](https://zero-to-nix.com/concepts/nix-installer) from [Determinate Systems](https://determinate.systems/)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
After installation, open a new terminal session to make the `nix` executable available in your `$PATH`.

### 3. Initialize ~/.config/nix-config
```sh
mkdir -p ~/.config && cd ~/.config
git clone https://github.com/b4lisong/nix-config.git
```

### 4. Make [apps](https://github.com/b4lisong/nix-config/tree/main/apps) executable
```sh
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys \) -exec chmod +x {} \;
```

### 5. Setup secrets
#### Install keys
Before generating your first build, these keys must exist in your `~/.ssh` directory.

| Key Name            | Platform         | Description                           | 
|---------------------|------------------|-----------------------------------------------------------|
| id_ed25519          | macOS / NixOS    | Download secrets from Github. Used only during bootstrap. |
| id_ed25519_agenix   | macOS / NixOS    | Copied over, used to encrypt and decrypt secrets.         |

##### Check keys
```sh
nix run .#check-keys
```
### 6. Install configuration
Ensure the build works before deploying the configuration, run:
```sh
nix run .#build
```
> [!NOTE]
> If you're using a git repository, only files in the working tree will be copied to the [Nix Store](https://zero-to-nix.com/concepts/nix-store).
>
> You must run `git add .` first.

> [!WARNING]
> You may encounter `error: Unexpected files in /etc, aborting activation` if `nix-darwin` detects it will overwrite
> an existing `/etc/` file. The error will list the files like this:
> 
> ```
> The following files have unrecognized content and would be overwritten:
> 
>   /etc/nix/nix.conf
>   /etc/bashrc
> 
> Please check there is nothing critical in these files, rename them by adding .before-nix-darwin to the end, and then try again.
> ```
> Backup and move the files out of the way and/or edit your Nix configuration before continuing.

### 7. Make changes
Finally, alter your system with this command:
```sh
nix run .#build-switch
```
