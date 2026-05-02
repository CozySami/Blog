# Math Equations in Blog Posts

This blog uses **MathJax** to render LaTeX equations in Markdown posts. Math rendering is **enabled globally** by default.

## Setup

The math rendering is configured in `hugo.toml`:

```toml
[markup.goldmark.extensions.passthrough]
  enable = true
  [markup.goldmark.extensions.passthrough.delimiters]
    block = [ ['\[', '\]'], ['$$', '$$'] ]
    inline = [ ['\(', '\)'] ]
```

## Usage

### Inline Equations

Use `\(...\)` delimiters within text:

```markdown
This is an inline equation \(E = mc^2\) in the middle of a sentence.
```

### Block Equations

Use `$$...$$` delimiters on their own lines with blank lines before and after:

```markdown
Some text above.

$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

Some text below.
```

Or use `\[...\]` delimiters:

```markdown
Some text above.

\[
a^2 + b^2 = c^2
\]

Some text below.
```

## Important Notes

1. **Blank lines are required** around block equations for them to be recognized
2. **Avoid raw `<` and `>` characters** in LaTeX - use `\langle`/`\rangle` or `\textless`/`\textgreater` instead
   - Bad: `\mathbf{i}_{<t}`
   - Good: `\mathbf{i}_{\langle t \rangle}`

## Per-Page Control

Math is enabled globally via `math = true` in `[params]` section of `hugo.toml`.

To **disable** math on a specific page, add to front matter:

```yaml
---
params:
  math: false
---
```
