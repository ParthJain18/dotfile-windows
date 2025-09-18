# My PowerShell Profile (`dotfiles`)

A collection of shortcuts to streamline my development workflow on Windows. Don't forget to star if you like them!

---
## Installation

1.  Clone the repository:
    ```powershell
    git clone [https://github.com/parthjain18/dotfiles-windows.git](https://github.com/parthjain18/dotfiles-windows.git)
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