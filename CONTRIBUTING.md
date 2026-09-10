# Contributing to MoonBit Motion Lab

Thank you for your interest in contributing to MoonBit Motion Lab!

## How to Contribute

### Reporting Issues
- Use GitHub Issues to report bugs
- Include MoonBit version and OS information
- Provide minimal reproduction steps

### Suggesting Features
- Open an issue with the "enhancement" label
- Describe the use case and expected behavior
- Consider whether the change fits the toolkit's scope: parameterized motion curves, custom curve evaluation, sampling, diagnostics, and timeline compilation.

### Code Contributions

#### Setup
```bash
# Clone the repository
git clone https://github.com/Kai-Junhan/moonbit-motion-lab.git
cd moonbit-motion-lab

# Run tests
moon test

# Check formatting
moon fmt --check
```

#### Pull Request Guidelines
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-easing`)
3. Make your changes with clear commit messages
4. Add tests for new functionality
5. Ensure all tests pass (`moon test`)
6. Update documentation if needed
7. Submit a pull request

#### Code Style
- Follow existing code patterns
- Use descriptive variable names
- Add comments only when a mathematical or numerical constraint is not obvious
- Keep functions focused and composable

#### Testing
- Add tests for new curve, sampling, diagnostic, or timeline behavior
- Test endpoints and boundary inputs
- Verify numerical behavior with tolerances where appropriate

## Development Principles

### Scope
This toolkit focuses on:
- Parameterized motion curves and custom curve evaluation
- Cubic Bezier evaluation for user-provided control points
- Sampling, interpolation, diagnostics, and timeline compilation

Out of scope:
- A catalogue of standard easing equations or CSS easing presets
- DOM manipulation or rendering
- Animation scheduling or runtime loops

### Performance
- Keep numerical functions lightweight
- Avoid unnecessary allocations
- Prefer deterministic calculations

### API Design
- Maintain functional programming style
- Use clear, consistent naming
- Keep curve inputs explicit and composable

## Questions?

Feel free to open an issue for discussion before starting major work.

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
