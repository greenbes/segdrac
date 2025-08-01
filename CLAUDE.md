# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the segdrac Obsidian theme based on the Dracula color scheme with custom modifications. The theme is designed to provide enhanced readability and aesthetics for Obsidian users who prefer dark themes.

## File Structure

- `theme.css` - Main theme stylesheet containing all CSS variables and styling rules
- `manifest.json` - Theme metadata for Obsidian
- `README.md` - Installation and usage documentation
- `LICENSE` - MIT license file

## Theme Architecture

The theme uses a two-tier CSS variable system:

1. **SEG Custom Variables** (lines 10-43 in theme.css) - Custom variables prefixed with `--seg-` for easy customization:
   - `--seg-dracula-*` - Core Dracula color palette
   - `--seg-content-*` - Spacing and layout variables
   - `--seg-code-*` - Code block styling
   - `--seg-*` - Theme-specific effects and styling

2. **Obsidian Standard Variables** (lines 44+ in theme.css) - Override Obsidian's built-in CSS variables to apply Dracula styling throughout the interface

## Key Features

- Unified dark mode for both light and dark themes
- Custom syntax highlighting with Dracula colors
- Distinct colors for each heading level (H1-H6)
- Enhanced code blocks with borders and syntax highlighting
- Custom styling for links, blockquotes, tables, and task lists
- Print support maintaining dark theme
- Naked embeds (embedded content without titles)

## Development Notes

- Both `.theme-dark` and `.theme-light` selectors use the same styling to ensure consistent dark appearance
- Color variables are centralized at the top of `theme.css` for easy customization
- The theme maintains compatibility with Obsidian 1.18.0+
- No build process required - direct CSS editing

## Testing

To test theme changes:
1. Copy files to Obsidian themes folder: `~/.obsidian/themes/seg-modified-dracula/`
2. Restart Obsidian or refresh theme in Settings > Appearance > Themes
3. Test in both Live Preview and Reading modes
4. Verify compatibility with various Obsidian features (code blocks, tables, links, etc.)

## Version Notes

- I am using Obsidian version 1.18.10

## Paths and Locations

- My Obsidian vault is located in `/Users/stevengreenberg/obsidian/SEG Notes/`
- Other custom themes are installed in `/Users/stevengreenberg/obsidian/SEG Notes/.obsidian/themes/`

## CLI Tools

- `jo` is a command line tool that will construct JSON structures. Documentation is available at `https://github.com/jpmens/jo/blob/master/jo.md`

## Known Limitations and Quirks

- IMPORTANT: The "name" key in `manifest.json` must EXACTLY match the name of the directory
