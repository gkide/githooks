# githooks

Those are the git hooks for local repo use, make it consistent and simple.

# Install nodejs & npm
[node_js_url]: https://nodejs.org/en/
[node_js_npm_url]: https://www.npmjs.com/
[validate_commit_msg_url]: https://github.com/conventional-changelog/validate-commit-msg
[standard_version_url]: https://github.com/conventional-changelog/standard-version

- install [node.js][node_js_url] and [npm][node_js_npm_url]
  - download **node-vx.x.x-x86/64.msi** and install for *windows*
  - install commands for *ubuntu*
    - `$ sudo apt install nodejs`
    - `$ sudo apt install nodejs-legacy`
  - install commands for *macos*
    - `$ brew install node`
- Check is node.js and npm install correctly
  - `$ npm --version`
  - `$ node --version`
- Install [validate-commit-msg][validate_commit_msg_url]
  - `$ npm install -g validate-commit-msg`
- Install [standard-version][standard_version_url]
  - `$ npm install -g standard-version`

# Configurations
- No mixing **LF** and **CRLF** by using `$ git config core.safecrlf true`
- Git newer than 2.9.0, conventional(Conventional.md) checking & git hooks:
  - `$ cd path/to/repo && mkdir scripts && cd scripts`
  - `$ git clone https://github.com/gkide/githooks`
  - `$ cd ..`
  - `$ git config core.hooksPath ${PWD}/scripts/githooks`
  - `$ git config commit.template ${PWD}/scripts/githooks/GitCommitStyle`
- Git older than 2.9.0, conventional(Conventional.md) checking & git hooks:
  - Clone & copy **githooks** to the `repo/.git/hooks/`
  - `$ git config commit.template path/to/GitCommitStyle`

# About Git Hooks
As of [2.9.0 the docs address][git_scm_docs_githooks_url]:

Before Git invokes a hook, it changes its working directory to either the root of
the working tree in a non-bare repository, or to the `$GIT_DIR` in a bare repository.

[git_scm_docs_githooks_url]: https://git-scm.com/docs/githooks/2.9.0

# Reference
- [Git Config][git_config_url]
- [Missing Git Hooks Docs][missing_git_hooks_docs_url]

[git_config_url]: https://git-scm.com/docs/git-config
[missing_git_hooks_docs_url]: https://longair.net/blog/2011/04/09/missing-git-hooks-documentation


