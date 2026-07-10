# Zephyr xtensa-espressif-esp32s2 Toolchain SDK for Workshop

This SDK provides the `xtensa-espressif_esp32s2_zephyr-elf` cross-compiler toolchain for building Zephyr
firmware. It requires the `zephyr` base SDK. Version updates are managed by
Renovate and tracked from upstream
[sdk-ng](https://github.com/zephyrproject-rtos/sdk-ng) releases.

---

## Using the SDK

### Prerequisites

1. The `zephyr` base SDK and `zephyr-sdk-ng` SDK are required.
2. Connect this SDK's `toolchain` slot to the matching toolchain plug so the
   `xtensa-espressif_esp32s2_zephyr-elf` cross-compiler becomes available inside the workshop.

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
- Purpose: Provides the `xtensa-espressif_esp32s2_zephyr-elf` cross-compiler to the `zephyr` base SDK.

---

## Documentation and guidance

- [Zephyr official documentation](https://docs.zephyrproject.org/latest/)
- [Workshop documentation](https://ubuntu.com/workshop/docs/)

---

## License and copyright

Copyright 2025 Canonical Ltd.

The Zephyr RTOS is licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
