# Zephyr SDK for Workshop

This SDK provides the Zephyr RTOS source tree and build tools (west,
cmake, ninja) for embedded firmware development. A companion toolchain SDK is
required to target a specific architecture. The `venv` plug should be
connected to a venv provider such as the `uv` SDK. The Zephyr build cache and
Python virtual environment are persisted on the host across workshop updates.

### Available toolchain SDKs

- `zephyr-amd64` — x86_64-zephyr-elf
- `zephyr-arm` — arm-zephyr-eabi
- `zephyr-arm64` — aarch64-zephyr-elf
- `zephyr-riscv64` — riscv64-zephyr-elf (also ships ESP32 HAL modules)
- `zephyr-xtensa-espressif-esp32s3` — xtensa-espressif_esp32s3_zephyr-elf
- `zephyr-xtensa-espressif-esp32` — xtensa-espressif_esp32_zephyr-elf
- `zephyr-arc` — arc-zephyr-elf
- `zephyr-arc64` — arc64-zephyr-elf
- `zephyr-microblazeel` — microblazeel-zephyr-elf
- `zephyr-mips` — mips-zephyr-elf
- `zephyr-nios2` — nios2-zephyr-elf
- `zephyr-sparc` — sparc-zephyr-elf
- `zephyr-xtensa-amd-acp-6-0-adsp` — xtensa-amd_acp_6_0_adsp_zephyr-elf
- `zephyr-xtensa-dc233c` — xtensa-dc233c_zephyr-elf
- `zephyr-xtensa-espressif-esp32s2` — xtensa-espressif_esp32s2_zephyr-elf
- `zephyr-xtensa-intel-ace15-mtpm` — xtensa-intel_ace15_mtpm_zephyr-elf
- `zephyr-xtensa-intel-ace30-ptl` — xtensa-intel_ace30_ptl_zephyr-elf
- `zephyr-xtensa-intel-tgl-adsp` — xtensa-intel_tgl_adsp_zephyr-elf
- `zephyr-xtensa-mtk-mt8195-adsp` — xtensa-mtk_mt8195_adsp_zephyr-elf
- `zephyr-xtensa-nxp-imx-adsp` — xtensa-nxp_imx_adsp_zephyr-elf
- `zephyr-xtensa-nxp-imx8m-adsp` — xtensa-nxp_imx8m_adsp_zephyr-elf
- `zephyr-xtensa-nxp-imx8ulp-adsp` — xtensa-nxp_imx8ulp_adsp_zephyr-elf
- `zephyr-xtensa-nxp-rt500-adsp` — xtensa-nxp_rt500_adsp_zephyr-elf
- `zephyr-xtensa-nxp-rt600-adsp` — xtensa-nxp_rt600_adsp_zephyr-elf
- `zephyr-xtensa-nxp-rt700-hifi1` — xtensa-nxp_rt700_hifi1_zephyr-elf
- `zephyr-xtensa-nxp-rt700-hifi4` — xtensa-nxp_rt700_hifi4_zephyr-elf
- `zephyr-xtensa-sample-controller` — xtensa-sample_controller_zephyr-elf
- `zephyr-xtensa-sample-controller32` — xtensa-sample_controller32_zephyr-elf

---

## Reference workshop

A minimal usable workshop:

```yaml
# workshop.yaml
name: dev
base: ubuntu@24.04
sdks:
  - name: uv
    channel: 0.9/stable
  - name: zephyr
    channel: 4.3/stable
  - name: zephyr-amd64
    channel: 0.17.4/stable

actions:
  build-amd64: |-
    for DIRNAME in */; do
        DIRNAME=${DIRNAME%/}
        [[ $DIRNAME == build* ]] && continue

        cmake -GNinja \
            -S "${DIRNAME}/" \
            -B "build-${DIRNAME}-amd64" \
            -DBUILD_VERSION="$ZEPHYR_VERSION" \
            -DBOARD=qemu_x86 \
            -DCROSS_COMPILE="$ZEPHYR_SDK_INSTALL_DIR/x86_64-zephyr-elf/bin/x86_64-zephyr-elf-"

        ninja -C "build-${DIRNAME}-amd64"
    done

connections:
  - plug: zephyr:amd64
    slot: zephyr-amd64:toolchain
  - plug: zephyr:venv
    slot: uv:venv
```

See the [reference workshop example](https://github.com/canonical/reference-workshops/blob/main/zephyr/workshop.yaml) for additional architecture targets (arm64,
riscv64/ESP32-C3) and their corresponding build actions.

---

## Using the SDK

### Prerequisites

1. A companion toolchain SDK is required. The reference workshop above uses
   `zephyr-amd64` for x86_64 targets. Substitute the appropriate toolchain SDK
   and connection for other architectures.
2. A venv provider is required. Connect the `venv` plug to the `uv` SDK (or
   another provider). On first launch, the SDK installs west into this venv.

### Build firmware

Place your Zephyr application directories in your project root. Then run the
`build-amd64` action from the example workshop above:

