# CLAUDE.md

This file provides guidance to Claude Code when working with the segdrac Obsidian theme repository.

## Project Overview

Segdrac is a Dracula-based dark theme for Obsidian with custom enhancements for improved readability and aesthetics. Compatible with Obsidian 1.18.0+.

## File Structure

- `theme.css` - Main stylesheet with all CSS variables and styling rules
- `manifest.json` - Theme metadata (name must match directory name)
- `README.md` - User-facing documentation
- `LICENSE` - MIT license

## Theme Architecture

### CSS Variable System (Two-tier approach)

1. **SEG Custom Variables** (lines 16-54) - Prefixed with `--seg-` for easy customization:
   - `--seg-dracula-*` - Core Dracula color palette
   - `--seg-content-*` - Spacing and layout
   - `--seg-code-*` - Code block styling
   - `--seg-border-*` - Border definitions
   - `--seg-*-font-style` - Typography effects
   - `--seg-transition-*` - Animation timing

2. **Obsidian Standard Variables** (lines 57-169) - Override built-in variables to apply theme globally

## Key Features

- Unified dark mode (both light/dark themes use same styling)
- Custom syntax highlighting with Dracula colors
- Distinct heading colors (H1-H6)
- Enhanced search result highlighting
- Naked embeds (content without titles)
- Custom blockquotes with yellow accent
- Improved tables with clear borders
- Task lists with custom checkboxes
- Nested list relationship lines
- Plugin support (Calendar, Kanban, Dataview, etc.)
- Print support maintaining dark theme

## Major CSS Sections

- **LINKS & BRACKETS** - Link styling and differentiation
- **EMBEDDED CONTENT** - Embed styling with colored borders
- **CODEBLOCKS** - Syntax highlighting and code appearance
- **SEARCH HIGHLIGHTING** - Search result visibility improvements
- **PLUGIN SUPPORT** - Compatibility with popular plugins
- **TEXT SELECTION** - Selection color customization

## Known Limitations

- Directory name in manifest.json must EXACTLY match theme folder name
- Installation directory is "obsidian" (lowercase), not "Obsidian" (backup)