# Conventional Commits Format

```
<type>(<scope>): <subject>
<HERE-SHOULD-BE-ONE-BLANK-LINE>
<body>
<HERE-SHOULD-BE-ONE-BLANK-LINE>
<footer>
```

- `<type>` & `<subject>` are expected, others are optional
- All message lines prefer not being longer than 80 characters


## `<type>` should be one of

> Version Major

- **Incompatible**: `major` for explicit bump major verion.
- **Incompatible**: `break` for make any incompatible changes.
- **Incompatible**: `breaking` for make any incompatible changes.
- **Security**: `security` for anything related with vulnerabilities and security.
- **Deprecated**: `deprecated` for functionality or API which are soon-to-be removed.

> Version Minor

- **Features**: `minor` for explicit bump minor verion.
- **Features**: `feat` for new or modify features in backwards-compatible manner.
- **Features**: `feature` for new or modify features in backwards-compatible manner.

> Version Patch

- **Fixed**: `fix` for any bug fixes.
- **Fixed**: `patch` for any bug fixes.
- **Fixed**: `bugfix` for any bug fixes.

> Version Tweak

- **Changed**: `perf` for changes that improves the performance.
- **Changed**: `revert` for revert to a previous commit.
- **Changed**: `refactor` for neither bugfix nor feature changes.

- **Preview**: `wip` for something which is working in process or perview.
- **Preview**: `preview` for something which is working in process or perview.

- **Dependencies**: `deps` for any external dependencies changes.
- **Dependencies**: `build` for changes that affect the build system.

> Version Unrelated

- `ci` CI configuration changes.
- `docs` Documentation changes.
- `test` Adding new or correcting existing tests.
- `style` Changes that do not affect the code meaning.
- `chore` Other changes that don't modify src or test files.
- `skip` Skip commit style checking for some reason.


## `<scope>` is optional

If any, it should be one word for further supplement, for example:

- Use `*` when the change affects more than a single scope
- **compile** changes has relation with compilation
- **network** for changes that related to a module, like network


### `<subject>` should be a short line of succinct description for the changes

The subject should following the rules:

- no dot `.` at the end of line
- do not capitalize the first letter
- use the imperative, present tense: "change" not "changed" nor "changes"


## `<body>` is optional

If any, it should include motivation for the change and following the rules:

- what this commit changes, and why?
- use the imperative, present tense: "change" not "changed" nor "changes"


## `<footer>` is optional

If any, it should be one of the following ones:

- Closed Issues, the format is:
```
[CLOSE] a short description message for the closed issue
- more details information
```
or

```
[CLOSE#1] a short description message for the closed issue
- more details information
[CLOSE#2] a short description message for the closed issue
- more details information
```

- Known Issue, the format is:
```
[KNOWN ISSUE] a short description message for the known issue
- more details information
```
or

```
[KNOWN ISSUE#1] a short description message for the known issue
- more details information
[KNOWN ISSUE#2] a short description message for the known issue
- more details information
```

- Breaking Changes, the format is:
```
[BREAKING CHANGES] A short description message for the breaking changes
- more details information
```
or

```
[BREAKING CHANGES#1] A short description message for the breaking changes
- more details information
[BREAKING CHANGES#2] A short description message for the breaking changes
- more details information
```

# Reference

- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://github.com/conventional-commits/conventionalcommits.org)
- [Change Log Style](https://codingart.readthedocs.io/en/latest/ChangeLog.html)
- [Ideal Change Log](https://github.com/gkide/coding-style/blob/master/data/CHANGELOG.md)
