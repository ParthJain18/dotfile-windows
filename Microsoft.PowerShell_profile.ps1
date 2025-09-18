function gtree {
    $files = git ls-files | Sort-Object
    $tree = @{}

    foreach ($file in $files) {
        $parts = $file -split '[\\/]'
        $path = ""
        for ($i = 0; $i -lt $parts.Length; $i++) {
            $path = if ($path) { "$path/$($parts[$i])" } else { $parts[$i] }
            if (-not $tree.ContainsKey($path)) {
                $tree[$path] = $i
            }
        }
    }

    foreach ($path in ($tree.Keys | Sort-Object)) {
        $depth = $tree[$path]

        if ($depth -le 0) {
            $indent = ""
        } else {
            $indent = ("|   " * ($depth - 1))
        }

        $prefix = if ($depth -gt 0) { "$indent+-- " } else { "" }
        Write-Output "$prefix$([System.IO.Path]::GetFileName($path))"
    }
}

function gspull { git stash; git pull; git stash pop }

function gundo { git reset --soft HEAD~1 }

function gamend { git add .; git commit --amend --no-edit }

function gpushf { git push --force-with-lease }

function killport { 
    param([int]$port) 
    $p = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue 
    if ($p) { 
        Stop-Process -Id $p.OwningProcess -Force 
        Write-Output "Killed process on port $port" 
    } else { 
        Write-Output "No process found on port $port" 
    }
}

function ports {
    Get-NetTCPConnection -State Listen |
        Select-Object LocalPort, OwningProcess, @{n="ProcessName"; e={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).Name}} |
        Format-Table -AutoSize
}

function openhere { ii . }

function paste-to-files {
    param(
        [Parameter(Mandatory=$true)]
        [string]$path,

        [switch]$a  # append mode
    )

    $content = Get-Clipboard

    if ($a) {
        Add-Content -Path $path -Value $content
        Write-Output "Appended clipboard to $path"
    } else {
        Set-Content -Path $path -Value $content
        Write-Output "Wrote clipboard to $path (overwrote if it existed)"
    }
}

function upy {
    param(
        [string]$script = "main.py",
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )
    uv run python $script @args
}

function Copy-Files {
    # Language map for Markdown syntax highlighting
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue) -or -not (Get-Command bat -ErrorAction SilentlyContinue)) {
        Write-Host "Error: 'fzf' and 'bat' are required for this function." -ForegroundColor Red
        Write-Host "Please install them (e.g., 'scoop install fzf bat')" -ForegroundColor Yellow
        return
    }
    $langMap = @{
        ".ps1" = "powershell"; ".py"  = "python";   ".js"  = "javascript";
        ".ts"  = "typescript"; ".jsx" = "jsx";      ".tsx" = "tsx";
        ".html"= "html";       ".css" = "css";      ".json"= "json";
        ".md"  = "markdown";   ".java"= "java";     ".cs"  = "csharp";
        ".cpp" = "cpp";        ".c"   = "c";        ".go"  = "go";
        ".rs"  = "rust";       ".sh"  = "shell";    ".sql" = "sql";
        ".yaml"= "yaml";       ".yml" = "yaml"
    }

    # 1. Run fzf and capture the selected file paths into an array
    $selectedPaths = fzf --multi --preview "bat --color=always --line-range :50 {}"

    # Exit if the user cancelled (fzf outputs nothing)
    if (-not $selectedPaths) {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        return
    }

    $fileCount = $selectedPaths.Count
    $processedCount = 0

    # 2. Process the array of paths and pipe the formatted strings to the clipboard
    $selectedPaths | ForEach-Object {
        $processedCount++
        $relativePath = $_.Replace("$PWD\", "")
        $extension = [System.IO.Path]::GetExtension($_).ToLower()
        
        # Tweak 2: Safely get the language, defaulting to an empty string if not found
        $language = ""
        if ($langMap.ContainsKey($extension)) {
            $language = $langMap[$extension]
        }

        # Output the formatted block
        "File: $relativePath"
        "````$language"
        Get-Content -Raw $_
        "````"

        # Tweak 1: Only add a separator if it's NOT the last file
        if ($processedCount -lt $fileCount) {
            "---"
            ""
        }
    } | clip.exe

    Write-Host "$fileCount file(s) formatted and copied to clipboard!" -ForegroundColor Green
}