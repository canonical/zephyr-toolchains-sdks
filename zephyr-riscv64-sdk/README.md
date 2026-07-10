# Zephyr riscv64 Toolchain SDK for Workshop

This SDK provides the riscv64-zephyr-elf cross-compiler toolchain for building
Zephyr firmware targeting RISC-V architectures. It also includes ESP32 HAL modules
and binary blobs for ESP32-S3 firmware development via the `modules` slot. A
Python virtual environment plug (`venv`) receives additional build tools
(esptool, pykwalify) on first launch. Version updates are managed by Renovate
and tracked from upstream [sdk-ng](https://github.com/zephyrproject-rtos/sdk-ng)
releases.

---

## Reference workshop

A minimal workshop:

```yaml
# workshop.yaml
name: zephyr-esp32
base: ubuntu@24.04
sdks:
  - name: uv
    channel: latest/stable
  - name: zephyr
    channel: 4.2/stable
  - name: zephyr-sdk-ng
    channel: 0.17.4/stable
  - name: zephyr-riscv64
    channel: 0.17.4/stable
connections:
  - plug: zephyr:sdk-ng
    slot: zephyr-sdk-ng:sdk-ng
  - plug: zephyr-sdk-ng:riscv64
    slot: zephyr-riscv64:toolchain
  - plug: zephyr:modules
    slot: zephyr-riscv64:modules
  - plug: zephyr:venv
    slot: uv:venv
  - plug: zephyr-riscv64:venv
    slot: uv:venv
```

This demonstrates a Zephyr environment with the RISC-V toolchain, ESP32 HAL
modules, and a uv-managed Python virtual environment connected to both the
base SDK and the riscv64 toolchain SDK.

### Compatibility matrix

| SDK NG / Toolchain | Zephyr |
|---|---|
| 1.1.x | 4.5.x |
| 1.0.x | 4.4.x |
| 0.17.x | 4.2.x, 4.3.x |

---

## Using the SDK

### Prerequisites, project layout

1. The `zephyr` base SDK and `zephyr-sdk-ng` SDK are required.
2. Connect the `riscv64` plug on `zephyr-sdk-ng` to the `toolchain` slot on this SDK.
3. No specific project layout is needed — the toolchain is available at
   `$ZEPHYR_SDK_INSTALL_DIR` once the workshop launches.

### Building Zephyr firmware

See the [Zephyr SDK README](https://github.com/canonical/zephyr-sdk) for the
full build workflow and environment setup.

On first launch, the `setup-project` hook installs ESP32-specific Python tools
(esptool, pykwalify, pyYAML, jsonschema, packaging, pyelftools) into the
shared virtual environment.

---

## Plugs (resources this SDK consumes)

### `venv`

- Interface: `mount`
- Workshop target: `$SDK/venv`
- Purpose: Receives the Python virtual environment from the `zephyr` base SDK
  for ESP32-specific tool installation. Tools installed into this venv persist
  across workshop updates.

---

## Slots (resources this SDK provides)

### `toolchain`

- Interface: `mount`
- Workshop source: `$SDK`
- Purpose: Provides the riscv64-zephyr-elf cross-compiler to the `zephyr` base
  SDK.

### `modules`

- Interface: `mount`
- Workshop source: `$SDK/modules`
- Purpose: Provides ESP32 HAL modules and binary blobs to the `zephyr` base
  SDK for ESP32-S3 firmware development.

---

## Documentation and guidance

- [Zephyr official documentation](https://docs.zephyrproject.org/latest/)
- [Workshop documentation](https://ubuntu.com/workshop/docs/)

---

## Community and support

- Zephyr community: [Zephyr GitHub](https://github.com/zephyrproject-rtos/zephyr)
- Zephyr community forum: [Zephyr Discord](https://chat.zephyrproject.org/)
- Workshop forum:
  [Discourse](https://discourse.ubuntu.com/)
- Please review our
  [Code of Conduct](https://ubuntu.com/community/ethos/code-of-conduct) before
  participating.

---

## Contributions

All contributions, including code, documentation updates, and issue reports,
are welcome!

- See `CONTRIBUTING.md` for guidelines.
- Open issues or pull requests on the official repository.

---

## License and copyright

Copyright 2025 Canonical Ltd.

The Zephyr SDK NG toolchains are licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
