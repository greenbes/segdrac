# segdrac Theme for Obsidian

A carefully crafted Dracula-based dark theme for [Obsidian](https://obsidian.md) that enhances readability while maintaining the classic Dracula aesthetic.

1. Download `theme.css` and `manifest.json` from this repository
2. Open Obsidian Settings → Appearance → Themes
3. Click "Open themes folder"
4. Create a new folder called `segdrac`
5. Copy both files into the `segdrac` folder
6. Restart Obsidian
7. Select "segdrac" from the theme dropdown

### Quick Install (macOS/Linux)
If you have `just` installed, simply run:
```bash
just install
```

## Customization

The theme uses CSS variables prefixed with `--seg-` for easy customization. Create a CSS snippet in `.obsidian/snippets/` to override:

- `--seg-dracula-*` - Color palette
- `--seg-content-*` - Spacing and layout
- `--seg-border-*` - Border styles

## Compatibility

- **Minimum Obsidian**: 0.16.0
- **Modes**: Live Preview and Reading
- **Print Support**: Maintains dark theme when printing

## License & Credits

MIT License

Based on the [Dracula Theme](https://draculatheme.com/) color palette.
Modified by [SEG](https://github.com/greenbes)

## Author

- Modified by: SEG
- GitHub: [https://github.com/greenbes](https://github.com/greenbes)

## Acknowledgments

- Original [Dracula Theme](https://draculatheme.com/) creators
- Obsidian community for inspiration and feedback
