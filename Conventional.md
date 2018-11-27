# Conventional Commits Format

```
<type>(scope): <subject>

[Optional Body]

[Optional Footer]

```

- `<type>` & `<subject>` are expected, others are optional
- All message lines prefer not being longer than 100 characters

## `<type>` should be one of

- `ci` CI configuration changes
- `fix` A bug fix
- `docs` Documentation changes
- `test` Adding new or correcting existing tests
- `build` Changes that do affect the build system
- `style` Changes that do not affect the code meaning
- `feature` Introduce or modify the codebase features 
- `performance` Code changes that improves the performance
- `chore` Other changes that don't modify src or test files
- `revert` Revert a previous commit
- `refactor` Changes that neither fixes a bug nor adds a feature

## `<scope>` is optional

If any, it should be one word for further supplement, for example:

- Use `*` when the change affects more than a single scope
- **compile** changes has relation with compilation
- **network** for changes that related to a module, like network

## `<subject>` should be a short line of succinct description for the changes

The subject should following the rules:

- no dot `.` at the end of line
- do not capitalize the first letter
- use the imperative, present tense: "change" not "changed" nor "changes"

## `<body>` is optional

If any, it should include motivation for the change and following the rules:

- what this commit changes, and why?
- use the imperative, present tense: "change" not "changed" nor "changes"

## `<footer>` is optional

If any, it should contain information about the following ones:

- Breaking Changes, the following format:
```
[BREAKING]: a short description message for the breaking changes
    - more details information
```

- Issues Reference that this commit closes, the format as following:
```
[CLOSE(ISSUE)]: a short description message contains the issue reference
    - more details information
```

# Reference
- [Conventional Commits](https://github.com/conventional-commits/conventionalcommits.org)
