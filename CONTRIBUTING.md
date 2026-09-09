# Contributing to moonbit-easing

Thank you for your interest in contributing to moonbit-easing!

## How to Contribute

### Reporting Issues
- Use GitHub Issues to report bugs
- Include MoonBit version and OS information
- Provide minimal reproduction steps

### Suggesting Features
- Open an issue with the "enhancement" label
- Describe the use case and expected behavior
- Consider if it fits the library's scope (pure mathematical easing functions)

### Code Contributions

#### Setup
```bash
# Clone the repository
git clone https://github.com/Kai-Junhan/moonbit-easing.git
cd moonbit-easing

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
- Add comments for complex mathematical formulas
- Keep functions focused and composable

#### Testing
- Add unit tests for new easing functions
- Test edge cases (t=0, t=1, t<0, t>1)
- Verify mathematical correctness

## Development Principles

### Scope
This library focuses on:
- Pure mathematical easing functions
- Cubic Bezier curve evaluation
- Easing composition utilities

Out of scope:
- Animation timeline management
- DOM manipulation
- Rendering/graphics

### Performance
- Keep functions lightweight
- Avoid unnecessary allocations
- Consider caching for expensive computations

### API Design
- Maintain functional programming style
- Use clear, consistent naming
- Provide both simple and advanced APIs

## Questions?

Feel free to open an issue for discussion before starting major work.

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
