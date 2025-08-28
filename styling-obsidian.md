# How to Write an Obsidian Theme

Table of Contents:

<table of contents goes here>

## Files

### File: manifest.json

### File: theme.css

## Styling Elements

### Styling Internal vs External Links in Obsidian (Live Preview vs Reading View)

Obsidian Reading View: In Reading view (the preview mode), Obsidian renders 
internal wiki links (like `[[Page]]`) as standard anchor (`<a>`) elements with 
the class `internal-link`, and external links (URLs or markdown links to 
outside sites) as anchors with class `external-link`. For example, a link to 
another note might appear in the HTML as `<a href="Page.md" 
class="internal-link">Page</a>`, whereas an external URL appears as `<a 
href="https://example.com" class="external-link">example.com</a>`. Obsidian 
also marks unresolved wiki links (links to notes that don’t exist yet) with an 
additional `.is-unresolved` class on the anchor. These classes make it easy to 
target internal vs external links in CSS:

- Internal link in Reading view: target the .internal-link class.
- External link in Reading view: target the .external-link class.
- (Optionally, unresolved links: target .internal-link.is-unresolved if you want a different style for broken links.)

For instance, you could use a CSS snippet to color internal links differently from external ones in the preview:

```css
.markdown-rendered a.internal-link { color: orange; }    /* Internal wiki links */
.markdown-rendered a.external-link { color: teal; }      /* External links */
.markdown-rendered a.internal-link.is-unresolved { opacity: 0.7; } /* Unresolved links */
```

In the example above, any internal link (wiki-style or internal markdown link) will 
appear orange, external links teal, and unresolved links slightly faded. The 
`.markdown-rendered` class here scopes the styling to preview mode content only. 
Obsidian’s default themes also utilize CSS custom properties for these link types – for 
example, `--link-color` and `--link-external-color` control the text color of resolved 
internal links and external links respectively. **You can set those variables on the body 
or appropriate container to globally adjust link colors** (e.g. `body { --link-color: gold; 
--link-external-color: dodgerblue; }` for gold internal and blue external links).

Live Preview (Editable) Mode – HTML Structure and Selectors

Obsidian Live Preview: In Live Preview (the WYSIWYG editing mode introduced in Obsidian v1.x), the internal structure of links is different. Obsidian uses the CodeMirror editor under the hood, which wraps link syntax in span elements with specific classes, rather than plain anchor tags (to allow editing). Here’s how you can identify internal vs external links in Live Preview:

- Internal wiki links (`[[Page]]`): In Live Preview, these are rendered as a `<span>` with class `cm-hmd-internal-link` encompassing the link text. Inside this span, the visible link text is often in an `<a>` or `<span>` with class `cm-underline` (this class provides the underlined, clickable appearance). If the link is unresolved, the element will also have an `.is-unresolved` class (often on the same span) to indicate a missing target. For example, the DOM might look like:

```html
<span class="cm-hmd-internal-link is-unresolved">
  <a class="cm-underline">MissingNote</a>
</span>
```

for an unresolved link, or without `is-unresolved` for a resolved note link. You can target these in CSS using the classes `cm-hmd-internal-link` and `cm-underline`. For instance, to style all internal wiki links in the editor, you might use:

```css
/* Internal wiki links in Live Preview (resolved) */
.markdown-source-view.is-live-preview span.cm-hmd-internal-link:not(.is-unresolved) .cm-underline {
  color: orange;
}
/* Unresolved wiki links in editor */
.markdown-source-view.is-live-preview span.cm-hmd-internal-link.is-unresolved .cm-underline {
  color: gray;
  text-decoration: dotted underline;
}
```

In the above snippet, we restrict to live preview by scoping under `.markdown-source-view.is-live-preview` (the container for the editable view). We then select the span for internal links and its underlined text. The `:not(.is-unresolved)` ensures we only catch existing-note links in the first rule, while a second rule targets unresolved ones.

- Internal markdown links (`[Text](Note.md)` pointing to a note in the vault): These are handled slightly differently. In Live Preview, a standard markdown link is enclosed in a span with class `cm-link`. The link text will be underlined in a child element (with class `cm-underline`), similar to above. If the link’s destination is an internal note (e.g. ends with .md), Obsidian does not add any special external indicator. If the destination is external (e.g. a web URL), Obsidian will append an extra element to mark it (described below). In practice, an internal markdown link in the editor might be represented as:

```html
<span class="cm-link">
  <a href="#" class="cm-underline">Text</a>
  <!-- (the URL part is hidden in Live Preview) -->
</span>
```

To target internal markdown links in CSS, you can leverage the absence of an external marker. One reliable selector is to catch `.cm-link` spans that do not have an external sibling. Obsidian’s editor inserts a special sibling element for external links (see next point), so internal links can be selected with `:not(:has(~ .external-link)`). For example:

```css
/* Internal markdown links (Live Preview) – no external marker present */
.markdown-source-view.is-live-preview .cm-link:not(:has(~ .external-link)) .cm-underline {
  color: orange;
}
```