```bash
workshop run build-amd64
```

`ZEPHYR_BASE` and `ZEPHYR_SDK_INSTALL_DIR` are set automatically by the
`setup-project` hook.

---

## Plugs (resources this SDK consumes)

### `zephyr-cache`

- Interface: `mount`
- Workshop target: `/home/workshop/.cache/zephyr`
- Purpose: Persists the Zephyr build cache across workshop updates.

### `amd64`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/x86_64-zephyr-elf`
- Purpose: Mount point for the x86_64 cross-compiler toolchain from the
  `zephyr-amd64` SDK.

### `arm64`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/aarch64-zephyr-elf`
- Purpose: Mount point for the AArch64 cross-compiler toolchain from the
  `zephyr-arm64` SDK.

### `arm`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/arm-zephyr-eabi`
- Purpose: Mount point for the ARM cross-compiler toolchain from the
  `zephyr-arm` SDK.

### `riscv64`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/riscv64-zephyr-elf`
- Purpose: Mount point for the RISC-V cross-compiler toolchain from the
  `zephyr-riscv64` SDK.

### `xtensa-espressif-esp32s3`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-espressif_esp32s3_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-espressif-esp32s3` SDK.

### `xtensa-espressif-esp32`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-espressif_esp32_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-espressif-esp32` SDK.

### `arc`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/arc-zephyr-elf`
- Purpose: Mount point for the ARC cross-compiler toolchain from the
  `zephyr-arc` SDK.

### `arc64`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/arc64-zephyr-elf`
- Purpose: Mount point for the ARC64 cross-compiler toolchain from the
  `zephyr-arc64` SDK.

### `microblazeel`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/microblazeel-zephyr-elf`
- Purpose: Mount point for the MicroBlaze cross-compiler toolchain from the
  `zephyr-microblazeel` SDK.

### `mips`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/mips-zephyr-elf`
- Purpose: Mount point for the MIPS cross-compiler toolchain from the
  `zephyr-mips` SDK.

### `nios2`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/nios2-zephyr-elf`
- Purpose: Mount point for the Nios II cross-compiler toolchain from the
  `zephyr-nios2` SDK.

### `sparc`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/sparc-zephyr-elf`
- Purpose: Mount point for the SPARC cross-compiler toolchain from the
  `zephyr-sparc` SDK.

### `xtensa-amd-acp-6-0-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-amd_acp_6_0_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-amd-acp-6-0-adsp` SDK.

### `xtensa-dc233c`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-dc233c_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-dc233c` SDK.

### `xtensa-espressif-esp32s2`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-espressif_esp32s2_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-espressif-esp32s2` SDK.

### `xtensa-intel-ace15-mtpm`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-intel_ace15_mtpm_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-intel-ace15-mtpm` SDK.

### `xtensa-intel-ace30-ptl`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-intel_ace30_ptl_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-intel-ace30-ptl` SDK.

### `xtensa-intel-tgl-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-intel_tgl_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-intel-tgl-adsp` SDK.

### `xtensa-mtk-mt8195-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-mtk_mt8195_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-mtk-mt8195-adsp` SDK.

### `xtensa-nxp-imx-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_imx_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-imx-adsp` SDK.

### `xtensa-nxp-imx8m-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_imx8m_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-imx8m-adsp` SDK.

### `xtensa-nxp-imx8ulp-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_imx8ulp_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-imx8ulp-adsp` SDK.

### `xtensa-nxp-rt500-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_rt500_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-rt500-adsp` SDK.

### `xtensa-nxp-rt600-adsp`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_rt600_adsp_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-rt600-adsp` SDK.

### `xtensa-nxp-rt700-hifi1`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_rt700_hifi1_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-rt700-hifi1` SDK.

### `xtensa-nxp-rt700-hifi4`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-nxp_rt700_hifi4_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-nxp-rt700-hifi4` SDK.

### `xtensa-sample-controller`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-sample_controller_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-sample-controller` SDK.

### `xtensa-sample-controller32`

- Interface: `mount`
- Workshop target: `$SDK/zephyr-sdk/xtensa-sample_controller32_zephyr-elf`
- Purpose: Mount point for the Xtensa cross-compiler toolchain from the
  `zephyr-xtensa-sample-controller32` SDK.

### `modules`

- Interface: `mount`
- Workshop target: `/home/workshop/modules`
- Purpose: Mount point for extra Zephyr modules such as `hal_espressif` from
  the `zephyr-riscv64` SDK.

### `venv`

- Interface: `mount`
- Workshop target: `$SDK/venv`
- Purpose: Receives a Python virtual environment from an external provider
  (e.g. the `uv` SDK). The `setup-project` hook installs west into this venv.
  Persisted on the host across workshop updates.

## Slots (resources this SDK provides)

This SDK doesn't define any slots.

---

## Documentation and guidance

- [Zephyr official documentation](https://docs.zephyrproject.org/latest/)
- [Zephyr getting started guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)
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

The Zephyr RTOS is licensed under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).
