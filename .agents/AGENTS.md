## Typst 0.12+ Compatibility and Packages
- **Package Versions**: Always use @preview/codly:1.3.0 (or newer) to avoid pattern variable crashes. Use @preview/fletcher:0.5.8 (or newer) and @preview/cetz:0.3.4 (or newer) to avoid coordinate resolution panics.
- **Codly Syntax**: Never use stroke-width: or stroke-color:. Use the combined stroke: parameter.

## CeTZ Drawing Syntax
- **Marks/Arrows**: When drawing lines with arrows in cetz, always use dictionary syntax: mark: (end: ">") instead of mark: ">".
- **Shadowing**: Inside #cetz.canvas({ ... }), standard Typst shapes like circle and ect are shadowed by cetz functions that expect coordinate arrays. If you need standard Typst shapes (e.g., inside a content() block for a legend), explicitly call #std.circle() or #std.rect().
