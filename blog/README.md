# Math Equations in Blog Posts

## Inline Equations

Use `\(...\)` delimiters:

```markdown
\(E = mc^2\)
```

## Block Equations

Use `$$...$$` delimiters:

```markdown
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$
```

Or use `\[...\]` delimiters:

```markdown
\[
a^2 + b^2 = c^2
\]
```

## Per-Page Control

To enable math only on specific pages, add to front matter:

```yaml
---
params:
  math: true
---
```