This will style the text of any markdown link that doesn’t have an .external-link sibling – effectively catching links to local notes or files ￼. Another method (if needed) is to use attribute selectors: Obsidian often embeds the target path in a data-link-path attribute for internal links. For instance, one could use:

```css
.cm-url[data-link-path$=".md"] { ... }
```

to target the URL part of internal links, or use `.cm-link:has([data-link-path$=".md"])` to style the whole link span. However, the sibling selector method above is commonly used and doesn’t require knowing the path.

- External links: For links pointing to external websites, Obsidian’s Live Preview adds a small indicator element. Specifically, after the span containing the link text, there will be a sibling `<span class="external-link">...</span>` (often this span contains an icon or is styled to show an arrow indicating an external link). The presence of this sibling is the key to identifying external links. The actual link text still resides in a `.cm-link` span as described, but now it has a `~ .external-link` sibling. In CSS, you can detect and style external links by targeting the `.cm-link` that has an external-link sibling, or the `a.cm-underline` within it. For example:

```css
/* External markdown links (Live Preview) – text and icon */
.markdown-source-view.is-live-preview .cm-link:has(~ .external-link) .cm-underline {
  color: teal; /* color for external link text */
}
.markdown-source-view.is-live-preview .external-link {
  filter: brightness(0.7);
  opacity: 0.8; /* dim or style the external link icon if desired */
}
```

In the snippet above, the first rule matches the underlined text of any link that has a following sibling with class `external-link` (i.e. an external link), coloring the text teal. The second rule targets the `.external-link` span itself (the icon/indicator) to adjust its appearance (here we just dim it slightly). You could also directly color that icon to match the link text. By default, Obsidian might use an SVG icon or a special character in this span; you can style it as needed via this class.

### Summary of Classes and Selectors for Link Types

In Obsidian 1.x, the following selectors allow you to distinguish link types:

- Reading view (preview):
    - `a.internal-link` – internal wiki links and internal file links ￼
    - `a.external-link` – external hyperlinks ￼
    - `a.internal-link.is-unresolved` – unresolved (broken) internal links ￼
- Live Preview (editor):
    - `span.cm-hmd-internal-link` – span wrapping a wiki-style link (`[[Page]]`).
    - Also `.is-unresolved` on this span if the target is missing.
    - `span.cm-link` – span wrapping a markdown link (the visible text part) in the editor.
    - Use `.cm-link:not(:has(~ .external-link))` to target internal links (no external sibling) ￼.
    - Use `.cm-link:has(~ .external-link)` to target external links (with the indicator sibling) ￼.
    - Child `.cm-underline` – the actual anchor/text within the above spans (often an `<a>` tag) that is underlined and clickable. For styling text color, target this element inside the span. For example, `.cm-hmd-internal-link .cm-underline { ... }` or `.cm-link .cm-underline { ... }`.
    - Sibling `.external-link` – the indicator for external links in edit mode (allows differentiation between external vs internal links in CSS) ￼.

Using these selectors, you can reliably apply distinct styles. Here’s a final example that puts it all together — say we want internal links green and external links purple, in both modes:

```css
/* Reading view styles */
.markdown-rendered a.internal-link { color: #3cb371; }           /* green for internal note links */
.markdown-rendered a.external-link { color: #9370DB; }           /* purple for external links */
.markdown-rendered a.internal-link.is-unresolved { opacity: 0.6; text-decoration: dotted underline; }

/* Live Preview styles */
.markdown-source-view.is-live-preview .cm-hmd-internal-link .cm-underline,
.markdown-source-view.is-live-preview .cm-link:not(:has(~ .external-link)) .cm-underline {
  color: #3cb371 !important;  /* green text for internal links (wiki or md) */
}
.markdown-source-view.is-live-preview .cm-link:has(~ .external-link) .cm-underline {
  color: #9370DB !important;  /* purple text for external link text */
}
.markdown-source-view.is-live-preview .external-link {
  color: #9370DB; /* style external link icon, if visible (or use filter) */
}
```

In this CSS snippet: internal wiki-links (`[[...]]`) and internal markdown links are colored green, while any link with an external indicator is colored purple. We also dim unresolved links in the reading view. The use of !important on the Live Preview text color may be necessary in some cases to override theme defaults, since the editor styling can be specific ￼. Adjust selectors or specificity as needed for your particular theme. With these rules and class selectors, Obsidian allows you to visually distinguish wiki-style internal links from external links in both editing and reading views.

References: The Obsidian developer documentation and community snippets confirm these class names and techniques. For example, the official CSS variables reference notes separate variables for internal, unresolved, and external link colors ￼. Obsidian’s forums contain examples of using selectors like `.internal-link` in preview and complex `:has()` selectors in Live Preview to target internal vs external links ￼ ￼. By leveraging those classes (as demonstrated above), you can reliably apply different styling to internal wiki links versus external links across both modes of Obsidian.


### Styling Block Quotes


