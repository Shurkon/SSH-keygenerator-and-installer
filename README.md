# SSH Key Generator & Installer

A simple Bash script that generates an RSA 4096-bit SSH key and copies it to a remote server's `authorized_keys`. Supports custom SSH ports.

## Usage

Run the script:

```bash
./ssh-addkey.sh
```

Follow the prompts for:

- SSH key name  
- Server IP or hostname  
- SSH username  
- SSH port (default: 22)

After running, use your key to SSH:

```bash
ssh -i ~/.ssh/<keyname> -p <port> <user>@<host>
```
