# Zephyr amd64 Toolchain SDK for Workshop

This SDK provides the x86_64 cross-compiler toolchain for building Zephyr
firmware targeting the x86_64-zephyr-elf target triple. Use this SDK alongside
the zephyr base SDK. Version updates are managed by Renovate and tracked from
upstream [sdk-ng](https://github.com/zephyrproject-rtos/sdk-ng) releases.

---

## Reference workshop

A minimal workshop:

```yaml
# workshop.yaml
name: zephyr-firmware
base: ubuntu@24.04
sdks:
  - name: uv
    channel: latest/stable
  - name: zephyr
    channel: 4.4/stable
  - name: zephyr-amd64
    channel: 1.0.1/stable
  - name: zephyr-sdk-ng
    channel: 1.0.1/stable
connections:
  - plug: zephyr:sdk-ng
    slot: zephyr-sdk-ng:sdk-ng
  - plug: zephyr-sdk-ng:amd64
    slot: zephyr-amd64:toolchain
  - plug: zephyr:venv
    slot: uv:venv
```

This demonstrates a Zephyr 4.4.x environment with the compatible SDK NG 1.0.x
toolchain bundle and the x86_64-zephyr-elf cross-compiler connected.

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
2. Connect the `amd64` plug on `zephyr` to the `toolchain` slot on this SDK.
3. No specific project layout is needed — the toolchain is available at
   `$ZEPHYR_SDK_INSTALL_DIR` once the workshop launches.

### Building Zephyr firmware

See the [Zephyr SDK README](https://github.com/canonical/zephyr-sdk) for the
full build workflow and environment setup.

---

## Plugs (resources this SDK consumes)

This SDK doesn't define any plugs.

---

## Slots (resources this SDK provides)

### `toolchain`

- Interface: `mount`
- Workshop source: `$SDK`
- Purpose: Provides the x86_64-zephyr-elf cross-compiler to the `zephyr` base
  SDK.

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
