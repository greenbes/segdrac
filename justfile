# segdrac Obsidian Theme justfile

# Variables
vault_path := "${HOME}/SEG Notes"
theme_name := "segdrac"
theme_dir := vault_path + "/.obsidian/themes/" + theme_name

# Default recipe - list available commands
default:
    @just --list

# Install theme to Obsidian vault
install:
    @echo "Installing {{theme_name}} theme to Obsidian vault..."
    mkdir -p "{{theme_dir}}"
    cp theme.css "{{theme_dir}}/theme.css"
    @cp manifest.json "{{theme_dir}}/manifest.json"
    @echo "Theme installed successfully!"
    @echo "To use: Open Obsidian > Settings > Appearance > Themes > {{theme_name}}"

# Backup current theme before installing
backup:
    @echo "Backing up current theme..."
    @mkdir -p backups
    @cp -f "{{theme_dir}}/theme.css" "backups/theme-$(date +%Y%m%d-%H%M%S).css" 2>/dev/null || echo "No existing theme to backup"
    @echo "Backup complete!"

# Install with backup
safe-install: backup install

# Watch for changes and auto-install
watch:
    @echo "Watching for theme changes..."
    @echo "Press Ctrl+C to stop"
    @while true; do \
        fswatch -1 theme.css manifest.json 2>/dev/null || inotifywait -e modify theme.css manifest.json 2>/dev/null; \
        echo "Changes detected, reinstalling..."; \
        just install; \
    done

# Validate theme files
validate:
    @echo "Validating theme files..."
    @if [ ! -f "theme.css" ]; then echo "ERROR: theme.css not found"; exit 1; fi
    @if [ ! -f "manifest.json" ]; then echo "ERROR: manifest.json not found"; exit 1; fi
    @echo "Checking manifest.json..."
    @cat manifest.json | jq . > /dev/null && echo "✓ manifest.json is valid JSON" || echo "✗ manifest.json has JSON errors"
    @echo "Checking theme name consistency..."
    @if [ "$(cat manifest.json | jq -r .name)" = "{{theme_name}}" ]; then \
        echo "✓ Theme name matches directory name"; \
    else \
        echo "✗ Theme name in manifest.json doesn't match expected: {{theme_name}}"; \
    fi

# Clean backups older than 7 days
clean-backups:
    @echo "Cleaning old backups..."
    @find backups -name "theme-*.css" -mtime +7 -delete 2>/dev/null || true
    @echo "Old backups removed"

# Show theme info
info:
    @echo "Theme: {{theme_name}}"
    @echo "Version: $(cat manifest.json | jq -r .version)"
    @echo "Author: $(cat manifest.json | jq -r .author)"
    @echo "Min Obsidian Version: $(cat manifest.json | jq -r .minAppVersion)"
    @echo ""
    @echo "Vault Path: {{vault_path}}"
    @echo "Theme Directory: {{theme_dir}}"
    @echo ""
    @echo "Files:"
    @ls -la theme.css manifest.json 2>/dev/null || true

# Lint CSS file
lint:
    @echo "Linting CSS..."
    @if command -v stylelint >/dev/null 2>&1; then \
        stylelint theme.css || true; \
    else \
        echo "stylelint not found. Install with: npm install -g stylelint stylelint-config-standard"; \
    fi

# Format CSS file
format:
    @echo "Formatting CSS..."
    @if command -v prettier >/dev/null 2>&1; then \
        prettier --write theme.css; \
    else \
        echo "prettier not found. Install with: npm install -g prettier"; \
    fi
