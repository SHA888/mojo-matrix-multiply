# Mojo Matrix Multiplication Calculator

This project implements a simple matrix multiplication calculator in [Mojo](https://www.modular.com/mojo), a programming language designed for AI and high-performance computing. The goal is to test Mojo's standard library, identify bugs or enhancements, and contribute back to the Mojo community.

## Purpose

- **Build** a functional matrix multiplication program.
- **Explore** Mojo’s array and math operations.
- **Identify** potential bugs or improvements in the Mojo standard library.
- **Contribute** findings to [modular/max](https://github.com/modular-ai/max).

## Setup

### Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/mojo-matrix-multiply.git
cd mojo-matrix-multiply
```

### Install Mojo

- To install the Modular magic CLI (required for Mojo), run:

  ```bash
  curl -ssL https://magic.modular.com/ | bash
  # Then add magic to your PATH for this session:
  source ~/.bashrc
  # (You may need to restart your terminal or run this command in each new session)
  ```

- To install the latest released build of Mojo, follow the [Get started with Mojo guide](https://docs.modular.com/mojo/manual/get-started).
- To use the latest nightly build, after installing the magic CLI, initialize your current directory as a Mojo project:

  ```bash
  magic init . --format mojoproject -c conda-forge -c https://conda.modular.com/max-nightly
  ```

  Or, if you prefer conda directly, add the nightly channel to your environment.yaml:

  ```yaml
  channels:
    - conda-forge
    - https://conda.modular.com/max-nightly/
  dependencies:
    - max
  ```

  See the [official instructions](https://github.com/modular/max/tree/main/mojo#installing-mojo) for more details.

### Run the Program

- See `src/main.mojo` for the main code.
- Run with:

```bash
magic run mojo src/main.mojo
```

(after setup)

## Contributing

- Found a bug? File an issue at [Mojo issues](https://github.com/modular/max/issues).
- Suggest enhancements via the [Contribution Guide](https://github.com/modular/max/blob/main/CONTRIBUTING.md).
- Join the community at [Modular Discord](https://discord.com/invite/modular) or [Modular Forum](https://forum.modular.com/).

## License

MIT License

## Running the Matrix Calculator

To execute the program, use:

```bash
magic run mojo src/main.mojo
```

This will run all the matrix operation tests and print results to the console.

## Project Findings

See the full incremental exploration and bug-hunting log in [FINDINGS.md](./FINDINGS.md).
