# claude

My Claude Code configuration

## Assumptions

- OS is macOS
- golang is installed
- node is installed

## Install

### Claude

Install claude using the official method for macOS (<https://code.claude.com/docs/en/quickstart>):

```shell
curl -fsSL https://claude.ai/install.sh | bash
```

Open claude

```shell
# You'll be prompted to log in on first use
claude
```

Once in claude, login:

```shell
# Follow the prompts to log in with your account
/login
```

### Configuration

Clone this repo:

```shell
git clone git@github.com:craighurley/claude.git
```

Install required dependencies:

```shell
./install.sh
```

Link the configuration files:

``` shell
./link.sh
```
