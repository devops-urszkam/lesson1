# lesson1

Simple Docker exercise: Ubuntu 22.04 image that installs a basic developer toolchain (git, curl, jq, zsh with Oh My Zsh) and sets up git aliases.

## Repo structure

```
.
├── Dockerfile            # Builds the image, runs startup script, starts zsh
├── src/
│   └── startup-script.sh # Installs tools, configures git, initializes /workspace/devops-test
├── tests/
│   └── tests.sh          # Basic environment checks
└── LICENSE               # MIT license
```

## Key files

-   `Dockerfile` – Ubuntu 22.04 base, runs `src/startup-script.sh`, defaults to `CMD ["zsh"]`, build args `GIT_NAME="User"` and `GIT_EMAIL="example@example.com"`. Tests are not baked into the image.
-   `src/startup-script.sh` – updates apt, installs git/curl/wget/unzip/htop/tree/jq/zsh, installs Oh My Zsh + autosuggestions, sets git aliases/name/email, creates `/workspace/devops-test` directory with `git init`.
-   `tests/tests.sh` – checks git, jq, git config (name/email), zsh/Oh My Zsh, and lists `/workspace/devops-test`. Run it from the host by mounting `tests/` into the container.

## Setup and run

1. Clone the repository:
    ```sh
    git clone <repo-url>
    cd lesson1
    ```
2. Prerequisites on the host (Debian):
    - Git:
        ```sh
        sudo apt install -y git
        ```
    - Docker:
        ```sh
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
        ```
3. Run the project:
    ```sh
    docker build -t lesson1 --build-arg GIT_NAME="Your Name" --build-arg GIT_EMAIL="Your Email" .
    ```
    - Open an interactive shell:
        ```sh
        docker run --rm -it lesson1
        ```
    - Or run the test script (tests are mounted from host for this run only):
        ```sh
        docker run --rm -it -v "$PWD/tests":/tests lesson1 /tests/tests.sh
        ```

## CI

-   GitHub Actions (`.github/workflows/ci.yml`) builds the Docker image and runs `tests/tests.sh` in a container for pull requests into `main`.
-   Direct pushes to `main` are blocked. Open a PR (for example from `dev` to `main`) to trigger CI.

## Notes

-   The setup script uses `GIT_NAME` and `GIT_EMAIL` build args. Pass them at build time.
