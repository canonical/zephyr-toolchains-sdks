# Zephyr xtensa-espressif-esp32 Toolchain SDK for Workshop

This SDK provides the xtensa-espressif_esp32_zephyr-elf cross-compiler
toolchain for building Zephyr firmware. It requires the `zephyr` base SDK.

---

## Reference workshop

A minimal workshop:

```yaml
# workshop.yaml
name: zephyr-firmware
base: ubuntu@24.04
sdks:
  - name: uv
    channel: all/edge
  - name: zephyr
    channel: 24.04/edge
  - name: zephyr-xtensa-espressif-esp32
    channel: 24.04/edge

connections:
  - plug: zephyr:xtensa-espressif-esp32
    slot: zephyr-xtensa-espressif-esp32:toolchain
  - plug: zephyr:venv
    slot: uv:venv
```

This demonstrates a Zephyr environment with the
xtensa-espressif_esp32_zephyr-elf toolchain and a uv-managed Python virtual
environment connected.

---

## Using the SDK

See the [Zephyr SDK README](../zephyr/README.md) for the full build workflow
and environment setup.

---

## Plugs (resources this SDK consumes)

This SDK doesn't define any plugs.

---

## Slots (resources this SDK provides)

### `toolchain`

- Interface: `mount`
- Workshop source: `$SDK`
- Purpose: Provides the xtensa-espressif_esp32_zephyr-elf cross-compiler to
  the `zephyr` base SDK.

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

Copyright 2026 Canonical Ltd.

The Zephyr RTOS is licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
