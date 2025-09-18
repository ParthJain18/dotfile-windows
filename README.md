# My PowerShell Profile (`dotfiles`)

A collection of shortcuts to streamline my development workflow on Windows. Don't forget to star if you like them!

---
## Installation

1.  Clone the repository:
    ```powershell
    git clone https://github.com/ParthJain18/dotfile-windows
    ```
2.  Open an **Administrator** PowerShell and create a symbolic link to your profile:
    ```powershell
    # Make sure to remove your old profile first
    New-Item -ItemType SymbolicLink -Path $PROFILE -Target "C:\path\to\your\dotfiles\Microsoft.PowerShell_profile.ps1"
    ```

---
## Functions 📜

### Git
| Function | Description |
| :--- | :--- |
| `gtree` | Displays a tree view of all files tracked by Git. |
| `gspull` | Safely pulls changes by stashing, pulling, and then applying the stash. |
| `gundo` | Undoes the last commit, keeping the changes staged for re-work. |
| `gamend` | Adds all current changes and amends them to the previous commit. |
| `gpushf` | Force pushes safely using `--force-with-lease`. |

### System & Networking
| Function | Description |
| :--- | :--- |
| `killport <port>` | Finds and kills the process running on a specific port. |
| `ports` | Lists all listening ports and the names of the processes using them. |
| `openhere` | Opens the current directory in Windows File Explorer. |
| `paste-to-files <path>` | Pastes clipboard content into a file (use `-a` to append). |

### Development
| Function | Description |
| :--- | :--- |
| `upy [script] [args]` | Runs a Python script using `uv run` (defaults to `main.py`). |
| `Copy-Files` | Opens an interactive `fzf` menu to select multiple files, formats their content as Markdown, and copies it to the clipboard. (Requires fzf and bat to be installed) |

## Dependencies

#### Install a Nerd Font

- A Nerd Font is required for prompt icons to display correctly.

- Download and install a font like FiraCode Nerd Font.

- Set your terminal's font to FiraCode Nerd Font Mono.

#### The prompt and helper functions require Oh My Posh, fzf, and bat.

- Open PowerShell and run this command to install all of them:

```PowerShell
winget install --id JanDeDobbeleer.OhMyPosh --scope user; winget install --id junegunn.fzf; winget install --id sharkdp.bat
```