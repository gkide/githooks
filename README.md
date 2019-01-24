# Githooks

![release](https://img.shields.io/github/release/gkide/githooks.svg)
![latest](https://img.shields.io/github/tag-date/gkide/githooks.svg?colorB=orange)

![top-language-rate](https://img.shields.io/github/languages/top/gkide/githooks.svg)
![languages-count](https://img.shields.io/github/languages/count/gkide/githooks.svg)
![code-size](https://img.shields.io/github/languages/code-size/gkide/githooks.svg)
![downloads-count](https://img.shields.io/github/downloads/gkide/githooks/total.svg)
![open-issues](https://img.shields.io/github/issues/gkide/githooks.svg)
![open-pull-requests](https://img.shields.io/github/issues-pr/gkide/githooks.svg)

The git hooks for local usage, make it consistent and simple.

## Recommend Usage

### Step 1: NodeJS

[node_js_url]: https://nodejs.org/en/
[node_js_npm_url]: https://www.npmjs.com/
[standard_release_url]: https://www.npmjs.com/package/@gkide/standard-release

- Install NodeJS

  - install [node.js][node_js_url] and [npm][node_js_npm_url]

    * download & install from one of [NodeJS](https://nodejs.org/en/download/)
    * download, uncompression and setup environment **PATH**

  - Check is node.js and npm install correctly

    * `$ npm --version`
    * `$ node --version`

- Install [standard-release][standard_release_url]

  * Local install: `$ npm install @gkide/standard-release`
  * Global install: `$ npm install -g @gkide/standard-release`

### Step 2: Githooks

- Local Configurations

  - No mixing **LF** and **CRLF** by using `$ git config core.safecrlf true`

  - Git newer than 2.9.0, [conventional](./Conventional.md) checking & git hooks:

    * `$ cd path/to/repo && standard-release -i && cd .standard-release`
    * It maybe a better idea to add **.standard-release** to **.gitignore**
    * `$ git clone https://github.com/gkide/githooks`
    * `$ cd ..`
    * `$ git config core.hooksPath ${PWD}/.standard-release/githooks`
    * `$ git config commit.template ${PWD}/.standard-release/githooks/GitCommitStyle`

  - Git older than 2.9.0, [conventional](./Conventional.md) checking & git hooks:

    * Clone **githooks** into the `path/to/repo/.git/hooks/`
    * `$ git config commit.template path/to/GitCommitStyle`

- Global Configurations

  - Git newer than 2.9.0, [conventional](./Conventional.md) checking & git hooks:

    * `$ cd && git clone https://github.com/gkide/githooks .githooks`
    * `$ git config --global core.hooksPath ~/.githooks`
    * `$ git config --global commit.template ~/.githooks/GitCommitStyle`

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


